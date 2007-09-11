Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Alexander Mette <mail@amette.eu>
To: bluez-users@lists.sourceforge.net
Date: Wed, 12 Sep 2007 00:18:54 +0200
MIME-Version: 1.0
Message-Id: <200709120018.54679.mail@amette.eu>
Subject: [Bluez-users] Bluez-3.18 Headset and ALSA
Reply-To: mail@amette.eu, BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello alltogether,

I'm trying to get a Plantronics Discovery 665 working with my Thinkpad R60 
(Broadcom Corp / BCM2045B) to do VoIP.

After some digging on the net to be able to distinguish the different 
approaches in the first place (kernel module bt-sco, bluetooth-alsa) and some 
trial and error (kernel module didn't compile, bluetooth-alsa sometimes just 
gives deafening noise to the other side - sometimes it works just great), I 
found out, that both are obsolete. So why bother with getting bluetooth-alsa 
running, when the present is so close... ;)

After emerging (Gentoo) the unstable marked bluez-libs and bluez-utils 3.18 I 
followed the advice at
	http://wiki.bluez.org/wiki/HOWTO/AudioDevices

Then I ran
	$ mplayer -ao alsa:device=bluetooth test.wav
and get
	[AO_ALSA] alsa-lib: pcm_bluetooth.c:1189:(bluetooth_init) Connection fail


Removing the "pcm.bluetooth" section from /etc/asound.conf gives me an 
	[AO_ALSA] alsa-lib: pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM bluetooth 
error from mplayer and as the error first mentioned above comes 
from "pcm_bluetooth.c", I'm pretty sure that I'm at the right place here. ;)

Very cool solution, just install bluez and tune your asound.conf - kudos for 
that implementation! :)

But this bug really sucks and I'm lost at this point.
I never was much into bluez, though I got ppp-dialup-connection and SyncML 
over bluetooth working before (bluez-2.xx) - and apparantly the upgrade didn't 
at least break the second one(though the view of my new kdebluetooth made me 
fear that)! :)
Only clue, that I found is from the above-mentioned link: "Make sure the audio 
service is installed and enabled"
	- Gentoo automatically installs a file
		/etc/bluetooth/audio.service
	  so I figure, everything is ok.
	BUT: Removing that file and restarting bluetooth as well as alsa doesn't make 
any difference

Is there a way to see the successfully started services?
Only thing I could think of is:
--------------------------
# hciconfig -a
..
Service Classes: Unspecified
..
--------------------------
So no services at all??

In the /etc/asound.conf I have the following(of course with correct 
MAC-address):
--------------------------
pcm.bluetooth {
        type bluetooth
        device "00:11:22:33:44:55"
        profile voice
}
--------------------------
The "profile" I found on some mailing-list post... before I tried 
with "preference", which is mentioned on
	http://wiki.bluez.org/wiki/Audio
But doesn't do any difference.

Any ideas and help are appreciated! :)
Thanks and

greets
amette

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
