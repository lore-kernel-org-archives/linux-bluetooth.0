Return-Path: <cyrus@holtmann.org>
Subject: Re: bug in audio/pcm_bluetooth.c causing memory corruption
From: David Mansfield <bluez@dm.cobite.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1233507584.4809.11.camel@californication>
References: <1233089481.32572.15.camel@gandalf.cobite.com>
	 <1233507584.4809.11.camel@californication>
Content-Type: text/plain
Date: Mon, 02 Feb 2009 10:24:33 -0500
Message-Id: <1233588273.3197.2.camel@gandalf.cobite.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2009-02-01 at 17:59 +0100, Marcel Holtmann wrote:
> Hi David,
> 
> > I've been debugging a problem using pulseaudio on top of an alsa
> > bluetooth device for a week or so and I've found the cause of the
> > problem (which manifests as a pulseaudio daemon segfault).
> > 
> > The bug is an line audio/pcm_bluetooth.c:802:
> > 
> > 
> >         if (pfds[1].revents & (POLLERR | POLLHUP | POLLNVAL))
> >                 io->state = SND_PCM_STATE_DISCONNECTED;
> > 
> >         revents[0] = (pfds[0].revents & ~POLLIN) | POLLOUT;
> > -->here revents[1] = (pfds[1].revents & ~POLLIN);
> > 
> >         return 0;
> > 
> > The 'unsigned short *revents' argument is NOT an array of shorts, but in
> > fact a pointer to a single short.  The assignment to revents[1] trashes
> > memory.
> > 
> > My guess is that all the flags should be combined into revents[0] (or
> > *revents, as that would be more semantically correct), but I'm not
> > really sure what the exact fix should be.
> > 
> > See this post by Jaroslav Kysela on the method
> > snd_pcm_poll_descriptors_revents, which ultimately ends up in the above
> > code:
> > 
> > http://osdir.com/ml/linux.alsa.devel/2002-07/msg00258.html
> 
> this is a real problem since it seem audicious seems to break if we not
> using revents[1]. So I have no clue what's the right fix is here. The
> problem seems to be more complex. Seems we need an ALSA expert to fix
> this for us.
> 

Well, I should think it's important to get confirmation first of what
the correct semantics of the function are.  I looked at the docs and
they're vague as hell.  Should I open a bug for this issue so we can
track the issue?  It's DEFINITELY causing memory corruption and
segmentation fault on x86_64 with pulseaudio via module-alsa-sink (on
Fedora 10).

Thanks,
David
