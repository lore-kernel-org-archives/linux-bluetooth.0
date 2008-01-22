Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 22 Jan 2008 09:47:12 +0100
Message-Id: <1200991632.7006.20.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Asus WL-BTD202 needs force_scofix
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I'm currently testing bluetooth audio with latest cvs.

I use this dongle and a mono headset (PROF PBH-6W) :
$ /usr/sbin/lsusb | grep ASUS
Bus 001 Device 002: ID 0b05:1715 ASUSTek Computer, Inc. 

Apparently, it only works with this option set hci_usb :
options hci_usb force_scofix=1

Recording and playback work, mostly.
Sometimes noise is produced, retrying once or twice make it work...

Could this option be set as a default in hci_usb.c, or could it have
some drawback I'm not aware of ?

Best regards,

Guillaume B.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
