Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4FDB2059.7000307@shapeseeker.com>
References: <4FDB2059.7000307@shapeseeker.com>
Date: Fri, 15 Jun 2012 15:17:22 +0200
Message-ID: <CANT-zCXOzBBaYvXRj3Z7xb=2oz7mSNTWLPUFeZi5ghHs6KzBwA@mail.gmail.com>
Subject: Re: Bluez patches for Multiple SCO Links
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Brian Smith <door@shapeseeker.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Jun 15, 2012 at 1:45 PM, Brian Smith <door@shapeseeker.com> wrote:
> Hi Mikel.
> Thanks for your patches to allow multiple SCO links. I'm trying to get it
> working. Can I ask you a couple of questions please?

Please provide some context information including what you're trying
to do, and which version of Kernel and userspace BlueZ you are using.

>
> 1) Can you recommend a specific USB bluetooth dongle that is known to work
> with this?

I cannot suggest any specific dongle but most of my testing was with
CSR chips and they all worked. Also Broadcom chips seemed to work.

You can use hciconfig -a to see information about your adapter.

> 2) Ideally i'd like to avoid pulseaudio and test this directly using the
> hstest.c code that comes with Bluez (this works OK with a single headset at
> least, but I'm having problems with multiple headsets and don't know if it
> is the bluetooth dongle I use that is the problem). Do you know if the patch
> allows hstest.c to play audio to 2 headsets at once? (or do I need to use
> pulseaudio).

Assuming your Kernel includes the patches, and you're using the latest
upstream version of BlueZ, most probably the problems you are having
are related to the MTU size.

These issues are a bit obscure to me and I don't have a full
explanation, but the MTU used during double-SCO needs to be twice as
big. My patches regarding this problem were (reasonably) rejected so
you will have to find a workaround.

First make sure the adapter is configured with at least 128 bytes,
using hciconfig hci0 scomtu 128:1. Once you have this, you should
probably be able to receive/record audio properly. If you want to
send/play audio, you might face some additional problems. However I
must admit I haven't tested it with hstest.

It would also be helpful If you could provide hcidump logs.

Cheers,
Mikel
