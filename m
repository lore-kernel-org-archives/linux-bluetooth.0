Return-Path: <cyrus@holtmann.org>
From: Jens-Erik Hansen <Jens-E.Hansen@gis.de>
To: bluez-users@lists.sourceforge.net
Date: Mon, 25 Feb 2008 20:10:34 +0100
MIME-Version: 1.0
Message-Id: <200802252010.34296.Jens-E.Hansen@gis.de>
Subject: [Bluez-users] rattling noise with bluefritz 2.0
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

Hi,

with a bluefritz usb v2.0 I hear a rattling noise in the headset which appears 
about every 1.5 sec during a voip call (twinkle/ekiga/skype).

I noticed that the bfusb module is not loaded automatically and that a 
modprobe bfusb doesn't pull the firmware (bfubase.frm) located 
in /lib/firmware.

I'm a bit confused, is the firmware still needed? What could be the reason for 
this background noise?

Greetings
Jens

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
