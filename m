Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241034DCF9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521226; cv=none; b=qIpL38PJ6dHLA85WVR7yLgDlhpQ0m/+ZWIMe+ek5VKIHgS4V2N60udowVj2SIoOXgY7eUC4LZmQTFc1Lvm4rjF4LN+A5mICL1IR9DSLRgY4cxlarGWaI2xL8J0VE/B3uQNX+Tx4VClROTf2wRgjSJCH8VTLC4bA2DFKogPKlU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521226; c=relaxed/simple;
	bh=xUOfVR4rsP4k4iSxfTxt28P2aCRP7f27RFLz88rROqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbyFPDymxTYfA76+AyWhOtGLbTDjaeyt7to8Wmhr9n4MHQ7ATW4Icm0ajUa0/cA3/3MiuLffIkUPuhFstlk/15MC1H0sPe6owg5Hsefe4mrf5V6RzE//IyM5GCz9MpU0qny+YzCT3tuaxDrXAOHYiHB3QdprCgChA3Ft0jWbBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY0zUH8m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY0zUH8m"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad617d5b80so5272255ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521225; x=1772126025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=KY0zUH8m7Iw1psu1q0hzSqh8kVqUHFTaFcrn55/eQnUy11muGYTgFrCvWOrV5iJgnt
         lln5LEFtovSDb0HplHUBW3TsI9mEFiXzZRe3Vd9sAGVO1iSfaLsE1BmWJ3mUUllKl29x
         qAJZJBel5oaL0VoWEgo+XGDiBR+b8Tg6/JgF8PNZmHch+GikaexuW3jL8tLzchK5GJiC
         od7B33BMXba+EtDGtQIkkam1AcaTZR5R2UoEGpJ/0sPlc1h527IlL0H3rf2juRSd+b89
         ZR5vk9cR8IQO/+5r8N9HKFpHmiydpeWQD2fW2TQ1blK0HFR9heN805WdC2QQJk0L7LRR
         X0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521225; x=1772126025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=vu3j+35dYUiJeLb0a4iOJWSjXSC117Cr3J+p6d+5T65M8LvPEm5LOl+BlGXe/nf2EF
         NAwDCG+nOLb6tTMmNQrFmrzbve8YeoVawYTyDOvlQSlSJmdYHrlBxpT77iWXrLbcRtVk
         +J9MIuGyaPbDzWu7bs9UJLBV1zvr8wJFU3Ipbsq0mIu+n2+7Onj56X9IH0MhzJj8KBtF
         JF3iiPVdQOQPfUzgiQmS3jYpBtg9NYdz6N73oX6nPMUeM/BLm5ew7zTpvk+G5r9RQFj9
         relqUBANQEBlt80oXcNSvk+AESJFUoBXjObOBQ2s/T12nzuLi1XVunQJ39eXDKrkjhI/
         JXnA==
X-Forwarded-Encrypted: i=1; AJvYcCVXZTaUehQBiWWavQeCvrTm4XgneCjs9zltfGO/zUN7TBRBMg1zXjyIl09NrQETnUZLAPi7/K88PBU6E/O5mic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRgj0kPa/AX3bGXfBzdCv7hPecr4fvxzzeLn3bsA549fsCYLQ
	UvhrZMzx8n5V8y9fcHoKj3dRtmWDy/Q+wf5IQjwv0jopzgzBb8bxLYqH
X-Gm-Gg: AZuq6aI/eMv8YblrQr5R+tM9ChmHDM8ej0iOmgVfl/t+HDsxpvjtU9v1xTx7jY7u5V1
	N/Uio3F0dcHchcDTVSsXLrIuVWl+hTH50fz0JaPqBre9sp82w6mXnJczRu8SJ/ZiKU/SNhkMINX
	pr0trNxxvLBmHBhf/4JIN15UYy56pWdOMtgYw/8RMzMJjeRHxw33aT7+jcwikaoK5kG4HdJtbfe
	35bjtGKbNiLJIF7uY0D1ICtLzrodUw6eDwJqzzNoM8XZWeQZLig+fNI3fwngW7GraORlj4Q6ano
	lUYTRw6CyIcBQ2wDnICLFNq9LJHlmDCBXifaloZXVXI0IsP5RGTsqf+1LmPMQ+kAkP+hIHZOeAP
	ZtkHXOLPXXUo6gvTJEmYWYEwQF+tsbXD/UpSDUDACEupQI7Nef7NWT+yxZ/yMwbCJ3yuipTzTw5
	T582Zgqgy16+KesvFw1pJbkayXHM+GGVTCd5V7lyVizCIjnZI2uH5/pYOZAk3W
X-Received: by 2002:a17:903:2b0d:b0:2aa:d7a7:8091 with SMTP id d9443c01a7336-2ad5aed3fcemr29265505ad.12.1771521224611;
        Thu, 19 Feb 2026 09:13:44 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:43 -0800 (PST)
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
Subject: [PATCH 5.10.y 07/15] timers: Rename del_timer() to timer_delete()
Date: Fri, 20 Feb 2026 02:13:02 +0900
Message-Id: <20260219171310.118170-8-aha310510@gmail.com>
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

[ Upstream commit bb663f0f3c396c6d05f6c5eeeea96ced20ff112e ]

The timer related functions do not have a strict timer_ prefixed namespace
which is really annoying.

Rename del_timer() to timer_delete() and provide del_timer()
as a wrapper. Document that del_timer() is not for new code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201625.015535022@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 include/linux/timer.h | 15 ++++++++++++++-
 kernel/time/timer.c   |  6 +++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 551fa467726f..e338e173ce8b 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -169,7 +169,6 @@ static inline int timer_pending(const struct timer_list * timer)
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
@@ -184,6 +183,7 @@ extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
+extern int timer_delete(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
@@ -198,6 +198,19 @@ static inline int del_timer_sync(struct timer_list *timer)
 	return timer_delete_sync(timer);
 }
 
+/**
+ * del_timer - Delete a pending timer
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete() instead.
+ */
+static inline int del_timer(struct timer_list *timer)
+{
+	return timer_delete(timer);
+}
+
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 60e538b566e3..2b5e8c26b697 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1257,7 +1257,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * del_timer - Deactivate a timer.
+ * timer_delete - Deactivate a timer
  * @timer:	The timer to be deactivated
  *
  * The function only deactivates a pending timer, but contrary to
@@ -1270,7 +1270,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-int del_timer(struct timer_list *timer)
+int timer_delete(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1286,7 +1286,7 @@ int del_timer(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(timer_delete);
 
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
-- 
