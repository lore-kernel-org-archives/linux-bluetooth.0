Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 mouse not working.
From: Marcel Holtmann <marcel@holtmann.org>
To: jungle@saphire.dk
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1090770937.983.26.camel@aquarius>
References: <1090765201.983.13.camel@aquarius>
	 <200407251632.32162.cijoml@volny.cz>  <1090769444.983.19.camel@aquarius>
	 <1090770122.31693.2.camel@pegasus>  <1090770937.983.26.camel@aquarius>
Content-Type: text/plain
Message-Id: <1090771873.31693.6.camel@pegasus>
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
Date: Sun, 25 Jul 2004 18:11:13 +0200

Hi Kim,

> > the error message is different, so I assume that you either don't
> > activated the hiddev support in your kernel or you use the dynamic USB
> > minor allocation. Check your kernel config for CONFIG_USB_DYNAMIC_MINORS
> > and CONFIG_USB_HIDDEV.
> 
> I checked my kernel configuration and found that
> CONFIG_USB_DYNAMIC_MINORS is nowhere to be found (not configured),
> however CONFIG_USB_HIDDEV is:
> 
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> CONFIG_USB_HIDDEV=y
> 
> It is also loaded (usbhid,usbkbd,usbmouse).

don't load usbkbd and usbmouse. Actually I don't know how you get them
compiled at the same time. Read the help text for those modules and
check your kernel config again. Mine looks like this:

<snip>

CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

<snip>

CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set

<snip>

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
