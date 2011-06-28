Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTinFieuN8HSLu8-pTaMix9r48d6HBw@mail.gmail.com>
References: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
	<BANLkTikuRgeFW-fXckR4ST14idxPSmNP7g@mail.gmail.com>
	<7.0.1.0.2.20110627205517.03250550@gmx.net>
	<BANLkTinFieuN8HSLu8-pTaMix9r48d6HBw@mail.gmail.com>
Date: Wed, 29 Jun 2011 00:48:20 +0300
Message-ID: <BANLkTimMQcjj3A=cNaUWY4xByY2WrhA9RA@mail.gmail.com>
Subject: Re: Media API with more than one headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: Peter Kornatowski <pkorn@gmx.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Jun 28, 2011 at 11:07 PM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
> Hi Peter,
>
> Can you try attached patch ?
> At least you should not lose audio on all the headsets when
> disconnecting one of them.

Good catch, the headset watch is not registered per device so we have
to do the matching inside the callback like you did, one thing that
perhaps is worth doing is to make the matching before the switch so if
the endpoint has a device then we match it with the device given to
the callback.


-- 
Luiz Augusto von Dentz
