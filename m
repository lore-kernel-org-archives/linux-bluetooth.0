Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <893c1030050829080733bb047e@mail.gmail.com>
From: Julien Carbonell <jcarbonellpro@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <893c103005082908023cd7f021@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <893c103005082908023cd7f021@mail.gmail.com>
Subject: [Bluez-users] Cannot connect BT RS232 module
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
Date: Mon, 29 Aug 2005 17:07:30 +0200

****************
Sorry I made a mistake and sent my email to bluez-devel... Here it is
again on the appropriate mailing list.
****************

I'm trying to connect a BrainBoxes BL-510 BT module to a Freescale
imx21 board (ARM cpu) running Linux 2.4.20 patched with
bluez-patch-2.4.20-mh18

When I run "hciattach /dev/ttyS3 bcsp 115200 flow", I get the following err=
ors :
"Can't set device: Protocol not supported
Can't initialize device: Illegal seek"

>From what I understood reading hciattach.c, this error means that the
HCI_BCSP protocol is not supported. I checked the modules: bluez and
hci_uart are loaded. I also checked my kernel config (copy/paste at
the end of my email).
i can't find what's missing in my configuration.

I've tested the module on a PC running Mandrake 10.0 kernel 2.4.25
(bluez and hci_uart loaded as modules) and it works perfectly
(hciattach + scan + ...).

Any idea ?

Thanks

Julien

#
# Bluetooth support
#
CONFIG_BLUEZ=3Dm
CONFIG_BLUEZ_L2CAP=3Dm
CONFIG_BLUEZ_SCO=3Dm
CONFIG_BLUEZ_RFCOMM=3Dm
CONFIG_BLUEZ_RFCOMM_TTY=3Dy
CONFIG_BLUEZ_BNEP=3Dm
CONFIG_BLUEZ_BNEP_MC_FILTER=3Dy
CONFIG_BLUEZ_BNEP_PROTO_FILTER=3Dy
CONFIG_BLUEZ_CMTP=3Dm

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=3Dm
CONFIG_BLUEZ_HCIUSB_SCO=3Dy
CONFIG_BLUEZ_HCIUART=3Dm
CONFIG_BLUEZ_HCIUART_H4=3Dy
CONFIG_BLUEZ_HCIUART_BCSP=3Dy
CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=3Dy
# CONFIG_BLUEZ_HCIBFUSB is not set
CONFIG_BLUEZ_HCIDTL1=3Dm
CONFIG_BLUEZ_HCIBT3C=3Dm
CONFIG_BLUEZ_HCIBLUECARD=3Dm
CONFIG_BLUEZ_HCIBTUART=3Dm
CONFIG_BLUEZ_HCIVHCI=3Dm


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
