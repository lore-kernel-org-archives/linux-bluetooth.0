Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <pypaulus@alterwave.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Wed, 05 Jul 2006 15:47:04 +0200
Message-Id: <1152107225.15040.48.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Nothing to read on /dev/rfcomm0
Reply-To: pypaulus@alterwave.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hello everyone,

I'm trying to to perform an OBEX push. Using the D-Bus API, I can get
connected to the device. /dev/rfcomm0 gets created, and I can write to
it. But I can't read anything out of it, I always get EOF.

Here is what I do:

-Get the RFCOMM object from D-Bus
-Call ConnectByChannel(address, channel);
-At this point my phone prompts me and ask me if I want to accept the
transfer or not. Of course, I accept it.
-/dev/rfcomm0 gets created.
-I start a stupid c program which tries to read /dev/rfcomm and shows
what it reads on the terminal as hex (char *input[1]; fscanf(stream, "%
c", input); printf("%x ", input[0]);
-I write new byte[] { (byte)0x80, 0x00, 0x07, 0x10, 0x00, 0x20, 0x00};
to /dev/rfcomm0 (that's an OBEX connect sequence as you know, this part
is from some java code). From hcidump -X I can see it being sent to the
device:

< ACL data: handle 42 flags 0x02 dlen 15
    L2CAP(d): cid 0x008f len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 7 fcs 0xce
      0000: 80 00 07 10 00 20 00                              ..... .

-The device does answer:

> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 4
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 7 fcs 0x8 credits 1
      0000: a0 00 07 10 00 07 fc 

And the last line above (which is the OBEX connection acceptance
sequence) never shows up on /dev/rfcomm0. What is wrong here?




Just afterwards, /dev/rfcomm0 get disconnected and the whole hcid does
crash because of some memory error I didn't have looked at so far. Some
info if it may help anybody:

hcid[19317]: Bluetooth HCI daemon
hcid[19317]: Register path:/org/bluez fallback:1
hcid[19317]: Device hci0 has been added
hcid[19317]: Starting security manager 0
hcid[19317]: Device hci0 has been activated
hcid[19317]: Register path:/org/bluez/hci0 fallback:0
hcid[19317]: Connect in progress
hcid[19317]: rfcomm_connect_cb: connected
hcid[19317]: Chmod return: 0
hcid[19317]: RFCOMM node /dev/rfcomm0 was disconnected
*** glibc detected *** corrupted double-linked list: 0x0806e8c8 ***
Aborted

(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7e00101 in raise () from /lib/tls/libc.so.6
#2  0xb7e017fd in abort () from /lib/tls/libc.so.6
#3  0xb7e32ef7 in __fsetlocking () from /lib/tls/libc.so.6
#4  0xb7e38c16 in malloc_usable_size () from /lib/tls/libc.so.6
#5  0xb7e38da1 in malloc_usable_size () from /lib/tls/libc.so.6
#6  0xb7e392df in malloc_usable_size () from /lib/tls/libc.so.6
#7  0xb7e395d9 in free () from /lib/tls/libc.so.6
#8  0xb7ef3f5e in hci_for_each_dev () from /usr/lib/libbluetooth.so.2
#9  0xb7ef42d4 in hci_devid () from /usr/lib/libbluetooth.so.2
#10 0x08053f46 in hcid_dbus_disconn_complete (local=0x0, status=0 '\0',
handle=42, reason=22 '\026')
    at dbus.c:1236
#11 0x0804d1a0 in io_security_event (chan=0x806c788, cond=G_IO_IN,
data=0x806c728) at security.c:607
#12 0x0805feba in g_main_loop_run (loop=0x8066b08) at glib-ectomy.c:305
#13 0x0804c7db in main (argc=0, argv=0x0) at main.c:729

(For some reason, line numbers do not show up for libluetooth.so.2 in
the bt, even if I did add "-g" to the CFLAGS in the Makefile. Do I have
to do something else/more to get the full information?)


Thanks in advance,
Best Regards.

Pierre-Yves


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
