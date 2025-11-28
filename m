Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65AB302CA3
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345971; cv=none; b=fURvrI2sUAhNcY/rgmrH1MsretUxJXC2LOAZUX95oSm64cefdhEmGuaZGPrV4j5O5011wAg+OxlB0nOYWQlG6UOEIwE4ixTjRXXTuD7jaow480do9vCRIZxzwXIvvlyiqowl10uAlvqmobG1v8sS0A7bDRqGc1qjwFLs53TrCM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345971; c=relaxed/simple;
	bh=kyxULOv2H236l1ucHIwcTRr5nnWT32c4Zye+wWGrJ6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RZ3yDN0tzzdAiR1Ae2Ex1zfzYyCg1ZNkiTpDtKBz99W6aIV79FKzkcpoKEP8jB6x+LTpKroQLie91odWRP5t6cqPwjWAVfU60M2UMi62BUY7JEvWDzAoBjvvk4nTm/pMT39YsvqwZtyPxy2du8Dz76rcss1IYIL7maMiVDrDoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyM8s1BT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyM8s1BT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab7623f42so2211981b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345969; x=1764950769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=eyM8s1BTMyX1oGBZTd2t1P1Sx1RuTJrbg+m0cp5NyI2sJYl1ugBXBoKpIw2rpIQmwa
         Lds5c1D+utJR3kPxXcuFKgEWZu97e07x05cY7Ls4ufsOGq9EJTtw9U/RmU77tDD9bm0T
         ex7NBkL4LlXZlBMS1dhTL0eLMVlgshUzDujvTzXcI2Ps34gbfyhWpWR44a0HAOsL/1iE
         di931BFELJCQKjZvHPkdakotzHWI/d/HR06uV4drCQRpcNcav2uvPAHGEx7We1VoS4ei
         7SjWggvfV7dYefyAWWxc4X4P1STNylUQA6JqTjD5VDys+qhSSqQmpnGqN8E749ZkN3UE
         CseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345969; x=1764950769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=AEbozqBCU/enGCH2hKAke92RquXO5SDw7OYc07NG6yFnVLG+Lchv6/Lfu4lTS0hTB5
         jf82cORl3aWooE89NrRASRmgOVH9j+XFDg7mpa9bNJg3Z41/VdTQLdMZiVAmY3nzpniH
         OtXMvg0Ma9wwu/6JgkoNzRhA3pz1QNVSOS6cyVBT+n/F02BREhEmf0+XRZ5frxIZ7C2b
         dsdATLLQAwdCIUmQc5vByNy5I/MNO+NSUAlopErmGQ9ytJBHAgsMtKoi3PnPQTwNyEXE
         H/16RUAORHveIPeWWYpQ4TZMBhjvoggb7QqPupXEKpIpJZZ+hWKCU76FYAk9FKahOWNn
         tTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGak0tGGq9HzEdAmPLZFmPS4BX8lW2EA3Yot4OhfBXFqSDF9DgBRU2uXhDmF8cJKv6kEZ4M2lj7IHgblcMbyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoIizaK1Un9vxGO7dEI7ngYPihPLh4KMDwTK5p0ZGed0G4B6F
	ri//+6GHMOIaVnzjF9xgQfQz2ybbTP+t/eik8VpfRadj6steCCjyl8PW
X-Gm-Gg: ASbGnctsopAp0tcVDhme0AqvtHnOUh7cpvNC87E3S/l6NZMV+c8V5Zadh6JH3p1FcHS
	vVTRimnwUZEvIrknWemKZPQiUBDV1PghLokgqcda/cAt6gua5qnoS+MySrnXFKL4KovPGkQW9Rn
	rZaj2QVT10+/m6VZ5CjX+hFG+Rlx6RDXyezlL+TiZaZhKVQNLiqMOFOj3dZfp+kUa7UoZSQpJJG
	0VLklUCX1yj3g/Pp7e3Nmulu0rP/hbMVKpubJQsitGZu3kZoM6x/nv8gmE11x3yjhwYec7NNRbl
	Hm0JQbdJ7Q/+ruA6XBzEaarBP0iXXP+5KoFVR2XyLqdfMI4Yqes0TmOIwnh43PtZ2mFdF8PgETS
	EERK1XbdTm/YuaG/s7CYbEh2lqmoJ+K/qB1ASVOtAS6kMnQdsZNP7UsxHMi7yG2+SGqOgNzDYpi
	dKVPc+wJ55i4825ILOuD/aRMLNdGWMvE+4u3p8Ow==
X-Google-Smtp-Source: AGHT+IHAtGLDzEpjYjWhaB+rR7Dys+EF0UdlOe5GiYObNTvZAonn+cDCVIEt6kBF0Ch2hk5wj+FaCw==
X-Received: by 2002:a05:6a00:b91:b0:7ab:5d1b:2d18 with SMTP id d2e1a72fcca58-7c58e6047eamr29577558b3a.26.1764345968898;
        Fri, 28 Nov 2025 08:06:08 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:08 -0800 (PST)
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
Subject: [PATCH 5.15.y 04/14] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
Date: Sat, 29 Nov 2025 01:05:29 +0900
Message-Id: <20251128160539.358938-5-aha310510@gmail.com>
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
