Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] can't establish a connection
References: <1091742606.6143.17.camel@localhost> <1092727197.12606.1.camel@localhost> <1092728177.31651.6.camel@pegasus>
In-Reply-To: <1092728177.31651.6.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200408170949.50588.cijoml@volny.cz>
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
Date: Tue, 17 Aug 2004 09:49:50 +0200

Hi Marcel,

better way is to buy a better dongle  (CSR based) ;-)

M.

Dne =FAt 17. srpna 2004 09:36 Marcel Holtmann napsal(a):
> Hi Ben,
>
> > I still cannot use my broadcom bluetooth dongle. It doesn't seem to be a
> > usb relevant problem. (as far as I know, cause I'm a newbie).
> >
> > This is what I get when I plug my dongle.
> >
> > tail -f /var/log/messages | grep usb
> >
> > Aug 16 11:17:25 localhost kernel: usb 1-1: new full speed USB device
> > using address 10
> > Aug 16 11:17:27 localhost kernel: usb 1-1.1: new full speed USB device
> > using address 11
> > Aug 16 11:17:28 localhost kernel: hci_usb_isoc_rx_submit: hci0 isoc rx
> > submit failed urb c1cb1014 err -90
> > Aug 16 11:17:28 localhost kernel: hci_usb_isoc_rx_submit: hci0 isoc rx
> > submit failed urb c1cb1014 err -90
> > Aug 16 11:17:30 localhost kernel: usb 1-1.2: new full speed USB device
> > using address 12
> > Aug 16 11:17:31 localhost kernel: input: USB HID v1.11 Keyboard
> > [0a5c:3502] on usb-0000:00:07.2-1.2
> > Aug 16 11:17:32 localhost kernel: usb 1-1.3: new full speed USB device
> > using address 13
> > Aug 16 11:17:33 localhost kernel: input: USB HID v1.11 Mouse [0a5c:3503]
> > on usb-0000:00:07.2-1.3
> >
> >
> > lsusb
> > Bus 002 Device 001: ID 0000:0000
> > Bus 001 Device 013: ID 0a5c:3503 Broadcom Corp.
> > Bus 001 Device 012: ID 0a5c:3502 Broadcom Corp.
> > Bus 001 Device 011: ID 0a5c:200a Broadcom Corp.
> > Bus 001 Device 010: ID 0a5c:3535 Broadcom Corp.
> > Bus 001 Device 001: ID 0000:0000
> >
> > I read your article Marcel Broadcom devices with bluetooth support but
> > the command HCI_Reset, returned an error. Do you have a clue?
>
> install a kernel where this problem is fixed.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
