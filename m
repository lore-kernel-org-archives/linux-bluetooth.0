Return-Path: <cyrus@holtmann.org>
Message-Id: <200802081658.m18GwrGX006241@fizban.dyndns.org>
To: bluez-users@lists.sourceforge.net
Date: Fri, 8 Feb 2008 11:58:53 -0500 (EST)
From: montef@bellsouth.net
MIME-Version: 1.0
Subject: [Bluez-users] No output from hciconfig
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello all,

 A problem/question from a complete Bluetooth newb..

 I've been trying to follow the article from the September 2007 issue of
Linux Journal titled "Hacking Cell Phones via Bluetooth Tools under
Linux".

 I bought the same D-Link DBT-120 Bluetooth dongle that Patrick M.
Davila references using in his article.

 I'm using kernel version 2.6.22-gentoo-r5, running on an AMD processor
and an ASUS motherboard with on-board USB.

 I've tried the DBT-120 in all 4 of the USB connectors on the
motherboard. 

 Plugging this same DBT-120 into a Windows XP box, and loading the
D-Link tools that came with the dongle; that machine *does* see
Bluetooth devices around it.  So that seems to indicate that the dongle
is fuctional.

 Following Patrick's article, I've done:

 lsmod |grep blue
bluetooth              52708  2 hci_usb,rfcomm,hidp,l2cap

 dmesg |grep Blue
Bluetooth: Core ver 2.11
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: Core ver 2.11
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HCI USB driver ver 2.9

 This all looks very close to the output printed in the article, aside
from differences in versions.

 The next step in the article is to do:

 hciconfig -a

 This is where I'm having problems. I can't get any output at all from
hciconfig. Searching the mailing list archives as well as Google,
haven't turned up much with what to do to debug this.  I have tried:

  hciconfig hci0 up
Can't get device info: No such device


 Anyone have any suggestions on what to try to debug this? 

-- 
	-Monte

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
