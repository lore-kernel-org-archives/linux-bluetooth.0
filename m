Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTid2cRwetSyNpaT3vGGT_GrSGxzjqR6BJt-J-g4wJuM0w@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCTid2cRwetSyNpaT3vGGT_GrSGxzjqR6BJt-J-g4wJuM0w@mail.gmail.com>
Date: Mon, 26 Mar 2012 11:41:34 -0300
Message-ID: <CABBYNZJw+7Jat-NUuiMgSr+zcRSoEm1JhmwSUea60hOhpROWmA@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Fri, Mar 23, 2012 at 2:51 PM, Mike <puffy.taco@gmail.com> wrote:
>
> Going back to this idea, it seems like MediaTransport should be
> redesigned to push the file descriptor to the endpoint, rather than
> the endpoint having to request it from the transport.  this would
> solve this issue.  The main problem is that acquiring the endpoint
> forces a call to resume.  In the case of HFP, this is bad.  I'm
> currently needing to implement HFP "Audio Connection Transfer Towards
> the AG".  Since I am the HS, all I need to do is drop the SCO
> connection -- however, there is no interface to do this well.  I tried
> implementing an SCO endpoint, since at least then the acquire and
> release calls would bring up an SCO connection and then allow me to
> drop it.  The issue here is that a phone that is connected via HFP
> will have a MediaTransport even though the SCO connection will not yet
> exist.  So, I get the SetConfiguration call which means I should be
> good to go on calling acquire.  But, if I call acquire now, it will
> create a useless SCO connection to my phone that then is dropped.
> There's no reason at this point to open the SCO connection.  I would
> rather be notified when the SCO connection exists, and have two
> additional methods called suspend and resume.  In the case of HFP,
> calling resume would eventually result in a new FD being pushed to me.

Pushing maybe a good idea in case of not being the initiator the
connection as you mentioned, in the other hand the endpoint may not be
ready, or willing to use the fd, at that point so I would only signal
that it is now available, otherwise the concept of using it on-demand
in broken. Btw, this already is possible if you listen to
Headset.State, also the interface was designed to have the connection
on-demand, so you should only call Acquire when you gonna use the fd,
anyway even in the case of audio transfer you maybe the initiator and
should be able to directly control the connection via Acquire/Release
to be able to do that so Resume/Suspend would not be that great even
for IVI/carkit systems.



-- 
Luiz Augusto von Dentz
