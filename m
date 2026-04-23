Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2430F545
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953249; cv=pass; b=Wqc8DbLrKiew4PMRCOa7BnUoS6yl/Ez8tQIzWfXvYFVhQJWuzI034MLiRJh5006docEPDcprtQpGMQGf68GoSgfw3FJ+UYQYC39SKMsjpvViE6QvwWzrhunj55dSlwtYh+xgOZZBTZEZnC75dcPCudK6f0mcSf/M+sFPcK0Z7fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953249; c=relaxed/simple;
	bh=vdEgnQ7UYncJPIweIDG0txiZ1qkftEmzo9ZKETJ59o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRwfPKhsWXYfFiJ3zSZ/K0Q+TDaLAxKE8HPUWoDHNnwrXDprStjzeYNp+g33FfaATefyI7/lcTvaBWu+jYaS7zVFic7ft2XuEhlMYIDpIZ9atoLJPArY6AO6c4o3/ADq5D0C+8NB7YRdhXw/shmRAb8qbyjkDqoXnrgmXYbssyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/jVyTsG; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/jVyTsG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acb856a674so80285726d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 07:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776953247; cv=none;
        d=google.com; s=arc-20240605;
        b=QTed2E9OE8pDf+WX6xWLlE9FjiInNnXmQphEn5I4cC1ddYnGHs92I1j3lh9Pa7k2ZV
         OZO0GCoCK5N1IxS5d/fQnWauf+ndSo2lRHRVMrk1LouixqJ46LYLfBGYqAWCKR4Xk10g
         6kOPS9dCg1bCdowulZxHka+ajEF/S30x2L2BAl2tWW5Epf79VuRY7RWm8Cf4cBWj5tQG
         GBTfqM8/lBLVJRv3j/jjT0xnPrC9t3/mbYB6LwToqrQGM/QNjiJKj9r9K73l3LR7KB6F
         Jz8FYwDJd317NHD+C9S4Cc47FYQkiLZux60H33W43gecxKtlIPc3YnT1Zwl+ySGixDEw
         t1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YnWvO7yjwrQhs9Z8T4RkhOyGwxBUSEXUTTKsZ/p4eKo=;
        fh=M5DeAsNZEqPjbPGv+A8ausvCO2XN0fCZSIjXzTQbuKc=;
        b=P3gVogUvXC5s1u4bQP9b94CzFAeID3t0OTPVX/m2FXb3flXfdoY6nHKzp6pl0TUDMj
         EgyLmA7igsR9YBSyZc2V0lvEl6z+hldpIKDf6DT8R8Z0ZjcmOBVz2HrSwJ1H4qpis3Z9
         KJJM01AAmUzaQoL4Iu1qgDW8MUcQzsxDbfr/UF2bYC3Gu6Sz8V8DqHhS3YKF/YZh5Ilp
         5GL3C4DkyCPX80RQLPrE/c2F8tVQyF0UVlJZj52S7SInOp6UcjNYZPzcs/MHXudNNr8U
         wpLoqQclhNODLkRJxnsFUmOl3HaFru6Njze7TJUvWyraEqxz45vSCzQyFrCRejXhtFWa
         Iwfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776953247; x=1777558047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YnWvO7yjwrQhs9Z8T4RkhOyGwxBUSEXUTTKsZ/p4eKo=;
        b=s/jVyTsGiyxgRH6irkrvazOlJ8hh77TwqdWVTqJOHk2RZbYFY7lA+SMJiqQluWOsGW
         Qhm5sYAM1+wsa2rtVMJpgR8T1CmU/vi4uOBwc+GEa52TceRDn3BBIdkxbehMpvh/fT6v
         0DWm5GXz4PUxaV6T/o5Ne+sVqRrO4w3sYF/L4X/kiCltCTJG2/KxqqNc4DK8JDMm6xQh
         JhP116cS8NGI3wkJBQf3YDB4HGdpLweTYgK4uQ9YQOrzX9ksUciNoux3TxJfEtsIGKHf
         oZq0RhuCFWik05NjL0PNis2pMAMCYf0yIVwybcPtg9EPM6osIPCfHIKENbr2BfoNB8kC
         YKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953247; x=1777558047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnWvO7yjwrQhs9Z8T4RkhOyGwxBUSEXUTTKsZ/p4eKo=;
        b=PwCuPATwgDsdIGqiP5NZRky2AckWEvTHYNE6BvVWOXAq4b5NvvgwXKIC6F5QwwSfti
         UXsr3PukCIRM4vBEg+6sRr0xbJ3X1vp/2gov80LZJr3Fymyi6+6n+5lBYd8MttTnk1qm
         ViJ8OuRLo6ZJ7+I2qcZjfVrANzB08MwQ3Ywj/+57IrI16/lbdCxqnf4QXfoIkNeVto2a
         tU/XBz+1Bu1gb86IW8s+QCrmYgnc3mV1G1al4oiQ+tFl4yET3fzEXZE+rpY3+736VpM+
         PKC4oCcnJG8uZZJm8TbNnz3QCYgFxuq4BGS53/WREkAONgzA6tXQkErm0AgVO/8q1VhF
         WMZg==
X-Forwarded-Encrypted: i=1; AFNElJ+fNoXbpE4Df1teLJXlQvzuoXilp0fAcZayU/roRt6FWo46yGzDSU7/oQqUGBvOAb6PNwsUF/yS0rtGVdv1dYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKyvuxMtFG9oKUDtWrmUpjSiFIfQZ0bqH5aVLwITs2NPbCMtq1
	a9Fv28mUxDeFdzDTllMu9SM26Rjos8gCzxw9eXzOhFNIVA2jymqvExz3q/RN/qmLfVxKIwb+Jcr
	orAVHKeY39iUwxoc69cTlRUKXWE9Bb3g=
X-Gm-Gg: AeBDietp2gzzblhz3i3dEYEEmWdmZlX6roYm6awTvRB39uNCgoCYBLFlBQr+32cA7gm
	pQVuTaraUuAhK7lvSQKYwx1k3THb3xyVE11YUpg+nTwoKusEYr1ncLFfoLaffVexhaaUSvDUScJ
	UkXVzhV4eoQk04SyZ4O95eGPIzOkFbt58h0wGsTNGv1dnE0ze7TLM9VfJ5lBEiwTotSlQwEsix2
	h25Kd+SZlJTu9IzrkMJp9hKSee5QTWn7P3Bg1PBIjMMKfnCAeImPPGAXWgZCIPkMmXi1RjRKRXR
	Rn/bccbruh2Z+w==
X-Received: by 2002:a05:6214:5505:b0:89c:cb57:6227 with SMTP id
 6a1803df08f44-8b028565f9fmr389605626d6.12.1776953247144; Thu, 23 Apr 2026
 07:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219171310.118170-1-aha310510@gmail.com> <2026042355-blighted-chewing-5e50@gregkh>
 <CAO9qdTE0NhB58hqK8_1=69bD7uG_vF-FfpQXGR8dqcuWV4H2Mw@mail.gmail.com> <2026042327-wackiness-purify-09c2@gregkh>
In-Reply-To: <2026042327-wackiness-purify-09c2@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 23 Apr 2026 23:07:14 +0900
X-Gm-Features: AQROBzCIjy63kF1LW75_LGFH4-N7i7woPyvD8ToIg_JgdzxbdpkrD0vUqxkoZkY
Message-ID: <CAO9qdTGQPoMdh6ds6LFWEDtPSnjWEM746mrpfaVfxi8LBtckwQ@mail.gmail.com>
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
> > >
> > > Ugh, I got the following build error for this series:
> > > ../drivers/misc/sgi-xp/xpc_partition.c: In function 'xpc_partition_disengaged':
> > > ../drivers/misc/sgi-xp/xpc_partition.c:294:25: error: implicit declaration of function 'del_singleshot_timer_sync' [-Werror=implicit-function-declaration]
> > >   294 |                         del_singleshot_timer_sync(&part->disengage_timer);
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> >
> > Oh dear. This issue occurred because commit 997754f114ef ("misc/sgi-xp:
> > Replace in_interrupt() usage") was merged into version 5.11-rc1 and was
> > therefore not backported to 5.10.y.
> >
> > Since this is a simple fix that only requires adding this commit to this
> > patch series, I will quickly write and send you the v2 patch.
> >
> > https://lore.kernel.org/all/20201119103151.ppo45mj53ulbxjx4@linutronix.de/
> >
> > >
> > > Don't know what happened, but I'll go and drop them all now.
> > >
> > > Do you _REALLY_ need these in the 5.10.y kernel?  Who is going to use
> > > them?
> > >
> >
> > You might think it is unnecessary, but I have seen bug patches related to
> > timer_shutdown[_sync]() being backported after I backported it, and I
> > believe it is well worth backporting if this feature allows various
> > bug-fixing patches to be backported smoothly.
>
> So you don't have a specific issue you are hitting with this patch set
> that you want to have it here for?  It can't be for android devices, as
> this patch series will be reverted from that tree, just like it was for
> the 5.15.y Android trees, so what systems require it?
>

I am not backporting because it is absolutely necessary for Android or a
specific system.

https://lore.kernel.org/all/20251007155808.438441-1-aha310510@gmail.com/T/#u

I simply started this in the hope that the same problem will not recur, as
I had to write a separate patch a few months ago when I backported a bug
fix patch I had written because the feature was missing.

> thanks,
>
> greg k-h

Regards,
Jeongjun Park
