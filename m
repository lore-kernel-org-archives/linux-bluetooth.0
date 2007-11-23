Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <9a119b3c0711230758v7fa8a53eub2532227762542bd@mail.gmail.com>
Date: Fri, 23 Nov 2007 16:58:08 +0100
From: "=?ISO-8859-1?Q?Csillag_Krist=F3f?=" <csillag.kristof@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Choppy sound with a2dp and mplayer
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

Hi all!

I am using bluez 3.22.

I have successfully configured the audio system with
my stereo Bluetooth headset, and a2dp & avrcp work now.

I have an ALSA device named "headset", and when an
applications (xmms, audacious, etc.) send sound to it,
it appears on my headset. So good, so far.

However, when I try to use it with mplayer, I get choppy
output. Playback is smooth for a few seconds, but then
it breaks up. I can not find any error/warning messages
in the output of mplayer.

I have made several tests. Here are the results:

1. Q: mplayer x.avi -ao alsa:device=headset	
   A: choppy

2: Q: mplayer x.avi -dumpaudio
      mplayer stream.dump -ao alsa:device=headset
   A: fluent

3: Q: mplayer x.avi -ao alsa:device=headset -vc null -vo null
   A: choppy

So, mplayer _can_ play the sound track of the file via the bt headset,
without any problems. However, if the video stream is there in the file,
even if it's not decoded at all, audio collapses.

Because of this, I guess this must be some timing/caching issue.
Do you agree? If no, what else? If yes, how can I make mplayer cache
more audio while playing?

(I have already configured hcid to be always master and no rswitch, but
this did not help.)

Any idea?

Thank you for your help:

    Kristof Csillag

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
