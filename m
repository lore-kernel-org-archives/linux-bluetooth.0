Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] sbc: bitstream packing optimization for encoder.
From: Marcel Holtmann <marcel@holtmann.org>
To: Christian Hoene <hoene@uni-tuebingen.de>
Cc: 'Siarhei Siamashka' <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <00c801c95c6d$9953dad0$cbfb9070$@de>
References: <200812112227.07170.siarhei.siamashka@nokia.com>
	 <1229045974.22285.18.camel@violet.holtmann.net>
	 <200812121137.18041.siarhei.siamashka@nokia.com>
	 <1229079849.22285.43.camel@violet.holtmann.net>
	 <00c801c95c6d$9953dad0$cbfb9070$@de>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 16:30:47 +0100
Message-Id: <1229095847.22285.93.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

can we please keep this mailing a top-posting free zone. I know it is
hard for Outlock to get this right, but it is possible.

> next week I will discuss the bug fixing of SBC with Jaska Uimonen, who is
> ill this week.
> 
> The sound quality of the fix point implementation still remains below of the
> quality of the floating point version.
> 
> Maybe, we shall support both depending on the performance requirements?

I think we should focus a fixed point version. There should be no need
for floating point at all. If fixed point isn't good enough, then we
screwed it up.

And in case of embedded devices we are seriously limited with floating
point and doing that in software just doesn't work out. And this is
mostly not directly a performance problem. It is more a power
consumption problem. We don't wanna have A2DP drain the battery.

Regards

Marcel


