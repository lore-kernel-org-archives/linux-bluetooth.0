Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030513105017.0d234df0@unixmail.qualcomm.com>
Date: Tue, 13 May 2003 11:00:18 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification - L2CA_DisconnectCfm
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000d01c318e4$32a57460$1a01010a@baked>
References: <1052783343.1132.159.camel@pegasus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 05:11 PM 5/12/2003, Daryl Van Vorst wrote:
>Marcel,
>
>The behaviour you list below makes sense to me. I think there's supposed to
>be a 60 second timeout instead of 5 seconds, but that seems a bit excessive
>to me. Does it matter? If we close L2CAP and then the remote side sends an
>L2CAP_DISCONN_RSP, does the fact that we've already closed the channel cause
>any different packets to be exchanged?
No. If they don't send rsp within 5 second we simply kill this channel.
And if we receive rsp for already closed channel we ignore it.

>The only advantage that I see in the capability of a blocking close is
>completeness. I can't think of a scenario where it really matters, but you
>never know what someone will cook up.
>
>I don't believe the application actually needs to know that the
>disconnection was normal, just that it has definitely been disconnected. I'm
>a little fuzzy on the definition of "disconnected". Telling the app that
>there was a timeout is optional.
What we need is SO_LINGER option support. Application doesn't care so much about
the disconnect itself but it does care if all the data that it had written to a 
socket has been sent.
i.e. 
        connect(sk);
        send(sk, stuff, sizeof(stuff));
        close(sk);

Some apps want close() to sleep until all data has been sent and connection was 
successfully closed.

>If the stack closing the L2CAP connection and then receiving an
>L2CAP_DISCONN_RSP afterwards does not cause any different traffic to occurr
>(ie: the remote side can't tell the difference), then we're probably ok. Is
>this true?  
Yes, remote side cannot tell whether a local app is sleeping on close() or not. 

>Then the only difference between what we do and what the spec
>says is _when_ the "L2CA_DisconnectCfm" gets sent to the app. In our case,
>it would be immediately (i.e.: close() returned success). In the test case,
>it is 60 seconds after sending the disconnect request.
Yes. But SO_LINGER support is still useful for real life apps. I'll look in to it.

Max
