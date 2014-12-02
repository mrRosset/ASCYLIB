.PHONY:	all

BENCHS = src/linkedlist-harris src/linkedlist-harris_opt src/linkedlist-michael src/hashtable-harris src/hashtable-rcu src/hashtable-java src/hashtable-copy src/hashtable-tbb src/skiplist src/skiplist-fraser src/skiplist-herlihy_lf src/skiplist-seq src/skiplist-herlihy_lb src/skiplist-pugh src/skiplist-string-pugh src/bst-ellen src/bst-seq_internal src/bst-howley src/bst-aravind src/noise/ src/tests/ src/bst-tk/
LBENCHS = src/linkedlist-coupling src/linkedlist-lazy src/linkedlist-pugh src/linkedlist-copy src/hashtable-pugh src/hashtable-coupling src/hashtable-lazy src/hashtable-tbb src/hashtable-java src/hashtable-copy src/skiplist-herlihy_lb src/skiplist-pugh src/skiplist-string-pugh src/bst-bronson src/bst-drachsler src/bst-tk/
LFBENCHS = src/linkedlist-harris src/linkedlist-harris_opt src/linkedlist-michael src/hashtable-harris src/hashtable-rcu src/skiplist src/skiplist-fraser src/skiplist-herlihy_lf src/bst-ellen src/bst-howley src/bst-aravind
SEQBENCHS = src/linkedlist-seq src/hashtable-seq src/skiplist-seq src/bst-seq_internal src/bst-seq_external
NOISE = src/noise
TESTS = src/tests
BSTS = src/bst-bronson src/bst-drachsler src/bst-ellen src/bst-howley src/bst-aravind src/bst-tk/

.PHONY:	clean all $(BENCHS) $(LBENCHS) $(NOISE) $(TESTS) $(SEQBENCHS)

all:	lockfree tas

mutex:
	$(MAKE) "LOCK=MUTEX" $(LBENCHS)

spin:
	$(MAKE) "LOCK=SPIN" $(LBENCHS)

tas:
	$(MAKE) "LOCK=TAS" $(LBENCHS)

ticket:
	$(MAKE) "LOCK=TICKET" $(LBENCHS)

hticket:
	$(MAKE) "LOCK=HTICKET" $(LBENCHS)

clh:
	$(MAKE) "LOCK=CLH" $(LBENCHS)

bst:	seqbstint seqbstext
	$(MAKE) $(BSTS)

bst_tk:
	$(MAKE) "LOCK=TAS" src/bst-tk/

bst_aravind:
	$(MAKE) "STM=LOCKFREE" src/bst-aravind

bst_howley:
	$(MAKE) "STM=LOCKFREE" src/bst-howley

bst_ellen:
	$(MAKE) "STM=LOCKFREE" src/bst

bst_drachsler:
	$(MAKE) "LOCK=TAS" src/bst-drachsler

bst_drachsler_no_ro:
	$(MAKE) "LOCK=TAS" "RO_FAIL=0" src/bst-drachsler

bst_bronson:
	$(MAKE) "LOCK=TAS" src/bst-bronson

sequential:
	$(MAKE) "STM=SEQUENTIAL" "SEQ_NO_FREE=1" $(SEQBENCHS)

seqgc:
	$(MAKE) "STM=SEQUENTIAL" $(SEQBENCHS)

seq:	sequential


seqht:
	$(MAKE) "STM=SEQUENTIAL" "SEQ_NO_FREE=1" src/hashtable-seq

seqhtgc:
	$(MAKE) "STM=SEQUENTIAL" "GC=1" src/hashtable-seq

seqsl:
	$(MAKE) "STM=SEQUENTIAL" "SEQ_NO_FREE=1" src/skiplist-seq

seqslgc:
	$(MAKE) "STM=SEQUENTIAL" "GC=1" src/skiplist-seq

lockfree:
	$(MAKE) "STM=LOCKFREE" $(LFBENCHS)

noise:
	$(MAKE) $(NOISE)

tests:
	$(MAKE) $(TESTS)

tbb:
	$(MAKE) "LOCK=TAS" src/hashtable-tbb

lfsl:
	$(MAKE) "STM=LOCKFREE" src/skiplist

lfsl_fraser:
	$(MAKE) "STM=LOCKFREE" src/skiplist-fraser

lfsl_herlihy_lf:
	$(MAKE) "STM=LOCKFREE" src/skiplist-herlihy_lf

lbsl_pugh:
	$(MAKE) "LOCK=TAS" src/skiplist-pugh

lbsl_string_pugh:
	$(MAKE) "LOCK=TAS" src/skiplist-string-pugh

lbsl_herlihy_lb:
	$(MAKE) "LOCK=TAS" src/skiplist-herlihy_lb

sl:	seqsl lfsl_fraser lfsl_herlihy_lf lbsl_pugh lbsl_string_pugh lbsl_herlihy_lb


lfll_harris:
	$(MAKE) "STM=LOCKFREE" src/linkedlist-harris

lfll_harris_opt:
	$(MAKE) "STM=LOCKFREE" src/linkedlist-harris_opt

lfll_michael:
	$(MAKE) "STM=LOCKFREE" src/linkedlist-michael

seqll:
	$(MAKE) "STM=SEQUENTIAL" "SEQ_NO_FREE=1" src/linkedlist-seq

seqllgc:
	$(MAKE) "STM=SEQUENTIAL" "GC=1" src/linkedlist-seq


lfll: lfll_harris lfll_michael lfll_harris_opt

# ll: seqll lfll lbll llcopy lbll_coupling lbll_pugh lbll_lazy

ll: seqll lfll lbll llcopy lbll_coupling lbll_pugh lbll_lazy lbll_lazy_no_ro llcopy_no_ro lbll_pugh_no_ro

lbht_coupling:
	$(MAKE) "LOCK=TAS" src/hashtable-coupling

lbht_pugh:
	$(MAKE) "LOCK=TAS" src/hashtable-pugh

lbht_lazy:
	$(MAKE) "LOCK=TAS" src/hashtable-lazy

lbht_coupling_gl:
	$(MAKE) "LOCK=TAS" "G=GL" src/hashtable-coupling

lbht_pugh_gl:
	$(MAKE) "LOCK=TAS" "G=GL" src/hashtable-pugh

lbht_pugh_gl_no_ro:
	$(MAKE) "LOCK=TAS" "G=GL" "RO_FAIL=0" src/hashtable-pugh

lbht_lazy_gl:
	$(MAKE) "LOCK=TAS" "G=GL" src/hashtable-lazy

lbht_lazy_gl_no_ro:
	$(MAKE) "LOCK=TAS" "G=GL" "RO_FAIL=0" src/hashtable-lazy

lbll_coupling:
	$(MAKE) "LOCK=TAS" src/linkedlist-coupling

lbll_pugh:
	$(MAKE) "LOCK=TAS" src/linkedlist-pugh

lbll_pugh_no_ro:
	$(MAKE) "LOCK=TAS" "RO_FAIL=0" src/linkedlist-pugh

lbll_lazy:
	$(MAKE) "LOCK=TAS" src/linkedlist-lazy

lbll_lazy_no_ro:
	$(MAKE) "LOCK=TAS" "RO_FAIL=0" src/linkedlist-lazy

llcopy:
	$(MAKE) "LOCK=CLH" src/linkedlist-copy

llcopy_no_ro:
	$(MAKE) "LOCK=CLH" "RO_FAIL=0" src/linkedlist-copy

htcopy:
	$(MAKE) "LOCK=TAS" src/hashtable-copy

htcopy_no_ro:
	$(MAKE) "LOCK=TAS" "RO_FAIL=0" src/hashtable-copy

htcopygl:
	$(MAKE) "LOCK=CLH" "G=GL" src/hashtable-copy

lfht:
	$(MAKE) "STM=LOCKFREE" src/hashtable-harris

htjava:
	$(MAKE) "LOCK=TAS" src/hashtable-java

htjava_no_ro:
	$(MAKE) "LOCK=TAS" "RO_FAIL=0" src/hashtable-java

htrcu:
	$(MAKE) "LOCK=TAS" "GC=0" src/hashtable-rcu

htrcugc:
	$(MAKE) "LOCK=TAS" src/hashtable-rcu

ht:	seqht lfht lbht htjava tbb htcopy htrcu lbht_coupling lbht_lazy lbht_pugh lbht_coupling_gl lbht_lazy_gl lbht_pugh_gl lbht_lazy_gl_no_ro lbht_pugh_gl_no_ro htcopy_no_ro htjava_no_ro

seqbstint:
	$(MAKE) "STM=SEQUENTIAL" "SEQ_NO_FREE=1" src/bst-seq_internal

seqbstext:
	$(MAKE) "STM=SEQUENTIAL" "SEQ_NO_FREE=1" src/bst-seq_external

seqbstintgc:
	$(MAKE) "STM=SEQUENTIAL" "GC=1" src/bst-seq_internal

seqbstextgc:
	$(MAKE) "STM=SEQUENTIAL" "GC=1" src/bst-seq_external

seqbstgc: seqbstextgc seqbstintgc

clean:
	$(MAKE) -C src/linkedlist-harris clean	
	$(MAKE) -C src/skiplist clean
	$(MAKE) -C src/hashtable-harris clean
	$(MAKE) -C src/hashtable-rcu clean
	$(MAKE) -C src/linkedlist-coupling clean
	$(MAKE) -C src/linkedlist-lazy clean
	$(MAKE) -C src/linkedlist-pugh clean
	$(MAKE) -C src/hashtable-pugh clean
	$(MAKE) -C src/hashtable-coupling clean
	$(MAKE) -C src/hashtable-lazy clean
	$(MAKE) -C src/sftree clean
	$(MAKE) -C src/bst-ellen clean
	$(MAKE) -C src/bst-howley clean
	$(MAKE) -C src/bst-aravind clean
	$(MAKE) -C src/bst-drachsler clean
	$(MAKE) -C src/bst-bronson clean
	$(MAKE) -C src/bst-tk clean
	$(MAKE) -C src/noise clean
	$(MAKE) -C src/tests clean
	rm -rf build

$(SEQBENCHS):
	$(MAKE) -C $@ $(TARGET)

$(LBENCHS):
	$(MAKE) -C $@ $(TARGET)

$(LFBENCHS):
	$(MAKE) -C $@ $(TARGET)

$(NOISE):
	$(MAKE) -C $@ $(TARGET)

$(TESTS):
	$(MAKE) -C $@ $(TARGET)
