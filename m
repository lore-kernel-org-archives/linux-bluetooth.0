Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A43EED3E-8B1F-4C4C-B7A9-26065DE55928@holtmann.org>
References: <CAOJw-HaHLZsbgCGi_e1ZspAf_16gKQuC6N7JM+5boWxQHCXWFQ@mail.gmail.com>
	<A43EED3E-8B1F-4C4C-B7A9-26065DE55928@holtmann.org>
Date: Tue, 12 Nov 2013 09:29:49 +0100
Message-ID: <CAOJw-Hb7Fn7RpyvhYoMp2BgU2QXWE0+Nq8S92e9keX4A4CGBQQ@mail.gmail.com>
Subject: Re: Problems with too many connections
From: Markus Roppelt <markus.roppelt@peus-testing.de>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2013/9/27 Marcel Holtmann <marcel@holtmann.org>
>
> Hi Markus,
>
> > I want to write an application which repeats the following procedure
> > for several (100+) bluetooth (low energy) devices:
> >
> > 1. connect
> > 2. read register values
> > 3. disconnect
> >
> > Therefore I modified the source code from /attrib/interactive.c.  For
> > testing purposes I am only looping  over one device. See attached
> > source code.
> >
> > The code works fine. It connects, reads the values and disconnects.
> > However, after 1020 repetitions, the following error occurs:
> > (process:10205): GLib-WARNING **: poll(2) failed due to: Invalid argument.
> >
> > I think the problem has to do with some sockets / file descriptors not
> > being closed properly.
> >
> > Can someone help me to get this fixed?
>
> have you considered trying to write this from scratch and not basing this off existing code.
>
> And yes, this will be most likely an issues with GSource handling of the attribute IO channel, but since you hacked the code is extremely hard to debug. It was never designed for what you are doing.
>
> Regards
>
> Marcel
>

I found a solution myself.  I quote from:
https://github.com/webOS-ports/nyx-modules/commit/bbcbbd64000ba76f39215e43a5179408ff96e097

"When a watch is added to the
glib mainloop it references internally a file descriptor to pass it
later to the poll
function (see poll(2)). Every watch gets an id which should be used by
the user to refer
to the watch whenever needed. When the io channel is destroyed the
watch should be remove
from the mainloop as well. If this isn't done probably by the user it
will cause the
internal list of fds which are passed to the poll function to exceed
the maximum of 256.
This finally results in poll returning EINVAL as error code."

With the additions from there my code runs without problems.

Greetings
 Markus
