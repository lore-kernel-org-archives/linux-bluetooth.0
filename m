Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B392C11C4
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951387; cv=pass; b=lbYSfYwE8oJzTaPRFuKeeNZ/qBv6drGb7xQmmt+YVZ+3QKLNlnJJVOo6J0CDMmLSD+YkqIS3LahAejgVvaZJuE+UvGsi55s0+2zt3x+yzUjNyCp5iJvIHtrdvnaufWTJvFQIkiakm7Qi/WPhNiU0h1ouwl2M1L24kVLlqjIB9uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951387; c=relaxed/simple;
	bh=F/cep53Ywkv6YQpg2IYGnHWs7tOX/EjkwJiVvWu7UnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eV/oRMRbIqGPHmigMn/HbWVnO0VCvCFBy+zsxv0clUfjBqhiNDCLHvgnswmSvyQQZdQDVbLTzj+XBqJ5Pv5s9LuBF1CjcVZJq8SfWhKSU0zE3Xrc9GQtiFj2MdaDVer5hH+2m0Mm6O9odPc4XFfzyKtt4x8JOfJk//QcMeyicg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILRKhLsf; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILRKhLsf"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4254480a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 06:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776951386; cv=none;
        d=google.com; s=arc-20240605;
        b=kZu3gqHQQxN8JWIyskukSnApCW+lN76Njw/Bb55ryXXpr53t/bbYkWF2dRecGQHFP7
         qqlhGkBbESh7jSJkQm0dfuKE2+YoIMAFjGxoia9NbLI6lx9XmsNBhAMFLMEqePr3rfhy
         SV2aZTITFY5K0PIGXNQ3JhZlE21I+xTEZCU7yaauabsKt9KiJZHI1+JhqfSq+4LH+YwL
         16VQ2+tsOGvAk87oYSV/F1xeoPk1cYO/SNPYp3HdLs2tB1dHhMqnvHkmMmXDd+PpiKa4
         9JpYO2OfPpFit8WD7lprkcgHKBcqaDrop/hhcqgyYOcj8wDLFdPA1fu015DoHj7gW63L
         tE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VhuOOby+gqJo2HpDu1be6m2G5DzT3bivgrqq1vW5a5g=;
        fh=LhxySiNIj4aZCK7oMbb2pR3WvFdUFzHSj+JdR0NHT2s=;
        b=G9XFqj3HdmWYfL8gCXF6ODp/40OngSLc8GGTTsfGi4RcJg4f4dahCC3D2Oek3h0uRc
         mlkTHwFKq92xKieUnwDX3aIfbzEnfjBKbXJJVPZfBjWCGfPnifEUW2hLxakyzuGHsdjn
         Bqgh1vkOiNV0qoKNi9rJp+hp/3iXlChKx4F/HIqTsi8WeW1svK6I3P9QOn0TTXEu+/OI
         gkgP930PKc+uWOb3OADfzz4DaCyyF+1emwfFhNQGeoDkJ2XoRWL6I0kOMdoYH82KRY9A
         XhDGRT7f3i55URkA620SRFjtwEeo3PvNLvLPNX4pD6wgtQKGmXh/wxlh4gjI/y56j5t9
         sOrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776951386; x=1777556186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhuOOby+gqJo2HpDu1be6m2G5DzT3bivgrqq1vW5a5g=;
        b=ILRKhLsfYxFOUP+1l8w/YFDDyzUiS7Pt3De07hqJbP467jZLMy/sjphkvyAFXryV2b
         XKwPx1N64YxdBYiHYs5hJclYE2ltHWHdWEbK7HeJH8omidnlgoCTqo16AHr3Ey7BYCfY
         iRB1k1P8JyTFM7ebXIA8HxlmPlu8Ftwln9MNuq2TzgV601V0zMP/xs9A74XIzqGOxm7u
         slL9IRfTuYTNNqiB5YBpFmn54JPK2jKxSRImY+HQZTymwOT4kF/IH9cAlPjpA+hJmoVg
         Co6e3dZwauZXTg5kNGTrv184F3GEDlOrk4bfAJK/QuqEoDS3kNFtMYfUP3uR02B9NFsH
         lSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951386; x=1777556186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhuOOby+gqJo2HpDu1be6m2G5DzT3bivgrqq1vW5a5g=;
        b=cAOQz7WmNAIwevyQL4+716Aym5+qjfIwxLUydlst0aMyGdmUr81zy/UYhPfz7HC8BJ
         r18HBQSFg0oADN/sjuPkHuzjcE87E+B+FNeQ9naDAgFl73r9/Ul/oS4V+ltphO3d1+aK
         42nHTelQD7Ay7bOt7p56aPCfiD4rZfyh9ttdAQ8B+WLlBnk8cul3kkclPzJjyhpeSk3F
         6PcSKFUnWS4Yq9IvMAX80JhFJOHeTcqwM1rk/+xb9HRqY4/Kzu3biiaeFIT2lsgHBQWZ
         gOYGjg2Tm3aMTYuyJeWGrpyHW/d+nnfKmsg+rQc8eU7hLUyb2a7EUsi7kZRwWnIZDuz1
         hTIQ==
X-Forwarded-Encrypted: i=1; AFNElJ85ENch0fpxmIUy7DssHZGTzFzZO/aRNBIpMJcWw1JzyjiywWtBZfgnnl2kpCPOC6jr+y0+/zFRm5FXk/yLqrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6o1E8FKdYfjWiTqOFKV6K8E6B4IbhBEagGEDdpyEsOh2aQhkC
	FwOn+zAegDKl9rXRXEKAlHKKzTSjD5aPiuXMMAHUaBIPF9VlaR7DBSAuGF+L5Bim/NaRFSWoWzL
	stXHcqnfn0NYqUbGrqS7Po1W4Q/dFebg=
X-Gm-Gg: AeBDietwWcnMDhSfkiLNfNStAI4jkbTyGdjsC7fBzlKc+SVojIVo7+Dw0WqQSu9uP4E
	uSZ0+SV9KSC7hWKMV8N2PKr2orRh5Xl+JC2o5hRsfDog95RISVhsJHw9ed7m/KhVzvMj/Efvehr
	idHvnRKq5rDeNIHZ2jBvOdilMNVeXeEwTPNttrtlYfabrQQ7ua4TI/T3meMagwXTQz2vBmnlEc0
	aeICycvU+0mhbvaA+47K7NFfrFJy7h3Jk6LXogjeGFvs1SR1ZE0Or/HAYgYMgIpd3P0tS9UCJ/K
	H+eFc6a9v+fO3A==
X-Received: by 2002:a05:6a20:728c:b0:39b:e789:7d20 with SMTP id
 adf61e73a8af0-3a08d8d9d5bmr32380807637.44.1776951385500; Thu, 23 Apr 2026
 06:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219171310.118170-1-aha310510@gmail.com> <2026042355-blighted-chewing-5e50@gregkh>
In-Reply-To: <2026042355-blighted-chewing-5e50@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 23 Apr 2026 22:36:13 +0900
X-Gm-Features: AQROBzAosyDO_yslNQKDZhWDhMLXCShJ7vPs7duQruIbTcEGDHRZq9mj7spWcms
Message-ID: <CAO9qdTE0NhB58hqK8_1=69bD7uG_vF-FfpQXGR8dqcuWV4H2Mw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 00/15] timers: Provide timer_shutdown[_sync]()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, tglx@linutronix.de, Julia.Lawall@inria.fr, 
	akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, luiz.dentz@gmail.com, marcel@holtmann.org, maz@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, sboyd@kernel.org, 
	viresh.kumar@linaro.org, zouyipeng@huawei.com, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 20, 2026 at 02:12:55AM +0900, Jeongjun Park wrote:
> > The "timers: Provide timer_shutdown[_sync]()" patch series implemented a
> > useful feature that addresses various bugs caused by attempts to rearm
> > shutdown timers.
> >
> > https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/
> >
> > However, this patch series was not fully backported to versions prior to
> > 6.2, requiring separate patches for older kernels if these bugs were
> > encountered.
> >
> > The biggest problem with this is that even if these bugs were discovered
> > and patched in the upstream kernel, if the maintainer or author didn't
> > create a separate backport patch for versions prior to 6.2, the bugs would
> > remain untouched in older kernels.
> >
> > Therefore, to reduce the hassle of having to write a separate patch, we
> > should backport the remaining unbackported commits from the
> > "timers: Provide timer_shutdown[_sync]()" patch series to versions prior
> > to 6.2.
> >
> > ---
> >  Documentation/RCU/Design/Requirements/Requirements.rst      |   2 +-
> >  Documentation/core-api/local_ops.rst                        |   2 +-
> >  Documentation/kernel-hacking/locking.rst                    |  17 ++---
> >  Documentation/timers/hrtimers.rst                           |   2 +-
> >  Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 ++---
> >  arch/arm/mach-spear/time.c                                  |   8 +--
> >  drivers/bluetooth/hci_qca.c                                 |  10 ++-
> >  drivers/char/tpm/tpm-dev-common.c                           |   4 +-
> >  drivers/clocksource/arm_arch_timer.c                        |  12 ++--
> >  drivers/clocksource/timer-sp804.c                           |   6 +-
> >  drivers/staging/wlan-ng/hfa384x_usb.c                       |   4 +-
> >  drivers/staging/wlan-ng/prism2usb.c                         |   6 +-
> >  include/linux/timer.h                                       |  17 ++++-
> >  kernel/time/timer.c                                         | 316 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> >  net/sunrpc/xprt.c                                           |   2 +-
> >  15 files changed, 322 insertions(+), 100 deletions(-)
> >
>
> Ugh, I got the following build error for this series:
> ../drivers/misc/sgi-xp/xpc_partition.c: In function 'xpc_partition_disengaged':
> ../drivers/misc/sgi-xp/xpc_partition.c:294:25: error: implicit declaration of function 'del_singleshot_timer_sync' [-Werror=implicit-function-declaration]
>   294 |                         del_singleshot_timer_sync(&part->disengage_timer);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>

Oh dear. This issue occurred because commit 997754f114ef ("misc/sgi-xp:
Replace in_interrupt() usage") was merged into version 5.11-rc1 and was
therefore not backported to 5.10.y.

Since this is a simple fix that only requires adding this commit to this
patch series, I will quickly write and send you the v2 patch.

https://lore.kernel.org/all/20201119103151.ppo45mj53ulbxjx4@linutronix.de/

>
> Don't know what happened, but I'll go and drop them all now.
>
> Do you _REALLY_ need these in the 5.10.y kernel?  Who is going to use
> them?
>

You might think it is unnecessary, but I have seen bug patches related to
timer_shutdown[_sync]() being backported after I backported it, and I
believe it is well worth backporting if this feature allows various
bug-fixing patches to be backported smoothly.

> thanks,
>
> greg k-h

Regards,
Jeongjun Park
