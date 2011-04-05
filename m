Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Apr 2011 12:39:53 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Subject: Re: [PATCH 04/10] Bluetooth: Use kthread API in bnep
Message-ID: <20110405153054.GA2259@joana>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
 <1300713606-23523-5-git-send-email-szymon.janc@tieto.com>
 <20110324201226.GG2236@joana>
 <201104050951.17932.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201104050951.17932.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-04-05 09:51:17 +0200]:

> > Hy Szymon,
> 
> Hi,
> 
> > * Szymon Janc <szymon.janc@tieto.com> [2011-03-21 14:20:00 +0100]:
> > 
> > > kernel_thread() is a low-level implementation detail and
> > > EXPORT_SYMBOL(kernel_thread) is scheduled for removal.
> > > Use the <linux/kthread.h> API instead.
> > 
> > Just to be sure. Have you tested the kernel_thread removal patches for bnep
> > and hipd?
> 
> Sorry for late reply, missed that one..
> Yes, I did test both bnep (basic connect-disconnect) and hidp (play around with it
> from my mobile). Kernel processes create and terminate fine.

Fair enough, I applied the 3 patches. Thanks for fixing this.

> 
> I didn't test cmtp (don't have isdn hw) but change is very similar to rest of patches.

No problem, no one should be using this thing these days.

-- 
Gustavo F. Padovan
http://profusion.mobi
