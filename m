Return-Path: <cyrus@holtmann.org>
Message-ID: <47928635.2030400@gmx.net>
Date: Sun, 20 Jan 2008 00:22:29 +0100
From: Gunnar Thielebein <gunnar_thielebein@gmx.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] audio bluetooth connectivity in gutsy
Reply-To: gunnar_thielebein@gmx.net,
	BlueZ users <bluez-users@lists.sourceforge.net>
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

Hi group,

I am trying to connect my headset in gutsy with default kernel 
2.6.22-14-generic. I tried all four(?) possible solutions: old sco way, 
plugz, bluetooth-alsa (at least the package in gutsy) and bluez-audio 
which all ends finally with a hardlock of my system when the connection
was established with headset.

Authentication and sdp browsing works fine at least in kde.

I tested sound play with smplayer,mplayer,aplay,play.

I also tested with the unstable packages from sid libbluez, bluez- 
bluez-audio, gstreamer-plugins

Could you tell if I need a more current kernel version than 22?
Or is it something with my hardware?

my hardware spec:

Headset: HBH-PV700
---
Dongle: Bus 001 Device 003: ID 0f4d:1000 Microtune, Inc. Bluetooth Dongle
---
arch: amd64 - 2.6.22-14-generic #1 SMP Tue Dec 18 05:28:27 UTC 2007 
x86_64 GNU/Linux

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
