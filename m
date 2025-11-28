Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E42D46A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345965; cv=none; b=RxEdi14BO7NtvQanRE1tjbQTl06NiNok64lMf06Rr/p9uTEtJogI3XPxMNVIKRRtlK9UlY0x2y9jPBvHblxMkOIk5Kvv6uQyAyIfkG4GccbC4UA/30+uEKs4hY4qxZo5ciyn2EZv+bNH/T5Asyy7qaW4QCAa10wl2Sj08w+HOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345965; c=relaxed/simple;
	bh=YY7i+ekw8WEClpFqVZfbZbIPcOFXG9mqoVtYSHhdgrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGcat6UkQ2eWz0fD+YIQe+krF4bcn86ocEvU58f97l2FLGOSiYaWf+t+EevxH2HBEoz6w1XIsF3qklVxiPg0M9kZyKhzS5l1WmV3lHZTXXcRik+bEMUtMipcFcJXzEkRgOM+6AviUfRNIdFkj5ff+lvITKFaZ96cKZU1AoJ45Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSVWatJd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSVWatJd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7ba55660769so1738957b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345964; x=1764950764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=QSVWatJdQOzmUezAOc32ZH0M3/HAPWABCph9Uu2t2OE8NaVxreBhIAdD9FWj1TomRy
         BOErNd5sD5m4b549B7NOOR6yueHQ1atWchkQ1P6u9nmD607PTEctMYr/1Llp4n+HEbn5
         1UdFcap54P7mVQbCdvwyg/kznLTItf/9YnG6Q1QzoaDN4fJwQF2Rr8iD1crFQTjjZXzR
         xPWDARJI7hixToZN0fiFAo+4J55QPok+oguDdDZS/jJrenHTnwwhHxMOjwD4Ese/RBDd
         rvwDPKREk5KoAvvGmkuVEN3/98MEPaQ51U61otD9lVnOMTKu5fTFYmRd/XmzXuHydszP
         WL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345964; x=1764950764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=qCnDqwcTtKlz79r8pg9kEeJv+wBtMYSJhKYcJSoC6STlwWSBkyP7tAgCOA1St4Vt45
         j64l74+UYZASnQifalhL7Z4B69SaTa6O2rppZtUofhpYhCaVntGLdsl+vRtzOHl0TUXG
         Cw1aJUcRHDnrmi7gFfU+3pyPrvR+5QvqgjoT96nvceVcCpvkUwWKxskUItv7/5OOodl0
         DjxMuJTSvJNjhwOF1scLnOJ/LO7rZLMFuFIsWTEegWgTImBOv5kNKiNVAgKm0XgfAjt7
         avOdjL+btbygqZZih9mhDh2FqlbT7lpg/C7cCickT/SM36Do+8CTIgs4JgRCvfZ6NiJM
         gphw==
X-Forwarded-Encrypted: i=1; AJvYcCWNmglqoNTuSZgHDkiSI0zrmAQp8G5guEXxzKwnA3fT+gEPxxFRf8O6gUYH2ognL1PPDzq2roVfANi0lP1w+6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMrofBdtQw1dTQyF90Me7ZLh/2J6zqWTDZSi9Zo9BgTVyixIF
	yjlzj9Omvf0P4Pb6v7DCAoPbLWpp/9qKLtHaigl+EmCRkdCbsLgwIzJD
X-Gm-Gg: ASbGnctSUz0oOaJxJlz0yarhcE8PXtVyQg5DBQRtwtWhFtr4rIlZH9OKq12xoBBJ3Z1
	TdH2KKpdIkWSsi+8m82k6MITuj8CJ3KAvISaLc1M/gOuzKrPn9KpAis+/JC32m9Nah5ceR3XSjQ
	VnrV9YlyGLAbSH5Nj0La8Nj6HKmHjhGmufrcj+o2WLJCnveHOYgUPJ3lENgrC+bVFxV8k2vFi6N
	bWttSbu4L8stUwCUpHVp6x7j5Dk0LGrT0q/ZwSCQJJL6DZSLrZBDWJzysw0YkPIgQMYLsN4tiZJ
	zR2gYQoZvm2M+i6THrwYlOFCmFbDYhqtvXXxvDuCF8N/NKX4wmP2qkWQpg/fpVhfTlHlUClgiXC
	gTDhZrDFIPY1LuNagvi19tpxLk+mG/rutIEckl02YVB2P+s4iSJX4OJ2DrXaexvmPyh2OIF+WC+
	VItMZVgshjvpYGhbqaVLkUCVKOqNrtKCysap9mkg==
X-Google-Smtp-Source: AGHT+IExmbTt0di4gnbgeXwjl0MdJHHrgB9GIijfMB5lD+egrT6JfkOALPfqqLh5IPKK0ig7n/DpYw==
X-Received: by 2002:a05:6a00:1383:b0:7b9:7349:4f0f with SMTP id d2e1a72fcca58-7c58988f7camr27966972b3a.0.1764345963342;
        Fri, 28 Nov 2025 08:06:03 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:02 -0800 (PST)
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
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.15.y 03/14] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
Date: Sat, 29 Nov 2025 01:05:28 +0900
Message-Id: <20251128160539.358938-4-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128160539.358938-1-aha310510@gmail.com>
References: <20251128160539.358938-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 73737a5833ace25a8408b0d3b783637cb6bf29d1 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to arch_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20221106212702.002251651@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.409832154@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.981725531@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.574672568@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fee1c4bf1021..ddcbf2b19651 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
 	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
 }
 
-static __always_inline int timer_shutdown(const int access,
-					  struct clock_event_device *clk)
+static __always_inline int arch_timer_shutdown(const int access,
+					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 
@@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
 
 static int arch_timer_shutdown_virt(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
 }
 
 static __always_inline void set_next_event(const int access, unsigned long evt,
--
