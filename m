Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17938330D5E
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346013; cv=none; b=OLZ1tF+GTRuT4Xro9aFEbF4QR9VIsxphv28G/hd//Cgmg25f1M0Vz1lB9T18UsoJliLvIlwgWVr+vPu4X1dwRxkB+oXdygpRBNqTMwZz6YKeRg95j79+MkPMuDR86ifM/EmmuB6Q8UA0SUpQH2vXL+KK91ScM1+RTpC6kNKC66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346013; c=relaxed/simple;
	bh=J7+paRiPLaCD/c+KTz8seNjK8t39KhNj40mTnjX9HD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=haN4KbYIwPPWVHsT5PaaCWsUe21j56qmErfpNzuccN4dTFDsZNbKMofGAuO60GeEeb/Zaz/ijUIN99cDCLXSq2p6OlaGFR7dbFlcP1Yjzbu2WqTtKHpaxUQxNe2OXufqxhPx+4PNPVfo+ePxOEv8vVQzHYfvlXXzQuWeyftfuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alwvx1Tw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alwvx1Tw"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso3186836b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764346011; x=1764950811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=alwvx1TwCnRD/Z4eW6RYq8k3jMVm6tTmLDibhQuny4iz9EJM0JWSOCoY3OKhsTUA7j
         mvhjIkYV68nAsTxbnNHRStg6RzEYk2VEU9MouhiE+9d/tvPaW0bN1zJEaux74N6iaJBY
         1iU4lYvcFk7zKDKxjftlBdXPLBUiH8nsYVp9ecxwd+zxEtJWHSmsfdlsbBWiX6jv/PGF
         SUpJrh+j4+Ap+xH7hu3w3U/aVvlUR+9HPfLO+8GzQSJO3pvue+7uYPsYjzg74vuEWqvQ
         D13AYCbb4+uMCQUDKt429vK7sfVlFUgafuBSiwfKEFAibKpMv5DQ6DGGuY9p2LnhKry0
         ks8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346011; x=1764950811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=B1L51s8AHqZCh/GVid6PVWfFYHpdUs6WZLRhDPM17fZNQVbfJsMooeGqooayaJdtVg
         GdFGasBPIxcbl8Dq+f6UFVdRs7rKa32h6vGL8QB4SxwCWMnlNecP4yFMi8dwCQvjX64F
         X617M8s9ElTe57YFjbzlSxTTNrBgLjDBc1YgF5SzU3O+8sioOpqnULVMGPdw/ClH78P+
         9vrhi90yGGWVNKduNxXI5cumAyrmWu1FFGoKHAmKColb9iKRzeYgMtyTRd0nrGz9tLtS
         C5q3Hkp3Rntd25hjGT4lxHoSyvRjDNUudlar+JzhYGW6cjhzm7aevWnUDSCs529y6/Zm
         /lJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1usEdN/OZ6EBHA8LwllJASwBWO/sWFz+0eRvJ2/3w+Erc2SQpq92fg6eIJoHv4e1AZKi9GRkGdSauPp9P1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cYdHlNjy6kqLwWJ50OhDpXtWkqBufPbWbhmujwi+yBpbn0tt
	rnGeQ+nulvk7k8O/vHCpxiE+rUWhAGlcDbDLp65y9DAmdsFlBJB8Tmkz
X-Gm-Gg: ASbGnctjtdfCrrz8TTiFrcF7jativZ7faO4sd0c7BXGrgE43Dbz1M1wnCXzx/3J0M5H
	Fx3CzfSIEeOFwQHm/TnU1Xu6oZmrg6bK11lqoiwrvowDwbTLKG2q8x5bJPkQ4/NRNSJPOisL273
	lgMDtNu7mBVNRHWTB8UdOATTAgi/1k9oc70vwjTY0q1205BoIFggt3uzStrKAUp8z9kHpZR29qM
	qc7skaJFQRUlAvuI5vT2vWjDwDyD0SxALnAO1mhRGUacSKA0ketHy4KWElf8zGt7lWieWMScTAy
	99vdyzIzroaWkpJK/Ruo+qu23oSSVvj8b20v3Rvi7bcgN7yjrqK+WVDT4BwUo2SoA4FHuRL+6cE
	+SC4T44+U13FzpnEvEthJUcpAj4cbN5SfI7ZgHjx6rts8szgtjt2tE8eIhK0szRr8XmHeJl1FpU
	RU4HnuA1Euwi4jGRHDYc5PVA8WbB7yWPaubvRAJA==
X-Google-Smtp-Source: AGHT+IFe/WzAJ4YhXxjHwL8WErLggbUzDU+xEOEqWM7cgEhnUCfU8qyTm7b6vv30SmypDB6nYkwQ6g==
X-Received: by 2002:a05:6a00:1828:b0:7ad:386e:3b6d with SMTP id d2e1a72fcca58-7ca8975fbecmr18947035b3a.21.1764346011056;
        Fri, 28 Nov 2025 08:06:51 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:50 -0800 (PST)
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
Subject: [PATCH 5.15.y 12/14] timers: Provide timer_shutdown[_sync]()
Date: Sat, 29 Nov 2025 01:05:37 +0900
Message-Id: <20251128160539.358938-13-aha310510@gmail.com>
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

[ Upstream commit f571faf6e443b6011ccb585d57866177af1f643c ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

Expose new interfaces for this: timer_shutdown_sync() and timer_shutdown().

timer_shutdown_sync() has the same functionality as timer_delete_sync()
plus the NULL-ification of the timer function.

timer_shutdown() has the same functionality as timer_delete() plus the
NULL-ification of the timer function.

In both cases the rearming of the timer is prevented by silently discarding
rearm attempts due to timer->function being NULL.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.314230270@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index e338e173ce8b..9162f275819a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -184,6 +184,8 @@ extern void add_timer(struct timer_list *timer);
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
 extern int timer_delete(struct timer_list *timer);
+extern int timer_shutdown_sync(struct timer_list *timer);
+extern int timer_shutdown(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index b46614e14da1..4f39025ac933 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1362,6 +1362,27 @@ int timer_delete(struct timer_list *timer)
 }
 EXPORT_SYMBOL(timer_delete);
 
+/**
+ * timer_shutdown - Deactivate a timer and prevent rearming
+ * @timer:	The timer to be deactivated
+ *
+ * The function does not wait for an eventually running timer callback on a
+ * different CPU but it prevents rearming of the timer. Any attempt to arm
+ * @timer after this function returns will be silently ignored.
+ *
+ * This function is useful for teardown code and should only be used when
+ * timer_shutdown_sync() cannot be invoked due to locking or context constraints.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown(struct timer_list *timer)
+{
+	return __timer_delete(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown);
+
 /**
  * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
  * @timer:	Timer to deactivate
@@ -1595,6 +1616,9 @@ static int __timer_delete_sync(struct timer_list *timer, bool shutdown)
  * lock. If there is the possibility of a concurrent rearm then the return
  * value of the function is meaningless.
  *
+ * If such a guarantee is needed, e.g. for teardown situations then use
+ * timer_shutdown_sync() instead.
+ *
  * Return:
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
@@ -1605,6 +1629,48 @@ int timer_delete_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(timer_delete_sync);
 
+/**
+ * timer_shutdown_sync - Shutdown a timer and prevent rearming
+ * @timer: The timer to be shutdown
+ *
+ * When the function returns it is guaranteed that:
+ *   - @timer is not queued
+ *   - The callback function of @timer is not running
+ *   - @timer cannot be enqueued again. Any attempt to rearm
+ *     @timer is silently ignored.
+ *
+ * See timer_delete_sync() for synchronization rules.
+ *
+ * This function is useful for final teardown of an infrastructure where
+ * the timer is subject to a circular dependency problem.
+ *
+ * A common pattern for this is a timer and a workqueue where the timer can
+ * schedule work and work can arm the timer. On shutdown the workqueue must
+ * be destroyed and the timer must be prevented from rearming. Unless the
+ * code has conditionals like 'if (mything->in_shutdown)' to prevent that
+ * there is no way to get this correct with timer_delete_sync().
+ *
+ * timer_shutdown_sync() is solving the problem. The correct ordering of
+ * calls in this case is:
+ *
+ *	timer_shutdown_sync(&mything->timer);
+ *	workqueue_destroy(&mything->workqueue);
+ *
+ * After this 'mything' can be safely freed.
+ *
+ * This obviously implies that the timer is not required to be functional
+ * for the rest of the shutdown operation.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown_sync);
+
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
 			  unsigned long baseclk)
--
