Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Fix unloading of adapter drivers
Date: Thu, 10 Mar 2011 15:16:29 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1299759009-17407-1-git-send-email-szymon.janc@tieto.com> <20110310134204.GA22155@jh-x301>
In-Reply-To: <20110310134204.GA22155@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201103101516.30070.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,
> 
> On Thu, Mar 10, 2011, Szymon Janc wrote:
> > Call driver remove callback only if corresponding probe succeed.
> > ---
> >  src/adapter.c |   41 +++++++++++++++++++++++++----------------
> >  1 files changed, 25 insertions(+), 16 deletions(-)
> 
> The patch looks ok'ish, but don't you have to update the
> btd_unregister_adapter_driver function too? (so it also removes
> potential entries in the loaded_drivers list)

Hmm all drivers unregisters them self only when plugin is unloaded, but it might
be good to be prepare for more 'dynamic' drivers in future..

Will prepare v2 shortly.

-- 
BR
Szymon Janc
