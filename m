Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040410155935.GA26618@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Which is needed to have usb bluetooth? (kernels modules)
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
Date: Sat, 10 Apr 2004 17:59:35 +0200

Hello,

I am getting deseperate regarding bluetooth under linux :-(

I got a kernel with which I could access my onboard usb bluetooth, but I
cannot anymore since at least 10 kernels rebuild...

I am using 2.6.5-mm3.
I don't find aynwhere exactly what is needed for Bluez, could someone
point me to the right config?

Right now I have:

CONFIG_BT=3Dy
CONFIG_BT_L2CAP=3Dy
CONFIG_BT_SCO=3Dy
CONFIG_BT_RFCOMM=3Dy
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dy
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HCIUSB=3Dy
CONFIG_BT_HCIUART=3Dy
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIVHCI=3Dy
CONFIG_USB=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_UHCI_HCD=3Dy
CONFIG_USB_STORAGE=3Dy
CONFIG_USB_SERIAL=3Dy
CONFIG_USB_SERIAL_VISOR=3Dy

And cat /proc/bus/usb/devices just show my hub and cards readers...

Thank for any info :-)

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
