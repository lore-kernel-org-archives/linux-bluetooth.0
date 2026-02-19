Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213A353EC2
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521260; cv=none; b=oIucxni/FBEGV/rAQxIZHFeRszQXVfjctgnoP9l6RsXsPJz8QPAN8IUP93EED1BWfqrt8kIiULHm5Mb1R5Y+4d52Z8dkDJiP+Dzx8ppZ8upedskw163FzMn0VcPAyoyGb9NJO6OhDhfOWATd1VR76aHrn+rNQlQm5plL5UvHy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521260; c=relaxed/simple;
	bh=Hkj+3H7Z8a3D2Y8tRX2SbgMdeMF/kuGLJMd704mftHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNcc+FexSl54He2jm7r7S2wPEj8+pJgZE2oOoLb4kkMkULsYqQ3sMsZplOjUcO6L6BxqM/4qdQ9WgX1J672Djl9Xcdc4hcg80/VQDmEVtNpadC0lS2qk9I2TczCBHC7+jGco8lV7R4qRpJK5TqyR0xI9+VicYg4vm30Nm6vY5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTSVdSNV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTSVdSNV"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8249cb73792so1030098b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521258; x=1772126058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKKfl8PT/GCaUO5UcTwQ5MiYDnn0Vh3veSo7jvr1Ic4=;
        b=OTSVdSNVuwBDyXp3D/0mYMOlcZ/IMRRwNikzboDFnxJPVV2zhMW7RKKZgUclNIQXDg
         7jzvPDlKIG0kRzsfa8L3IwpnM7wnF1+XfsxKv2pAgjANZ9fv1qDdOdfUPT95aLQCorng
         ZSLElhkX3S6L28YVBEnvfkIg3Ynaba9hm34SBOrqeNcxQ1zlxrMfkxyiu4Vib9ydiIV0
         +Dpz+Kyn2QHw0DeC1yjlpg3wtvrVEUbKlC0V9gmjVIccqXbqjL+2d5sV8ZuYpREEnEZO
         5EMcqLTixUWA0UKXvNBQ7VS81ZCKuv/pS4dlgKcMqGCY1+/1AB4Ssj1HAZn8kKdodPPc
         1i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521258; x=1772126058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKKfl8PT/GCaUO5UcTwQ5MiYDnn0Vh3veSo7jvr1Ic4=;
        b=UJq3OFAdjIncHND0jCIQOg+zP/IzNy/hGAHDYWrBo8uCtn1VlTd696GHkQPhMGY1wO
         NVI4sl+7B8cWM5IdI+isTAonC2K9BGNiurEG/Bv2L0+Z8pl1Xe0kKAOC2Ka+/P+jIdxO
         IPi6yqOJmxJPZziLYXNybMCi4EdKvZlhlKPp7A9/Yq2zLxK2RuTPVlI2y5XdDjt4LhAS
         vBkeae0baB1hGCbepmxe6FDGeBgKQWBAKHO++6QKPtgth11dUT4r0yjKxruVhi9PD1PB
         e7SEeu1IakCvFim4AhKi/425tN8sVxnGW88P6pnqP3jcP7otL0nJKCGgWF143az+WG6o
         WC0A==
X-Forwarded-Encrypted: i=1; AJvYcCVf6XrsppjlviaUvIvmybYRaIkqGSsqJUXCi2jdh+3L/iPPmLq35YJsOyUaS5OeIf0vcT5/1XmLpPzO28mBsCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV70X6bkDi3TETIOOVmqsFzG4dRI7KhD61/JBmnNC3EF+0kCJd
	62NKHmeWzFmI/bNLLSX4Fu1rfsDVpATuwpMhPrStmiW/gXWZNiZGGmvq
X-Gm-Gg: AZuq6aK2oRMBuq8hIOCao9674L2njBCRMy2l/kZN72+Ff/VgQ90OSUyRFmXXkh3qkRT
	I5f/85pjgTSP1DmTvtiZ6UDqgQ7bRKno7xwIEMmhsgY6U7NmUsZl+QUMbA1yj+3ql7dxW8ODrq4
	rO/21Br1XEg4S33mA7mvOsvZ1PgMjBW2bMViFPPlIJ9XhVGJ6xq1rEARNZ9cUAma1KvctdHDVMi
	YgiKTuV/n4gBjaPRMysaA5s3+FJzaO1sGeaiIFyiVZwta03aj3qUI28MrUnN//sdQm2utnh+tt8
	5iJQF0pXj2UoaprvAEvZP3K7l++bWMY05T8dk6tSiI56Wnp1uqKh1S9R9IRtnDu4TVYySB3AACZ
	EFu7mqGPVoAvzttU6kw5WbMxLyq3hvOw6fMKargNZOSBagizmiI+H5B47sMF/rFBITLgkoVPx++
	RlgcgRm4JDIBo+HLq2mauBn7PneaPJxMP8qjOOHqaDMUGVw7peqw==
X-Received: by 2002:a05:6a20:cf88:b0:361:28dd:a9ff with SMTP id adf61e73a8af0-39483a5a85dmr17158114637.38.1771521258512;
        Thu, 19 Feb 2026 09:14:18 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:17 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH 5.10.y 15/15] timers: Fix NULL function pointer race in timer_shutdown_sync()
Date: Fri, 20 Feb 2026 02:13:10 +0900
Message-Id: <20260219171310.118170-16-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yipeng Zou <zouyipeng@huawei.com>

[ Upstream commit 20739af07383e6eb1ec59dcd70b72ebfa9ac362c ]

There is a race condition between timer_shutdown_sync() and timer
expiration that can lead to hitting a WARN_ON in expire_timers().

The issue occurs when timer_shutdown_sync() clears the timer function
to NULL while the timer is still running on another CPU. The race
scenario looks like this:

CPU0					CPU1
					<SOFTIRQ>
					lock_timer_base()
					expire_timers()
					base->running_timer = timer;
					unlock_timer_base()
					[call_timer_fn enter]
					mod_timer()
					...
timer_shutdown_sync()
lock_timer_base()
// For now, will not detach the timer but only clear its function to NULL
if (base->running_timer != timer)
	ret = detach_if_pending(timer, base, true);
if (shutdown)
	timer->function = NULL;
unlock_timer_base()
					[call_timer_fn exit]
					lock_timer_base()
					base->running_timer = NULL;
					unlock_timer_base()
					...
					// Now timer is pending while its function set to NULL.
					// next timer trigger
					<SOFTIRQ>
					expire_timers()
					WARN_ON_ONCE(!fn) // hit
					...
lock_timer_base()
// Now timer will detach
if (base->running_timer != timer)
	ret = detach_if_pending(timer, base, true);
if (shutdown)
	timer->function = NULL;
unlock_timer_base()

The problem is that timer_shutdown_sync() clears the timer function
regardless of whether the timer is currently running. This can leave a
pending timer with a NULL function pointer, which triggers the
WARN_ON_ONCE(!fn) check in expire_timers().

Fix this by only clearing the timer function when actually detaching the
timer. If the timer is running, leave the function pointer intact, which is
safe because the timer will be properly detached when it finishes running.

Fixes: 0cc04e80458a ("timers: Add shutdown mechanism to the internal functions")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251122093942.301559-1-zouyipeng@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1360,10 +1360,11 @@ static int __try_to_del_timer_sync(struc
 
 	base = lock_timer_base(timer, &flags);
 
-	if (base->running_timer != timer)
+	if (base->running_timer != timer) {
 		ret = detach_if_pending(timer, base, true);
-	if (shutdown)
-		timer->function = NULL;
+		if (shutdown)
+			timer->function = NULL;
+	}
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);

--
