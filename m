Return-Path: <cyrus@holtmann.org>
From: Jens-Erik Hansen <Jens-E.Hansen@gis.de>
To: bluez-users@lists.sourceforge.net
Date: Sat, 1 Mar 2008 18:27:11 +0100
MIME-Version: 1.0
Message-Id: <200803011827.11761.Jens-E.Hansen@gis.de>
Subject: [Bluez-users] trouble with Belkin F8T012V and sco
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

Hello,

using the Belkin F8T012V, a Broadcom based usb dongle, I have some trouble 
with sco. If I ring somebody or receive a sip call I can hear the caller but 
he only hears loud noise. This occurs not every time I use sip but very often 
and I noticed that this mostly happens after some time of no sip activity.

Could somebody please give me a hint if the Belkin dongle is supported by 
bluez or how I can debug this behaviour further? How can I figure out if this 
device is Broadcom Blutonium based?

I read that hciconfig hci0 revision should either print "SCO mapping: HCI" 
or "SCO mapping: PCM". Unfortunately my hciconfig hci revsion output looks 
like:

hci0:   Type: USB
        BD Address: 00:0A:3A:72:7B:C9 ACL MTU: 1017:8 SCO MTU: 64:8
        Firmware 7.67 / 14

I assume this is not a good sign, on the other hand I'm able to pair a headset 
with the dongle and e.g. obex ftp works.

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
