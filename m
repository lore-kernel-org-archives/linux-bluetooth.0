Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Feb 2008 09:31:30 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200802111731.m1BHVTFp009669@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users]  failed PIN Code Request
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

	Quoth jayjwa:
	'Years ago I used Slackware, and it never installed stuff in
/usr/local. Unless it underwent a fundimental change (and that's hard
to image if you know how Patrick is) that looks like a 3rd-party or
user add-on.'
	I built my bluetooth stuff from source so I could have the
latest.  I mentioned Slackware because everything I don't build from
source comes from Slackware.

	'passkey-agent --default <PIN> <bt address of remote device> &
	'auth-agent &'
	This doesn't work for me.

	'On the Jabra I use, there is a button on the side. Pressing
it causes it to try to pair with the computer. At that time,
passkey-agent and auth-agent answer, and output to the console that
they did get a request.'
	I have a Motorola HS850.  The instructions tell me to close
it, press the button for a few seconds until the light comes on, then
open it (which turns it on), then its ready to pair for a few seconds.
I run:
	 hcitool cc $headset

and get:

	Can't create connection: Connection timed out

Speaking into the headset doesn't help.

hcidump returns:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:DD:D0:86 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:13:17:DD:D0:86
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 0 bdaddr 00:13:17:DD:D0:86 type ACL encrypt 0x00
    Error: LMP Response Timeout

russell bell

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
