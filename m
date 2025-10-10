Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8302F9DA2
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108601; cv=none; b=jZnriiQaqEo8CYdD2BsRAO1RN2ZBMuuErXYIp92oBTzujC/o2XLF5kG+SCXn4u8oje6BwTmyP2JX5e8LmOl1jCM6jeQVQEN3QifnDkNn0WUHFcUkDB/+b02X1a42rvDI2CDF+YFPEtj5DtHXjdXjvdCe4og5QBaqDaosfWSMwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108601; c=relaxed/simple;
	bh=kyxULOv2H236l1ucHIwcTRr5nnWT32c4Zye+wWGrJ6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmE8SHFQT+AgMdxliljenDC/jVSOoP3W0SLCH08vU74HmLqfRDkceYnqaiUwb4Wbtbwf5AsusV1+zoXs3bMWNirqbrxQpS2nLY+b6vj5qAdCQKQ1SRPiTI5D4Y60/iqA5NA6kH7fhRud/9jGlBT5PLVazv46AyP+IlGeHwNBsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su+5/5Ih; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su+5/5Ih"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso2194377b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108599; x=1760713399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=Su+5/5IhGDJljNWqvdLuLQXyqkbWvf2cbmnmjD7zjzywNoFV80FhOQIm/b1p1OfZBO
         vk35gqHf8PUvH/ZZZHgIP2CqeRLDHJsFqgGadCIn/QPG9BdjsEyUeONZUs5FXCQVI7RC
         RG25CKozBZaN7DTNR3oeC9qh2I1a9rbdjMu7EXSaSX7/uUvdAaEcqJBsqS3cTqqrUOu1
         6U02NccwfSNp51o9E7nod/5yynsZc2sWPPERn1Vdb5j+zTCejT4bOhSggOC7uprHxnxZ
         v7ZZwhwP9IXbF2Ijr+rUpD+wAcq1rD+2wN9oHLUK/ZsYoo6T9wHP1XBuaxfpPIS5m9Rc
         20Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108599; x=1760713399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=uHmLmNr0rdg1CSZnVA8K/NGoWZhCrn6bq0D+a7PR16MrvJ+6dEBGA2//lfwNaXduuK
         q0i9Mhq9zHLUKZ69LIWelR5H5o21zoLLbMf0eonqz4QJaKxhCSTHHjtjXlntAlQPT8tS
         mBlEkAIL7rYlfbBp0F/gtueCCk1m5Zv0ur8Hftkfj/ANr0r3pxFWKcd9MxRTJH8H4xoA
         tU3vMwRxFf+yu/g/2b9StzIm2l4ZSxEZPPnGOHufz0E52DXuZk3OPfV2LTMXzBLX7+BH
         q8VqkfKbM9El/Wrxkcnb0gXIhC6+xC+DTjLhIDZMFpEACdqIdSe0GwEzG+UuOzb0pzjj
         P/cg==
X-Forwarded-Encrypted: i=1; AJvYcCVrdbWR5HPDPkCgui9HzFF5bKH1c0AinPKatbbqwiSwvQAJnWdJom6m5DNLk2EnCl9N06YIcaU7Kf3axsH20KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9dzAFjXplM/FE2uGZKXu01F/zQd4LJwfwO6R2uZoZFJXSbHS
	vkcraj4EZPNqItYR+jW2xqRasNDcMu3OoQaJ8DK9sAkUO6E487e92YJcmJjhn5eekQGBMQ==
X-Gm-Gg: ASbGncugFcN6Dq96+60AE8vSvAb+0VxoPyhX8FUO7sVCU0Je17he4bgwUAu6P/lFomM
	Qalw8l6ofCWk8M94VZCVK2It9coIvePpRPD9UuZSOrWYPHQ93CbYZPw01PTnONgXsEj2ruKfWfo
	th1NjiD7RbQrZPIprDTX4k0lI/dWczv2xFI69OSQcH5g++IyghqgG6+0mnte6UjyfQoT5/TKuqw
	UwfpKwlMmNg6CbYd7jeAPY/h13+y+KdbfKN/PFv0mq2zmZHCHEWDIbP/JPD3qbijymFQGYj/BIx
	j48xlUZY9Z5x1Y/sXeGSAKVuuGRqkbx2dauX6iK8PlXs1f/wVO6CmrWsB9SDPWbV1w6os7fMIcf
	MkGx8FGE9wxdR+EpTFXsL4SfJuhiTX6U0JSj9YEqkSS3vnH/LmenNKHxKaFRai9EvOtcE
X-Google-Smtp-Source: AGHT+IE1TkwVHA7tUUhpnxMC0Ew+qral7pJWbGGXX+m1f8imGiLvrl15HPVZo6jvgfFxLbQ7GCafnA==
X-Received: by 2002:a05:6a20:7d8a:b0:2fb:62bb:dec with SMTP id adf61e73a8af0-32da83db679mr15075982637.39.1760108598855;
        Fri, 10 Oct 2025 08:03:18 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:18 -0700 (PDT)
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
Subject: [PATCH 6.1.y 04/12] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
Date: Sat, 11 Oct 2025 00:02:44 +0900
Message-Id: <20251010150252.1115788-5-aha310510@gmail.com>
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
