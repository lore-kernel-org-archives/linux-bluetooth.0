Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH 04/10] Bluetooth: Use kthread API in bnep
Date: Tue, 5 Apr 2011 09:51:17 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com> <1300713606-23523-5-git-send-email-szymon.janc@tieto.com> <20110324201226.GG2236@joana>
In-Reply-To: <20110324201226.GG2236@joana>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201104050951.17932.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hy Szymon,

Hi,

> * Szymon Janc <szymon.janc@tieto.com> [2011-03-21 14:20:00 +0100]:
> 
> > kernel_thread() is a low-level implementation detail and
> > EXPORT_SYMBOL(kernel_thread) is scheduled for removal.
> > Use the <linux/kthread.h> API instead.
> 
> Just to be sure. Have you tested the kernel_thread removal patches for bnep
> and hipd?

Sorry for late reply, missed that one..
Yes, I did test both bnep (basic connect-disconnect) and hidp (play around with it
from my mobile). Kernel processes create and terminate fine.

I didn't test cmtp (don't have isdn hw) but change is very similar to rest of patches.

I've noticed that hidp patch doesn't apply anymore to bluetooth-next-2.6 after
merging 2.6.39-rc1. I'll send v2 shortly (only for that one if you're fine with that)

BR,
Szymon Janc
