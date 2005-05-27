Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Early failures with Treo 650
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <429682D6.2020800@gmail.com>
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>
	 <4292938B.2090000@gmail.com> <1116924491.30044.131.camel@pegasus>
	 <429553F1.7020604@gmail.com> <1117095364.12036.14.camel@pegasus>
	 <429682D6.2020800@gmail.com>
Content-Type: text/plain
Message-Id: <1117177537.12036.90.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 27 May 2005 09:05:37 +0200

Hi David,

> >>>what kind of USB dongle is this?
> >>
> >>The USB dongle is a "Kensington Bluetooth USB Adapter".
> > 
> > be a little bit more specific.
> 
> I would have been more specific, the only other distinguishing thing on
> it is the model number:
> 
> Kensington Bluetooth USB Adapter
> Model #33085
> 
> Here is the product info page:
> http://www.kensington.com/html/6397.html

I hate companies that are not able to clearly name their product. Once
they build another Bluetooth adapter you can't differentiate between
them :(

It seems that this dongle is not available in Germany. Does anyone have
a spare one for me?

> > So here we go. You can first try to load the hci_usb module with the
> > reset=1 parameter, but I doubt that it helps for this dongle. What you
> > need will be the attached patch to switch it from HID into HCI mode.
> 
> Excellent!  The patch did it (after also loading with the reset=1).  I'm
> now on my way trying to set up a PPP connection.

So loading with "modprobe hci_usb reset=1" and without the patch doesn't
make it work? Don't using "reset=1" and applying the patch does also not
work? Only when you do both things the dongle is working. This is odd,
because one of my previous Broadcom based dongles like this only needed
the BCM92035 quirk to switch from HID into HCI mode. Please test all
possibilities so I can add the correct quirk to the kernel.

If you add HCI_RESET to the line for your device it will have the same
effect as if you provide "reset=1" on module loading.

> Thanks a lot for the
> curteous help Marcel.

You are welcome.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
