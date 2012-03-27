Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
To: Mike <puffy.taco@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Tue, 27 Mar 2012 08:31:09 +0200
Subject: RE: media transport -- when is acquire ok to call?
Message-ID: <66BD268F973E3544A665E5F503FB38B71AE959B22A@DC01.bmw-carit.intra>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCTid2cRwetSyNpaT3vGGT_GrSGxzjqR6BJt-J-g4wJuM0w@mail.gmail.com>
	<CABBYNZJw+7Jat-NUuiMgSr+zcRSoEm1JhmwSUea60hOhpROWmA@mail.gmail.com>
 <CAB7rCTjdCTiOP+XWjk5GcF=37tRi4_uHYYOFX2j1Kj5xBSsqhA@mail.gmail.com>
In-Reply-To: <CAB7rCTjdCTiOP+XWjk5GcF=37tRi4_uHYYOFX2j1Kj5xBSsqhA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,
 
> So that has me confused.  If the MediaTransport interface is somewhat
> generic, why would I want to listen to another interface to know if I
> should call Acquire?  In my case, I would need to listen to
> HeadsetGateway.  As it is, the audio from my SCO connection is sent
> over a PCM bus, so I currently do not even register an SCO endpoint,
> because it was not needed.  I agree that if you are the initiator,
> Acquire/Release is sufficient.  In my case, as the non-initiator, it is
> not sufficient because I do not want to open an audio link by calling
> acquire unless it already exists.

I'm not sure if this solves your specific problem(s) but I would propose that the MediaTransport API is extended with a method such as TryAcquire (or alternatively Acquire can be extended with either one more parameter, or some specific flag in accesstype). In that case the transport would not be acquired unless the audio link already exists.

The current approach of listening to a state property and then calling Acquire is racy, no matter if the property is in the same interface or not.

Regarding your comment on the need to listen to a different interface, I don't think this should be a big problem. Having said that, the Playing state in HeadsetGateway (and equivalents) could be replaced by a state in MediaTransport. That actually seems more appropriate to me.

Cheers,
Mikel

