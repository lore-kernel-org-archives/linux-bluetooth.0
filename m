Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Thu, 3 Jul 2008 17:53:49 +0000 (UTC)
Message-ID: <loom.20080703T174456-410@post.gmane.org>
References: <loom.20080703T025528-873@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-users] scotest problem
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

I just tried to install Ubuntu 7.10 (linux 2.6.22) 
And the scotest works between two PCs (each with a usb dongle on it)
After that, I rebuild with the patched kernel 2.6.23 in an old way
(make all modules_install install;  mkinitramfs /boot/initrd-2.6.23 2.6.23)
But the thing becomes worse that "hcitool -i hci0 scan" can't see anything.
There are some error message in the dmesg
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb ee84b414 err -90

Actually I have also tested the patched kernel in Ubuntu 6.06, and it works in a
half way.
(The the client can send and receive packet while the server just halt on
"Receiving..")
What could be the reason? is there any better way to try this?
Hope someone can share the experience.

Really really need help


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
