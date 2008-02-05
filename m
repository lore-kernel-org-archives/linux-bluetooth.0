Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802050736r66aa9a89idd71e8bf382e8867@mail.gmail.com>
Date: Tue, 5 Feb 2008 08:36:02 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <578422.48756.qm@web8411.mail.in.yahoo.com>
MIME-Version: 1.0
References: <578422.48756.qm@web8411.mail.in.yahoo.com>
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

Pramod

if you run mplayer from a console instead of X you might get more
detail when the kernel spits out junk to the consoles.

Brad

On Feb 5, 2008 3:46 AM, pramod gurav <pramod_gurav_etc@yahoo.co.in> wrote:
>
> hello again
> I have compiled linux-2.6.22...with all support needed for Bluez...
> Now when i again try to play asong to my headset using
>
> [Pramod@localhost src]$ mplayer_install/bin/mplayer -ao alsa:device=headset
> 1.mp3
> The popup comes on system when i enter "0000" the application waits and
> connects to
> headset. One beep is heard on headset...After that system hangs with the
> monitor all white..
>
> As system is hanged i cant see the /var/log/messages nor the hcidump...
> Someone please help me this...
> Thanks in advance...
>
> Pramod
>
>
>
> ----- Original Message ----
> From: jayjwa <jayjwa@atr2.ath.cx>
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Sent: Tuesday, 5 February, 2008 12:48:20 AM
> Subject: Re: [Bluez-users] No sound on headset
>
>
>
> On Mon, 4 Feb 2008, pramod gurav wrote:
>
> -> I want to play audio from my system on my BT headset..
> -> I am able connect to it, pair it, but when i run command
> -> [Pramod@localhost ~]$ mplayer_install/bin/mplayer -ao alsa:device=headset
> 1.mp3                                                      mmmmmmm
> -> It gives one beep and waits for few seconds and again comes out with this
> error.....
> ->
> -> [AO_ALSA] alsa-lib: pcm_sco.c:277:(sco_headset_hw_params) Unable to set
> number of SCO buffers : please upgrade your Kernel !
> -> [AO_ALSA] Unable to set hw-parameters: Invalid argument
> -> Could not open/initialize audio device -> no sound.
> -> Audio: no sound
> -> Video: no video
>
> You should at least use a modern kernel for the best chance at getting this
> to
> work. The current version is something like 2.6.24 last time I looked, so
> 2.6.15 is very old and possibly vulnerable to a number root exploits if not
> patched.
>
>
> -> After this one beep is being listened..
> -> What may be the reason for this ???
>
> There's not enough info here for me to tell. Try running the daemons in
> debug
> in the forground (hcid, sdpd). Maybe run hcidump during the time you try as
> well.
>
>
> -> I tried adding patch from plugs from Bluez CVS....But its not compatible
> with my kernel
> -> 2..6.15 fedoraCore-5....
> -> Which patch i should add for upgrading my kernel.....?
>
> Just download the latest kernel. Build, install.
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>  ________________________________
>  Get the freedom to save as many mails as you wish. Click here to know how.
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>



-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
