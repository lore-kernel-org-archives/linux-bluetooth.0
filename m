Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1826221353@web.de>
References: <1826221353@web.de>
Date: Mon, 04 Jun 2007 17:23:32 +0200
Message-Id: <1180970612.13429.54.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez-utils on old kernel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Phillip,

> I'm trying to add bluetooth support to my arm based NAS which runs on
> a 2.6.10 Kernel.
> 
> I compiled the bluez-libs and utils (3.11) but hcitool dev won't
> show any devices and when I exec hciconfig I get
> 
> icybox / # /system/overlay/apps/bluez-utils/sbin/hciconfig
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN INIT RUNNING
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
> 
> so I think the device is somehow active but I can't nether reset nor
> do anything usefull with the bw-dongel.

I have no idea what went wrong, but it looks like an init issue and is
maybe actually a kernel bug that we already fixed.

> I then tried to apply the latest kernelpatch to the 2.6.10 kernel
> which gives lots of errors

This will never work. The patch has 2.6.21 in its name and that means it
only applied to 2.6.21 source code.

> My question is: is it possoble to upgrade the kernel (bluetooth) step by
> step because a jump from 2.6.10 to 2.6.21 is quite big i guess.
> Or do i make something else wrong?

Upgrading the kernel to 2.6.21 is easier. It might be possible to
backport all the Bluetooth patches, but that takes time and I would
personally charge a lot for doing that.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
