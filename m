Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6332FB084
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108626; cv=none; b=Bt44ZJ5DLpgjKrj3mTm0Uh9l8XUYIyoXKXCtFIxMW2uboc2HgWhA3e2jSz9jd6sPkiCOaDPHK0qrAolHoUhekDLnJaOJulTMwUvx0Ybq0hJG/84FwlUiXKI2ar3Jd3BEPjVBoWQ9MQeUKBfp2tpoyShtEr/gDOawuzb6h53UrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108626; c=relaxed/simple;
	bh=7nNzz17kSCCmlWDu86ZhyMKFITWZeFxpgwAsgGFQJqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWd722ooXVLhNWIKwvrM55VbHq/tfY3BbPAtDgx1zcHSkUxDzsWbMWzkbDFdHJZI2GtwJ7uQSijPag2mVY2nECL87PBDsiYVc6Dv6Xyty65treqkc/QPMf26LZPKhIi0OwzctvIQKfqBMDNhNg6X1+2LAjoqaRVmv01wxacuwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fV1MeqoC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fV1MeqoC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-793021f348fso2070078b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108623; x=1760713423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1WOyKHAoHX8FrQxrc3Dl9TiChr0cIqUNlYEGeUOx2A=;
        b=fV1MeqoCo9+XinoqwRCcfrBmPcA0nfxE+n3HmKJKHYGn2O3+8JNqAvleRmenjusiaD
         50K+UkC8gIhwD/ZwqbwnTl3GsN5G3S11YZvWdCQAnEyUfITWr0QYUlz7rEvJtue4Cuqo
         0H9XLt35S+9Bvz0UZi9U9lkY/AG5Tn2Cdk8B5AojhcPEILTEbaGeqfDnENXcXTPSNxy1
         fN37EdJ49EFQ/6tj5h+Xvu7F94bxbW/EdvRVJGxARZGmDo0CuoIbMf+oQDfxZw6ggkpO
         wA3H9y7/WFjejyzXhJcTQkORnKRQOSzty82+27X6DzoVoMHGgN8iXvGnGBGAopDsr0fz
         qLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108623; x=1760713423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1WOyKHAoHX8FrQxrc3Dl9TiChr0cIqUNlYEGeUOx2A=;
        b=AwyGYN71B8ieNismMCQJtA/S4vk4PWdoKYoCsgP3ekAOeWfHYfEqZu0rujNf4CSnfZ
         qLqSinV66AXNuaOzzdZpeGSJvpoxO5QVJ/tPXlgYc2OCYBuiwa2hi2UM0ws1dfdhDRZo
         Pw9ehbqqiAfcvZLvMFWXEGhXZJvW0rdYalfMh/x/gg8Q6l1Wx8Er1JL95zs3BvBQ6xND
         noF1wu+1eWM6xAcUYLxMJhmUeGWnfh5x4zGhE4PbE293CtXO+UrbZ2Erkzz9EpHo7R+e
         TVGOu9IeKAlt1gL8khwxACv/Ay6cSAAlPBDYBnRMHwsM6zYdz2osbfyb1YWuRFY9jnEr
         R66w==
X-Forwarded-Encrypted: i=1; AJvYcCXH9AKnkdVrqO/2wmtZO9cpwoObFvcJ/1QJ9rsbSeT3kr0iMa3Ox/jczFM9TvoJgIdYod+nCOpUOYqNiFnsPv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEa1RE1ZHwggTikjsSoV0/Lj8w0WOvrm3ATNSag+J4Uo1qE5M
	7zWbveicBqOwr4Qjmj0ZRg91IQ0QMAFXUXQ1LThplLEntNDAmwNEjvgd
X-Gm-Gg: ASbGncsC5qUHWgyPNpHWHoxill3OOjzvOjg0eO4KTSKETzpFJIK1yGRzlwOPBysCa3H
	eAc/k3W6ikCPKTDSSwPsv8xdYqq5mYO9GIcB2wH5uWzIz3eyP5KuW3fSH3nBFVhnTHLFefojf7R
	oX4H/uBpZ1HDAHKhdllFz8iv2zAtPe5K6PdB1CjxUIGDevC+Lxu19uTqmfyceE6O8LrM79w8o0S
	OmSKF0MRtan+oAvV564p8Zoysd0AAWEtuWDcVrN/pP9XtGF0An4PSD+yvrVs6/IUKZtTDNZ7J9h
	9M5qBzq8/ItWmjVC3qo+MyN0wRlKq3OEkZkXtHPj1YwSHiBmv7G3uJ6FYMhcJnGb4SkFdln3L4I
	Fq0Lj+r4lhlOkJbrSlXaMZyh4E2I/QQgJoS5cJep3CAPuSpm7fKVnCs1Cj4qw8K0IQRoI
X-Google-Smtp-Source: AGHT+IHrduPK+iiS9nbHl2XLfSpxtFJG0LliAypgacWlL77CyWlc81OQiQGuYb3a2zEvexULQddNrg==
X-Received: by 2002:a05:6a00:17a7:b0:781:8832:9159 with SMTP id d2e1a72fcca58-79385709429mr12871804b3a.4.1760108622956;
        Fri, 10 Oct 2025 08:03:42 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:42 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 09/12] timers: Add shutdown mechanism to the internal functions
Date: Sat, 11 Oct 2025 00:02:49 +0900
Message-Id: <20251010150252.1115788-10-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 0cc04e80458a822300b93f82ed861a513edde194 ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

Add a shutdown argument to the relevant internal functions which makes the
actual deactivation code set timer->function to NULL which in turn prevents
rearming of the timer.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.253883224@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 62 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0b76a2ab42e3..b46614e14da1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1300,12 +1300,19 @@ EXPORT_SYMBOL_GPL(add_timer_on);
 /**
  * __timer_delete - Internal function: Deactivate a timer
  * @timer:	The timer to be deactivated
+ * @shutdown:	If true, this indicates that the timer is about to be
+ *		shutdown permanently.
+ *
+ * If @shutdown is true then @timer->function is set to NULL under the
+ * timer base lock which prevents further rearming of the time. In that
+ * case any attempt to rearm @timer after this function returns will be
+ * silently ignored.
  *
  * Return:
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-static int __timer_delete(struct timer_list *timer)
+static int __timer_delete(struct timer_list *timer, bool shutdown)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1313,9 +1320,22 @@ static int __timer_delete(struct timer_list *timer)
 
 	debug_assert_init(timer);
 
-	if (timer_pending(timer)) {
+	/*
+	 * If @shutdown is set then the lock has to be taken whether the
+	 * timer is pending or not to protect against a concurrent rearm
+	 * which might hit between the lockless pending check and the lock
+	 * aquisition. By taking the lock it is ensured that such a newly
+	 * enqueued timer is dequeued and cannot end up with
+	 * timer->function == NULL in the expiry code.
+	 *
+	 * If timer->function is currently executed, then this makes sure
+	 * that the callback cannot requeue the timer.
+	 */
+	if (timer_pending(timer) || shutdown) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
+		if (shutdown)
+			timer->function = NULL;
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
@@ -1338,20 +1358,31 @@ static int __timer_delete(struct timer_list *timer)
  */
 int timer_delete(struct timer_list *timer)
 {
-	return __timer_delete(timer);
+	return __timer_delete(timer, false);
 }
 EXPORT_SYMBOL(timer_delete);
 
 /**
  * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
  * @timer:	Timer to deactivate
+ * @shutdown:	If true, this indicates that the timer is about to be
+ *		shutdown permanently.
+ *
+ * If @shutdown is true then @timer->function is set to NULL under the
+ * timer base lock which prevents further rearming of the timer. Any
+ * attempt to rearm @timer after this function returns will be silently
+ * ignored.
+ *
+ * This function cannot guarantee that the timer cannot be rearmed
+ * right after dropping the base lock if @shutdown is false. That
+ * needs to be prevented by the calling code if necessary.
  *
  * Return:
  * * %0  - The timer was not pending
  * * %1  - The timer was pending and deactivated
  * * %-1 - The timer callback function is running on a different CPU
  */
-static int __try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer, bool shutdown)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1363,6 +1394,8 @@ static int __try_to_del_timer_sync(struct timer_list *timer)
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
+	if (shutdown)
+		timer->function = NULL;
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
@@ -1387,7 +1420,7 @@ static int __try_to_del_timer_sync(struct timer_list *timer)
  */
 int try_to_del_timer_sync(struct timer_list *timer)
 {
-	return __try_to_del_timer_sync(timer);
+	return __try_to_del_timer_sync(timer, false);
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
@@ -1468,12 +1501,25 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
  * __timer_delete_sync - Internal function: Deactivate a timer and wait
  *			 for the handler to finish.
  * @timer:	The timer to be deactivated
+ * @shutdown:	If true, @timer->function will be set to NULL under the
+ *		timer base lock which prevents rearming of @timer
+ *
+ * If @shutdown is not set the timer can be rearmed later. If the timer can
+ * be rearmed concurrently, i.e. after dropping the base lock then the
+ * return value is meaningless.
+ *
+ * If @shutdown is set then @timer->function is set to NULL under timer
+ * base lock which prevents rearming of the timer. Any attempt to rearm
+ * a shutdown timer is silently ignored.
+ *
+ * If the timer should be reused after shutdown it has to be initialized
+ * again.
  *
  * Return:
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
  */
-static int __timer_delete_sync(struct timer_list *timer)
+static int __timer_delete_sync(struct timer_list *timer, bool shutdown)
 {
 	int ret;
 
@@ -1503,7 +1549,7 @@ static int __timer_delete_sync(struct timer_list *timer)
 		lockdep_assert_preemption_enabled();
 
 	do {
-		ret = __try_to_del_timer_sync(timer);
+		ret = __try_to_del_timer_sync(timer, shutdown);
 
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1555,7 +1601,7 @@ static int __timer_delete_sync(struct timer_list *timer)
  */
 int timer_delete_sync(struct timer_list *timer)
 {
-	return __timer_delete_sync(timer);
+	return __timer_delete_sync(timer, false);
 }
 EXPORT_SYMBOL(timer_delete_sync);
 
--
