Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45F176B0.3090507@idlum.be>
Date: Fri, 09 Mar 2007 16:01:04 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Problem with RFCOMM kernel module
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

On a Debian "testing" box running stock debian 2.6.18-3-486 kernel, I 
sometimes get this in my syslog:

kernel: Bluetooth: RFCOMM socket layer initialized
kernel: Bluetooth: RFCOMM TTY layer initialized
kernel: Bluetooth: RFCOMM ver 1.8
kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to 
register things with the same name in the same directory.
kernel:  [<c01a99d3>] kobject_add+0x12e/0x154
kernel:  [<c020186b>] class_device_add+0x9b/0x3a6
kernel:  [<c01a977d>] kobject_get+0xf/0x13
kernel:  [<c0201bfd>] class_device_create+0x77/0x96
kernel:  [<c01eafcb>] tty_register_device+0xa0/0xab
kernel:  [<c01ac3c1>] sprintf+0x1d/0x20
kernel:  [<c82d9520>] rfcomm_dev_ioctl+0x215/0x47a [rfcomm]
kernel:  [<c82d86f4>] rfcomm_sock_ioctl+0x1c/0x2b [rfcomm]
kernel:  [<c021adf8>] sock_ioctl+0x198/0x1ba
kernel:  [<c021ac60>] sock_ioctl+0x0/0x1ba
kernel:  [<c0156bea>] do_ioctl+0x16/0x42
kernel:  [<c0156df9>] vfs_ioctl+0x1e3/0x1f1
kernel:  [<c021c219>] sys_socketcall+0x9f/0x177
kernel:  [<c0156e51>] sys_ioctl+0x4a/0x61
kernel:  [<c0102a47>] syscall_call+0x7/0xb

When it does happen, BT related operations are pretty much screwed up 
until next reboot. For background purposes, the box runs a custom 
application which makes use of Bluez through the DBus bindings, mainly 
to get /dev/rfcommX sockets to various devices, and sending data to them.

What's happening? How to prevent it?

Also, I all the time(obviously when the app is running) get a lot of 
statements like the followings:

l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
hci_acldata_packet: hci1 ACL packet for unknown connection handle 11
hci_acldata_packet: hci1 ACL packet for unknown connection handle 11
hci_acldata_packet: hci1 ACL packet for unknown connection handle 11
hci_acldata_packet: hci1 ACL packet for unknown connection handle 11
hci_acldata_packet: hci1 ACL packet for unknown connection handle 11
hci_acldata_packet: hci1 ACL packet for unknown connection handle 11
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)


What do they mean? What's happening there?


Thanks in advance,
Best Regards

Pierre-Yves Paulus


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
