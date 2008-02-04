Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Feb 2008 14:18:20 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <123158.43460.qm@web8404.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802041337320.20697@nge2.ngu.pk>
References: <123158.43460.qm@web8404.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] No sound on headset
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



On Mon, 4 Feb 2008, pramod gurav wrote:

-> I want to play audio from my system on my BT headset..
-> I am able connect to it, pair it, but when i run command
-> [Pramod@localhost ~]$ mplayer_install/bin/mplayer -ao alsa:device=headset 
1.mp3                                                       mmmmmmm
-> It gives one beep and waits for few seconds and again comes out with this error.....
-> 
-> [AO_ALSA] alsa-lib: pcm_sco.c:277:(sco_headset_hw_params) Unable to set number of SCO buffers : please upgrade your Kernel !
-> [AO_ALSA] Unable to set hw-parameters: Invalid argument
-> Could not open/initialize audio device -> no sound.
-> Audio: no sound
-> Video: no video

You should at least use a modern kernel for the best chance at getting this to 
work. The current version is something like 2.6.24 last time I looked, so 
2.6.15 is very old and possibly vulnerable to a number root exploits if not 
patched.


-> After this one beep is being listened..
-> What may be the reason for this ???

There's not enough info here for me to tell. Try running the daemons in debug 
in the forground (hcid, sdpd). Maybe run hcidump during the time you try as 
well.


-> I tried adding patch from plugs from Bluez CVS....But its not compatible  with my kernel 
-> 2..6.15 fedoraCore-5....
-> Which patch i should add for upgrading my kernel.....?

Just download the latest kernel. Build, install.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
