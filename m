Return-Path: <cyrus@holtmann.org>
Message-ID: <4FDB4583.5070902@shapeseeker.com>
Date: Fri, 15 Jun 2012 15:24:03 +0100
From: Brian Smith <door@shapeseeker.com>
MIME-Version: 1.0
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez patches for Multiple SCO Links
References: <4FDB2059.7000307@shapeseeker.com> <CANT-zCXOzBBaYvXRj3Z7xb=2oz7mSNTWLPUFeZi5ghHs6KzBwA@mail.gmail.com>
In-Reply-To: <CANT-zCXOzBBaYvXRj3Z7xb=2oz7mSNTWLPUFeZi5ghHs6KzBwA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mikel Astiz wrote:
>
> Assuming your Kernel includes the patches, and you're using the latest
> upstream version of BlueZ, most probably the problems you are having
> are related to the MTU size.
>
> These issues are a bit obscure to me and I don't have a full
> explanation, but the MTU used during double-SCO needs to be twice as
> big. My patches regarding this problem were (reasonably) rejected so
> you will have to find a workaround.
>
> First make sure the adapter is configured with at least 128 bytes,
> using hciconfig hci0 scomtu 128:1. Once you have this, you should
> probably be able to receive/record audio properly. If you want to
> send/play audio, you might face some additional problems. However I
> must admit I haven't tested it with hstest.
>
>   
Thanks for your reply Mikel. I tested your suggestion of changing the 
MTU and it worked!  It started as 64:8, changing to 128:1 didn't work 
but changing to 128:8 solved the problem. (I am using kernel 3.5rc1, 
BlueZ 4.100,  'Sitecom' branded CSR dongle, 'hstest.c' player). Also 
I've tested both playback and recording on 2 headsets in parallel, both 
are working well.

Cheers,
Brian.

-- 
Brian Smith.
"The bells of clocktowers stitch the sleeper's dreams together." - Memory Palace

