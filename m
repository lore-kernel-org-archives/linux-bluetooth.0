Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: wimpunk <kwdpggwxwumz@spammotel.com>
Date: Wed, 12 Sep 2007 08:58:58 +0200
Message-ID: <iafkr4-c36.ln1@tisnix.motzarella.org>
Mime-Version: 1.0
Subject: [Bluez-users] Bluetooth mouse not connecting using Lenny
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

Hi List,

Since my upgrade to Lenny, my mouse doesn't connect automatically
anymore.  To get my mouse working, I have to remove my USB bluetooth
dongle and put it back.  I've compared the modules before and after but
everything is the same.
I've asked this on the debian mailinglist but nobody had an answer so
maybe the bluez-user list can.
When I try to connect after startup I get:

$ hidd --connect 00:30:05:00:04:13
Can't get device information: Connection timed out
$

I remove the BT dongle and put it back:
$ hidd --connect 00:30:05:00:04:13
$

Any one a suggestion what's going wrong?


Kind regards,

wimpunk.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
