Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d8640503160537449496dd@mail.gmail.com>
From: Benny <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1110391057.5462.30.camel@notepaq>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_273_30495478.1110980244283"
References: <d1f423d30503071045794c487e@mail.gmail.com>
	 <f54d86405030903455bf71640@mail.gmail.com>
	 <1110391057.5462.30.camel@notepaq>
Subject: [Bluez-users] USSP compilation problem for linux 2.6
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 16 Mar 2005 19:07:24 +0530

------=_Part_273_30495478.1110980244283
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

We have purchased a BT Serial port adapter. I am now involved in
testing this. To one PC I am connecting a Standard BT USB dongle and
to another PC I am connecting the BT Serial port adaptor.

I am facing some problems while compiling(On fedora 3 - linux kernel -
2.6.9-1.667) the "ussp" source found in the "rfcomm-0.10" source
downloaded from the
http://www.holtmann.org/linux/bluetooth/rfcomm.html site.

Is there any bluetooth patch available for linux 2.6.9.

Please find the error log of the compilation.

Anyone has come across this problem?

Please advice.

Thanks & Regards,
Benny

------=_Part_273_30495478.1110980244283
Content-Type: text/plain; name="err.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="err.txt"

-D__KERNEL__ -I/usr/src/linux-2.6/include -I. -DMODULE -Wall -Wstrict-proto=
types -O2   -c -o ussp.o ussp.c
In file included from ussp.c:48:
/usr/include/linux/modversions.h:1:2: #error Modules should never use kerne=
l-headers system headers,
/usr/include/linux/modversions.h:2:2: #error but rather headers from the ap=
propriate kernel package.
/usr/include/linux/modversions.h:3:2: #error Change -I/usr/src/linux/includ=
e (or similar) to
/usr/include/linux/modversions.h:4:2: #error -I/lib/modules/$(uname -r)/bui=
ld/include
/usr/include/linux/modversions.h:5:2: #error to build against the currently=
-running kernel.
In file included from /usr/src/linux-2.6/include/asm/processor.h:18,
                 from /usr/src/linux-2.6/include/asm/thread_info.h:16,
                 from /usr/src/linux-2.6/include/linux/thread_info.h:21,
                 from /usr/src/linux-2.6/include/linux/spinlock.h:12,
                 from /usr/src/linux-2.6/include/linux/capability.h:45,
                 from /usr/src/linux-2.6/include/linux/sched.h:7,
                 from /usr/src/linux-2.6/include/linux/module.h:10,
                 from ussp.c:51:
/usr/src/linux-2.6/include/asm/system.h: In function `__set_64bit_var':
/usr/src/linux-2.6/include/asm/system.h:193: warning: dereferencing type-pu=
nned pointer will break strict-aliasing rules
/usr/src/linux-2.6/include/asm/system.h:193: warning: dereferencing type-pu=
nned pointer will break strict-aliasing rules
In file included from /usr/src/linux-2.6/include/linux/irq.h:20,
                 from /usr/src/linux-2.6/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.6/include/linux/hardirq.h:6,
                 from /usr/src/linux-2.6/include/linux/interrupt.h:11,
                 from ussp.c:57:
/usr/src/linux-2.6/include/asm/irq.h:16:25: irq_vectors.h: No such file or =
directory
In file included from /usr/src/linux-2.6/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.6/include/linux/hardirq.h:6,
                 from /usr/src/linux-2.6/include/linux/interrupt.h:11,
                 from ussp.c:57:
/usr/src/linux-2.6/include/linux/irq.h: At top level:
/usr/src/linux-2.6/include/linux/irq.h:70: error: `NR_IRQS' undeclared here=
 (not in a function)
In file included from /usr/src/linux-2.6/include/linux/irq.h:72,
                 from /usr/src/linux-2.6/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.6/include/linux/hardirq.h:6,
                 from /usr/src/linux-2.6/include/linux/interrupt.h:11,
                 from ussp.c:57:
/usr/src/linux-2.6/include/asm/hw_irq.h:28: error: `NR_IRQ_VECTORS' undecla=
red here (not in a function)
ussp.c:66:26: linux/tqueue.h: No such file or directory
ussp.c:73:29: linux/compatmac.h: No such file or directory
ussp.c: In function `ussp_tty_hangup':
ussp.c:200: error: called object is not a function
ussp.c:200: error: syntax error before string constant
ussp.c:204: error: called object is not a function
ussp.c:204: error: syntax error before string constant
ussp.c: In function `ussp_tty_flush_buffer':
ussp.c:212: error: called object is not a function
ussp.c:212: error: syntax error before string constant
ussp.c:221: error: called object is not a function
ussp.c:221: error: syntax error before string constant
ussp.c:226: error: called object is not a function
ussp.c:226: error: syntax error before string constant
ussp.c: In function `ussp_tty_flush_chars':
ussp.c:232: error: called object is not a function
ussp.c:232: error: syntax error before string constant
ussp.c:233: error: called object is not a function
ussp.c:233: error: syntax error before string constant
ussp.c: In function `ussp_tty_stop':
ussp.c:239: error: called object is not a function
ussp.c:239: error: syntax error before string constant
ussp.c:240: error: called object is not a function
ussp.c:240: error: syntax error before string constant
ussp.c: In function `ussp_tty_start':
ussp.c:246: error: called object is not a function
ussp.c:246: error: syntax error before string constant
ussp.c:247: error: called object is not a function
ussp.c:247: error: syntax error before string constant
ussp.c: In function `ussp_dummy':
ussp.c:253: error: called object is not a function
ussp.c:253: error: syntax error before string constant
ussp.c:254: error: called object is not a function
ussp.c:254: error: syntax error before string constant
ussp.c: In function `ussp_init':
ussp.c:265: error: called object is not a function
ussp.c:265: error: syntax error before string constant
ussp.c:284: warning: assignment makes integer from pointer without a cast
ussp.c:285: error: structure has no member named `table'
ussp.c:318: error: called object is not a function
ussp.c:318: error: syntax error before string constant
ussp.c: In function `copy_to_circular_buffer':
ussp.c:350: error: called object is not a function
ussp.c:350: error: syntax error before string constant
ussp.c:378: error: called object is not a function
ussp.c:378: error: syntax error before string constant
ussp.c: In function `copy_from_circular_buffer':
ussp.c:388: error: called object is not a function
ussp.c:388: error: syntax error before string constant
ussp.c:417: error: called object is not a function
ussp.c:417: error: syntax error before string constant
ussp.c: In function `ussp_write_to_ctl':
ussp.c:428: error: called object is not a function
ussp.c:428: error: syntax error before string constant
ussp.c:431: error: called object is not a function
ussp.c:431: error: syntax error before string constant
ussp.c:439: error: called object is not a function
ussp.c:439: error: syntax error before string constant
ussp.c:484: error: called object is not a function
ussp.c:484: error: syntax error before string constant
ussp.c: In function `ussp_tty_set_termios':
ussp.c:492: error: called object is not a function
ussp.c:492: error: syntax error before string constant
ussp.c:499: error: called object is not a function
ussp.c:499: error: syntax error before string constant
ussp.c: In function `ussp_tty_write':
ussp.c:509: error: called object is not a function
ussp.c:509: error: syntax error before string constant
ussp.c:517: error: called object is not a function
ussp.c:517: error: syntax error before string constant
ussp.c: In function `ussp_tty_put_char':
ussp.c:526: error: called object is not a function
ussp.c:526: error: syntax error before string constant
ussp.c:533: error: called object is not a function
ussp.c:533: error: syntax error before string constant
ussp.c: In function `ussp_tty_open':
ussp.c:544: error: called object is not a function
ussp.c:544: error: syntax error before string constant
ussp.c:546: error: `MOD_INC_USE_COUNT' undeclared (first use in this functi=
on)
ussp.c:546: error: (Each undeclared identifier is reported only once
ussp.c:546: error: for each function it appears in.)
ussp.c:548: error: structure has no member named `device'
ussp.c:549: error: structure has no member named `tty'
ussp.c:557: error: called object is not a function
ussp.c:557: error: syntax error before string constant
ussp.c:580: error: structure has no member named `device'
ussp.c:591: warning: `interruptible_sleep_on' is deprecated (declared at /u=
sr/src/linux-2.6/include/linux/wait.h:290)
ussp.c:594: error: called object is not a function
ussp.c:594: error: syntax error before string constant
ussp.c:614: error: structure has no member named `leader'
ussp.c:614: error: structure has no member named `tty'
ussp.c:615: error: structure has no member named `leader'
ussp.c:615: error: structure has no member named `tty'
ussp.c:617: error: structure has no member named `tty'
ussp.c:618: error: structure has no member named `tty_old_pgrp'
ussp.c:619: error: structure has no member named `session'
ussp.c:620: error: structure has no member named `pgrp'
ussp.c:623: error: called object is not a function
ussp.c:623: error: syntax error before string constant
ussp.c: In function `ussp_tty_close':
ussp.c:633: error: called object is not a function
ussp.c:633: error: syntax error before string constant
ussp.c:657: error: `MOD_DEC_USE_COUNT' undeclared (first use in this functi=
on)
ussp.c:658: error: called object is not a function
ussp.c:658: error: syntax error before string constant
ussp.c: In function `ussp_tty_ioctl':
ussp.c:669: error: called object is not a function
ussp.c:669: error: syntax error before string constant
ussp.c:675: error: called object is not a function
ussp.c:675: error: syntax error before string constant
ussp.c:684: warning: implicit declaration of function `Put_user'
ussp.c:697: warning: implicit declaration of function `Get_user'
ussp.c:725: error: called object is not a function
ussp.c:725: error: syntax error before string constant
ussp.c: In function `ussp_tty_write_room':
ussp.c:735: error: called object is not a function
ussp.c:735: error: syntax error before string constant
ussp.c:746: error: called object is not a function
ussp.c:746: error: syntax error before string constant
ussp.c: In function `ussp_ctl_open':
ussp.c:754: error: called object is not a function
ussp.c:754: error: syntax error before string constant
ussp.c:756: error: `MOD_INC_USE_COUNT' undeclared (first use in this functi=
on)
ussp.c:758: error: called object is not a function
ussp.c:758: error: syntax error before string constant
ussp.c: In function `ussp_ctl_ioctl':
ussp.c:769: error: called object is not a function
ussp.c:769: error: syntax error before string constant
ussp.c:791: error: called object is not a function
ussp.c:791: error: syntax error before string constant
ussp.c:808: warning: implicit declaration of function `get_free_page'
ussp.c:817: error: called object is not a function
ussp.c:817: error: syntax error before string constant
ussp.c:826: error: called object is not a function
ussp.c:826: error: syntax error before string constant
ussp.c:833: error: called object is not a function
ussp.c:833: error: syntax error before string constant
ussp.c:841: error: called object is not a function
ussp.c:841: error: syntax error before string constant
ussp.c: In function `ussp_ctl_read':
ussp.c:851: error: called object is not a function
ussp.c:851: error: syntax error before string constant
ussp.c:854: error: called object is not a function
ussp.c:854: error: syntax error before string constant
ussp.c:860: error: called object is not a function
ussp.c:860: error: syntax error before string constant
ussp.c:865: warning: `interruptible_sleep_on' is deprecated (declared at /u=
sr/src/linux-2.6/include/linux/wait.h:290)
ussp.c:867: error: called object is not a function
ussp.c:867: error: syntax error before string constant
ussp.c:878: error: called object is not a function
ussp.c:878: error: syntax error before string constant
ussp.c:891: error: called object is not a function
ussp.c:891: error: syntax error before string constant
ussp.c: In function `ussp_ctl_write':
ussp.c:902: error: called object is not a function
ussp.c:902: error: syntax error before string constant
ussp.c:908: error: called object is not a function
ussp.c:908: error: syntax error before string constant
ussp.c:913: error: called object is not a function
ussp.c:913: error: syntax error before string constant
ussp.c:922: error: called object is not a function
ussp.c:922: error: syntax error before string constant
ussp.c:958: error: called object is not a function
ussp.c:958: error: syntax error before string constant
ussp.c: In function `ussp_ctl_close':
ussp.c:967: error: called object is not a function
ussp.c:967: error: syntax error before string constant
ussp.c:996: error: `MOD_DEC_USE_COUNT' undeclared (first use in this functi=
on)
ussp.c:997: error: called object is not a function
ussp.c:997: error: syntax error before string constant
ussp.c: In function `ussp_ctl_poll':
ussp.c:1008: error: called object is not a function
ussp.c:1008: error: syntax error before string constant
ussp.c:1026: error: called object is not a function
ussp.c:1026: error: syntax error before string constant
ussp.c: In function `ussp_tty_chars_in_buffer':
ussp.c:1036: error: called object is not a function
ussp.c:1036: error: syntax error before string constant
ussp.c:1040: error: called object is not a function
ussp.c:1040: error: syntax error before string constant
ussp.c: In function `init_ussp_module':
ussp.c:1050: error: called object is not a function
ussp.c:1050: error: syntax error before string constant
ussp.c:1054: error: called object is not a function
ussp.c:1054: error: syntax error before string constant
ussp.c: In function `exit_ussp_module':
ussp.c:1062: error: called object is not a function
ussp.c:1062: error: syntax error before string constant
ussp.c:1070: error: called object is not a function
ussp.c:1070: error: syntax error before string constant
ussp.c: At top level:
ussp.c:1077: warning: type defaults to `int' in declaration of `EXPORT_NO_S=
YMBOLS'
ussp.c:1077: warning: data definition has no type or storage class
make: *** [ussp.o] Error 1


------=_Part_273_30495478.1110980244283--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
