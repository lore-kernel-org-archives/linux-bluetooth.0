Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710071722k2ac2074dqe0dfc16ac960f982@mail.gmail.com>
Date: Sun, 7 Oct 2007 18:22:26 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47092B7D.5000404@free.fr>
MIME-Version: 1.0
References: <47092B7D.5000404@free.fr>
Subject: Re: [Bluez-devel] [PATCH] Alsa plugin fix
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fabien,

I noticed the same problem with xmms, but it works great now. I
committed your fix.

thanks
Brad

On 10/7/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
> All,
>
> I've spent most of my afternoon fixing the support for my favorite media
> player, the descendant of XMMS : audacious. :-)
>
> Audacious was almost working except for a *very* annoying bug (in our
> side :-( ). It would
> eventually stop playing at the end of each song, which meant i would
> have to manually select the next song and hit play again... not very
> funny :-(
>
> Now it looks it works perfectly (didn't have time to check that in
> details, but that should be fixed as soon i tomorrow, after i would
> have spent the most part of the day listening to music with Audacious ;-)=
 )
>
> The patch is fairly simple, it implements the delay() call to make sure
> we change the pcm state to the XRUN state whenever the hw_ptr moves
> on top of appl_ptr.
>
> Anybody to review it and commit to CVS ?
>
> Cheers,
>
> Fabien
>
> Index: pcm_bluetooth.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- pcm_bluetooth.c     (r=E9vision 74)
> +++ pcm_bluetooth.c     (copie de travail)
> @@ -764,6 +764,25 @@
>         return ret;
>  }
>
> +static int bluetooth_playback_delay(snd_pcm_ioplug_t *io,
> +                               snd_pcm_sframes_t *delayp)
> +{
> +       DBG("");
> +
> +       /* This updates io->hw_ptr value using pointer() function */
> +       snd_pcm_hwsync(io->pcm);
> +
> +       *delayp =3D io->appl_ptr - io->hw_ptr;
> +       if ((io->state =3D=3D SND_PCM_STATE_RUNNING) && (*delayp < 0)) {
> +               io->callback->stop(io);
> +               io->state =3D SND_PCM_STATE_XRUN;
> +               *delayp =3D 0;
> +       }
> +       /* This should never fail, ALSA API is really not
> +       prepared to handle a non zero return value */
> +       return 0;
> +}
> +
>  static snd_pcm_ioplug_callback_t bluetooth_hsp_playback =3D {
>         .start                  =3D bluetooth_playback_start,
>         .stop                   =3D bluetooth_playback_stop,
> @@ -774,6 +793,7 @@
>         .transfer               =3D bluetooth_hsp_write,
>         .poll_descriptors       =3D bluetooth_playback_poll_descriptors,
>         .poll_revents           =3D bluetooth_playback_poll_revents,
> +       .delay                  =3D bluetooth_playback_delay,
>  };
>
>  static snd_pcm_ioplug_callback_t bluetooth_hsp_capture =3D {
> @@ -798,6 +818,7 @@
>         .transfer               =3D bluetooth_a2dp_write,
>         .poll_descriptors       =3D bluetooth_playback_poll_descriptors,
>         .poll_revents           =3D bluetooth_playback_poll_revents,
> +       .delay                  =3D bluetooth_playback_delay,
>  };
>
>  static snd_pcm_ioplug_callback_t bluetooth_a2dp_capture =3D {
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
