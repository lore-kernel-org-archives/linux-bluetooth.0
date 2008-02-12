Return-Path: <cyrus@holtmann.org>
Message-ID: <20080212091420.4o1zmuk9usoocwck@www.domaingo-webmail.de>
Date: Tue, 12 Feb 2008 09:14:20 +0100
From: mail@saschahoppe.de
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Using multiple bluetooth devices or WLAN creates
	sluggish sound
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

first of all I need to say, that it was really easy to set bluetooth  
sound up in Ubuntu Gutsy 7.10 with the instructions mentioned in the  
Bluez wiki. I use a Voiis www.voiis.com Audio gateway and a Bluetooth  
USB Dongle that is a class I device supporting Bluetooth v2.0 and the  
A2DP-SRC protocol.

I got it paired and can hear music with amarok for example in a really  
good quality over my Hifi-amp.
But whenever I load a webpage via WLAN there is a drop-out in the  
music output. And when I try to use my Bluetooth mouse simultaneously  
with music playback everything is over. Whenever I move the mouse the  
music is totally paused until I stop moving the mouse.

Isn't bluetooth capable of supporting up to seven simultaneous  
devices? Wasn't it fixed in Bluetooth 1.2 that WLAN interferes with  
Bluetooth via Adaptive frequency hopping?

Is this a bug or can I somehow fix this behaviour.

Thank you for any advice.




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
