Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114D3C07A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521450; cv=pass; b=Uq5TC3Ri3DQRwz7NLnIbhvZ8ZZa31uyQ3Pnm8saN3ZwRNbGoEmFSX2qVx8CcP2J+l0gcfI3d8JxQYBnVgxvNGs9RnlqOUTgu5g9US+DKe6Ow4VzG34FyERRD1ZnU5O0XO1swE/c6zNqL8iE7urFEfNpI5C2/ORjqdr/puKQOHaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521450; c=relaxed/simple;
	bh=8s7zqn+JKR5OYoKOoaTPQWs8K5lNLxKEgdGO9RiCybo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqWqVVEIqCIfODhU2I33sgS7Gv27BCQ4JUytN7PqAcL5KxMzQgJx/QMs1bibmUbxA2aca+jCTR2yABW9WEB0D/p+KKkn85P6J4HC227SBpskfksTitaX0zH/i+3QkhcseT7kzPhdIYqD6LtV7bcEZ7qfS2fKS19v+tx+c9eoTn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Euoj26kU; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euoj26kU"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8947ddce09fso10295236d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771521448; cv=none;
        d=google.com; s=arc-20240605;
        b=Rp0sLwoeDPGnEqdcUPv4A1TzkqCGr9GxOGHmcj5JPbAbHjO7KHiL7ULT2qCXA/VJ2T
         RZ2Po2F6PFI2Y3FhqwSc12M7y7pSPvyA4PI7GXRXtF35hMeXd7TCZy4rE5SYWEbEi+mZ
         8Phdggflnn4QMy979i+xJCfp2k4tjAWfsdcGLo/rfKH9GLkLlSMuoBLQzI2KRD2y24f7
         rdgWI9p0+phNBSs+oI3S2JFkw8sTaGPTtdViK+kf0aOYeVXC8RDgauQW2gjjNDHGR64m
         PfxYbkN5NPOpky7Jbx63ra8WuAb/jyWd2aF0aCBXEHmApqdobWxYK7HI3uh39pV1TtKB
         sPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S5w/msoFDa9orh2H96VLrf36iiFdGsvKYnvJC5OxIJw=;
        fh=m9vitscNKuMV+qfAtDrq7YglNdMUNF8obUmJdzDkS30=;
        b=ZKCRwYNf05hzlmMrcZvZDCcxPT1h6BFI29InSr50Ire+qJ5mHTJEzjgLY+iHacbgKU
         6NvM1ruS9+tRjvP62XcBJ9xpkLACiSveBVDC4Y/UMKHo8f34l/jx48PLouYiU+bXydZl
         JsFtlFn8aHzOFg5m6ugOgT7neLALOkXvqxcKrm/8mM+rjVUFXh4rS9+oBAZHpbI34Mbl
         fRBZyIWD5fGmp483UAY2ndNxJhESeKnP461BSXBfL7CpoYRAYyXmfSyjhOQy4NvKcaCK
         lqL10Jdrd94ALHW2lfkV59oZVULWe2zC/ponr2lGiRosmXSS+Q+4a1Fv94BtyWvrocXL
         KPKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521448; x=1772126248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S5w/msoFDa9orh2H96VLrf36iiFdGsvKYnvJC5OxIJw=;
        b=Euoj26kUrtcgEk6QPtpHD+kB/MwC2KTzN6gfCyDpZjfIcIziTSNNcrxFLz4YEz4580
         kVBu8Ky1ewyPSj6UsZO6k5e17FbGgup5BHqzPN2ENpIKbBzKaLqymZc+dA2Je9l+tE22
         UzhMSfPYKHn/oY0vVTp3MqyUppHs6enM6PIRN47idsdDmlAZ29nuAsXGafMCSvoTnRW7
         4+9wI15XYWfeviVRigEa1ovsO/O92xzwvn59ba8ipb2y26bMmo25smsIKM5P/O6r4wA1
         XA6O8HBKM+AKaUNgSFwpZBvvi4OeAWGcqwbglEkQFtnlpCpA6ZFaEBmRsG30VLOs1V1A
         V42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521448; x=1772126248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5w/msoFDa9orh2H96VLrf36iiFdGsvKYnvJC5OxIJw=;
        b=X/7c3Uqp+wctXBuDtSPd9XZG8+qiaC+YyHLqnu7Ewzvs1bzJui00StoYZCYJQm78Kn
         5qWPHraIAw49YSlI74PuRt6xbkSyQ/guCWJRDkyTZ/vNnh4IyXojq2k4Uq4Zr2bqeFFy
         AhzTBF/oiIGRC+/F5GkCUPyUrxIo0FQvS6iZKlSjlqSdgtV78zdnKU8SH1dD1emBPNZb
         6u/bnehj8qI8SKs+7QcMXPumomiTTXD2BAzR5NWWUWaic1ckP8knuAE4BHZP+Z/h4xQ2
         E/975+03CIwAZzB99PSewE7XDtbWAnP39R/QVfa4uU7f5plyFRvlZkKkotJnVk9dF2Nd
         mJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXWZjD9YwD5zRlQ+upccE8GXerSJqjOc4wfXReMK/BXjDvkIMC7D4VNjOW6a4L+6FdAfQ5HX5RnDTT0Vorac9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+keDiVYe//voSk5DaAQ+Cap+qAshZF0Lys7By10gH5iGHRcSD
	5SgVLpOCtWoC1JuvYLKv2lLtx8XFmV2ZG7sdB33QMVIRTSPBnXwWnF2t53L+s+X8CRu7gY5o4aq
	skNvzbQ1wu7ykxd+0kXiBGWTruTeM7TM=
X-Gm-Gg: AZuq6aJpjUTc2SRYk+bcG980uJP2dWOVxaCRh/hSMlU9Jdp9jaZKnuZ/b33sZR3JJuf
	VMUx9LLyYuoh1gvVeHN3hEgoStbC33M4EkewrmZ1j+Q3JXmD6iy8kHRlA1eL1ewKkIS1Y6sy+PZ
	C18XoTJc3PHl8b2H8X5oyh1L1H7BDS220Z73saJuZGF1rVQIWO4/XSncGQsdxgMiN7NzQgno3qB
	4a1TZSjhflXSsHGtJZIvoY5nDy3/Oql5IKy2VTfyCruwJLQRSSJaSXDZqRTfYDq6xpmsA9Y4KBv
	6N/N2ZMhtQ==
X-Received: by 2002:a05:6214:27eb:b0:896:f6d5:c73c with SMTP id
 6a1803df08f44-899580a8bcbmr89613496d6.41.1771521447631; Thu, 19 Feb 2026
 09:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219171310.118170-1-aha310510@gmail.com> <20260219171310.118170-16-aha310510@gmail.com>
In-Reply-To: <20260219171310.118170-16-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Fri, 20 Feb 2026 02:17:18 +0900
X-Gm-Features: AaiRm529edBYEh1GUJI3ts8-SzVmsBmd3V91rJtHn___pgs9QXwHrjAbeawXVSs
Message-ID: <CAO9qdTGZVdkug1kn0goW8Uwro95P+_jLW3MBxxp04bxgq=SsCA@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 15/15] timers: Fix NULL function pointer race in timer_shutdown_sync()
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, Julia.Lawall@inria.fr, 
	akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, luiz.dentz@gmail.com, marcel@holtmann.org, maz@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, sboyd@kernel.org, 
	viresh.kumar@linaro.org, zouyipeng@huawei.com, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park <aha310510@gmail.com> wrote:
>
> From: Yipeng Zou <zouyipeng@huawei.com>
>
> [ Upstream commit 20739af07383e6eb1ec59dcd70b72ebfa9ac362c ]
>
> There is a race condition between timer_shutdown_sync() and timer
> expiration that can lead to hitting a WARN_ON in expire_timers().
>
> The issue occurs when timer_shutdown_sync() clears the timer function
> to NULL while the timer is still running on another CPU. The race
> scenario looks like this:
>
> CPU0                                    CPU1
>                                         <SOFTIRQ>
>                                         lock_timer_base()
>                                         expire_timers()
>                                         base->running_timer = timer;
>                                         unlock_timer_base()
>                                         [call_timer_fn enter]
>                                         mod_timer()
>                                         ...
> timer_shutdown_sync()
> lock_timer_base()
> // For now, will not detach the timer but only clear its function to NULL
> if (base->running_timer != timer)
>         ret = detach_if_pending(timer, base, true);
> if (shutdown)
>         timer->function = NULL;
> unlock_timer_base()
>                                         [call_timer_fn exit]
>                                         lock_timer_base()
>                                         base->running_timer = NULL;
>                                         unlock_timer_base()
>                                         ...
>                                         // Now timer is pending while its function set to NULL.
>                                         // next timer trigger
>                                         <SOFTIRQ>
>                                         expire_timers()
>                                         WARN_ON_ONCE(!fn) // hit
>                                         ...
> lock_timer_base()
> // Now timer will detach
> if (base->running_timer != timer)
>         ret = detach_if_pending(timer, base, true);
> if (shutdown)
>         timer->function = NULL;
> unlock_timer_base()
>
> The problem is that timer_shutdown_sync() clears the timer function
> regardless of whether the timer is currently running. This can leave a
> pending timer with a NULL function pointer, which triggers the
> WARN_ON_ONCE(!fn) check in expire_timers().
>
> Fix this by only clearing the timer function when actually detaching the
> timer. If the timer is running, leave the function pointer intact, which is
> safe because the timer will be properly detached when it finishes running.
>
> Fixes: 0cc04e80458a ("timers: Add shutdown mechanism to the internal functions")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20251122093942.301559-1-zouyipeng@huawei.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Jeongjun Park <aha310510@gmail.com>

> ---
>  kernel/time/timer.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1360,10 +1360,11 @@ static int __try_to_del_timer_sync(struc
>
>         base = lock_timer_base(timer, &flags);
>
> -       if (base->running_timer != timer)
> +       if (base->running_timer != timer) {
>                 ret = detach_if_pending(timer, base, true);
> -       if (shutdown)
> -               timer->function = NULL;
> +               if (shutdown)
> +                       timer->function = NULL;
> +       }
>
>         raw_spin_unlock_irqrestore(&base->lock, flags);
>
> --
