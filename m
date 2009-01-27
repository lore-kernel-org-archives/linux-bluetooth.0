Return-Path: <cyrus@holtmann.org>
Subject: bug in audio/pcm_bluetooth.c causing memory corruption
From: David Mansfield <bluez@dm.cobite.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Tue, 27 Jan 2009 15:51:21 -0500
Message-Id: <1233089481.32572.15.camel@gandalf.cobite.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've been debugging a problem using pulseaudio on top of an alsa
bluetooth device for a week or so and I've found the cause of the
problem (which manifests as a pulseaudio daemon segfault).

The bug is an line audio/pcm_bluetooth.c:802:


        if (pfds[1].revents & (POLLERR | POLLHUP | POLLNVAL))
                io->state = SND_PCM_STATE_DISCONNECTED;

        revents[0] = (pfds[0].revents & ~POLLIN) | POLLOUT;
-->here revents[1] = (pfds[1].revents & ~POLLIN);

        return 0;

The 'unsigned short *revents' argument is NOT an array of shorts, but in
fact a pointer to a single short.  The assignment to revents[1] trashes
memory.

My guess is that all the flags should be combined into revents[0] (or
*revents, as that would be more semantically correct), but I'm not
really sure what the exact fix should be.

See this post by Jaroslav Kysela on the method
snd_pcm_poll_descriptors_revents, which ultimately ends up in the above
code:

http://osdir.com/ml/linux.alsa.devel/2002-07/msg00258.html

Thanks,
David


