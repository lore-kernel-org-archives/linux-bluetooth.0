Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC82C234A;
	Thu, 23 Apr 2026 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951798; cv=none; b=sXL16serR/WHDY4aWb/RBpsxbvwnejfimCZ/by+DxoL/W2Re6LbFT6AqfJTMCHLrK+uQM/X+gHyn9ZRAjo4V86W1WTzTZtj5XCrBM6OR7pPOva95XFkoZCxZm7X/vmR0sAAu2yVTLg03KGSPzVqefiGNlWw9OxmEJQmE/9PgS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951798; c=relaxed/simple;
	bh=gpRjfb10QZDnm3Q/lvwUaX6a9G19JYd7lLGtlSJJf0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLOjOC35Liholza1gfV0csI+92KNk/ZTmkXJG12a67tRTqWDViGKCYJj2k69QbramPhB+EW+AF9cILyS2IAUxCV6hvKGq3ApSxT3JFWyLYAadhvLEJyLHLUvcEhZzBOtteq/P7pcduqlVB1aea2fy0hZK3RSIwiALEUnMbNkZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vl38Mtpv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vl38Mtpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6656EC2BCAF;
	Thu, 23 Apr 2026 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776951797;
	bh=gpRjfb10QZDnm3Q/lvwUaX6a9G19JYd7lLGtlSJJf0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vl38MtpvDGdp8SgifcuNTNGyBgkbU08kWEsp7pJZ5SsE+otL7ZO+SO51bsigtFsAO
	 qmkoyxpxT8PPQmdxVSQl/n475niMQryUBf2Z5x4VK/DRUjryp3mtD9CjEjgDfhqNAX
	 1tdKca3UAvcOncSIwoinMjUyx2CGs42N52uQGpWA=
Date: Thu, 23 Apr 2026 15:43:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: stable@vger.kernel.org, tglx@linutronix.de, Julia.Lawall@inria.fr,
	akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, luiz.dentz@gmail.com, marcel@holtmann.org,
	maz@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	sboyd@kernel.org, viresh.kumar@linaro.org, zouyipeng@huawei.com,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 5.10.y 00/15] timers: Provide timer_shutdown[_sync]()
Message-ID: <2026042327-wackiness-purify-09c2@gregkh>
References: <20260219171310.118170-1-aha310510@gmail.com>
 <2026042355-blighted-chewing-5e50@gregkh>
 <CAO9qdTE0NhB58hqK8_1=69bD7uG_vF-FfpQXGR8dqcuWV4H2Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTE0NhB58hqK8_1=69bD7uG_vF-FfpQXGR8dqcuWV4H2Mw@mail.gmail.com>

On Thu, Apr 23, 2026 at 10:36:13PM +0900, Jeongjun Park wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 20, 2026 at 02:12:55AM +0900, Jeongjun Park wrote:
> > > The "timers: Provide timer_shutdown[_sync]()" patch series implemented a
> > > useful feature that addresses various bugs caused by attempts to rearm
> > > shutdown timers.
> > >
> > > https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/
> > >
> > > However, this patch series was not fully backported to versions prior to
> > > 6.2, requiring separate patches for older kernels if these bugs were
> > > encountered.
> > >
> > > The biggest problem with this is that even if these bugs were discovered
> > > and patched in the upstream kernel, if the maintainer or author didn't
> > > create a separate backport patch for versions prior to 6.2, the bugs would
> > > remain untouched in older kernels.
> > >
> > > Therefore, to reduce the hassle of having to write a separate patch, we
> > > should backport the remaining unbackported commits from the
> > > "timers: Provide timer_shutdown[_sync]()" patch series to versions prior
> > > to 6.2.
> > >
> > > ---
> > >  Documentation/RCU/Design/Requirements/Requirements.rst      |   2 +-
> > >  Documentation/core-api/local_ops.rst                        |   2 +-
> > >  Documentation/kernel-hacking/locking.rst                    |  17 ++---
> > >  Documentation/timers/hrtimers.rst                           |   2 +-
> > >  Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 ++---
> > >  arch/arm/mach-spear/time.c                                  |   8 +--
> > >  drivers/bluetooth/hci_qca.c                                 |  10 ++-
> > >  drivers/char/tpm/tpm-dev-common.c                           |   4 +-
> > >  drivers/clocksource/arm_arch_timer.c                        |  12 ++--
> > >  drivers/clocksource/timer-sp804.c                           |   6 +-
> > >  drivers/staging/wlan-ng/hfa384x_usb.c                       |   4 +-
> > >  drivers/staging/wlan-ng/prism2usb.c                         |   6 +-
> > >  include/linux/timer.h                                       |  17 ++++-
> > >  kernel/time/timer.c                                         | 316 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> > >  net/sunrpc/xprt.c                                           |   2 +-
> > >  15 files changed, 322 insertions(+), 100 deletions(-)
> > >
> >
> > Ugh, I got the following build error for this series:
> > ../drivers/misc/sgi-xp/xpc_partition.c: In function 'xpc_partition_disengaged':
> > ../drivers/misc/sgi-xp/xpc_partition.c:294:25: error: implicit declaration of function 'del_singleshot_timer_sync' [-Werror=implicit-function-declaration]
> >   294 |                         del_singleshot_timer_sync(&part->disengage_timer);
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> >
> 
> Oh dear. This issue occurred because commit 997754f114ef ("misc/sgi-xp:
> Replace in_interrupt() usage") was merged into version 5.11-rc1 and was
> therefore not backported to 5.10.y.
> 
> Since this is a simple fix that only requires adding this commit to this
> patch series, I will quickly write and send you the v2 patch.
> 
> https://lore.kernel.org/all/20201119103151.ppo45mj53ulbxjx4@linutronix.de/
> 
> >
> > Don't know what happened, but I'll go and drop them all now.
> >
> > Do you _REALLY_ need these in the 5.10.y kernel?  Who is going to use
> > them?
> >
> 
> You might think it is unnecessary, but I have seen bug patches related to
> timer_shutdown[_sync]() being backported after I backported it, and I
> believe it is well worth backporting if this feature allows various
> bug-fixing patches to be backported smoothly.

So you don't have a specific issue you are hitting with this patch set
that you want to have it here for?  It can't be for android devices, as
this patch series will be reverted from that tree, just like it was for
the 5.15.y Android trees, so what systems require it?

thanks,

greg k-h
