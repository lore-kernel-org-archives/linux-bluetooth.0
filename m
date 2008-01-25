Return-Path: <cyrus@holtmann.org>
From: SA <sa@claborn.net>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Date: Thu, 24 Jan 2008 22:56:33 -0600
Message-Id: <200801242256.33910.sa@claborn.net>
Subject: [Bluez-users] How to setup a headset as an audio device? Getting
	"Device busy" errors
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

My boss has just purchased a "Jawbone" bluetooth headset (cell phone type) 
that he wants to hook up to his computer to use like skype.

I found instructions for old btsco first, and plugz. I saw that btsco was 
outdated but I tried plugz and sbc first.

Then I saw on http://wiki.bluez.org/wiki/HOWTO/AudioDevices the following:

"Note: you will not need bluetooth-alsa, plugz, btsco or the like for audio to 
work. They are obsolete. "

The steps there are listed as

1. Make sure the audio service is installed and enabled 
(file /etc/bluetooth/audio.service should exist)

2. modify your ~/.asoundrc to contain

pcm.bluetooth {
   type bluetooth
   device 00:11:22:33:44:55
}
3. configure your audio application to use the alsa device "bluetooth". See 
Supported Players 
http://wiki.bluez.org/wiki/HOWTO/AudioDevices#SupportedPlayers for some 
examples.
4. start playing :) 

Which is wonderfully simple, but it did not work for me. I also tried it on my 
own computer. Both computers have OpenSuSE 10.3. I used the KDE bluetooth 
manager to pair the devices. It shows up correctly in "hcitool scan"

The correct Bluetooth address is 00:0D:3C:6F:0E:89, so I tried this on both 
computers (for the remainder of this email I will focus on my own computer - 
once I get it working here I can make it work on my boss's laptop too)

Here's my /etc/bluetooth/audio.service:
[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service


Here's my ~/.asoundrc:
pcm.bluetooth {
   type bluetooth
   device 00:0D:3C:6F:0E:89
}

I have the following bluez packages installed:

bluez-utils-3.18-12
bluez-libs-3.18-5


When I try to configure any of the players as recommended by the page 
http://wiki.bluez.org/wiki/HOWTO/AudioDevices#SupportedPlayers the best 
response I get is "Device Busy" from amarok and Kaffiene (xine engine) like 
this:

"Audio output unavailable; the device is busy.
xine parameters: "

MPlayer, when I try to run the suggested command 
"mplayer -ao alsa:device=bluetooth"
prints out the options/argument list as though I'm using an incorrect command.

I can't configure audacious at all, under Audio the "Current output plugin" 
has no option to select, and all the other preferences are grayed out too.

Can anyone tell me what I need to do to make this work?

Thanks,

	JW

-- 

----------------------
System Administrator - Cedar Creek Software http://www.cedarcreeksoftware.com
http://jwadmin.blogspot.com/
-- 

----------------------
System Administrator - Cedar Creek Software
http://www.cedarcreeksoftware.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
