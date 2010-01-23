Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Jan 2010 15:45:18 +0000 (GMT)
To: Anil Sasidharan <anilvpr@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: A2DP multiple sink support
In-Reply-To: <f6c5b8d91001172139q5f23201fnd2ab2193ebc9a33f@mail.gmail.com>
References: <f6c5b8d91001170441m1d0d8755x15147f92b85b477f@mail.gmail.com>  <f6c5b8d91001170450n415bf083l5044e193014d8f85@mail.gmail.com>  <1263760863.5591.59.camel@localhost.localdomain> <f6c5b8d91001172139q5f23201fnd2ab2193ebc9a33f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1264261518.596186.16656.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 18 Jan 2010, Anil Sasidharan wrote:

> However I did not get the last point mentioned in your mail i.e. "So
> expect some cracks in the audio until both connections are setup
> properly".....
>
> Could you please elaborate on this.

Anil you should be aware that Marcel will rarely respond to top posting..

> On Mon, Jan 18, 2010 at 2:11 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > This whole thing with one source adapter works, but during inquiry and
> > page it is almost impossible for a Bluetooth chip to transmit any data.
> > So expect some cracks in the audio until both connections are setup
> > properly.

This means that when a Bluetooth device is performing a device inquiry, or
setting up a connection (paging) to another device, it will usually pause
data transfer over other baseband connections that it already holds.

This means that if you set up an audio stream, then try to start another
stream or perform a device inquiry at the same time the first stream may
become broken (cracks) as no data is being transferred.

Actually, since A2DP is not necessarily low-latency, you may find that
forward buffering is adequate to cover small temporary lapses in data
transfer.

regards,
iain


