Return-Path: <cyrus@holtmann.org>
Message-ID: <48590D7A.6030706@gmail.com>
Date: Wed, 18 Jun 2008 14:28:26 +0100
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
From: Gareth R White <garethrwhite@gmail.com>
Subject: [Bluez-users] Monitoring BT traffic
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

I want to monitor realtime BlueTooth data to/from a Wiimote controller 
as it's being used to play a game on Nintendo's Wii.
(apologies if this is off-topic for this mailing list - if I get no
replies I'll try elsewhere)

There are a couple of possible ways I can imagine of doing this:

Set up Linux PC as a bridge between 2 BlueTooth devices (a Wii and a 
Wiimote).
Connect the Wiimote and Ubuntu so that motion data from the Wiimote is 
received by the PC (and saved for later analysis). Also establish a 
connection between the PC and the Wii, and forward all data between the 
Wiimote and the Wii.
This might cause additional lag, and I'm not even sure if this is
technically feasible.

Multiple connect.
Have the PC and the Wii simultaneously connect to the same Wiimote.
Am I right in thinking this is not even possible with BlueTooth?

Passive monitoring.
Is there any way to monitor BT traffic between a directly connected
Wiimote and Wii? I've heard of BlueTooth sniffers which are apparently
rather expensive. How easy would it be to interrogate this data and
interpret it as Wii motion data?

Are there any applications that'll do this, and if not then how complex
does this task sound to build using any available libraries (is Bluez 
even where I should be looking?)

I'm a C++ / Python programmer but don't know where to find the 
appropriate Linux (Ubuntu 8.04) source and BlueTooth specs.
Any help or suggestions much appreciated!

Cheers,
Gareth

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
