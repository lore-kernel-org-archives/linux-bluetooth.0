Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Dec 2007 19:32:17 +0100
From: Felix Dorner <felix_do@web.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20071228193217.5277a57f@serenity>
Mime-Version: 1.0
Subject: [Bluez-users] Connecting to the Logitech HS05 V04 Headset
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

I am currently testing if I can connect to this Logitech device (HS05
V04). I got the devices name/mac by "hcitool scan". I now followed the
steps for "bluez-utils-3.16 and newer" (I got some 3.2x version) from
this page:

http://wiki.bluez.org/wiki/HOWTO/AudioDevices

1. Make sure the audio service is installed and enabled

Not being quite sure what that means I
checked /etc/bluetooth/audio.service. The file exists. I changed the 
"Autostart" option from false to true - just to be safe. So I guess
Step 1 should be ok.

2. I had to create ~/.asoundrc to insert the template and entered the
devices MAC.

Now I try "aplay -D bluetooth -f S16_LE somefile" which fails with:

ALSA lib pcm_bluetooth.c:1240:(bluetooth_init) Connection fail
aplay: main:545: audio open error: Connection refused

I tried the following:
- Restart alsa
- I somewhere read that I'd need to load the snd-usb-audio module, did.

Is it that the device is simply not supported? what else might i have
missed?


Thanks for any hints.

Felix


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
