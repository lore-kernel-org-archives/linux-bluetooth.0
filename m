Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKyPPb=Ov+6p6-9PUY6nrBTD1M_Ew9YeF_cxt8OQ5x85Q@mail.gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKyPPb=Ov+6p6-9PUY6nrBTD1M_Ew9YeF_cxt8OQ5x85Q@mail.gmail.com>
Date: Tue, 15 May 2012 08:46:35 +0200
Message-ID: <CANT-zCU-CTWq-9ZR+YQQfuQWKHnxut_dXBA1Cpna9vTJvO5J9w@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 0/5] ACL disconnect reason
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 14, 2012 at 7:00 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Mon, May 14, 2012 at 6:32 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> Some use-cases require distinguishing the reason behind an ACL disconnection. Particularly, IVI use-cases regarding HFP and A2DP need to know if a disconnection was due to a timeout, in order to know which should be the reconnection strategy.
>
> Afaik there is only one use case which is link loss aka out of range,
> because of that carkit/headset policy is normally clean disconnect do
> not reconnect, non-clean disconnect do reconnect.

Right, with a few exceptions including clean disconnection during
head-unit shutdown.

>>
>> This information needs to be exposed to some component implementing the specific policy of each application. Typically neither BlueZ or oFono (in case of HFP) would be the case. This means the disconnect reason needs to be exposed in D-Bus.
>>
>> In this patch series the proposed approach is to add a signal in the device API, given that we already have some low-level disconnection-related API there. Another approach would be to support it in the specific HFP and A2DP interfaces.
>
> The disconnect reason might no be necessary, have you thought about
> implementing the reconnection logic directly in bluetoothd? This way
> we can test this without the UI, and we know when for example A2DP has
> disconnect without CLOSE command or things like that and afaik we can
> query the error from the socket.

The connection/reconnection policy is manufacturer and model-specific.
Therefore I find it difficult that we could include this inside
bluetoothd.

Having said that, I would be happy to review any proposal.

> Btw, none of this is useful without tuning the link supervision
> timeout because the current one used by BlueZ iirc is 20 seconds, far
> too big for being able to recover the audio.

That should definitely be tuned. However it's not always about
recovering audio, but knowing to which phone the car should connect.
With HFP there might be no audio and no voicecall during connection.

Cheers,

Mikel
