Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with kernel-2.6.5
Message-ID: <20040421130948.GA15330@gmx.net>
References: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 21 Apr 2004 15:09:48 +0200

On  0, Timothy Murphy <tim@birdsnest.maths.tcd.ie> wrote:
> I wonder if anyone has had a problem with Bluetooth in linux-2.6.5?
> I have a Sony C1VFK Picturebook with built-in bluetooth.
> Everything works fine in 2.6.3,
> buit when I go to 2.6.5 I get the oops below.
> I should say that this occurs after "service bluetooth restart" 
> and "spicctrl -l1" 
> (the latter being required to activate bluetooth on this machine).
> 
> It is possible that this has nothing to do with bluetooth,
> and is a USB problem.

It is probably a bug in the USB Subsystem of 2.6.5, which appears when
the module hci_usb is already loaded befor the USB BT dongle is
connected to the USB bus. I don't know the way your internal BT is
realized. You might try to unload the hci_usb driver, activate the bt
subsystem and then load it again. Or you just compile your kernel
without the SCO support for hci_usb.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
