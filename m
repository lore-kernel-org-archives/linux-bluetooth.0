Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060517221929.76231.qmail@web54604.mail.yahoo.com>
References: <20060517221929.76231.qmail@web54604.mail.yahoo.com>
Date: Mon, 29 May 2006 15:20:25 +0200
Message-Id: <1148908825.31689.41.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Linux control of bluetooth radio
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

Hi Peter,

> I have a dual-boot (WinXP and Mandriva w/ 2.6.14) Dell
> M70 laptop with an internal Bluetooth daughter card. 
> It would seem that I can use WinXP to disable the
> radio on the Bluetooth card.  When I then boot into
> Linux, the BT card is detected and hci0 is initialised
> but Bluetooth doesn't work.
> 
> Is there a way to turn the BT radio on and off under
> Linux ?  (hciconfig up/down and reloading the kernel
> module doesn't seem to work and there's no /proc
> interface)

check /proc/bus/usb/devices if the Bluetooth is present there. Otherwise
you need to find the switch to activate Bluetooth with a Dell laptop. I
don't have a Dell machine, so I don't know what's the magic trick.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
