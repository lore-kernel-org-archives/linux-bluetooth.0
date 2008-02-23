Return-Path: <cyrus@holtmann.org>
Message-ID: <c02b565a0802230725v771c8dd9r4178847a36d07491@mail.gmail.com>
Date: Sat, 23 Feb 2008 16:25:19 +0100
From: "Crni Gorac" <cgorac@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Plantronics 350 headset
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

Trying to make Plantronics 350 headset to work with BlueZ, on a
Slackware 12 installation updated to today released BlueZ 3.26
Slackware packages.  I've put PIN number to corresponding file in
/etc/bluetooth/passkey directory, also create corresponding
/etc/asound.conf file.  Afterwards, I've changed my
/etc/bluetooth/hcid.conf, so that same PIN code is put there, under
"options "section, and also changed my /etc/bluetooth/rfcomm.conf file
to list my headset there.   Afterwards, I've employed rfcomm to bind
my headset, and then "hcitool cc" to connect to my headset.  However,
while connection is listed when I issue "hcitool con" immediately
afterwards, headset seems to be disconnected after couple seconds -
another "hcitool con" shows no connections.  So, my questions are:
- Anyone having experience with making Plantronics 350 works on Linux?
- Is there any place where steps needed to employ Bluetooth headset
under Linux are described?  Obviously,
http://wiki.bluez.org/wiki/HOWTO/AudioDevices is less than complete
description, and trying to get some clue from the rest of BlueZ
documentation is really frustrating (well, at least to myself)...

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
