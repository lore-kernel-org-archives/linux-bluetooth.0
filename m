Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7934F47D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521236; cv=none; b=Yz0RJ09xce0Ago3OptgjS1f43klWfugKL53ovaFARBODZhwKSlIbyP3aBXAZegwsDcR7A9rnpVxiL02q/KsGwXO9ddB4QvNoIeli9lZ8MU+QvsWRNhQRdmj1zfHH40Cu/z9sAjBWOa4xqpbelMuLjwjYMjnwBtczjWcuH+nsgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521236; c=relaxed/simple;
	bh=A7NZvw6BwM3JH9LFTZM0pkj7MM2Mf/KMJNxtIByaxbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+voAQpJQgiM7ZzMGsyloJhlFe2SpAHpDQMgo+ga3MY1lfrwQ88igs8Dx065unwJCLCWJimpSeVOy9cnXojy4PihnTAyK34SSKNVUmMipOCiT3DILmxYuti53JErBc3q2X/mWINqQjtvna9w/3Hb5+gmp/Xe4GLcFjguMHJnFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2xIpNTa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2xIpNTa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a77c1d5c3bso4951945ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521234; x=1772126034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=A2xIpNTaLKxPgBBGcN7gM2nJb/aWDGI9cNvUQkur9JkNOee0EuGzRETI/ppS17MYur
         glmusF6Gm3bRj6nHs5A7YwxyUlmBngZF2WHobQiLXQDR1fH/7OZK03JIBUC7xmOFsQ6v
         dSiOyobgS44PRCE8qnggOyruqnmgYF27gpDfAn484nDXSKetDkjRxx7311dIlRIDAXln
         Yy3EhFpHjbmR2ddGF+s4kJHKGfrrhe5++axQv7pnGMztP9m1dwf+gWgjhnaWQQdLLkJr
         st9mfTebci4PV5GJdYO9eVEgTS8RwZwh/eaEwqQMgWANCRAZIJkZxKN27f1aMhulHOwg
         A3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521234; x=1772126034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=c1p/1wwZwnuEJRNwHFn83UGlqUc4rXeDFxAkbAje8ELFU+XC/sGh/ytfTZKd3IvmpI
         3SI2OpR7K03Wd3wbBA6LHjaBmCeiVotAGxQZz7PNF3GUMd8IJlDBUXN/c8Ebe72C9UNj
         cg1w9Rv3I/KUHv9CGHRyyS6VUh2wTAMteEandU0SmdyRGpbcyuWVU0YiLCxNPkdXxSum
         4JDtYnMnP9MUl3fCqW4ibQUU4bpT/CPW/wbfFHQR7IfKomz+APPJ/9mtNGk/4LsGXDyA
         t21GU6jKIMZBImn96DZSfpXZ/gv4xiIYPOyLb4A3Y035gfgwFh1qN11m9gIsb9mu9Viq
         4iLA==
X-Forwarded-Encrypted: i=1; AJvYcCUWKUBrfTypXfP7IueSJ7ldCdyT+rqdje4iS+Ad4gquYa2nOWcFph0cyQlJZdDBFOdKJg/MtaqydL6RjUukS/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfj8LUU+pcdbSHtduWgfGlHHB0USn2SoLtMzFp6INL/0thjLBQ
	c/qsfRVPPLIDePQfHNzhkutPpVS9CicJSp09RHKD8S2LBH/dZmzswuAi
X-Gm-Gg: AZuq6aKu5OaQjrfMmsehyc9fldT6VopCgDTtCzAyoYY8y25MA9jx3odTPob6iCC319d
	hzAnl8Ty0VF1iNzua1Sn7zFFVORmvDPgSWgpTgO/IohQxeO9nvM+6raRszbBShUijKKsrVniwxA
	2iqO5MPXqQaAtz+CMePoGbfx3zV5iFFTKS5PiKWMaP1oqpRPVV3pdoQyUHfmwvVsYvhklbxfvcA
	Ursvzt5BNeKUmRIj/FX/iqGzu28RTt8pCrTEL1BAnsYHanA0T64gw219YC1c7o8/bUL+zoGqPpn
	36WjbW/XRgp4LtWcPIzV1UeHezPMW4XyvBD3pxYxROip8nh51aokzIcz5ejBkfP/tEy/4l1WMkc
	a0uhTGjA1A88b9zy44UEZq/pa0Qa5oXtCTvpORdZ0fOJbaWaZFr/SnCClVIP5ntXz1BnoUemHLW
	3NXhtFW0/rno+fFe8Xs+Zj7lk6KwY/5yflbvrU19cLbIzeUzZy+04dwrdgdM/I
X-Received: by 2002:a17:902:db01:b0:2a0:d629:903f with SMTP id d9443c01a7336-2ad50e76db9mr47242025ad.9.1771521233834;
        Thu, 19 Feb 2026 09:13:53 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:52 -0800 (PST)
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
Subject: [PATCH 5.10.y 09/15] timers: Silently ignore timers with a NULL function
Date: Fri, 20 Feb 2026 02:13:04 +0900
Message-Id: <20260219171310.118170-10-aha310510@gmail.com>
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
