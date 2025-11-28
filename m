Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D08330B06
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346003; cv=none; b=eLU1A4FRYTStu6bMgZgRqdyPi081ZHH0H0Jtz7Fcf5/5tY2jUMHsgJjGsdSqwSra/jtulzZ9KhouGL/Nsfxf+LFV9siEC70yVaBBWEab3d4JvOtQ0QlkeUafFCyEVmC7A1OW9ssih8uCipoZqXQ7cdUnEMcbil7a2EINi063/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346003; c=relaxed/simple;
	bh=FfeWAFL01yrxGNZ9KQqmQL8U/+v/91/EffrzfYdxZZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjXVirkBrmW24jcwKIurNMDkFAWpDrkBUBvJTXySXe1MPGHFT8/o7NUl9VCA3xoDkyKibYVpKr+0Ml/rzudHfc/ar2h5eoy/v1V175SKwNBCXdMS01T1OonWmQICyLPs12BNdTdKESlLx+XOlW1RwoQbHMzIFOvi33FxflNc4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btCE0S4t; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btCE0S4t"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34585428e33so2108192a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764346001; x=1764950801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0bNeek1LW81/KG2/Q/uicdT1bV3tR+ITFKGtccSqSg=;
        b=btCE0S4tzM5oYyo56TYoRMXM5D8yThvODRP9kxt18z2gOB49QPdUHz2RDDT5sdjK2T
         kS5d+asqJmu23eIDRrqvLnIi/5kIDE0IAJtxI9Xbq/A3wysx7ktf/WS2ILWvBVR1T87A
         6L4X54VWPbg9joOCODmnAudEhsZ7/OkaZn4lRodV9XNrmAiBSHJQCeiGdU9CRYJUhjrV
         vAS+Zi+iaJxnTN0C2J1cR+TyIf9vdtHVqdkr4AP1HIG4ig3UIFz+lxAe5dfHnYWd0tGe
         pAh2J2cgyYLwQ8Wc5BWHipC2w8OeVt58Bt5fauGO1GxdWHjCmaCJBfNHUg8w9iljNkgF
         gZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346001; x=1764950801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0bNeek1LW81/KG2/Q/uicdT1bV3tR+ITFKGtccSqSg=;
        b=VXguwTRC/Q7fz0bw7ywfrbnCnoG8m2BQimKB8h8wD7IwOgrD7cJ4izznJy4Bdy1ATt
         LLS19oWer0QIwjR/O391t4cGv1SGqnlK9yDRT0R1yFhBLyMS4zR6Y6iGO/KS254yiQge
         IrCC/5T9ENY7btwKECcVlBAvekZzYcCkSR8yJ50g/ueWG9VIQLPmw/BadAPPTJfj7lFd
         3He6yp4sydZTYs9GBIpgVjbxydo5VlsARxgHeOmjMwwKRCngUjcEFazZ0OgSI+JvhA0s
         0nm48piPok4FT8WjNy2R4qk6A3n782iB7xAeCjkcRAM3y1z2HGGTJ5tvJRCJBjixfA9m
         WZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWeugPc+zuG/xgic3GJ+6Ld+padJ9wgvaubIFqvmMOe2X3EhwhteLYrA3BAh8P/L9Q6EfvMx0VWjRgnZpU93vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6mU4klNCBRG5E6jv2lkKIgznupJafxIIxaQdl0QkKGRoLncE
	ztsKsc55rPlx2+AZvGovzeJDV6s+b5e0+uidg/fQmQxP/7zfFrCwSiMt
X-Gm-Gg: ASbGncvl4APaCS+kaODzmOXBvWnOvOz+Osd4h/7EfRkBmG9lFf1C33i0VhBZM6T/geh
	BFfoIcxqJZo2tAYMePXgty+/sYzORCzHdJVeTaKUnU9mmp1lPiOZdDyTp7Z+SXbilET8GXWeF8/
	eUyXrTY/DOjMyhcSXbTx8xBIBNlEycRkShN5XurNaNjuIZtpd6QPkgpHZMg1p+Sbhy5jbaJofYz
	WQ0X8x0W5Su3MRRSlWW9SUsJyyomr/JMGC4jg67Lslk8FsT3jTmX8uOmjr4HtKlfAYXNKl1Xf3g
	a3WV4Cr80mCbPSogNBX0Rf3bBkMX1vMPZCmC8i3p24j88uZg9alK6kuEYvaUV9Y+CmMCMQDh4KC
	/N72sU4VrAYa3i88cxkDL4rb+dc/ksUGbWB/B/hqi9kIsrrWulbtzDmXAD4OrvbpbXNRqWGXz2h
	L1NHdn9qy283JvKW96zVlnH6cmEvoyo8aFiC07KA==
X-Google-Smtp-Source: AGHT+IGMMK/ksK1xGTlKIL49CG15hI1qCc5kwWuiMLMNCyhPjSNUAFybYnQmIenfoilVz4fFQ6RaXg==
X-Received: by 2002:a17:90b:1c86:b0:33f:eca0:47c6 with SMTP id 98e67ed59e1d1-34733f23531mr24238024a91.30.1764346000442;
        Fri, 28 Nov 2025 08:06:40 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:39 -0800 (PST)
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
Subject: [PATCH 5.15.y 10/14] timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode
Date: Sat, 29 Nov 2025 01:05:35 +0900
Message-Id: <20251128160539.358938-11-aha310510@gmail.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8553b5f2774a66b1f293b7d783934210afb8f23c ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

Split the inner workings of try_do_del_timer_sync(), del_timer_sync() and
del_timer() into helper functions to prepare for implementing the shutdown
functionality.

No functional change.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.195147423@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 143 ++++++++++++++++++++++++++++----------------
 1 file changed, 92 insertions(+), 51 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3b6624cd9507..0b76a2ab42e3 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1298,20 +1298,14 @@ void add_timer_on(struct timer_list *timer, int cpu)
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * timer_delete - Deactivate a timer
+ * __timer_delete - Internal function: Deactivate a timer
  * @timer:	The timer to be deactivated
  *
- * The function only deactivates a pending timer, but contrary to
- * timer_delete_sync() it does not take into account whether the timer's
- * callback function is concurrently executed on a different CPU or not.
- * It neither prevents rearming of the timer. If @timer can be rearmed
- * concurrently then the return value of this function is meaningless.
- *
  * Return:
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-int timer_delete(struct timer_list *timer)
+static int __timer_delete(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1327,25 +1321,37 @@ int timer_delete(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(timer_delete);
 
 /**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer:	Timer to deactivate
+ * timer_delete - Deactivate a timer
+ * @timer:	The timer to be deactivated
  *
- * This function tries to deactivate a timer. On success the timer is not
- * queued and the timer callback function is not running on any CPU.
+ * The function only deactivates a pending timer, but contrary to
+ * timer_delete_sync() it does not take into account whether the timer's
+ * callback function is concurrently executed on a different CPU or not.
+ * It neither prevents rearming of the timer.  If @timer can be rearmed
+ * concurrently then the return value of this function is meaningless.
  *
- * This function does not guarantee that the timer cannot be rearmed right
- * after dropping the base lock. That needs to be prevented by the calling
- * code if necessary.
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending and deactivated
+ */
+int timer_delete(struct timer_list *timer)
+{
+	return __timer_delete(timer);
+}
+EXPORT_SYMBOL(timer_delete);
+
+/**
+ * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
+ * @timer:	Timer to deactivate
  *
  * Return:
  * * %0  - The timer was not pending
  * * %1  - The timer was pending and deactivated
  * * %-1 - The timer callback function is running on a different CPU
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1362,6 +1368,27 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer:	Timer to deactivate
+ *
+ * This function tries to deactivate a timer. On success the timer is not
+ * queued and the timer callback function is not running on any CPU.
+ *
+ * This function does not guarantee that the timer cannot be rearmed right
+ * after dropping the base lock. That needs to be prevented by the calling
+ * code if necessary.
+ *
+ * Return:
+ * * %0  - The timer was not pending
+ * * %1  - The timer was pending and deactivated
+ * * %-1 - The timer callback function is running on a different CPU
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	return __try_to_del_timer_sync(timer);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #ifdef CONFIG_PREEMPT_RT
@@ -1438,45 +1465,15 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
 /**
- * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * __timer_delete_sync - Internal function: Deactivate a timer and wait
+ *			 for the handler to finish.
  * @timer:	The timer to be deactivated
  *
- * Synchronization rules: Callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts unless the timer is an irqsafe one. The caller must
- * not hold locks which would prevent completion of the timer's callback
- * function. The timer's handler must not call add_timer_on(). Upon exit
- * the timer is not queued and the handler is not running on any CPU.
- *
- * For !irqsafe timers, the caller must not hold locks that are held in
- * interrupt context. Even if the lock has nothing to do with the timer in
- * question.  Here's why::
- *
- *    CPU0                             CPU1
- *    ----                             ----
- *                                     <SOFTIRQ>
- *                                       call_timer_fn();
- *                                       base->running_timer = mytimer;
- *    spin_lock_irq(somelock);
- *                                     <IRQ>
- *                                        spin_lock(somelock);
- *    timer_delete_sync(mytimer);
- *    while (base->running_timer == mytimer);
- *
- * Now timer_delete_sync() will never return and never release somelock.
- * The interrupt on the other CPU is waiting to grab somelock but it has
- * interrupted the softirq that CPU0 is waiting to finish.
- *
- * This function cannot guarantee that the timer is not rearmed again by
- * some concurrent or preempting code, right after it dropped the base
- * lock. If there is the possibility of a concurrent rearm then the return
- * value of the function is meaningless.
- *
  * Return:
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
  */
-int timer_delete_sync(struct timer_list *timer)
+static int __timer_delete_sync(struct timer_list *timer)
 {
 	int ret;
 
@@ -1506,7 +1503,7 @@ int timer_delete_sync(struct timer_list *timer)
 		lockdep_assert_preemption_enabled();
 
 	do {
-		ret = try_to_del_timer_sync(timer);
+		ret = __try_to_del_timer_sync(timer);
 
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1516,6 +1513,50 @@ int timer_delete_sync(struct timer_list *timer)
 
 	return ret;
 }
+
+/**
+ * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * @timer:	The timer to be deactivated
+ *
+ * Synchronization rules: Callers must prevent restarting of the timer,
+ * otherwise this function is meaningless. It must not be called from
+ * interrupt contexts unless the timer is an irqsafe one. The caller must
+ * not hold locks which would prevent completion of the timer's callback
+ * function. The timer's handler must not call add_timer_on(). Upon exit
+ * the timer is not queued and the handler is not running on any CPU.
+ *
+ * For !irqsafe timers, the caller must not hold locks that are held in
+ * interrupt context. Even if the lock has nothing to do with the timer in
+ * question.  Here's why::
+ *
+ *    CPU0                             CPU1
+ *    ----                             ----
+ *                                     <SOFTIRQ>
+ *                                       call_timer_fn();
+ *                                       base->running_timer = mytimer;
+ *    spin_lock_irq(somelock);
+ *                                     <IRQ>
+ *                                        spin_lock(somelock);
+ *    timer_delete_sync(mytimer);
+ *    while (base->running_timer == mytimer);
+ *
+ * Now timer_delete_sync() will never return and never release somelock.
+ * The interrupt on the other CPU is waiting to grab somelock but it has
+ * interrupted the softirq that CPU0 is waiting to finish.
+ *
+ * This function cannot guarantee that the timer is not rearmed again by
+ * some concurrent or preempting code, right after it dropped the base
+ * lock. If there is the possibility of a concurrent rearm then the return
+ * value of the function is meaningless.
+ *
+ * Return:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
+ */
+int timer_delete_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer);
+}
 EXPORT_SYMBOL(timer_delete_sync);
 
 static void call_timer_fn(struct timer_list *timer,
--
