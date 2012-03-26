Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTjdCTiOP+XWjk5GcF=37tRi4_uHYYOFX2j1Kj5xBSsqhA@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCTid2cRwetSyNpaT3vGGT_GrSGxzjqR6BJt-J-g4wJuM0w@mail.gmail.com>
	<CABBYNZJw+7Jat-NUuiMgSr+zcRSoEm1JhmwSUea60hOhpROWmA@mail.gmail.com>
	<CAB7rCTjdCTiOP+XWjk5GcF=37tRi4_uHYYOFX2j1Kj5xBSsqhA@mail.gmail.com>
Date: Mon, 26 Mar 2012 14:01:10 -0300
Message-ID: <CABBYNZLx3CZ9qhA7NyKaSz99bT44LPaPxtyiDy+RLTsTSozD6g@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Mon, Mar 26, 2012 at 1:10 PM, Mike <puffy.taco@gmail.com> wrote:
>> Pushing maybe a good idea in case of not being the initiator the
>> connection as you mentioned, in the other hand the endpoint may not be
>> ready, or willing to use the fd, at that point so I would only signal
>> that it is now available, otherwise the concept of using it on-demand
>> in broken.
>
> Isn't that the point of registering an endpoint?  If you have
> registered, you are declaring you will accept data.

The endpoint takes care of the configuration, it doesn't mean you need
to Acquire the file descriptor, actually you should only acquire if
you are going to use it, so even if the phone connects and open the
SCO connection it doesn't mean you should pickup it right away since
different policies/routing might be implemented.

>> Btw, this already is possible if you listen to
>> Headset.State, also the interface was designed to have the connection
>> on-demand, so you should only call Acquire when you gonna use the fd,
>> anyway even in the case of audio transfer you maybe the initiator and
>> should be able to directly control the connection via Acquire/Release
>> to be able to do that so Resume/Suspend would not be that great even
>> for IVI/carkit systems.
>
> So that has me confused.  If the MediaTransport interface is somewhat
> generic, why would I want to listen to another interface to know if I
> should call Acquire?  In my case, I would need to listen to
> HeadsetGateway.  As it is, the audio from my SCO connection is sent
> over a PCM bus, so I currently do not even register an SCO endpoint,
> because it was not needed.  I agree that if you are the initiator,
> Acquire/Release is sufficient.  In my case, as the non-initiator, it
> is not sufficient because I do not want to open an audio link by
> calling acquire unless it already exists.

That is a broken design, PCM routing also needs proper endpoint
otherwise it is impossible to implement routing policies since the
audio is transparently routed, it only works if you have a single
purpose device. Also please pay attention that with audio transfer you
may be the initiator of SCO connection even in case of IVI/carkit
role.

> My perception is that the interface is written from the point of view
> of the audio source (A2DP Audio Source or HFP AG), but this does not
> translate as well to the audio sinks (A2DP Audio Sink or HFP HF).

Nope it should works in both cases, it only assumes that the endpoint
need to know when it should Acquire the file descriptor not bluetoothd
should push the file descriptor. Anyway I still believe pull is
better, because the client may not be ready or block (using threads)
and it know better when it needs the fd.

-- 
Luiz Augusto von Dentz
