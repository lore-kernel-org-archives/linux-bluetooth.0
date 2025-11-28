Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042D330321
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345998; cv=none; b=fM7UDlXgyOxzmYUzQ01FrzUAdJngV+gt14gw1BChMaDqU22f/bMTe5Ad2/4AtcvjhSf3eUeas6FgWf0/Xt7Zo1qQeMGTokxqQ6xppKumHBvc7/Kb+P8vUCX8jFvtohkC307xxQRBfgbdW8xCxypY5Wk1M1t06vHVBR221JJkyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345998; c=relaxed/simple;
	bh=A7NZvw6BwM3JH9LFTZM0pkj7MM2Mf/KMJNxtIByaxbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRE/IJKhqMK80fmzMlh1laNKHQRx1osPekbjhS387BtJYY3SWr1xaR/rCumgj/4KvW4SzwYVkIDj6Ez1qNn1Mxxy53zE+Y2b8sJb+mk+1Cs7NDPQcWsNFJ2H/MzfGv1FY1+H3t2f+kudYg7XuferHutfeOL1xcgKpktwtJnDAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYhaCsCl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYhaCsCl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so1683875b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345996; x=1764950796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=MYhaCsClS+WoMgwkCexc+jqHtqfk7wjuxPEoGMCoz2gXOmavZWF7YsM8gpzZiQxQhK
         irmoW7CEl/8DsjX+V44wwhQ6pxDgF1zw5PXWcBGJk+aOwhbYaWq6JNr6IKCJsiLCQ/xJ
         1itMMAFkdTzQLpticTdw3aI+0SP4p2voGWLjhXVOA4a7mabh/yw/byuh8XjRHlshShzn
         l4IVaGSdYMg3l6A9/cSvhqoxkn+9iLfHnsYXv6nogtdBK9sUhySnXPt2MAe8p39gDcxC
         8ATnf6GfNpoRSzYkFs7ZPhhnF2tf3LlleTxb0QOdBVjNhOZFdkd3wGCw5b95OEnZeyjO
         W6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345996; x=1764950796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=lB1z31ZlFqAv251Wxi3jhbdvdLIhf1GGaip4xhdNngNgOGZi+TjnFw53Y9imOk9S/B
         4T6XY+UuwvhDBup7arPxixCldPb/Jo86mz/L1qWxNNDQtfQnE06ybZI2IvTDZszetk5g
         QgtuRSqBKYt1loNj40XHdEYdcCSESoW8+/YHI/VJju9wSHMMe3Et1CDm2CrwrJeppEi0
         JCeATeCuTSaujbB5YeyBN6jaW9NeEhhW95zaczxdK09hx8dPjq3YGqTD8LYhwzEE8H0O
         QYnD6EUAEMSFwhGd1zTkIxFMsyfjNZ2NfP4CbvoqZnrcnsP903SmLeTpGa3MjN2cuJtz
         8hDg==
X-Forwarded-Encrypted: i=1; AJvYcCU391PEcmRY+7jE+EpSyRoVmY4I79KCZS96+fx7rF8hqWcL1eWVAbOUrlPMyTczY4jq/+RBotYxRvEmnR5SmS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHHFCMxh67qMGw5Nj79NYDvgjFCnrKwphus99LNRMyr2TLqGwR
	SxE+AVzKgu1Xqr8e4T4LCittqCnowWEX+DuA+86AHhFPfOqRS05AlU0A
X-Gm-Gg: ASbGncsuMfH90NkOQpbQ6wMbzIz/j0yu47br08E27YWD7+mdIYBt2aJziyHwFAs1uwK
	1cDYlhvh6rskoV1a1Le/S6xlJLXl+Fqim9JXHo60RKniedn3pU0mBxvjdLqxUtZRBhIGYMYmMEJ
	MmDwYq0ZYTWQnGaEJG6OWvw4QuoRhVbQkELF+ebqGa5SSUSJqpng64KNNey3JhfMEpz3PKTGWpS
	1usT+fYqdFInlSh3cbJ0MsZm5kBzzvNwLiwDSITS6irTKt289axc/cLNiBZIe3pZ+k8EaHwYrSX
	QPUhO2Z3Tu2O0zuhpSiajBZWxD97IBcb9BgJDqxqVZh0n49AIKjSmjAEeUD3thwHqqq5xmrG7Uc
	8pyTzbxK0lhcWczd06p1+ebkAFg8o6w+fDfefWglhtzF517sCtzkeEFB8v/83zDUkUHFDwzya1m
	FQycSkn1bYrMWAHDg0yziYSqpYoQJmo4JYxXl+mw==
X-Google-Smtp-Source: AGHT+IFLg5ORPm0TEtuxOShEmNUFI7ZjoXaSp/U/kqJZNCs3wbN4/+zsI460r5w0wy7yoJqUDfaS3A==
X-Received: by 2002:a05:6a20:1592:b0:35d:d477:a7ff with SMTP id adf61e73a8af0-3614eb798e6mr32656783637.21.1764345995543;
        Fri, 28 Nov 2025 08:06:35 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:34 -0800 (PST)
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
Subject: [PATCH 5.15.y 09/14] timers: Silently ignore timers with a NULL function
Date: Sat, 29 Nov 2025 01:05:34 +0900
Message-Id: <20251128160539.358938-10-aha310510@gmail.com>
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

[ Upstream commit d02e382cef06cc73561dd32dfdc171c00dcc416d ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

In preparation for that replace the warnings in the relevant code paths
with checks for timer->function == NULL. If the pointer is NULL, then
discard the rearm request silently.

Add debug_assert_init() instead of the WARN_ON_ONCE(!timer->function)
checks so that debug objects can warn about non-initialized timers.

The warning of debug objects does not warn if timer->function == NULL.  It
warns when timer was not initialized using timer_setup[_on_stack]() or via
DEFINE_TIMER(). If developers fail to enable debug objects and then waste
lots of time to figure out why their non-initialized timer is not firing,
they deserve it. Same for initializing a timer with a NULL function.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/87wn7kdann.ffs@tglx
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 57 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7094b916c854..3b6624cd9507 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1017,7 +1017,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	unsigned int idx = UINT_MAX;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
+	debug_assert_init(timer);
 
 	/*
 	 * This is a common optimization triggered by the networking code - if
@@ -1044,6 +1044,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		 * dequeue/enqueue dance.
 		 */
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 
 		if (timer_pending(timer) && (options & MOD_TIMER_REDUCE) &&
@@ -1070,6 +1078,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 	} else {
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 	}
 
@@ -1128,8 +1144,12 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
  * mod_timer_pending() is the same for pending timers as mod_timer(), but
  * will not activate inactive timers.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and not modified
+ * * %0 - The timer was inactive and not modified or was in
+ *	  shutdown state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
@@ -1155,8 +1175,12 @@ EXPORT_SYMBOL(mod_timer_pending);
  * same timer, then mod_timer() is the only safe way to modify the timeout,
  * since add_timer() cannot modify an already running timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded. In this case the return value is 0 and meaningless.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires did
  *	  not change the effective expiry time
@@ -1176,8 +1200,12 @@ EXPORT_SYMBOL(mod_timer);
  * modify an enqueued timer if that would reduce the expiration time. If
  * @timer is not enqueued it starts the timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires
  *	  did not change the effective expiry time such that the
@@ -1200,6 +1228,9 @@ EXPORT_SYMBOL(timer_reduce);
  * The @timer->expires and @timer->function fields must be set prior
  * to calling this function.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * If @timer->expires is already in the past @timer will be queued to
  * expire at the next timer tick.
  *
@@ -1228,7 +1259,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(timer_pending(timer) || !timer->function))
+	debug_assert_init(timer);
+
+	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
@@ -1239,6 +1272,13 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 * wrong base locked.  See lock_timer_base().
 	 */
 	base = lock_timer_base(timer, &flags);
+	/*
+	 * Has @timer been shutdown? This needs to be evaluated while
+	 * holding base lock to prevent a race against the shutdown code.
+	 */
+	if (!timer->function)
+		goto out_unlock;
+
 	if (base != new_base) {
 		timer->flags |= TIMER_MIGRATING;
 
@@ -1252,6 +1292,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	debug_timer_activate(timer);
 	internal_add_timer(base, timer);
+out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
@@ -1541,6 +1582,12 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 
 		fn = timer->function;
 
+		if (WARN_ON_ONCE(!fn)) {
+			/* Should never happen. Emphasis on should! */
+			base->running_timer = NULL;
+			continue;
+		}
+
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
--
