Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] sbc: bitstream packing optimization for encoder.
Date: Wed, 17 Dec 2008 16:16:52 +0200
Cc: "'Marcel Holtmann'" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
References: <200812112227.07170.siarhei.siamashka@nokia.com> <1229079849.22285.43.camel@violet.holtmann.net> <00c801c95c6d$9953dad0$cbfb9070$@de>
In-Reply-To: <00c801c95c6d$9953dad0$cbfb9070$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812171616.52348.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 12 December 2008 17:23:33 ext Christian Hoene wrote:
> Hi all,
>
> next week I will discuss the bug fixing of SBC with Jaska Uimonen, who is
> ill this week.
>
> The sound quality of the fix point implementation still remains below of
> the quality of the floating point version.

Has the sound quality improved with the latest patches?

By the way, which floating point version do you have in mind? Is it btsco,
which is referenced from this wiki page: http://wiki.bluez.org/wiki/SBC ?

I tried to have a look at btsco, but it seems to be much worse quality wise
than the fixed point version with an updated filtering function. I tried to
encode some audio sample, decode it back and compare result with the
original file in both cases.

Also I compared 32-bit fixed point vs. 16-bit fixed point, and looks like
16-bit fixed point version has a sufficient precision. Anyway, the values,
received from the filter, are quantized later and much more information
about lower order bits is usually lost at this stage.

-- 
Best regards,
Siarhei Siamashka
