Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5c34db00708210446k64253502w5dd9c7b49b5064ca@mail.gmail.com>
Date: Tue, 21 Aug 2007 17:16:25 +0530
From: "umamahesh yelchuru venkata" <umeshyv@gmail.com>
To: bluez-users@lists.sf.net
MIME-Version: 1.0
Subject: [Bluez-users] bluetooth compilation
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0290898425=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0290898425==
Content-Type: multipart/alternative;
	boundary="----=_Part_143542_12704694.1187696785752"

------=_Part_143542_12704694.1187696785752
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,
I work on Au1200 processor (its an MMU processor),ported linux-2.6.11 kernel
and i want to test usb blutooth dongle on this board when i compiled
bluetooth libraries and utils (i downloaded the following versions
bluez-libs-2.25.tar.gz,bluez-libs-2.25.tar.gz ) and followed compilation
procedure,
Compiling bluetooth libraries
>./configure --host=mipsel --prefix=/usr --enable-shared=no
--enable-static=yes
>make
>make install DESTDIR=/home/busybox/bluez/bluez- libs-2.25/install

Compiling bluetooth utils
>./configure --host=mipsel
--with-bluez=/home/busybox/bluez/bluez-libs-2.25/install/usr
CPPFLAGS="-D__KERNEL__ $(LINUXINCLUDE)" LDDFLAGS="Wl,-elf2flt"
>make
>make install DESTDIR=/home/busybox/bluez/bluez-utils-2.25/install

it doesnot execute and says binary file cannot be executed and when i remove
LDDFLAGS  it leads to following errors,

else rm -f ".deps/main.Tpo"; exit 1; \
fi
In file included from /usr/include/linux/bitops.h:77,
                 from /usr/include/linux/kernel.h:15,
                 from /usr/include/linux/skbuff.h:18,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/bitops.h:402: error: static declaration of 'ffs' follows
non-static declaration
In file included from /usr/include/linux/skbuff.h:18,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez- libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/kernel.h:102: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/linux/kernel.h:102: error: expected declaration specifiers or
'...' before '__builtin_object_size'
/usr/include/linux/kernel.h:104: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/linux/kernel.h:104: error: expected declaration specifiers or
'...' before '__builtin_object_size'
/usr/include/linux/kernel.h:106: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/linux/kernel.h:106: error: expected declaration specifiers or
'...' before '__builtin_object_size'
/usr/include/linux/kernel.h:108: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/linux/kernel.h:108: error: expected declaration specifiers or
'...' before '__builtin_object_size'
In file included from /usr/include/asm/percpu.h:4,
                 from /usr/include/asm/processor.h:24,
                 from /usr/include/asm/thread_info.h:17,
                 from /usr/include/linux/thread_info.h:21,
                 from /usr/include/linux/preempt.h:10,
                 from /usr/include/linux/spinlock.h:52,
                 from /usr/include/linux/seqlock.h:30,
                 from /usr/include/linux/time.h:7,
                 from /usr/include/linux/skbuff.h:20,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez- libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm-generic/percpu.h:8: error: 'CONFIG_NR_CPUS' undeclared here
(not in a function)
In file included from /usr/include/linux/skbuff.h:20,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/time.h:12: error: redefinition of 'struct timespec'
/usr/include/linux/time.h:18: error: redefinition of 'struct timeval'
In file included from /usr/include/linux/sched.h:12,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/jiffies.h:33:3: error: #error You lose.
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
/usr/include/linux/jiffies.h:248:46: error: division by zero in #if
In file included from /usr/include/linux/sched.h:12,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/jiffies.h: In function 'jiffies_to_msecs':
/usr/include/linux/jiffies.h:253: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h:253: error: (Each undeclared identifier is
reported only once
/usr/include/linux/jiffies.h:253: error: for each function it appears in.)
/usr/include/linux/jiffies.h:259:46: error: division by zero in #if
/usr/include/linux/jiffies.h: In function 'jiffies_to_usecs':
/usr/include/linux/jiffies.h:264: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h:272:46: error: division by zero in #if
/usr/include/linux/jiffies.h: In function 'msecs_to_jiffies':
/usr/include/linux/jiffies.h:277: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h:285:46: error: division by zero in #if
/usr/include/linux/jiffies.h: In function 'usecs_to_jiffies':
/usr/include/linux/jiffies.h:290: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h: In function 'timespec_to_jiffies':
/usr/include/linux/jiffies.h:309: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h:315: error: 'SHIFT_HZ' undeclared (first use in
this function)
/usr/include/linux/jiffies.h: In function 'jiffies_to_timespec':
/usr/include/linux/jiffies.h:328: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h: In function 'timeval_to_jiffies':
/usr/include/linux/jiffies.h:350: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h:354: error: 'SHIFT_HZ' undeclared (first use in
this function)
/usr/include/linux/jiffies.h: In function 'jiffies_to_timeval':
/usr/include/linux/jiffies.h:366: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h: At top level:
/usr/include/linux/jiffies.h:377: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'jiffies_to_clock_t'
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
/usr/include/linux/jiffies.h: In function 'clock_t_to_jiffies':
/usr/include/linux/jiffies.h:391: error: 'CONFIG_HZ' undeclared (first use
in this function)
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
/usr/include/linux/jiffies.h: In function 'jiffies_64_to_clock_t':
/usr/include/linux/jiffies.h:411: error: 'CONFIG_HZ' undeclared (first use
in this function)
In file included from /usr/include/linux/bitmap.h:8,
                 from /usr/include/linux/cpumask.h:86,
                 from /usr/include/linux/sched.h:15,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/string.h: At top level:
/usr/include/linux/string.h:16: error: expected identifier or '(' before
'__extension__'
/usr/include/linux/string.h:16: error: expected identifier or '(' before ')'
token
/usr/include/linux/string.h:17: error: expected identifier or '(' before
'__extension__'
/usr/include/linux/string.h:17: error: expected identifier or '(' before ')'
token
/usr/include/linux/string.h:18: error: expected identifier or '(' before
'__extension__'
/usr/include/linux/string.h:18: error: expected identifier or '(' before ')'
token
/usr/include/linux/string.h:19: error: expected identifier or '(' before
'__extension__'
/usr/include/linux/string.h:19: error: expected identifier or '(' before ')'
token
In file included from /usr/include/linux/string.h:24,
                 from /usr/include/linux/bitmap.h:8,
                 from /usr/include/linux/cpumask.h:86,
                 from /usr/include/linux/sched.h:15,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/string.h:30: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/asm/string.h:30: error: expected ')' before '!=' token
/usr/include/asm/string.h:30: error: expected ')' before '?' token
/usr/include/asm/string.h:44: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/asm/string.h:44: error: expected ')' before '!=' token
/usr/include/asm/string.h:44: error: expected ')' before '?' token
/usr/include/asm/string.h:63: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/asm/string.h:63: error: expected ')' before '!=' token
/usr/include/asm/string.h:63: error: expected ')' before '?' token
/usr/include/asm/string.h:80: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/asm/string.h:80: error: expected ')' before '!=' token
/usr/include/asm/string.h:80: error: expected ')' before '?' token
/usr/include/asm/string.h:103: error: expected identifier or '(' before
'__extension__'
/usr/include/asm/string.h:103: error: expected identifier or '(' before ')'
token
/usr/include/asm/string.h:125: error: expected identifier or '(' before
'__extension__'
/usr/include/asm/string.h:149: error: expected identifier or '(' before
'__extension__'
/usr/include/asm/string.h:171: error: static declaration of 'strrchr'
follows non-static declaration
/usr/include/asm/string.h:190: error: static declaration of 'strlen' follows
non-static declaration
/usr/include/asm/string.h:327: error: expected declaration specifiers or
'...' before numeric constant
/usr/include/asm/string.h:327: error: expected ')' before '!=' token
/usr/include/asm/string.h:327: error: expected ')' before '?' token
/usr/include/asm/string.h:333: error: static declaration of 'memchr' follows
non-static declaration
/usr/include/string.h:67: error: previous declaration of 'memchr' was here
In file included from /usr/include/linux/list.h:7,
                 from /usr/include/linux/wait.h:23,
                 from /usr/include/asm/semaphore.h:41,
                 from /usr/include/linux/sched.h:20,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/prefetch.h: In function 'prefetch_range':
/usr/include/linux/prefetch.h:64: error: 'CONFIG_X86_L1_CACHE_SHIFT'
undeclared (first use in this function)
In file included from /usr/include/linux/rwsem.h:27,
                 from /usr/include/asm/semaphore.h:42,
                 from /usr/include/linux/sched.h:20,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/rwsem.h: In function '__down_read':
/usr/include/asm/rwsem.h:105: error: expected ':' or ')' before
'KBUILD_BASENAME'
/usr/include/asm/rwsem.h: In function '__down_write':
/usr/include/asm/rwsem.h:157: error: expected ':' or ')' before
'KBUILD_BASENAME'
/usr/include/asm/rwsem.h: In function '__up_read':
/usr/include/asm/rwsem.h:194: error: expected ':' or ')' before
'KBUILD_BASENAME'
/usr/include/asm/rwsem.h: In function '__up_write':
/usr/include/asm/rwsem.h:220: error: expected ':' or ')' before
'KBUILD_BASENAME'
/usr/include/asm/rwsem.h: In function '__downgrade_write':
/usr/include/asm/rwsem.h:245: error: expected ':' or ')' before
'KBUILD_BASENAME'
In file included from /usr/include/linux/sched.h:20,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez- libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/semaphore.h: In function 'down':
/usr/include/asm/semaphore.h:105: error: expected ':' or ')' before
'KBUILD_BASENAME'
/usr/include/asm/semaphore.h: In function 'down_interruptible':
/usr/include/asm/semaphore.h:130: error: expected ':' or ')' before
'KBUILD_BASENAME'
/usr/include/asm/semaphore.h: In function 'down_trylock':
/usr/include/asm/semaphore.h:155: error: expected ':' or ')' before
'KBUILD_BASENAME'
/usr/include/asm/semaphore.h: In function 'up':
/usr/include/asm/semaphore.h:179: error: expected ':' or ')' before
'KBUILD_BASENAME'
In file included from /usr/include/linux/signal.h:6,
                 from /usr/include/linux/sched.h:28,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/signal.h: At top level:
/usr/include/asm/signal.h:24: error: conflicting types for 'sigset_t'
/usr/include/sys/select.h:38: error: previous declaration of 'sigset_t' was
here
In file included from /usr/include/linux/signal.h:6,
                 from /usr/include/linux/sched.h:28,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/signal.h:117: error: expected ':', ',', ';', '}' or
'__attribute__' before '.' token
/usr/include/asm/signal.h:123: error: redefinition of 'struct sigaction'
/usr/include/asm/signal.h:124: error: expected ':', ',', ';', '}' or
'__attribute__' before '.' token
/usr/include/asm/signal.h:151: error: redefinition of 'struct sigaltstack'
In file included from /usr/include/asm/siginfo.h:4,
                 from /usr/include/linux/signal.h:7,
                 from /usr/include/linux/sched.h:28,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm-generic/siginfo.h:7: error: redefinition of 'union sigval'
/usr/include/asm-generic/siginfo.h:40: error: redefinition of 'struct
siginfo'
/usr/include/asm-generic/siginfo.h:75: error: expected
specifier-qualifier-list before 'clock_t'
/usr/include/asm-generic/siginfo.h:251: error: redefinition of 'struct
sigevent'
In file included from /usr/include/linux/sched.h:28,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/signal.h:180: error: conflicting types for 'sigemptyset'
/usr/include/signal.h:216: error: previous declaration of 'sigemptyset' was
here
/usr/include/linux/signal.h:192: error: conflicting types for 'sigfillset'
/usr/include/signal.h:219: error: previous declaration of 'sigfillset' was
here
/usr/include/linux/signal.h:261: error: conflicting types for 'sigprocmask'
/usr/include/signal.h:250: error: previous declaration of 'sigprocmask' was
here
In file included from /usr/include/linux/gfp.h:4,
                 from /usr/include/linux/slab.h:15,
                 from /usr/include/linux/percpu.h:5,
                 from /usr/include/linux/sched.h:34,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/mmzone.h:41: error: 'CONFIG_X86_L1_CACHE_SHIFT'
undeclared here (not in a function)
/usr/include/linux/mmzone.h:41: error: requested alignment is not a constant
/usr/include/linux/mmzone.h:64: error: requested alignment is not a constant
/usr/include/linux/mmzone.h:249: error: requested alignment is not a
constant
In file included from /usr/include/linux/sched.h:37,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez- libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/rcupdate.h:69: error: requested alignment is not a
constant
/usr/include/linux/rcupdate.h:72: error: requested alignment is not a
constant
In file included from /usr/include/linux/hrtimer.h:19,
                 from /usr/include/linux/sched.h:108,
                 from /usr/include/linux/mm.h:4,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/ktime.h:263: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'ktime_to_clock_t'
In file included from /usr/include/linux/mm.h:15,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/prio_tree.h:45: error: expected specifier-qualifier-list
before 'pgoff_t'
/usr/include/linux/prio_tree.h:50: error: expected declaration specifiers or
'...' before 'pgoff_t'
/usr/include/linux/prio_tree.h:50: error: expected declaration specifiers or
'...' before 'pgoff_t'
/usr/include/linux/prio_tree.h: In function 'prio_tree_iter_init':
/usr/include/linux/prio_tree.h:53: error: 'struct prio_tree_iter' has no
member named 'r_index'
/usr/include/linux/prio_tree.h:53: error: 'r_index' undeclared (first use in
this function)
/usr/include/linux/prio_tree.h:54: error: 'struct prio_tree_iter' has no
member named 'h_index'
/usr/include/linux/prio_tree.h:54: error: 'h_index' undeclared (first use in
this function)
In file included from /usr/include/linux/stat.h:6,
                 from /usr/include/linux/fs.h:212,
                 from /usr/include/linux/mm.h:16,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/stat.h: At top level:
/usr/include/asm/stat.h:13: error: expected ':', ',', ';', '}' or
'__attribute__' before '.' token
/usr/include/asm/stat.h:18: error: redefinition of 'struct stat'
/usr/include/asm/stat.h:29: error: expected ':', ',', ';', '}' or
'__attribute__' before '.' token
/usr/include/asm/stat.h:64: error: expected ':', ',', ';', '}' or
'__attribute__' before '.' token
In file included from /usr/include/linux/mm.h:16,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez- libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/fs.h:242: error: expected declaration specifiers or '...'
before 'sector_t'
/usr/include/linux/fs.h:244: error: expected declaration specifiers or '...'
before 'sector_t'
In file included from /usr/include/linux/mm.h:16,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/fs.h:360: error: expected specifier-qualifier-list before
'sector_t'
/usr/include/linux/fs.h:382: error: expected specifier-qualifier-list before
'pgoff_t'
In file included from /usr/include/asm/fcntl.h:1,
                 from /usr/include/linux/fcntl.h:4,
                 from /usr/include/linux/fs.h:736,
                 from /usr/include/linux/mm.h:16,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm-generic/fcntl.h:115: error: redefinition of 'struct flock'
In file included from /usr/include/linux/mm.h:16,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/fs.h:960: error: expected declaration specifiers or '...'
before 'sector_t'
/usr/include/linux/fs.h:1440: error: expected declaration specifiers or
'...' before 'pgoff_t'
/usr/include/linux/fs.h:1440: error: expected declaration specifiers or
'...' before 'pgoff_t'
/usr/include/linux/fs.h:1450: error: expected declaration specifiers or
'...' before 'pgoff_t'
/usr/include/linux/fs.h:1450: error: expected declaration specifiers or
'...' before 'pgoff_t'
/usr/include/linux/fs.h:1464: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'bmap'
In file included from /usr/include/asm/fixmap.h:27,
                 from /usr/include/asm/pgtable.h:17,
                 from /usr/include/linux/mm.h:38,
                 from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/acpi.h:31:28: error: acpi/pdc_intel.h: No such file or
directory
In file included from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez- libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/mm.h:249: error: expected specifier-qualifier-list before
'pgoff_t'
In file included from /usr/include/linux/skbuff.h:26,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/mm.h: In function 'lowmem_page_address':
/usr/include/linux/mm.h:517: error: 'CONFIG_PAGE_OFFSET' undeclared (first
use in this function)
/usr/include/linux/mm.h: At top level:
/usr/include/linux/mm.h:577: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'page_index'
/usr/include/linux/mm.h:691: error: expected specifier-qualifier-list before
'pgoff_t'
/usr/include/linux/mm.h:902: error: expected declaration specifiers or '...'
before 'pgoff_t'
/usr/include/linux/mm.h:905: error: expected declaration specifiers or '...'
before 'pgoff_t'
/usr/include/linux/mm.h:915: error: expected declaration specifiers or '...'
before 'pgoff_t'
/usr/include/linux/mm.h:963: error: expected declaration specifiers or '...'
before 'pgoff_t'
/usr/include/linux/mm.h:965: error: expected declaration specifiers or '...'
before 'pgoff_t'
/usr/include/linux/mm.h:969: error: expected declaration specifiers or '...'
before 'pgoff_t'
/usr/include/linux/mm.h:972: error: expected declaration specifiers or '...'
before 'pgoff_t'
In file included from /usr/include/linux/poll.h:4,
                 from /usr/include/linux/skbuff.h:28,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/poll.h:20: error: redefinition of 'struct pollfd'
In file included from /usr/include/linux/skbuff.h:29,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/net.h:83: error: redeclaration of enumerator
'SOCK_STREAM'
/usr/include/bits/socket.h:43: error: previous definition of 'SOCK_STREAM'
was here
/usr/include/linux/net.h:84: error: redeclaration of enumerator 'SOCK_DGRAM'

/usr/include/bits/socket.h:46: error: previous definition of 'SOCK_DGRAM'
was here
/usr/include/linux/net.h:85: error: redeclaration of enumerator 'SOCK_RAW'
/usr/include/bits/socket.h:49: error: previous definition of 'SOCK_RAW' was
here
/usr/include/linux/net.h:86: error: redeclaration of enumerator 'SOCK_RDM'
/usr/include/bits/socket.h:51: error: previous definition of 'SOCK_RDM' was
here
/usr/include/linux/net.h:87: error: redeclaration of enumerator
'SOCK_SEQPACKET'
/usr/include/bits/socket.h:53: error: previous definition of
'SOCK_SEQPACKET' was here
/usr/include/linux/net.h:89: error: redeclaration of enumerator
'SOCK_PACKET'
/usr/include/bits/socket.h:60: error: previous definition of 'SOCK_PACKET'
was here
In file included from /usr/include/linux/module.h:23,
                 from /usr/include/linux/textsearch.h:9,
                 from /usr/include/linux/skbuff.h:30,
                 from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/asm/module.h:62:2: error: #error unknown processor family
In file included from /usr/include/linux/if_ether.h:110,
                 from /usr/include/net/ethernet.h:27,
                 from /home/busybox/bluez/bluez-libs-2.25
/install/usr/include/bluetooth/bnep.h:32,
                 from main.c:47:
/usr/include/linux/skbuff.h:31:26: error: net/checksum.h: No such file or
directory
main.c: In function 'run_devup':
main.c:93: warning: passing argument 2 of '__builtin___sprintf_chk' makes
pointer from integer without a cast
main.c:108: error: 'struct sigaction' has no member named
'__sigaction_handler'
main.c: In function 'write_pidfile':
main.c:449: warning: ignoring return value of 'fscanf', declared with
attribute warn_unused_result
main.c: In function 'main':
main.c:671: error: 'struct sigaction' has no member named 'sa_flags'
main.c:672: error: 'struct sigaction' has no member named
'__sigaction_handler'
main.c:676: error: 'struct sigaction' has no member named
'__sigaction_handler'
main.c:679: error: 'struct sigaction' has no member named
'__sigaction_handler'
main.c:694: warning: ignoring return value of 'chdir', declared with
attribute warn_unused_result
make[2]: *** [main.o] Error 1
make[2]: Leaving directory `/home/busybox/bluez/bluez-utils-2.25/pand'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/busybox/bluez/bluez-utils-2.25'
make: *** [all] Error 2

can you guide me and suggest me where i am going wrong .waiting for your
valuable suggestions

Regards
Umesh

------=_Part_143542_12704694.1187696785752
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,<br>I work on Au1200 processor (its an MMU processor),ported linux-2.6.11 kernel and i want to test usb blutooth dongle on this board when i compiled bluetooth libraries and utils (i downloaded the following versions 
bluez-libs-2.25.tar.gz,bluez-libs-2.25.tar.gz ) and followed compilation procedure,<br>Compiling bluetooth libraries<br>&gt;./configure --host=mipsel --prefix=/usr --enable-shared=no --enable-static=yes<br>&gt;make<br>&gt;make install DESTDIR=/home/busybox/bluez/bluez-
libs-2.25/install<br><br>Compiling bluetooth utils<br>&gt;./configure --host=mipsel --with-bluez=/home/busybox/bluez/bluez-libs-2.25/install/usr CPPFLAGS=&quot;-D__KERNEL__ $(LINUXINCLUDE)&quot; LDDFLAGS=&quot;Wl,-elf2flt&quot;
<br>&gt;make<br>&gt;make install DESTDIR=/home/busybox/bluez/bluez-utils-2.25/install<br><br>it doesnot execute and says binary file cannot be executed and when i remove LDDFLAGS&nbsp; it leads to following errors,<br><br>else rm -f &quot;.deps/main.Tpo&quot;; exit 1; \
<br>fi<br>In file included from /usr/include/linux/bitops.h:77,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/kernel.h:15,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:18,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/bitops.h:402: error: static declaration of &#39;ffs&#39; follows non-static declaration
<br>In file included from /usr/include/linux/skbuff.h:18,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-
libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/kernel.h:102: error: expected declaration specifiers or &#39;...&#39; before numeric constant<br>/usr/include/linux/kernel.h:102: error: expected declaration specifiers or &#39;...&#39; before &#39;__builtin_object_size&#39;
<br>/usr/include/linux/kernel.h:104: error: expected declaration specifiers or &#39;...&#39; before numeric constant<br>/usr/include/linux/kernel.h:104: error: expected declaration specifiers or &#39;...&#39; before &#39;__builtin_object_size&#39;
<br>/usr/include/linux/kernel.h:106: error: expected declaration specifiers or &#39;...&#39; before numeric constant<br>/usr/include/linux/kernel.h:106: error: expected declaration specifiers or &#39;...&#39; before &#39;__builtin_object_size&#39;
<br>/usr/include/linux/kernel.h:108: error: expected declaration specifiers or &#39;...&#39; before numeric constant<br>/usr/include/linux/kernel.h:108: error: expected declaration specifiers or &#39;...&#39; before &#39;__builtin_object_size&#39;
<br>In file included from /usr/include/asm/percpu.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/asm/processor.h:24,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/asm/thread_info.h:17,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/thread_info.h:21,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/preempt.h:10,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/spinlock.h:52,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/seqlock.h:30,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/time.h:7,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:20,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-
libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm-generic/percpu.h:8: error: &#39;CONFIG_NR_CPUS&#39; undeclared here (not in a function)<br>In file included from /usr/include/linux/skbuff.h:20,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/time.h:12: error: redefinition of &#39;struct timespec&#39;<br>/usr/include/linux/time.h:18: error: redefinition of &#39;struct timeval&#39;<br>In file included from /usr/include/linux/sched.h:12,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/jiffies.h:33:3: error: #error You lose.<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:204:31: error: division by zero in #if<br>/usr/include/linux/jiffies.h:248:46: error: division by zero in #if
<br>In file included from /usr/include/linux/sched.h:12,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/jiffies.h: In function &#39;jiffies_to_msecs&#39;:
<br>/usr/include/linux/jiffies.h:253: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)<br>/usr/include/linux/jiffies.h:253: error: (Each undeclared identifier is reported only once<br>/usr/include/linux/jiffies.h:253: error: for each function it appears in.)
<br>/usr/include/linux/jiffies.h:259:46: error: division by zero in #if<br>/usr/include/linux/jiffies.h: In function &#39;jiffies_to_usecs&#39;:<br>/usr/include/linux/jiffies.h:264: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)
<br>/usr/include/linux/jiffies.h:272:46: error: division by zero in #if<br>/usr/include/linux/jiffies.h: In function &#39;msecs_to_jiffies&#39;:<br>/usr/include/linux/jiffies.h:277: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)
<br>/usr/include/linux/jiffies.h:285:46: error: division by zero in #if<br>/usr/include/linux/jiffies.h: In function &#39;usecs_to_jiffies&#39;:<br>/usr/include/linux/jiffies.h:290: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)
<br>/usr/include/linux/jiffies.h: In function &#39;timespec_to_jiffies&#39;:<br>/usr/include/linux/jiffies.h:309: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)<br>/usr/include/linux/jiffies.h:315: error: &#39;SHIFT_HZ&#39; undeclared (first use in this function)
<br>/usr/include/linux/jiffies.h: In function &#39;jiffies_to_timespec&#39;:<br>/usr/include/linux/jiffies.h:328: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)<br>/usr/include/linux/jiffies.h: In function &#39;timeval_to_jiffies&#39;:
<br>/usr/include/linux/jiffies.h:350: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)<br>/usr/include/linux/jiffies.h:354: error: &#39;SHIFT_HZ&#39; undeclared (first use in this function)<br>/usr/include/linux/jiffies.h: In function &#39;jiffies_to_timeval&#39;:
<br>/usr/include/linux/jiffies.h:366: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)<br>/usr/include/linux/jiffies.h: At top level:<br>/usr/include/linux/jiffies.h:377: error: expected &#39;=&#39;, &#39;,&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;__attribute__&#39; before &#39;jiffies_to_clock_t&#39;
<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:379:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h: In function &#39;clock_t_to_jiffies&#39;:<br>/usr/include/linux/jiffies.h:391: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if
<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h:410:6: error: division by zero in #if<br>/usr/include/linux/jiffies.h: In function &#39;jiffies_64_to_clock_t&#39;:
<br>/usr/include/linux/jiffies.h:411: error: &#39;CONFIG_HZ&#39; undeclared (first use in this function)<br>In file included from /usr/include/linux/bitmap.h:8,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/cpumask.h:86,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:15,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/string.h: At top level:<br>/usr/include/linux/string.h:16: error: expected identifier or &#39;(&#39; before &#39;__extension__&#39;
<br>/usr/include/linux/string.h:16: error: expected identifier or &#39;(&#39; before &#39;)&#39; token<br>/usr/include/linux/string.h:17: error: expected identifier or &#39;(&#39; before &#39;__extension__&#39;<br>/usr/include/linux/string.h:17: error: expected identifier or &#39;(&#39; before &#39;)&#39; token
<br>/usr/include/linux/string.h:18: error: expected identifier or &#39;(&#39; before &#39;__extension__&#39;<br>/usr/include/linux/string.h:18: error: expected identifier or &#39;(&#39; before &#39;)&#39; token<br>/usr/include/linux/string.h:19: error: expected identifier or &#39;(&#39; before &#39;__extension__&#39;
<br>/usr/include/linux/string.h:19: error: expected identifier or &#39;(&#39; before &#39;)&#39; token<br>In file included from /usr/include/linux/string.h:24,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/bitmap.h:8,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/cpumask.h:86,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:15,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/string.h:30: error: expected declaration specifiers or &#39;...&#39; before numeric constant
<br>/usr/include/asm/string.h:30: error: expected &#39;)&#39; before &#39;!=&#39; token<br>/usr/include/asm/string.h:30: error: expected &#39;)&#39; before &#39;?&#39; token<br>/usr/include/asm/string.h:44: error: expected declaration specifiers or &#39;...&#39; before numeric constant
<br>/usr/include/asm/string.h:44: error: expected &#39;)&#39; before &#39;!=&#39; token<br>/usr/include/asm/string.h:44: error: expected &#39;)&#39; before &#39;?&#39; token<br>/usr/include/asm/string.h:63: error: expected declaration specifiers or &#39;...&#39; before numeric constant
<br>/usr/include/asm/string.h:63: error: expected &#39;)&#39; before &#39;!=&#39; token<br>/usr/include/asm/string.h:63: error: expected &#39;)&#39; before &#39;?&#39; token<br>/usr/include/asm/string.h:80: error: expected declaration specifiers or &#39;...&#39; before numeric constant
<br>/usr/include/asm/string.h:80: error: expected &#39;)&#39; before &#39;!=&#39; token<br>/usr/include/asm/string.h:80: error: expected &#39;)&#39; before &#39;?&#39; token<br>/usr/include/asm/string.h:103: error: expected identifier or &#39;(&#39; before &#39;__extension__&#39;
<br>/usr/include/asm/string.h:103: error: expected identifier or &#39;(&#39; before &#39;)&#39; token<br>/usr/include/asm/string.h:125: error: expected identifier or &#39;(&#39; before &#39;__extension__&#39;<br>/usr/include/asm/string.h:149: error: expected identifier or &#39;(&#39; before &#39;__extension__&#39;
<br>/usr/include/asm/string.h:171: error: static declaration of &#39;strrchr&#39; follows non-static declaration<br>/usr/include/asm/string.h:190: error: static declaration of &#39;strlen&#39; follows non-static declaration
<br>/usr/include/asm/string.h:327: error: expected declaration specifiers or &#39;...&#39; before numeric constant
<br>/usr/include/asm/string.h:327: error: expected &#39;)&#39; before &#39;!=&#39; token<br>/usr/include/asm/string.h:327: error: expected &#39;)&#39; before &#39;?&#39; token<br>/usr/include/asm/string.h:333: error: static declaration of &#39;memchr&#39; follows non-static declaration
<br>/usr/include/string.h:67: error: previous declaration of &#39;memchr&#39; was here<br>In file included from /usr/include/linux/list.h:7,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/wait.h:23,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/asm/semaphore.h:41,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:20,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/prefetch.h: In function &#39;prefetch_range&#39;:
<br>/usr/include/linux/prefetch.h:64: error: &#39;CONFIG_X86_L1_CACHE_SHIFT&#39; undeclared (first use in this function)<br>In file included from /usr/include/linux/rwsem.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/asm/semaphore.h:42,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:20,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/rwsem.h: In function &#39;__down_read&#39;:
<br>/usr/include/asm/rwsem.h:105: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;<br>/usr/include/asm/rwsem.h: In function &#39;__down_write&#39;:<br>/usr/include/asm/rwsem.h:157: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;
<br>/usr/include/asm/rwsem.h: In function &#39;__up_read&#39;:<br>/usr/include/asm/rwsem.h:194: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;<br>/usr/include/asm/rwsem.h: In function &#39;__up_write&#39;:
<br>/usr/include/asm/rwsem.h:220: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;
<br>/usr/include/asm/rwsem.h: In function &#39;__downgrade_write&#39;:<br>/usr/include/asm/rwsem.h:245: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;<br>In file included from /usr/include/linux/sched.h:20,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-
libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/semaphore.h: In function &#39;down&#39;:<br>/usr/include/asm/semaphore.h:105: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;
<br>/usr/include/asm/semaphore.h: In function &#39;down_interruptible&#39;:<br>/usr/include/asm/semaphore.h:130: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;<br>/usr/include/asm/semaphore.h: In function &#39;down_trylock&#39;:
<br>
/usr/include/asm/semaphore.h:155: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;<br>/usr/include/asm/semaphore.h: In function &#39;up&#39;:<br>/usr/include/asm/semaphore.h:179: error: expected &#39;:&#39; or &#39;)&#39; before &#39;KBUILD_BASENAME&#39;
<br>In file included from /usr/include/linux/signal.h:6,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:28,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/signal.h: At top level:<br>/usr/include/asm/signal.h:24: error: conflicting types for &#39;sigset_t&#39;<br>/usr/include/sys/select.h:38: error: previous declaration of &#39;sigset_t&#39; was here
<br>In file included from /usr/include/linux/signal.h:6,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:28,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/signal.h:117: error: expected &#39;:&#39;, &#39;,&#39;, &#39;;&#39;, &#39;}&#39; or &#39;__attribute__&#39; before &#39;.&#39; token<br>/usr/include/asm/signal.h:123: error: redefinition of &#39;struct sigaction&#39;
<br>/usr/include/asm/signal.h:124: error: expected &#39;:&#39;, &#39;,&#39;, &#39;;&#39;, &#39;}&#39; or &#39;__attribute__&#39; before &#39;.&#39; token
<br>/usr/include/asm/signal.h:151: error: redefinition of &#39;struct sigaltstack&#39;<br>In file included from /usr/include/asm/siginfo.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/signal.h:7,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:28,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm-generic/siginfo.h:7: error: redefinition of &#39;union sigval&#39;
<br>
/usr/include/asm-generic/siginfo.h:40: error: redefinition of &#39;struct siginfo&#39;<br>/usr/include/asm-generic/siginfo.h:75: error: expected specifier-qualifier-list before &#39;clock_t&#39;<br>/usr/include/asm-generic/siginfo.h:251: error: redefinition of &#39;struct sigevent&#39;
<br>In file included from /usr/include/linux/sched.h:28,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/signal.h:180: error: conflicting types for &#39;sigemptyset&#39;
<br>/usr/include/signal.h:216: error: previous declaration of &#39;sigemptyset&#39; was here<br>/usr/include/linux/signal.h:192: error: conflicting types for &#39;sigfillset&#39;<br>/usr/include/signal.h:219: error: previous declaration of &#39;sigfillset&#39; was here
<br>/usr/include/linux/signal.h:261: error: conflicting types for &#39;sigprocmask&#39;<br>/usr/include/signal.h:250: error: previous declaration of &#39;sigprocmask&#39; was here<br>In file included from /usr/include/linux/gfp.h:4,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/slab.h:15,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/percpu.h:5,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:34,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/mmzone.h:41: error: &#39;CONFIG_X86_L1_CACHE_SHIFT&#39; undeclared here (not in a function)<br>/usr/include/linux/mmzone.h:41: error: requested alignment is not a constant
<br>
/usr/include/linux/mmzone.h:64: error: requested alignment is not a constant<br>/usr/include/linux/mmzone.h:249: error: requested alignment is not a constant<br>In file included from /usr/include/linux/sched.h:37,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-
libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/rcupdate.h:69: error: requested alignment is not a constant<br>/usr/include/linux/rcupdate.h:72: error: requested alignment is not a constant
<br>In file included from /usr/include/linux/hrtimer.h:19,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/sched.h:108,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/ktime.h:263: error: expected &#39;=&#39;, &#39;,&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;__attribute__&#39; before &#39;ktime_to_clock_t&#39;<br>In file included from /usr/include/linux/mm.h:15,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/prio_tree.h:45: error: expected specifier-qualifier-list before &#39;pgoff_t&#39;<br>/usr/include/linux/prio_tree.h:50: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>/usr/include/linux/prio_tree.h:50: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;<br>/usr/include/linux/prio_tree.h: In function &#39;prio_tree_iter_init&#39;:<br>/usr/include/linux/prio_tree.h:53: error: &#39;struct prio_tree_iter&#39; has no member named &#39;r_index&#39;
<br>/usr/include/linux/prio_tree.h:53: error: &#39;r_index&#39; undeclared (first use in this function)<br>/usr/include/linux/prio_tree.h:54: error: &#39;struct prio_tree_iter&#39; has no member named &#39;h_index&#39;<br>
/usr/include/linux/prio_tree.h:54: error: &#39;h_index&#39; undeclared (first use in this function)
<br>In file included from /usr/include/linux/stat.h:6,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/fs.h:212,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:16,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from 
main.c:47:<br>/usr/include/asm/stat.h: At top level:<br>/usr/include/asm/stat.h:13: error: expected &#39;:&#39;, &#39;,&#39;, &#39;;&#39;, &#39;}&#39; or &#39;__attribute__&#39; before &#39;.&#39; token<br>/usr/include/asm/stat.h:18: error: redefinition of &#39;struct stat&#39;
<br>/usr/include/asm/stat.h:29: error: expected &#39;:&#39;, &#39;,&#39;, &#39;;&#39;, &#39;}&#39; or &#39;__attribute__&#39; before &#39;.&#39; token<br>/usr/include/asm/stat.h:64: error: expected &#39;:&#39;, &#39;,&#39;, &#39;;&#39;, &#39;}&#39; or &#39;__attribute__&#39; before &#39;.&#39; token
<br>In file included from /usr/include/linux/mm.h:16,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-
libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/fs.h:242: error: expected declaration specifiers or &#39;...&#39; before &#39;sector_t&#39;<br>/usr/include/linux/fs.h:244: error: expected declaration specifiers or &#39;...&#39; before &#39;sector_t&#39;
<br>In file included from /usr/include/linux/mm.h:16,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/fs.h:360: error: expected specifier-qualifier-list before &#39;sector_t&#39;
<br>/usr/include/linux/fs.h:382: error: expected specifier-qualifier-list before &#39;pgoff_t&#39;<br>In file included from /usr/include/asm/fcntl.h:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/fcntl.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/fs.h:736,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:16,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm-generic/fcntl.h:115: error: redefinition of &#39;struct flock&#39;
<br>
In file included from /usr/include/linux/mm.h:16,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/fs.h:960: error: expected declaration specifiers or &#39;...&#39; before &#39;sector_t&#39;
<br>/usr/include/linux/fs.h:1440: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;<br>/usr/include/linux/fs.h:1440: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>/usr/include/linux/fs.h:1450: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>/usr/include/linux/fs.h:1450: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;<br>/usr/include/linux/fs.h:1464: error: expected &#39;=&#39;, &#39;,&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;__attribute__&#39; before &#39;bmap&#39;
<br>In file included from /usr/include/asm/fixmap.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/asm/pgtable.h:17,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/mm.h:38,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/acpi.h:31:28: error: acpi/pdc_intel.h: No such file or directory
<br>In file included from /usr/include/linux/skbuff.h:26,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-
libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/mm.h:249: error: expected specifier-qualifier-list before &#39;pgoff_t&#39;<br>In file included from /usr/include/linux/skbuff.h:26,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/mm.h: In function &#39;lowmem_page_address&#39;:<br>/usr/include/linux/mm.h:517: error: &#39;CONFIG_PAGE_OFFSET&#39; undeclared (first use in this function)<br>/usr/include/linux/mm.h: At top level:
<br>/usr/include/linux/mm.h:577: error: expected &#39;=&#39;, &#39;,&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;__attribute__&#39; before &#39;page_index&#39;<br>/usr/include/linux/mm.h:691: error: expected specifier-qualifier-list before &#39;pgoff_t&#39;
<br>/usr/include/linux/mm.h:902: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>/usr/include/linux/mm.h:905: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;<br>/usr/include/linux/mm.h:915: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>/usr/include/linux/mm.h:963: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>/usr/include/linux/mm.h:965: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;<br>/usr/include/linux/mm.h:969: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>/usr/include/linux/mm.h:972: error: expected declaration specifiers or &#39;...&#39; before &#39;pgoff_t&#39;
<br>In file included from /usr/include/linux/poll.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:28,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/poll.h:20: error: redefinition of &#39;struct pollfd&#39;<br>
In file included from /usr/include/linux/skbuff.h:29,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/net.h:83: error: redeclaration of enumerator &#39;SOCK_STREAM&#39;<br>/usr/include/bits/socket.h:43: error: previous definition of &#39;SOCK_STREAM&#39; was here<br>
/usr/include/linux/net.h:84: error: redeclaration of enumerator &#39;SOCK_DGRAM&#39;
<br>/usr/include/bits/socket.h:46: error: previous definition of &#39;SOCK_DGRAM&#39; was here<br>/usr/include/linux/net.h:85: error: redeclaration of enumerator &#39;SOCK_RAW&#39;<br>/usr/include/bits/socket.h:49: error: previous definition of &#39;SOCK_RAW&#39; was here
<br>/usr/include/linux/net.h:86: error: redeclaration of enumerator &#39;SOCK_RDM&#39;<br>/usr/include/bits/socket.h:51: error: previous definition of &#39;SOCK_RDM&#39; was here<br>/usr/include/linux/net.h:87: error: redeclaration of enumerator &#39;SOCK_SEQPACKET&#39;
<br>/usr/include/bits/socket.h:53: error: previous definition of &#39;SOCK_SEQPACKET&#39; was here<br>/usr/include/linux/net.h:89: error: redeclaration of enumerator &#39;SOCK_PACKET&#39;<br>/usr/include/bits/socket.h:60: error: previous definition of &#39;SOCK_PACKET&#39; was here
<br>In file included from /usr/include/linux/module.h:23,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/textsearch.h:9,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/skbuff.h:30,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/linux/if_ether.h:110,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/asm/module.h:62:2: error: #error unknown processor family
<br>In file included from /usr/include/linux/if_ether.h:110,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /usr/include/net/ethernet.h:27,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/busybox/bluez/bluez-libs-2.25/install/usr/include/bluetooth/bnep.h:32,<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from main.c:47:<br>/usr/include/linux/skbuff.h:31:26: error: net/checksum.h: No such file or directory<br>main.c: In function &#39;run_devup&#39;:<br>main.c:93: warning: passing argument 2 of &#39;__builtin___sprintf_chk&#39; makes pointer from integer without a cast
<br>main.c:108: error: &#39;struct sigaction&#39; has no member named &#39;__sigaction_handler&#39;<br>main.c: In function &#39;write_pidfile&#39;:<br>main.c:449: warning: ignoring return value of &#39;fscanf&#39;, declared with attribute warn_unused_result
<br>main.c: In function &#39;main&#39;:<br>main.c:671: error: &#39;struct sigaction&#39; has no member named &#39;sa_flags&#39;<br>main.c:672: error: &#39;struct sigaction&#39; has no member named &#39;__sigaction_handler&#39;
<br>main.c:676: error: &#39;struct sigaction&#39; has no member named &#39;__sigaction_handler&#39;
<br>main.c:679: error: &#39;struct sigaction&#39; has no member named &#39;__sigaction_handler&#39;<br>main.c:694: warning: ignoring return value of &#39;chdir&#39;, declared with attribute warn_unused_result<br>make[2]: *** [
main.o] Error 1<br>
make[2]: Leaving directory `/home/busybox/bluez/bluez-utils-2.25/pand&#39;<br>make[1]: *** [all-recursive] Error 1<br>make[1]: Leaving directory `/home/busybox/bluez/bluez-utils-2.25&#39;<br>make: *** [all] Error 2<br><br>

can you guide me and suggest me where i am going wrong .waiting for your valuable suggestions<br><br>Regards<br>Umesh<br>

------=_Part_143542_12704694.1187696785752--


--===============0290898425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0290898425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0290898425==--
