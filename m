Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo/Desktop MX Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Stian Jordet <liste@jordet.nu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1071170463.763.10.camel@chevrolet.hybel>
References: <1071170463.763.10.camel@chevrolet.hybel>
Content-Type: text/plain
Message-Id: <1071171612.27255.65.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 11 Dec 2003 20:40:12 +0100

Hi Stian,

> I've been searching the archives a bit. I found some references and talk
> about the diNovo, but no real answer, though I understand that work are
> progressing in this area.
> 
> Since Greg KH is claiming that my keyboard/mouse are faulty (keeps
> reconnecting when using usb-serial adapter), I'm going to buy a new set
> during Christmas, and I'd like to have one of Logitechs BT sets. Thus I
> have some questions.
> 
> Will it work with Linux? I'm running 2.6 kernels. If not, what will I
> need, and is this already developed? I saw something about a user-space
> daemon called bthid. Does that mean that the keyboard can't be used
> untill a user-space daemon has loaded? Can it be used with Grub, for
> instance?
> 
> And one last question, will I be able to sync my phone using the
> Logitech BT dongle, while both the keyboard and mouse is connected?

the diNovo Desktop is working fine with Linux, but the code is in an
early phase of development. We have two implementations at the moment,
the one from Peter Klausler and the other one from me which is based on
the new Bluetooth library I am working on. Peter's code need some
patches to make the keyboard and mouse working and for 2.6 it also needs
a patch to support the uinput kernel driver. My code includes already
all the needed stuff, but there is no official release available and the
code only exists in the BlueZ CVS repositories.

The Logitech Bluetooth HUB is a little bit problematic, because it is a
HID proxy capable device. This means it has a HID mode and a HCI mode.
In HID mode it presents you a USB HID mouse and keyboard and you don't
need a Bluetooth stack on your PC to have it working. And in this mode
you can also use your keyboard in the BIOS and for Grub. The HCI mode
converts this HUB into a simple USB Bluetooth dongle and your OS needs
to support Bluetooth HID devices. Actually at the moment nobody knows
how to switch this HUB from HID to HCI mode and back.

This all means that you can use the diNovo desktop always with the
Logitech Bluetooth HUB in HID mode under Linux, but you can't use the
HUB for phone connections at the same time. You need an extra Bluetooth
dongle for this until someone figured out how to switch the modes.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
