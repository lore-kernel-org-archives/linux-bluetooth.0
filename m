Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20134A3DA
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521206; cv=none; b=r9Lm0q5+q7Awt/YjI2fJN6QpEjlOAwfxZY14thlgr9k1j4FJobxh1nqg8y3DXA5cjtgoXQISdoApETLDv2m26gip8kLqIMyFvkdhU2mjGZtjXMi3MIg1g3DmjaEKsqowXB1TYbheIwzS4XHcU7KpxhTDnoTwcJyCDlgmZqaEJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521206; c=relaxed/simple;
	bh=FgQfbLiyDT66S+sNI1wE/oslfO+pvzybNJFnYppNieM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7OJqNriGKq0BdfufH6/0xN9YbjtOtWBnLkwQIkAXwJDCsPVZr1RTKcnCMcGDHjPCGLB5Je5Fj3MvXuw8UgYo5tj6UiXQIKIZc7jCD1moT+bkYKU/FN60ZRvgfiQfM/xh7U6SaeuypOZuRBfuip30QX9dYs6dEW6qVHqiCw541w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH7VRoc1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH7VRoc1"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824a6f2d816so524554b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521204; x=1772126004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=BH7VRoc1sc/CwuoO/dLbXTiwZb06cO+UinnRhpzQQzplqMSCxnzOaboHEfeop65UOv
         gnQq0L/DyPWVNYaIhlhQVQHYOtm5c0+THmf+fGS5kuWN3FDN+aBSVVp8mjRGBsZdvgNQ
         crFOQUGvnb7oW1aWIFOvtiHaK1/+y9tPXDM2Jp2TU5lFPW6MpfP2uX3DyH9bHKCR8P/8
         1rRElxM4+lpNEhFGPIUHnwH5uGPKbvasBRXchUGCj7NKeFNmK7E0tzbdY5znZ924KDIJ
         52eigSOJlS6C6njPOfINNVvBMl4St+KFab7fqraAHwRDDj7AaktvyRLhmD1BiEsaZJjS
         OW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521204; x=1772126004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=ZvZ1ypPRGw6t0B0PA9vcX1zUUY+vdQKjSq/YIi6LyIxWNsGQm1ueZPtYyklEhcU3YK
         JxKGe7FCz7c2xGKfgfYeIurcJdQbFTicd28vZ9KCGiMXoh7gfFABt7KG+ZrrCqGglhw4
         DmQ6k53vfVn4VYYBK/emnVboypwPA6iaRbaVfsRG1/RFTxph4RO3OPctFgq5hw7fzJhP
         hdqDpxnr9vOK2DUOzoKbry/CUEWOi71Om6tu7Iqbnb14oANcdZATivw3oNErkePyI2K5
         kstNm9IspvqiBKgYQwv/Dg2Tks07KzBFnN5n6rUxbGHcgF+44FA02UL3786HMabPKD0p
         mwhg==
X-Forwarded-Encrypted: i=1; AJvYcCVWxxeikBFUWR6C9vz450INu3TnabeCZ95cReZIwcs1jVnT56AAWyxOpjaddrjkyP/pDy/36wVKYPAuGpEHp0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznciMzzeE3DODt5ZyUTyCAJodnDwmoOVEuW36jY5gIodRIe4a7
	k4OMtb/GmpGiInGKqOupxwm00Ef9WsBiWxU3RLIph8RclzCCVDcyarK3
X-Gm-Gg: AZuq6aICU68yKsutXaQfS71ANWnHB8Zl19yLJEkhWo8YjyC5c/s49QLsQChulYgTzRc
	KBKsaTO4vsO3SK8p0ucKCcWfTBpBDsWgh8m8or2b8B9ijEhJ7zaYOxkKFGrkUgqmi7geAHm+goz
	990d9wGi6m71nKhBk8xxnLY5J9XhU0KVHkfyuXFAvLZL1OLQvTmM5bHK6LNkWJXV86zIZO7vIPA
	vTvzovqo040L90IS7+nZdWu+gM6YJ9VLw+E+AKy0d5pj3JNNlxWXz1t1+OG1rZdskwqQi9fDeQa
	JY2qs0AyxJA3BkRSY585Bf19iezwxtEXqYTQbbvC46VHxvVwijH6VXH/hLBi5TWbEN2q50aEOZK
	9xjH5zVhLfeQ47UqdldQHq8VoUUFd4EnrsUFGwWMXFT6ojXuGYIkn8D0CpP8VzU7Z5/EioNRStS
	6y1x/TdjYMtmbO4Pvfiz09lkJ77elJuIjhyqMDwrNR+c29OO9sTw==
X-Received: by 2002:a05:6a21:62c8:b0:366:5332:466 with SMTP id adf61e73a8af0-394fc2fd726mr5605743637.53.1771521203784;
        Thu, 19 Feb 2026 09:13:23 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:23 -0800 (PST)
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
Subject: [PATCH 5.10.y 02/15] ARM: spear: Do not use timer namespace for timer_shutdown() function
Date: Fri, 20 Feb 2026 02:12:57 +0900
Message-Id: <20260219171310.118170-3-aha310510@gmail.com>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 80b55772d41d8afec68dbc4ff0368a9fe5d1f390 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions called
"timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to spear_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20221106212701.822440504@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.228348078@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.810953418@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.513863211@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 arch/arm/mach-spear/time.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index e979e2197f8e..5371c824786d 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -90,7 +90,7 @@ static void __init spear_clocksource_init(void)
 		200, 16, clocksource_mmio_readw_up);
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void spear_timer_shutdown(struct clock_event_device *evt)
 {
 	u16 val = readw(gpt_base + CR(CLKEVT));
 
@@ -101,7 +101,7 @@ static inline void timer_shutdown(struct clock_event_device *evt)
 
 static int spear_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int spear_set_oneshot(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	val = readw(gpt_base + CR(CLKEVT));
 	val |= CTRL_ONE_SHOT;
@@ -126,7 +126,7 @@ static int spear_set_periodic(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	period = clk_get_rate(gpt_clk) / HZ;
 	period >>= CTRL_PRESCALER16;
--
