Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 28 Mar 2007 08:36:25 +0200
From: Marc Haber <mh+bluez-devel@zugschlus.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070328063625.GA25229@torres.zugschlus.de>
Mime-Version: 1.0
Subject: [Bluez-devel] SCO headsetd: "appli closed connection"
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I am trying to use a Jabra BT 330 with ALSA. My system is Debian
unstable, running Liux 2.6.20.4 patched with the SCO timing patch.
Last night, I was able to do a single VoIP call using twinkle, and
then things stopped working.

When twinkle starts up, I start hearing very low background hiss in
the headset, so the connection seems to actually work, but when the
application tries sending in actual data, nothing is heard. This is
headsetd's output:

$ headsetd -n
headsetd[30223]: Bluetooth headset daemon version 0.5
headsetd[30223]: Configuration phase ended: target bdaddr is 00:07:A4:BA:48:59, timeout is 6000 ms
headsetd[30223]: Changing state: Idle-->Paging
headsetd[30223]: Changing state: Paging-->Connecting
Headset connected
headsetd[30223]: Changing state: Connecting-->Ready
headsetd[30223]: Changing state: Ready-->Opening
headsetd[30223]: SCO channel opened handle=0x002c mtu=64
headsetd[30223]: Changing state: Opening-->Streaming
headsetd[30223]: Appli closed socket
headsetd[30223]: Changing state: Streaming-->Zombie
headsetd[30223]: Changing state: Zombie-->Streaming
headsetd[30223]: Appli closed socket
headsetd[30223]: Changing state: Streaming-->Zombie
Received from HS: AT+VGS=10
headsetd[30223]: Changing state: Zombie-->Streaming
headsetd[30223]: Appli closed socket
headsetd[30223]: Changing state: Streaming-->Zombie
headsetd[30223]: Changing state: Zombie-->Streaming
headsetd[30223]: Appli closed socket
headsetd[30223]: Changing state: Streaming-->Zombie
headsetd[30223]: Changing state: Zombie-->Streaming
headsetd[30223]: Appli closed socket
headsetd[30223]: Changing state: Streaming-->Zombie
headsetd[30223]: Changing state: Zombie-->Streaming
headsetd[30223]: Appli closed socket
headsetd[30223]: Changing state: Streaming-->Zombie
headsetd[30223]: Nobody uses SCO channel anymore, closing it.
headsetd[30223]: Changing state: Zombie-->Connected
headsetd[30223]: exiting cleanly

When I try amarok to play back an MP3 file, the same thing happens,
only that the three lines "Streaming-->Zombie", "Zombie-->Streaming",
"Appli closed socket" repeat a lot more often.

What might be going wrong here? Is there any more information that you
need?

I am particularly stymied that it worked once and ceased to do so later.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
