Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1264261518.596186.16656.nullmailer@galant.ukfsn.org>
References: <f6c5b8d91001170441m1d0d8755x15147f92b85b477f@mail.gmail.com>
	 <f6c5b8d91001170450n415bf083l5044e193014d8f85@mail.gmail.com>
	 <1263760863.5591.59.camel@localhost.localdomain>
	 <f6c5b8d91001172139q5f23201fnd2ab2193ebc9a33f@mail.gmail.com>
	 <1264261518.596186.16656.nullmailer@galant.ukfsn.org>
Date: Fri, 5 Feb 2010 21:29:42 +0530
Message-ID: <f6c5b8d91002050759s3968fa13ka3ee4bfaab4b8b4@mail.gmail.com>
Subject: Re: A2DP multiple sink support
From: Anil Sasidharan <anilvpr@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jan 23, 2010 at 9:15 PM, Iain Hibbert <plunky@rya-online.net> wrote:
>
> This means that when a Bluetooth device is performing a device inquiry, or
> setting up a connection (paging) to another device, it will usually pause
> data transfer over other baseband connections that it already holds.
>
> This means that if you set up an audio stream, then try to start another
> stream or perform a device inquiry at the same time the first stream may
> become broken (cracks) as no data is being transferred.
>
> Actually, since A2DP is not necessarily low-latency, you may find that
> forward buffering is adequate to cover small temporary lapses in data
> transfer.
>

Hi Iain,

Thanks a lot for the inputs. Based on this I've tried some experiments.
1. A2DP src has been paired and connected to the A2DP sink
2. While the connection with first SINK is active, I've tried to pair
and connect to another A2DP sink
3. Pairing with the second SINK gets done, however while trying to
connect I'm encountering an error from D-Bus "Stream Setup Failed".
What could be wrong

It would be really great if you could throw some light on this. BTW
I'm using Bluez v3.36

Warm Regards,
Anil
