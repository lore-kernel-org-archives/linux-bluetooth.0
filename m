Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Which is needed to have usb bluetooth? (kernels
	modules)
From: Marcel Holtmann <marcel@holtmann.org>
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040410155935.GA26618@magma.epfl.ch>
References: <20040410155935.GA26618@magma.epfl.ch>
Content-Type: text/plain
Message-Id: <1081613259.5398.5.camel@pegasus>
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
Date: Sat, 10 Apr 2004 18:07:39 +0200

Hi Gregoire,

> I am getting deseperate regarding bluetooth under linux :-(
> 
> I got a kernel with which I could access my onboard usb bluetooth, but I
> cannot anymore since at least 10 kernels rebuild...
> 
> I am using 2.6.5-mm3.
> I don't find aynwhere exactly what is needed for Bluez, could someone
> point me to the right config?
> 
> Right now I have:
> 
> CONFIG_BT=y
> CONFIG_BT_L2CAP=y
> CONFIG_BT_SCO=y
> CONFIG_BT_RFCOMM=y
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=y
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_HCIUSB=y
> CONFIG_BT_HCIUART=y
> CONFIG_BT_HCIUART_H4=y
> CONFIG_BT_HCIUART_BCSP=y
> CONFIG_BT_HCIVHCI=y
> CONFIG_USB=y
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_BANDWIDTH=y
> CONFIG_USB_DYNAMIC_MINORS=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_UHCI_HCD=y
> CONFIG_USB_STORAGE=y
> CONFIG_USB_SERIAL=y
> CONFIG_USB_SERIAL_VISOR=y
> 
> And cat /proc/bus/usb/devices just show my hub and cards readers...

I personally prefer having the USB and Bluetooth subsystem as modules,
but it should work in both ways. May you wanna try a modular system.

Show us the content of /proc/bus/usb/devices and what do lspci and lsusb
say? What kind of Bluetooth dongle do you have?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
