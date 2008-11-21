Return-Path: <cyrus@holtmann.org>
Message-ID: <49268707.3030409@gmx.net>
Date: Fri, 21 Nov 2008 11:01:43 +0100
From: Gunnar Thielebein <gunnar_thielebein@gmx.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] audio / mpd issue
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

I can successfully play sound from bt when using mplayer to my stereo 
using a bluetooth audio sink (mbr-100).
But theres an issue when using mpd (musicplayer daemon).
First it is not possible to use alsa directly in mpd.conf but only 
driver type ao in conf. It crashes when using "alsa" (see link below)
Mpd wiki did not suggest to use this as type "alsa" is more maintened.
Second when using ao the playback has extreme jitters. This is not the 
case with mplayer.

I tried setting buffer_time / period_time in mpd.conf / asound.conf but 
this seems to be not configurable options for alsa type bluetooth.
Has somebody an idea what occurs this issue? I mean apart of some smooth 
yowl from time to time with mplayer sound quality is really acceptable.
Someone an idea about the crash with "alsa".

works with jitters:
> audio_output {
>         type                    "ao"
>         name                    "Bluetooth Device"
>         options                 "dev=bluetooth"
>         device                  "plug:bluetooth"
> }
>
>
makes mpd crash:
> audio_output {
>         type                    "alsa"
>         name                    "Bluetooth Device"
>         options                 "dev=bluetooth"
>         device                  "plug:bluetooth"
> }
>
>


For avoiding double post current thread with further config and log 
files attached in mpd forum:

http://www.musicpd.org/forum/index.php?topic=1764.0

Bluetooth versions in use: 3.26 and 3.36-2.
Packages for 4.18 seems to be broken (connection timeout)

Best,
Gunnar

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
