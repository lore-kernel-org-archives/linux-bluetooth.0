Return-Path: <liste@jordet.nu>
Subject: Re: [Bluez-users] Logitech diNovo/Desktop MX Bluetooth
From: Stian Jordet <liste@jordet.nu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1071171612.27255.65.camel@pegasus>
References: <1071170463.763.10.camel@chevrolet.hybel>
	 <1071171612.27255.65.camel@pegasus>
Content-Type: text/plain
Message-Id: <1071172456.763.35.camel@chevrolet.hybel>
Mime-Version: 1.0
Date: Thu, 11 Dec 2003 20:54:17 +0100
List-ID: <bluez-users.lists.sourceforge.net>

tor, 11.12.2003 kl. 20.40 skrev Marcel Holtmann:
> the diNovo Desktop is working fine with Linux, but the code is in an
> early phase of development. We have two implementations at the moment,
> the one from Peter Klausler and the other one from me which is based on
> the new Bluetooth library I am working on. Peter's code need some
> patches to make the keyboard and mouse working and for 2.6 it also needs
> a patch to support the uinput kernel driver. My code includes already
> all the needed stuff, but there is no official release available and the
> code only exists in the BlueZ CVS repositories.
> 
> The Logitech Bluetooth HUB is a little bit problematic, because it is a
> HID proxy capable device. This means it has a HID mode and a HCI mode.
> In HID mode it presents you a USB HID mouse and keyboard and you don't
> need a Bluetooth stack on your PC to have it working. And in this mode
> you can also use your keyboard in the BIOS and for Grub. The HCI mode
> converts this HUB into a simple USB Bluetooth dongle and your OS needs
> to support Bluetooth HID devices. Actually at the moment nobody knows
> how to switch this HUB from HID to HCI mode and back.
> 
> This all means that you can use the diNovo desktop always with the
> Logitech Bluetooth HUB in HID mode under Linux, but you can't use the
> HUB for phone connections at the same time. You need an extra Bluetooth
> dongle for this until someone figured out how to switch the modes.

Thank you for your prompt answer (as always) :)

I already have a 3com BT dongle, so I will manage untill someone
eventually (and hopefully) figures how to switch modes. The 3com is a
bit picky as well [1], so it would have been good to get rid of it :)

Thanks for your great work with BT in Linux :)

Best regards,
Stian

[1] hci_usb: probe of 1-2:1.1 failed with error -5
