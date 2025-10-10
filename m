Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C52F7AB8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108591; cv=none; b=SoCiRqLAt9qhi5U/HYWm1gV0Xot8Elko6yxkYc2OIvwCf9m3VRcMAw1eAQNqEl1JVNDM8Sc7g/WaMMyu5DJOBOyhlANSjA3+YraCBQbW3wPisGwUZDQA8pvV/fyxcKBRGwc9tpK9axmOapPBMT4JxJphvm34lGla+zb3LBA4ShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108591; c=relaxed/simple;
	bh=FgQfbLiyDT66S+sNI1wE/oslfO+pvzybNJFnYppNieM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTbStsMOTv+BxEPL6ojd1bkUlRIGTtXFLErb5zIBK7By25nbCV3Vc7BUHUeGfyT6EbykV6X/WXLoEr2WSUDgfpJyhrmkaiQfxXQFzKCtbYpwD7YCgKk98SJxVEWxSD8Qez78SrVxQGF3VmopFZuoMwi7wkbyogWumdNNiKMHWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpWrckV/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpWrckV/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so1881805b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108589; x=1760713389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=RpWrckV/JP7K3rBXqLxBCPZ3r+/KHE+Zva9B+hQ/IpZyvb9ML8WbUa8q/esCb2fb4y
         ymlmTU0QbOJlDRiqXD0JpKBUcDmkrAJ9upSO9ZF6NWWmhx3PrAPRz0Ah3/fsPaoVHi59
         NK6Pizz6h/bi7LjWTOMf1lSdl/txsUs5vF0zKcEM0JFe2qYLg/eM5lPyM7TZFNMRHhe+
         A+cwnS4gZ7o7opxLNINSNzjGJlHOxnFUG4cFW/LnEKqvGqV4dfjCSNYhg3zHCJv6ktl1
         l1Dnju47/ug9Zv7TrKZ/cv9mld/mHDw562LCLoXgSN7COm4MzXa90Ye+NiSn/XGoHy/k
         ok/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108589; x=1760713389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=NOunDEuiSZHnTOYlIA74WfO0leg9qv84kOyh5BCQjI39/b0a7SEVPwoVtleOiLgcV4
         t4KM1lM2Qa5mJJtXzmvN6tObPLVbWVULk1fx7UDj2oS4thOF8ZHs/Je/jMHdkYNz4Rs2
         V6lfInn08WfuDMEAifZ55UDIPursDdq0GJPmbedLdcca1VMJR6zw9tSVFyqnAdNcRFQm
         NZbxzq3vSqaeffbN8ZD/z84TSUS10VO3gxrEORGVRHD0Vkb+a873EkzwwAZiK9qpkD10
         eD8ZHIUIAMxlOyY9wZBmJzSK44Xyx9qnC4mYj4DhUGL6jK3t8HkQXLoR0XUzsEjj9mk4
         Gn1g==
X-Forwarded-Encrypted: i=1; AJvYcCUbiaXId2wgHzG5uzdKd7PXhYvJwmMYEcfC4/QanrZNRVJ62T/x0ouU47PAgpJ9ZHaF1iDfU95JItvlI/qMJLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHg6cys49z8zv4wGnYcWivwQE3B8JV14Tgkxi0jU/WNzAm3NGo
	dHHhwNr9PizIUIwzT2J+A9y3ft19Q4270ahTWN1jaVm1rxKecln8AUbV
X-Gm-Gg: ASbGncuOEHJo9fJCijzsPZaVeMgJwKlhYzFRrqUNBa2N32FqUptO5mPymGJwnjY0Ojt
	O9hME4Gngn2vScloK+oKLScxib4ETvE+Ibr6IFQ8hChxUTy8xq5SL+yQuDIvDLrPfWrwWU2jAdE
	NQtxQAG4tT6dzd9a2Z9FlBR60Soco+mSfXmq5xmh/lR1KsmTVSR7WIv9p5LtekNCnAvtd5/nRgG
	F7Bdf3AVfkK1Uuja+7olvp/0Ra0WqP0AYoyOw+OViG+N36avHr92xUOx1lJvD1FZ639v+3fL6tR
	c7N7froBDtrSf0PvHW1WwurZiVYxqr4sAA+R73qHJ/uNGt8hnUsvvcJcyHGnwIox2AxTGWU3tFS
	fmBhIvceAkP2308eMwo44D8wSBvb7dfv30z6xOtYObwjcnIo/1OQ38cmOh0RD33PqoO1ycK4XXH
	9ja9E=
X-Google-Smtp-Source: AGHT+IGEQqV4pmO4XmsOQ15F9bsuz1pxj5V/e0Gc4K06vCx6p2KIreXiVTGYqdNwaxkJG480WOWOvA==
X-Received: by 2002:a05:6a21:50f:b0:32d:a8fd:396c with SMTP id adf61e73a8af0-32da8fd3980mr15459388637.35.1760108589350;
        Fri, 10 Oct 2025 08:03:09 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:09 -0700 (PDT)
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
Subject: [PATCH 6.1.y 02/12] ARM: spear: Do not use timer namespace for timer_shutdown() function
Date: Sat, 11 Oct 2025 00:02:42 +0900
Message-Id: <20251010150252.1115788-3-aha310510@gmail.com>
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
