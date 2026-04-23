Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BF1946BC;
	Thu, 23 Apr 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948581; cv=none; b=VNSu4UwXuOi/Op8W7Wp+G2S9gZx+LZCy+xSK1gRFgStiR6s7hv3tjn/D5RArl7vRerB7dZY4ywBoteP8n8/kJabeOq6t/LKUdHZ/YgAJZse2vtHyBFasM3cNliFsA7FjQTotnPWhQaBja0LQ/3NKxiOq8Ybx4FA0quV4960O15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948581; c=relaxed/simple;
	bh=pEaZ1P/+PfX8bgotfo5B2mkvnW6BbyRKoVpESP0lZeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzN9WBYwOmvj50BFQNS9+UpFZLMCEulKc4onY5Q0stB4TX4ffwFda01HGJA3b+mxg7LbVW8/UOjmq11WW8ujHqhM/frrt9nZeHDHi0YyjdSOA3QOxqPD8wxpqJIs3C+dR9OXG4BB+xmK9RnOaXuT060pTb/LTlx2G2nDp40IT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieeRnMT4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieeRnMT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B82C2BCAF;
	Thu, 23 Apr 2026 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776948581;
	bh=pEaZ1P/+PfX8bgotfo5B2mkvnW6BbyRKoVpESP0lZeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieeRnMT4i1lP/R9j6oB7TCe/sC7WvQIriGrM6n+wiRaEMGxDhZvHCvAgZN3qwuvat
	 iNVX2FdzuLPPG7NYdxRAZcEtoXPbRLXa/uhNW/i/hPcb6WIL2KcwLu6dB4hauXCv25
	 4BIPlt+tHixd7b2dn5slNIi01/dFjklS0iX11Pjs=
Date: Thu, 23 Apr 2026 14:49:38 +0200
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
Message-ID: <2026042355-blighted-chewing-5e50@gregkh>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>

On Fri, Feb 20, 2026 at 02:12:55AM +0900, Jeongjun Park wrote:
> The "timers: Provide timer_shutdown[_sync]()" patch series implemented a
> useful feature that addresses various bugs caused by attempts to rearm
> shutdown timers.
> 
> https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/
> 
> However, this patch series was not fully backported to versions prior to
> 6.2, requiring separate patches for older kernels if these bugs were
> encountered.
> 
> The biggest problem with this is that even if these bugs were discovered
> and patched in the upstream kernel, if the maintainer or author didn't
> create a separate backport patch for versions prior to 6.2, the bugs would
> remain untouched in older kernels.
> 
> Therefore, to reduce the hassle of having to write a separate patch, we
> should backport the remaining unbackported commits from the
> "timers: Provide timer_shutdown[_sync]()" patch series to versions prior
> to 6.2.
> 
> ---
>  Documentation/RCU/Design/Requirements/Requirements.rst      |   2 +-
>  Documentation/core-api/local_ops.rst                        |   2 +-
>  Documentation/kernel-hacking/locking.rst                    |  17 ++---
>  Documentation/timers/hrtimers.rst                           |   2 +-
>  Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 ++---
>  arch/arm/mach-spear/time.c                                  |   8 +--
>  drivers/bluetooth/hci_qca.c                                 |  10 ++-
>  drivers/char/tpm/tpm-dev-common.c                           |   4 +-
>  drivers/clocksource/arm_arch_timer.c                        |  12 ++--
>  drivers/clocksource/timer-sp804.c                           |   6 +-
>  drivers/staging/wlan-ng/hfa384x_usb.c                       |   4 +-
>  drivers/staging/wlan-ng/prism2usb.c                         |   6 +-
>  include/linux/timer.h                                       |  17 ++++-
>  kernel/time/timer.c                                         | 316 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  net/sunrpc/xprt.c                                           |   2 +-
>  15 files changed, 322 insertions(+), 100 deletions(-)
> 

Ugh, I got the following build error for this series:
../drivers/misc/sgi-xp/xpc_partition.c: In function 'xpc_partition_disengaged':
../drivers/misc/sgi-xp/xpc_partition.c:294:25: error: implicit declaration of function 'del_singleshot_timer_sync' [-Werror=implicit-function-declaration]
  294 |                         del_singleshot_timer_sync(&part->disengage_timer);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~


Don't know what happened, but I'll go and drop them all now.

Do you _REALLY_ need these in the 5.10.y kernel?  Who is going to use
them?

thanks,

greg k-h
