Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bgsmith@bendcable.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1148930801.6559.5.camel@localhost.localdomain>
References: <1148930801.6559.5.camel@localhost.localdomain>
Date: Mon, 29 May 2006 22:36:12 +0200
Message-Id: <1148934972.31689.118.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] DiNovo keyboard/mouse and FC5
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

Hi Brad,

> I have a Logitech dinovo keyboard and mouse combination that use
> bluetooth.  The computer is running FC5 (x86-64).  The mouse and
> keyboard will work briefly during boot, but stop working after boot is
> complete.  
> 
> I can get the mouse and keyboard to start working again if I unplug the
> bluetooth receiver from the UBB port and then plug it back in.  This
> happens, naturally, every time I have to reboot (usually seldom).
> 
> Is there a way I can set up this system so that the mouse and keyboard
> just work without having to manually unplug and plug in the USB
> connector?

you can tweak the init scripts to not execute hid2hci and you dongle
will stay in HID proxy. Or you must run hidd in server mode and at least
connect once to your keyboard and mouse with hidd in client mode.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
