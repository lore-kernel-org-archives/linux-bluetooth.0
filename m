Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 5 Jul 2012 08:58:08 +0200
Subject: AW: media transport -- when is acquire ok to call?
Message-ID: <66BD268F973E3544A665E5F503FB38B71B39C4120B@DC01.bmw-carit.intra>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCTid2cRwetSyNpaT3vGGT_GrSGxzjqR6BJt-J-g4wJuM0w@mail.gmail.com>
	<CABBYNZJw+7Jat-NUuiMgSr+zcRSoEm1JhmwSUea60hOhpROWmA@mail.gmail.com>
	<CAB7rCTjdCTiOP+XWjk5GcF=37tRi4_uHYYOFX2j1Kj5xBSsqhA@mail.gmail.com>
	<66BD268F973E3544A665E5F503FB38B71AE959B22A@DC01.bmw-carit.intra>
 <CAB7rCTgUQsygR4sBWp5oVwi647OfEncgCTZeQivgj4oZg9qt0A@mail.gmail.com>
In-Reply-To: <CAB7rCTgUQsygR4sBWp5oVwi647OfEncgCTZeQivgj4oZg9qt0A@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Hi Mikel,
> 
> On Tue, Mar 27, 2012 at 1:31 AM, Mikel Astiz <Mikel.Astiz@bmw-carit.de>
> wrote:
> > Hi Mike,
> >
> >> So that has me confused.  If the MediaTransport interface is somewhat
> >> generic, why would I want to listen to another interface to know if I
> >> should call Acquire?  In my case, I would need to listen to
> >> HeadsetGateway.  As it is, the audio from my SCO connection is sent
> >> over a PCM bus, so I currently do not even register an SCO endpoint,
> >> because it was not needed.  I agree that if you are the initiator,
> >> Acquire/Release is sufficient.  In my case, as the non-initiator, it
> >> is not sufficient because I do not want to open an audio link by
> >> calling acquire unless it already exists.
> >
> > I'm not sure if this solves your specific problem(s) but I would propose that
> the MediaTransport API is extended with a method such as TryAcquire (or
> alternatively Acquire can be extended with either one more parameter, or
> some specific flag in accesstype). In that case the transport would not be
> acquired unless the audio link already exists.
> >
> > The current approach of listening to a state property and then calling
> Acquire is racy, no matter if the property is in the same interface or not.
> 
> I think your proposal would fix this race in a way that doesn't fundamentally
> change the current design, so I'm in favor of it.
> 
> > Regarding your comment on the need to listen to a different interface, I
> don't think this should be a big problem. Having said that, the Playing state in
> HeadsetGateway (and equivalents) could be replaced by a state in
> MediaTransport. That actually seems more appropriate to me.
> 
> Agreed. The reason I don't like the current approach is that there is no
> explicit connection between the MediaTransport object and the other object
> that has the state property.
> 
> Mike

The issue above could be briefly discussed next week as well.

Cheers,
Mikel

