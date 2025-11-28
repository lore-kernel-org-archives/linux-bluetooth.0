Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2A2BE053
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345987; cv=none; b=Z//yvdf7kPPkASAHuCU9ezzrKcqC7aQef9KAh3nAliR0b+I1LZbKiFKeUwNZuyBHHDAmkphF5t3gp9UIZ3SGd8PrkqQO5eUDWl7/ryRArjjbdpE+Wi5UrGROboDYYCw8eUcNxlMnqPsKYK+E9siqXYnobVpOQ71srFGCUjklOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345987; c=relaxed/simple;
	bh=xUOfVR4rsP4k4iSxfTxt28P2aCRP7f27RFLz88rROqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbFsMI79zx+w7/GQsgg+/TvHMU9zynszAIYw9BvJkWUP0ShdSc09GVKNDFrEUtKlB8qnLrUqic+Ecn3BTryw5/fA0LO/YjKSlqH1pBrx3EKuF67JU8r87k5smfHljqcumeF9cU/M6N7bLxlvsYpYrqHHnRIWm+Wu7LmNnBuJ7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GONYey7a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GONYey7a"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso1562789b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345985; x=1764950785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=GONYey7aKY1Qli2QU187NYWEtijrZYSSrGDyDZuvBWIXX3wPFvjFAq+dNrVsgy6Y1+
         JIrpusGVJZfLpWhf34s+nNQ913aNP76l0V65Zf+45ZFze9OtXanXOSHSv3Hcx5FvzGeB
         b9dL2tuXLzlBQXJAsbgRQ+1UMrHJKKj4AHLcTsRIAm+lsauWgWxAWaioTbHgjOwxmEVf
         bKRn/mkrQ1aPGyxDxyeoelB3cOSoTwiqITvyw62mqxLRdxoa2bex/T4iKogfQzm4elyV
         IwX+0h4nPo8mUep/HKJaRVuVJYXewWPdphBZUQRBievnctv5tdOW8oROQJHEcrXLXyaY
         lnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345985; x=1764950785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=RIQovkJkdo41pAaZ+fQtQmsHI6uHx/mkau+4L3hHTaLx5F6m1W/V2EuN2KIY5J/4Xg
         +tvdOvtA64/80MmDlG8DKpipK04f1RBT7jtuZR22b6L6Mr1o4y1mCmKiVfXGgKYUji9e
         myPwFFxVala2tZLhXaEnXpm12xS13Mm/ZXqGwhK3T4YEF2TbcfzAozbDpXig6RpnDm66
         zv5R+lfUuPPH2GGvq5oPdfCxPkDS50RFGPVGgHAu+PEJU2KFeF1DevFnVNurz44d2Vc5
         H4ALBwzQNAF3C4V+He7b+foA706+E5TcNgw32i8a27kK69AZDef6K3M1MuYvVyDC4wZR
         m5TA==
X-Forwarded-Encrypted: i=1; AJvYcCXmsBWVI5ByhnSBXfwzMHNXz7o0L8pJ/dFfjjE9DFZJU/7relzioi9n1QFTHGAzLIecRYn+pG856MOZIpPzHeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUaX6FPCcEVoTW0pE6C4iSVtPnoBQLncBsflX0W5zE9MvNZ1a
	d+Y/fsmlNjpNDjFesvEn9PFz3q2jKrguvfgchrrbUwi3ZyrLLWJukh5grnG20vSzG6NpMA==
X-Gm-Gg: ASbGnctfs+FdV620b306zoHNzm1jIILF549GgJZ60o1zoOUUdnMOSrpMoDQlj77ASG1
	xIv9ezJYV1ReDDi9uCXECDrc9/ENbZVCExJ0I0Jv5gbH4iNllpjr2hmbstEzrOTbxofuNVGBaDZ
	Q7fG1m/+nx8ZIoxZWMNIpZ/9xFps/vON+KvyM2qy2oRvbfAW6lOBbUhqqSbVrbHVFMLQpPKqZhT
	CZxkmNzdkAezTZE8z8lk4rU3sNRUCR29FdJW0ebcT2FdjF3pvD2rIvh1UF8XGQrvDfvedlnR925
	cui0wCwFcdf3pdLr/+GWEtKPKu9NB/VPe2jJoWYgowCYQ4dcrVL6uQUm+BWbzetPNQiaZj6+x7Z
	dDgCz+tWoKD2H8vZOF+nA20qAnSlaTr3tc0mkRbmuj69H01YKzoxQANvCMsdnAo+prWlJb9cyUj
	2udcxl5o7scqqHoYVsLbxh/mFP7Fg30hSNugOKDQ==
X-Google-Smtp-Source: AGHT+IEztlvGKlUoqD0g25lCC8MUysNRG6xtAj50T9YwNqBxGNZ27/ROzosGghSBWQujOhn5Z/L7rQ==
X-Received: by 2002:a05:6a00:987:b0:7b8:7c1a:7f60 with SMTP id d2e1a72fcca58-7ca8977c27emr17931768b3a.12.1764345984715;
        Fri, 28 Nov 2025 08:06:24 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:23 -0800 (PST)
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
Subject: [PATCH 5.15.y 07/14] timers: Rename del_timer() to timer_delete()
Date: Sat, 29 Nov 2025 01:05:32 +0900
Message-Id: <20251128160539.358938-8-aha310510@gmail.com>
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
