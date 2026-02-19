Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057934FF74
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521240; cv=none; b=mhjuWXPuVvOwNk0n/xq5xSGRl5qWpvThXYktbob4eXjgvPA3NegzQFCrVllEiAKtBhH+ZPRiap6Tigps1I4zSQdtlHzp9M5Q3YK5cjfiBPLtFqb/N8lXYPexxYJg508OtB+UVmlAxgc0ZaY7GvDpt6tWCUrOLVaG9N0AD4D+zhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521240; c=relaxed/simple;
	bh=FfeWAFL01yrxGNZ9KQqmQL8U/+v/91/EffrzfYdxZZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbyUAcYKm2qWPMnKEg1hhEAXuzups0lM73+sNQ6HS47SeAN0QkwAqGiY4tX2/Iwi84LVo7NszV6Dsoh0PdYwzOUZ1Gc0knrV590iVEPr744WRCKFMYAR2MDG349S8uTovryPpXfX7TFMyeSXMDeXFMmjl59d0M6vhilpJ/21nwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyGey/qG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyGey/qG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8220bd582ddso581869b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521238; x=1772126038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0bNeek1LW81/KG2/Q/uicdT1bV3tR+ITFKGtccSqSg=;
        b=iyGey/qGN2bH2syhXFZyONTsL0ilPXFhOG61L0+4zSQyErMbUWIKILGG/kbJwg/kLW
         SNtDcJW4TqqRvCQH5GkYEqoozJuqyLtug1gef69hXKqoHJp9Co4Ql4lx5Z/HAiy1duP9
         yY9xqq9J8RVlwoGVfY/RPfPwTduCdWvFwy84Ti481pduAGkCGCV0MoKshEudhSTFtEx5
         VZmeukutF9VoTH+ugk9l7jGc77D4oX1NAoQFP2mcZZZZaVYjyjtTD1mnJCiIbMloeb7O
         TSxcsnc6BW0QJS0SVaJguXzXE9hfFtX5sTtyjrJzA6DZWS36F4tgjTWYh/f3TErcdi5e
         xHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521238; x=1772126038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0bNeek1LW81/KG2/Q/uicdT1bV3tR+ITFKGtccSqSg=;
        b=j3MpeaHbD4IxyqjJM7RTCCq7FDYC3hdPRJ58OjP1hlZ1LUtBvspwXMooHlg5I1kHKw
         v45IASDJOPUv20FpR1ORfKPr3/VKwFvcbhMjlBTXoilcmTYwy5OFVY9knqOF+xqOTWOn
         WgpCkMk/pqxP+p/rs3ZFug5nnxlEmmOsauW1XHwfmCLkGKw++dyeLgXlGIhIZ1Vvp/3J
         sLSvnzaOPeUftxsR+plkRHT5XTtE1icVhR3GzPuWuS/5okU6uCNoItdTkopzEd3aSVN8
         cY4WlVsULB98smVh2PeHAfuH68+ouLCTTs4VmJx77TqNXa1V9APgvlh8P5R2AmzTlm3S
         H7ow==
X-Forwarded-Encrypted: i=1; AJvYcCVDTnfRfPvH7gJ0BI+x4UAqeHJvhAyxjM+FF5W5vzRXvfSAsk4B0vnwefimrLYonQ06c1zLBWIPLYwFCLQsOLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbIMP5etcxbhuPMsZFMsUd9q5NQTROpz/DZyeNITeyeWm9xEh
	STEyVHDqV+/G0E2IM9y5yTe94+nkXwcRKW7ESBL1SbGkLStF8Wa2wggr
X-Gm-Gg: AZuq6aJUweSUnO9YOYNS5zMJE4ImNBt1FLHlRUb0MjMapYxaDEdhF9QWYOlHeXieMvq
	UdwIKy+wx/++mJU+fX7Cxjs+EabLMrESnTqsdOvz2s2GJZRORfMpp0DuoSInzCSbFi+AeZlnFjD
	TqfQnHZn/CSGmmPWYpGDwX91ZEWkOtam8GQf7WGA9lZ6KdDVpEwK3p45LgYVUObSW3CgboQOr0h
	qMYRorqZ4qxoM5uiHIhUToMAbOPAvl1splA40vVdCpBYD2PrPZH0koaCT6gjym2O/eVtf7bRONa
	vBPo19IjYIv6Zt/cV9sP8LhaDrXx5VE4beg7OhL7LCjQPSux2L2pmPe2OOhPlOEKmeDmWkJ2GfT
	qvCoYF5xlQmvUOhZAfRB55xw+BTMvg4w0AnSoBeCUCfwXLB1z7RQp/wKCMqwdx1jyfaBnRB8o+z
	GjxWz3s2NVN9gDdONROD02YqUOp0OTg8ekL/g17LCrs1NrzyToJw==
X-Received: by 2002:a05:6a21:3a48:b0:35d:d477:a7db with SMTP id adf61e73a8af0-394fc34764bmr5169360637.56.1771521238056;
        Thu, 19 Feb 2026 09:13:58 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:57 -0800 (PST)
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
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 10/15] timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode
Date: Fri, 20 Feb 2026 02:13:05 +0900
Message-Id: <20260219171310.118170-11-aha310510@gmail.com>
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
