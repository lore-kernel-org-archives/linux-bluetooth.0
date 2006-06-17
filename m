Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4493FEAF.3000904@uni-koblenz.de>
Date: Sat, 17 Jun 2006 15:07:59 +0200
From: Kevin Read <kread@uni-koblenz.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Multiple connections with kernel 2.4 make HCI die
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I know that kernel 2.4 is no longer supported, but I hope that somebody 
can give me a clue here...

I'm attempting to create a multi-threaded, multi-dongle OBEX client
appliance. When I run it on a kernel 2.6 based machine (either a x86 or
on a NSLU2, which is a big-endian ARM box), everything runs very smooth.

The same code compiled for a little endian MIPS machine running kernel
2.4.30 has problems. I cannot change the kernel version, because the
on-board Broadcom wireless chipset of the router doesn't really work yet
  under kernel 2.6 (damn closed source drivers) :(

When one bt interface does device discovery and another interface does
service discovery and the RFCOMM transfers, everything is fine. As soon
as data is sent/received over two connections simultaneously, the HCIs
begin to "die" - they don't respond to hciconfig reset/up/down commands
and all data transmissions time out, as do SDP connects. If I 'hciconfig
down' the interfaces, they don't come up again afterwards. The only
thing that helps is re-plugging the dongles. Re-loading hci-usb or the
uhci drivers is not enough, although all interfaces show as "up" again
afterwards. They still time out, though.

This hang might come after a few kb's of simultenous data was sent, or
after up to two megabyte have been transferred. It comes quicker when
two dongles transmit data simultaneously, but also happens when I have
two active RFCOMM connections on one dongle.

I have applied the changes in the 2.4.32 patch by Marcel, but I think
they only refer to module unloading. Bluez installed is version 2.32. I
already stressed the USB bus with wireless and a hard disk, to rule out
that the usb driver has some funkiness, but everything went smooth.

It would be great if somebody could help me here, I'm totally stuck. I
can give out shell access to the router, if that is of any help with
this problem.

Best regards,

Kevin



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
