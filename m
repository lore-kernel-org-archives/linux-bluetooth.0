Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58134EF12
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521248; cv=none; b=to3g/R9W5T+fChGNr1npCseXmR/VeX3oFc7KLiu34OHBunyLJonxQKoNM1XYGu8BVain/z+u8PFxuZgOqlu7qXKH3lMfWk05snAFZG5DvOyIrhsUpYS6NTUrFdaN2cObA7x9LIRZw7H807intqLNDc2v5WDItC9AHli0ASZW1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521248; c=relaxed/simple;
	bh=J7+paRiPLaCD/c+KTz8seNjK8t39KhNj40mTnjX9HD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GM266T1m7TfCNJ/rOfaIHqBU9fAj7KzTkKiTe1dB6IgBjU9eCPm0+c/6Zg7QUtrq6SMrdCXhzQpLCPfBCBmk0SKDdVlP2aRt+BDqtQJOp+QH0vJE/9nsDF5wOhImLrycK2wOgemPGjBedt43IJQlMomRq5q5HcE6p+oX6Jafr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgRX22We; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgRX22We"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824484dba4dso1041121b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521246; x=1772126046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=kgRX22WeMszm0lbN6aVORu4ACNzYgkL2yG+In274D2/zZBMrVEj3yE0df0DvSHPNvc
         Es2U/vQ3tL0HP6BzLbd5NWPnmk7kcjNM1wCFU39WVQUZ+seMYw9NfO+sa2PdZAsdGn0b
         6RNMJAvZQ33SzAEJo2JkiaUTHrA2bN2/UrEJ1+XwH3PjTfHqiG2NWRhcWnWIYG0qQtC2
         csptSjwKBhh3yS6U9+gEeRNEf01dwf4r+S4wRad7lRYIRr8Fka7LECkZN7yiq41CjnlP
         wJOK2ACy1yHIG34Ycf7jvd2jHNg0rwkuXWvMj3OVOZH7xzhC1IYye3TZapvpjGs9Q59z
         giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521246; x=1772126046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=k36G1OnHe0CtfuVwL6btCSfjvkJmY9kie/W2LCvUwpBbSdRhQMrjx8QUvBlyomz7bU
         rCxd8/90i3ej2ZbLO39UR6gBtk363wCVI2uE4v6tGWo6VV5zKwLskxAtcTdspaYJewOf
         lIzodmx3YCLhCc/CegpgWHXCpT4p6L4fWzRKH6lX+uLGy+fL17XnsJamw9OCeoXBTITX
         P7Hm0gdwP46hvojPuKovunaf9wEVUmBGGJQpPYYE3irJZGRul1+XuiHHnLxG6KNacCBs
         FKWhEps93OHPBinOvmHBtajuP8tptLBUdoaR+gfbxyfyTlnyS6b58++Cmaju2ncWyz1s
         jUWw==
X-Forwarded-Encrypted: i=1; AJvYcCWQkq4ocb+LSKRMuhleVLlHRlthhJCMawbn1gHMJGJhOv2aB6xHWTw/hF4c0Xa2WWQDmIn92beA6DPWYAfHbqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWLRymfr1AaJUEVcudaOtiZqsoOPHhzqM7x3uey1yFC3O33Wq
	7vEe0fVMTTOQA4hMEBQV8Lxyk7vupwsxRKfQYg7ggi08XguVDzYcMijP
X-Gm-Gg: AZuq6aIPGFM3NOylxV4l+q6sm/+FSy1vIR4ZqrrfxplV1iI/YjIFhUyndlGanEbsx23
	xQ70t3DkPIjNm4Cs/gXuaUKFumKsJKgGrOIGm9SmHlPrk3wtZMB3nf+igvM+TngdJtG9v80vMeO
	bCreE/Xi7M3FPPxHu2DhmVemJsrT3R17fpMDT+E+jQ08vtWSEbbBw+8M4Gs1dFYmPT3APMNL8e5
	sjLFTME7PivDy7ul08RP9tmYhvz4t2o+yYXdUHw76KkAfGJO8OKMd6FnB7jaWZimTmtS5Lf7/kN
	xI2/Wt/oJhctKJ4hGxPkGpL1TuycTYarWV+thSCri4+nQiEK33Au7W96Tw9hkyxPwEMW5HgDAw4
	y62+CN0fILj4HuKJwhFvPiMLGXYMUOyYWNQamw2AJpwgbs5OEXn5EN2Hv8TpxJ6aQZY2c4G9OEU
	RhEXENtDFMue80HqVt5jYNdSbymeBWVvYe7vVogtvAyc8JAiCgCg==
X-Received: by 2002:a05:6a21:2982:b0:394:662e:89ab with SMTP id adf61e73a8af0-394fc24ddc9mr5454817637.23.1771521246359;
        Thu, 19 Feb 2026 09:14:06 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:05 -0800 (PST)
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
Subject: [PATCH 5.10.y 12/15] timers: Provide timer_shutdown[_sync]()
Date: Fri, 20 Feb 2026 02:13:07 +0900
Message-Id: <20260219171310.118170-13-aha310510@gmail.com>
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
