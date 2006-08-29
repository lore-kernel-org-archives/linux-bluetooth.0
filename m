Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 29 Aug 2006 10:23:33 +0200
Message-Id: <1156839814.8576.104.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] hcid crash
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

There seems to be a bug causing a crash in hcid, ver. 3.4.

1) Using the DBus API, I open an RFCOMM connection to the OPP channel on
a phone (tested with nokia n-gage and SE Z600)

2) Once the connection is established, I shut the phone down, or force a
bluetooth shtudown (only possible on the nokia, not allowed on the SE)

3) hcid will crash (instantly with the nokia, after a few seconds with
the SE).

Backtrace:

# gdb --quiet --args hcid -xn
Using host libthread_db library "/lib/tls/libthread_db.so.1".
(gdb) run
Starting program: /usr/sbin/hcid -xn
hcid[14874]: Bluetooth HCI daemon
hcid[14874]: Register path:/org/bluez fallback:1
hcid[14874]: HCI dev 0 registered
hcid[14874]: Register path:/org/bluez/hci0 fallback:0
hcid[14874]: HCI dev 0 already up
hcid[14874]: Device hci0 has been added
hcid[14874]: Starting security manager 0
hcid[14874]: Device hci0 has been activated
hcid[14874]: Connect in progress
hcid[14874]: rfcomm_connect_cb: connected
hcid[14874]: RFCOMM node /dev/rfcomm0 was disconnected
*** glibc detected *** double free or corruption (fasttop): 0x080708d8
***

Program received signal SIGABRT, Aborted.
0xffffe410 in __kernel_vsyscall ()
(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7e44101 in raise () from /lib/tls/libc.so.6
#2  0xb7e457fd in abort () from /lib/tls/libc.so.6
#3  0xb7e76ef7 in __fsetlocking () from /lib/tls/libc.so.6
#4  0xb7e7cc16 in malloc_usable_size () from /lib/tls/libc.so.6
#5  0xb7e7d5d9 in free () from /lib/tls/libc.so.6
#6  0x08061096 in watch_remove (w=0x0) at glib-ectomy.c:116
#7  0x0806146c in g_main_loop_run (loop=0x806a108) at glib-ectomy.c:324
#8  0x0804c59b in main (argc=0, argv=0x0) at main.c:729

It is always reproducible here. I'll be glad to give any other output or
info that may prove useful, just ask.

Regards

Pierre-Yves


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
