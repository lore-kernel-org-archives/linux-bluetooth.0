Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4492B250.000111.26041@bj163app70.163.com>
References: <mailman.0.1150463548.25144.bluez-users@lists.sourceforge.net>
	<4492B250.000111.26041@bj163app70.163.com>
Date: Sat, 17 Jun 2006 12:16:19 +0200
Message-Id: <1150539379.17539.8.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] l2ping issues
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

Hi,

> I have 2 issues with l2ping. bluz version is as the following:
> rpm info:
> linux-l20w:~ # rpm -qa|grep bluez
> bluez-utils-2.24-17
> bluez-libs-2.24-10
> 
> 1. l2ping failed to ping itself
> linux-l20w:~ # hciconfig
> hci0:   Type: USB
>         BD Address: 00:0E:9B:DD:E4:D1 ACL MTU: 377:10 SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:5545 acl:3 sco:0 events:193 errors:0
>         TX bytes:4482 acl:3 sco:0 commands:168 errors:0
> 
> linux-l20w:~ # lsmod|grep -E "l2cap|rfcomm|bcm203x"
> rfcomm                 32408  5
> l2cap                  20740  14 hidp,bnep,rfcomm
> bluetooth              41188  10
> hidp,bnep,rfcomm,l2cap,hci_vhci,hci_usb
> linux-l20w:~ # l2ping 00:0E:9B:DD:E4:D1
> Can't connect: No route to host
> 
> Is this normal or correct?
> 
> 2. I can run hciemu to emulate a faked bluetooth device, but the
> l2ping still failed. Is that normal or correct?
> linux-l20w:~ # modprobe hci_vhci
> linux-l20w:~ # ls /dev/vhci -l
> crw-rw---- 1 root root 10, 62 Jun 15 07:51 /dev/vhci
> linux-l20w:~ # hciemu 00:0E:9B:DD:E4:D2
> linux-l20w:~ # hciconfig
> hci0:   Type: USB
>         BD Address: 00:0E:9B:DD:E4:D1 ACL MTU: 377:10 SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:203 acl:0 sco:0 events:28 errors:0
>         TX bytes:876 acl:0 sco:0 commands:28 errors:0
> 
> hci1:   Type: VHCI
>         BD Address: 00:0E:9B:DD:E4:D2 ACL MTU: 192:8 SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:0 acl:0 sco:0 events:15 errors:0
>         TX bytes:569 acl:0 sco:0 commands:15 errors:0
> 
> linux-l20w:~ # l2ping  00:0E:9B:DD:E4:D2
> Can't connect: Host is down

you can't connect a virtual HCI device to a real device. It is not
working this way. Use either two real or two virtual devices.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
