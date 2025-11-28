Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3E285406
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345960; cv=none; b=PPbqPKGV5mNaElRZITC5j2RxHaOIvcpOFwvAKJgK/FslH7T+FXjK+VyewJR07ALjFkttWFSmiqQYNCRLMmcRtQdZU2QHNDurY6vVEDXqjueQBXv1iOYsb8/nzJhhaZjACZEFLXmOjgUh1is+UGYhwyJoxVQ33D0NCNSU0iLCym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345960; c=relaxed/simple;
	bh=FgQfbLiyDT66S+sNI1wE/oslfO+pvzybNJFnYppNieM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5ZZwedyewPzLagfKtt24dTA7f78ok/drgLaJQU1hHaAH5AKqpm0yc6M8pGgabNIeE11Vy4gEtdFpYqCJCfgZDURZ77Mhzpf3d/dP3JAwrSxHz/P3jzKUPycQwqi4FkuxMCgJaGCboovkIvX6Ja59Xw4tsByQNXk3/BUIvOEi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVsshIDi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVsshIDi"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so2529237b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345958; x=1764950758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=UVsshIDiMTeVetzWcr46lZWBkHx5enSo+AAFgzbi5/pbetdKdEdL2LPflg7bmTqEVO
         npp/7O0T+IPGSzY5kZ6nLE6nAfYVqumDxspQr4yxnoIfPHZAa992pkpNlPGAjYu9COeg
         sTRNThIoaXK8yNO6mJGcGzMm0TT6r0VNwsnlSj0QX+IWgiUGKdPwbee0qGuKaOQ+pATz
         0/Le1ChtWm1VN3eOOKipDtUMm/XWN/4C1FroPL4oNOXgLP4wVDJjGR3TEwbtiFcGgZVo
         pcbVs1G9qid4+LbrxPKzNNG/C7qDgZhMS8K3iPoy2xg9P3LBAmDe4hXWg0r/yVQHVzem
         HNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345958; x=1764950758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=KBVWaeXd9RtNC8o6LR3js/hvahulyl/6PKLPeGw6U+HBUVMbC+JbNgm+cFQ22zEDBQ
         MXtPR5D02+UmzDdj2TlZQuFXI6sRlQ/dg6Ta9pvtxQPxdxsgZAP/k6ia97z0DVWKILLs
         uJtPmmN1okVpOjDqgOLha2Nb1hQBYfv39zRlKsvAN1AfzhhoSFUdMKW09PSHMXYcdeSK
         dYM4ax8dsf4uLUzxt/n4zrdcIvsS14Posdt7x/BrnpeL68WmFv9deNRioxcjHSyLCNwX
         zQFxtP0thlD0Ld+y4URXFLXbEfbKV7vDk9M7wagJrAqDpXM/BYBTXma8QarL67SbjYaD
         GOng==
X-Forwarded-Encrypted: i=1; AJvYcCUkGUceLeHX0tEjCk0kfLXRoV72psYReBT3Twk9CEHc/ERUNn231FfqjOJXhwnU6zCnBxlrpVnpnWXt8WyHRzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48miwsBGy4B38DfB55IEEzHtjndoV7nrTk0cTgGQVAGhKVxEM
	4o6IEKCcWWg3Qe+sbwJq2ivsAABUBmrpmkaxL9eZKmIQutTg9v9lXgQJ
X-Gm-Gg: ASbGncuqPfj1RrGnoeLrWJEJkGotaMW+Ee3iSXuSP/djNMRO3H8wal9r6IvTGdwcMMK
	jIwHxtR1dMgv6sDnPgnbjBqc5H4HDHi9pUiBMWxavLD4YXuRAdTBEgzsnR8byW9mwohtOM90Zdx
	jRSmeBpozvEaM6w+h+y0g8b9/GM+66ykXJoMEIBN5CgCbKLGasVIAwXbdsQmQv4rrE0ROC7AT/3
	dBbchTc+Eoo9m81/hd2tbGPuAe7cLYD7gFzCSAPoVlhILaZdPoeHNoog9lZ/gm1qNaLY4EugpuG
	kYfNzZWjiFRXGtrSZBSh1b3DcM7X2V3c/bxMcILrmJgoNQqFzb3DezwCZFl6I4gkM0bAuhe9iet
	boKriGu05aVh5tX+x/7zbmrV9Du7b9Y9dh2LphXERKOHpkg2ZDi7jYSn8Zoim6nlfB5Kqw6UHfw
	iqF7F1wUEZgpbrb1DnE271Xqn7bMvPrkwapF2xqQ==
X-Google-Smtp-Source: AGHT+IF0Q8QvQVgk/GlOhROATsy4H0jZvj77M4n2inngSNShmeeB6QTjv1ds/QlTk5r7jRniqk/a7w==
X-Received: by 2002:a05:6a21:99a5:b0:35d:53dc:cb64 with SMTP id adf61e73a8af0-3614ee0a109mr30924321637.54.1764345957992;
        Fri, 28 Nov 2025 08:05:57 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:05:57 -0800 (PST)
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
Subject: [PATCH 5.15.y 02/14] ARM: spear: Do not use timer namespace for timer_shutdown() function
Date: Sat, 29 Nov 2025 01:05:27 +0900
Message-Id: <20251128160539.358938-3-aha310510@gmail.com>
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
