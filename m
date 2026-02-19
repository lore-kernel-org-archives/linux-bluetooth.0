Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AB34DB72
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521214; cv=none; b=n3Rjfn1wKY+mqifnskq8eypXza/B2BD/lVRsfqvoXyB5AQ34kptlfzd9p+5JJcqyV2cNWw0aBSDk/4Z4ViuxAcaEbXZThhYi3hq+Tya1ORlg/kiwqqQmA8/A6x5KIUTeKZf/OVg4ez6VuLy4k6rnwCsZFuWM7OYED8wsY3/Beck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521214; c=relaxed/simple;
	bh=kyxULOv2H236l1ucHIwcTRr5nnWT32c4Zye+wWGrJ6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=araVMY8u3gT6z/5fNPm2pXSR8zURAkDH/ssKqhs+oyQ2QqdMJjqPT3+h2tyf8KD3iJ+l9qGGJZWbGc53IqYrOg4qd9yrA6hQ0aGJTr0Ql8FX/Rzku37LCrPHEccDOvkNKa3z0exgFu0p2DyAML5ZIAp82IA5ZuOuwzn13mVoFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Bp0l3H; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Bp0l3H"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82491fbf02cso631765b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521212; x=1772126012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=W3Bp0l3HAahee6jM1ZFsDQY48RFSKlrq9I2k1a0rW5Pr8PGi0dstQu6Ye4Pwlh//36
         vyUFE2XWfsxvdUjrh3kFAWNcjJgBWHineh1GaJWMURPIlIPgyKh9KrSqcYQMkdLPrG5N
         HlHfPj2BGJ3H+I/JXIwjZzZH9gZTEkFMPrgomSWxZq+A6igRcS7FmKMnbh6K0DudrhPM
         TjLf/lqvebR+svC8AoIChIaxlUlM5H6bjQrRPFHPlM9lkluXqsq4gCA3Rn9z/9kXgUza
         py6/waBbNlDwJ00ON8OIXF8dV0lE7aKrJ0O5hOxnT6fL0EZRJWDKp/hOMVCVXgcM4wcv
         da7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521212; x=1772126012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=Epw3MMlWgFp4ALrswexbc+81KehCPJjqMrJHHGRTq65WjiDakpFw3HURa6J7y4Xszn
         VnZXZlJyD0z5sNUgaXA8z63dJTTo7E+4CK3PbVIphxrEwOPZEttK0pPc2KHjknyYihED
         Col7tY8/FwNgp9RZgQ3Qgxp+oa69s09Qqm6rp6XZS3JforsnR/IJCzrGG8QRuYWipzAC
         a76yBBd6h28f2yep69HmUgP7HmQ2oo7K/uZv1TFAQZtGY0W1MvydvL29Z1h+nsTZgpha
         9ymJajHFMy91Fjvmm1/K5s5CafLgWWm/4RunIJd5T9TUBKShzk4nq7MIKYbGPuA1WY0b
         5PPg==
X-Forwarded-Encrypted: i=1; AJvYcCUaTxZp5l0JhetqAIPVFdWwE6sbNO20GJV0Veg+WyOFPAAjkEnJPuIcDaMH4fj6Ga7DS/E9idpWwo+JUUCixDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6j7veID1vK53VjVkBY6f9bCcxzT9wCWnrQ4ag5YpGnVygHDj6
	lbhHAplq18p01RBMfA8RRREWO+oJE7Oq8AcAYtm1LIq5lsuGek37S2a8
X-Gm-Gg: AZuq6aKAo5RKN3dyMi2X/SImFYkPcBpMMeUU5iHZNv3/g2vZvr47h8I2RG75FDwM+TC
	MGvGA3D17zTmWEz+pzKt+Hh/XRLr0nA+WIcjKhvffSKl2n4igAHKGK4zqlCiDiTMkC4GEgY1oPC
	DAC6XobVzn+IVay8UAA4k+WQ3+lRPyna7STLqhVKm1GPo901IuuZCWfQKY4UCs6febKIdkJQeHU
	0UGOORS7s/yIgu2nLwLd+lev+mST2k2luflx5/WMAodvtn735MBoBb8ufYleha0D2hRJTnG9qCF
	xWPfcHzG+L+MwAUapOpuh+ZdNNCbdpMU/rRIYtDBUJ5oMd0rWgAiY3rV+0zO6bgBBwi/Tfdnq4+
	wvjBPJ7NwQAX4oDaobNingAYdYz67GgUomx1aNIlLFQfB8CwQT7psU4iU7LJpSNMG8d7HhIohFh
	TbTwwZKWGq/czM8dlRo4pZKl/QxwoOIeMWRyOE398zlXb1XDIi0OSNUOiAhuWE
X-Received: by 2002:a05:6a21:1645:b0:38d:f08d:b349 with SMTP id adf61e73a8af0-394839d554cmr16555786637.43.1771521212312;
        Thu, 19 Feb 2026 09:13:32 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:31 -0800 (PST)
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
Subject: [PATCH 5.10.y 04/15] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
Date: Fri, 20 Feb 2026 02:12:59 +0900
Message-Id: <20260219171310.118170-5-aha310510@gmail.com>
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

[ Upstream commit 6e1fc2591f116dfb20b65cf27356475461d61bd8 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lkml.kernel.org/r/20221106212702.182883323@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.592778858@goodmis.org/
Link: https://lore.kernel.org/r/20221110064147.158230501@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.634354813@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/clocksource/timer-sp804.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e6a87f4af2b5..cd1916c05325 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -155,14 +155,14 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void evt_timer_shutdown(struct clock_event_device *evt)
 {
 	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	return 0;
 }
 
@@ -171,7 +171,7 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	writel(common_clkevt->reload, common_clkevt->load);
 	writel(ctrl, common_clkevt->ctrl);
 	return 0;
--
