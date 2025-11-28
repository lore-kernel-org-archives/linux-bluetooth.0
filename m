Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5392D2383
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346009; cv=none; b=m14f5UAJLbls/wyT9i0zviW6QM2w3FaYBJcXhADxal5HUVOUVd/TjpqTQfQpEWdP29zuoG9iA5GNEu2g7yBlV56Sh9HmBVXM3Wwp54m3UD22uQsKTPJhNLwRt8pg0jYN4hslvNXyQOl651dHmSVzeMEOluXbhcismZbKe+KMrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346009; c=relaxed/simple;
	bh=7nNzz17kSCCmlWDu86ZhyMKFITWZeFxpgwAsgGFQJqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZaAtufMRjgTcBPNXBsvo3st3Prs75eraaYxhkCB+3XvQi8CJrUtuC22CDzmSvwsdG51fmZtKaJ2g/UNgt1hNn74wFbXXJEvudDmvQcTyRQveXAklaGqT3VOBBNtPkURVN1zGKCzL3Jt+jVR5cs/lVrBWBEbaCyGREJOXnPB8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4ETs3x6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4ETs3x6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso2376255b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764346006; x=1764950806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1WOyKHAoHX8FrQxrc3Dl9TiChr0cIqUNlYEGeUOx2A=;
        b=S4ETs3x6kBPPUpXtx6VSoW6Dd/28zDOIEBTsCsNuda5Wr54WpiXNQ1EFe6UB/SqTJe
         bcjbXXFCRy2n9oFffXSVOPz/l/6AYr4GXsYxflRZSs+GTt8FtjH6Z/h4WP4VZbQ8KcWa
         ir0C2IanVTfin1oMFboTVb+FR1xxhupSdscPakDV6fgF+Qzl97RJdcNrGeoYJJdQWxrg
         bfQ8P+Ez/t7BJdg1xq/AJUBt0JmnPluJ+4LlNaKflv+zJwklixfeZVbRbx9z8g/hVdzT
         0ewCtUwPUseWsvZheGVn2lltGCStTmpJ2hUZL9iJbppSnIp4IEtNhu4JzlqpjiJMggKt
         tCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346006; x=1764950806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x1WOyKHAoHX8FrQxrc3Dl9TiChr0cIqUNlYEGeUOx2A=;
        b=VaHhqcvaZau5blfkKJmS2sfgahVPJfnhq8Gc9fEv+nF+4ed1ArQlhmRpk5mfr82twQ
         VvjhLfzbLmz8VIqFCQrO0/dWOkmjuxu/biGXjpcDA5Hhz2uHNwauyFHeDDAyXgnYIz16
         XBXSK9n3nZl+HV5OFNCg++4saQnSia4pd8Rk8aJuyyrL9GjJwce29wjr0/2QRHeTheEm
         eS83DBpeGc/2ry8XQdP0wnm7Y55NWI8geZw3FKo43IdSeZvaLAX+flKLb6AGB16rFVf9
         prl1opvZM4ynGtH/t6GF2QOa9kwCKVgxkjeTt9PwwX4aU2kcZv2htXWWfTtEKg0d6K5x
         K0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXKo0vf1u6OFBlE8zt40q/FnKsPy1uQEK1DJf0oasMp/4UZcc7m46Nbu9YkEbGPYD7RjJ+UbTjPo/2j5uQSBIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0ua0YPpJ4TzEArgSi6YdH05j3KLDE76VEpAUfyZA5MrKd0XU
	HBF6VLYeB5yH1NLSFCJf/ST8Y6EVLDtTIg1ARqASlzi2RhO7VlgQEsAv
X-Gm-Gg: ASbGnctoSxMO1Ery/e87Mskyx/da5UdzTCrdh0B2r9dG9O6P7KHvgftiJHrvbhH6UIK
	43VuUUUz0dp74+p3PIUqpSq2fadlzCyRBvLrRUkCDCsiYe55aNOQDnq78xwgZ967lzfWqvgleNw
	CZyLzmBkumchUZLIivvhdjH5hkQCH9LeL9dYDEnKWxNZMW61fC9N1BL15DJw2SOnGvME4MEJ+Oi
	7ZfPF0OtbGgVcS/nHP8PTzIgh/iCEskOoP0pWvVrB9WzqfQa7LuIV7EioHzDpbI2iBvrXAHeKvI
	hWDaK1uetFPf4Cb8DclnqejjysftX3x9hk6rOqhodndG4AheK54Jjeu5U5cDyVdg3Vth0c58Es5
	+z83NT6NbK8w3HUhDRAOhto2nD45xDqZ7P7dHCU7DwAubTSI9R3EBOiNt2JLT0X45lUWj3ko0eP
	BmePX2E6AghD8Huibd+3AW0Cnj1R2Lt/odVMYDcg==
X-Google-Smtp-Source: AGHT+IE3aYPKQhA3JTw9tSf5TPOec0+aL0hUx34xQqnLoed5SBOn8rW6c+/UgrHXUkcaMJPKba4Qkg==
X-Received: by 2002:a05:6a20:e291:b0:2df:8271:f095 with SMTP id adf61e73a8af0-3614ecbf7e9mr33783469637.24.1764346006160;
        Fri, 28 Nov 2025 08:06:46 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:45 -0800 (PST)
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
Subject: [PATCH 5.15.y 11/14] timers: Add shutdown mechanism to the internal functions
Date: Sat, 29 Nov 2025 01:05:36 +0900
Message-Id: <20251128160539.358938-12-aha310510@gmail.com>
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
