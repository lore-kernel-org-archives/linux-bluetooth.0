Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <001d01c42a09$847440a0$1401a8c0@amd1>
From: "Alexandre Ghisoli" <alexandre.ghisoli@ycom.ch>
To: <bluez-users@lists.sourceforge.net>
References: <1082745203.718.0.camel@darthvader.linuxkot.kap> <1082808911.16910.18.camel@darthvader.linuxkot.kap> <1082810374.4828.23.camel@pegasus>
Subject: Re: [Bluez-users] Can't get diNovo works in BT :'( help please. (a bit long, sorry)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 24 Apr 2004 16:36:16 +0200

Hum,

On which Kernel ?

Please, take a look to the Bueche's site :
http://www.bueche.ch/comp/mx900/mx900.html

And follow the link for OFeedback section
(http://www.bueche.ch/comp/mx900/feedback/)

I can make diNovo working on Linux.

Hope this Help

    --Alexandre

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Di Pietro Nicolas" <potens@swing.be>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Sent: Saturday, April 24, 2004 2:39 PM
Subject: Re: [Bluez-users] Can't get diNovo works in BT :'( help please. (a
bit long, sorry)


> Hi Nicolas,
>
> > I've found a way to have the mouse working but,... it's odd, dirty and
> > it's not in hci mode :
> > If the mediapad hasn't link at boot time (because I've removed the cells
> > for exemple) the mouse work. After, if the media pad has a link, it
> > doesn't matter with the mouse, it works.
> >
> > if I try hid2hci, I get :
> > Switching device 046d:c704 to HCI mode was successful
> > usb 3-1.2 : new full speed USB deviceusing address 4
> > Bluetooth : Core ver 2.4
> > hci_usb : Unknow symbol hci_free_dev
> > hci_usb : Unknow symbol hci_alloc_dev
> > hci_usb : Unknow symbol hci_unregister_dev
> > hci_usb : Unknow symbol hci_register_dev
> > NET : Registered protocol family 31
> > Bluetooth : HCI device and connection manager initialized
> > Bluetooth : HCI socket layer initialized
> > hci_usb : Unknow symbol hci_free_dev
> > hci_usb : Unknow symbol hci_alloc_dev
> > hci_usb : Unknow symbol hci_unregister_dev
> > hci_usb : Unknow symbol hci_register_dev
> > Bluetooth : HCI USB driverver 2.5
> > drivers/usb/core/usb.c : registered new driver hci_usb
> >
> > and after that, the recivers seems freezed, no more link for
> >  media pad (and for the mouse and the keyboard, I think).
> > If I unplug and replug the hub, it's always in the same state.
> >
> > What's wrong with the keypad and why the hid2hci prog freeze the hub ?
>
> if you switch to HCI mode, you have to run the HID profile by yourself.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
