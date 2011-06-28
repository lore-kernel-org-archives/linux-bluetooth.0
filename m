Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimMQcjj3A=cNaUWY4xByY2WrhA9RA@mail.gmail.com>
References: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
	<BANLkTikuRgeFW-fXckR4ST14idxPSmNP7g@mail.gmail.com>
	<7.0.1.0.2.20110627205517.03250550@gmx.net>
	<BANLkTinFieuN8HSLu8-pTaMix9r48d6HBw@mail.gmail.com>
	<BANLkTimMQcjj3A=cNaUWY4xByY2WrhA9RA@mail.gmail.com>
Date: Wed, 29 Jun 2011 00:16:30 +0200
Message-ID: <BANLkTiknkbZcS2AASzS_qeXbNJ3_Qa2e1A@mail.gmail.com>
Subject: Re: Media API with more than one headset
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Peter Kornatowski <pkorn@gmx.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 28, 2011 at 11:48 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Tue, Jun 28, 2011 at 11:07 PM, Lukasz Rymanowski
> <lukasz.rymanowski@gmail.com> wrote:
>> Hi Peter,
>>
>> Can you try attached patch ?
>> At least you should not lose audio on all the headsets when
>> disconnecting one of them.
>
> Good catch, the headset watch is not registered per device so we have
> to do the matching inside the callback like you did, one thing that
> perhaps is worth doing is to make the matching before the switch so if
> the endpoint has a device then we match it with the device given to
> the callback.

I thought about it but we can do matching only if transport exist.
Second thing is that in state HEADSET_STATE_CONNECTING we are actually
interested to do something if transport does not exist yet (look into
media_endpoint_set_configuration() )
So it looks like different states have different approach.
Anyway, let's wait for test result.

>
>
> --
> Luiz Augusto von Dentz
>

/Lukasz
