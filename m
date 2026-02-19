Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866734DB48
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521211; cv=none; b=qqW6Bq1vm+P27VW3dGWCYFRCve1oZLmq22zR/TzrsUDmkidvOLBnXbw+IhA6SR4KYhTWMvYzb3/XZc0rGMAV6dX1DENsuzqoA58xpIxzw5SnI+kgd8L25oPJcwoGDx0AEhum92JLKd3mO6VnXI3IEJ5Inqvn4nl53igneVL/3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521211; c=relaxed/simple;
	bh=YY7i+ekw8WEClpFqVZfbZbIPcOFXG9mqoVtYSHhdgrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nWwKtnLFiQoYZDbEnSuO0e06aAJ6Wr+OiyQiLRS+5vTgTS0UosNP2yX+sn88kYkLsQLW6sjf0USX5Iygm8f9mjUFUHikSi+ryZkAWwCWoEIqBkZpcEVU1s2IUptGgwEWE44euq8zxeu9ahSpoBtZHCGjkVL5Mbnuqx8ca5gq+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR00ZLgb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR00ZLgb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-823210d1d8eso693814b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521208; x=1772126008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=jR00ZLgbANM9QQcV6D1qJrZXE56WthEzEZ/6cBIiXYM3oppVe7F9M6qiq0g1aTyy2U
         9RU3gzgybGUrlFOclauBaMFM8Pjri1YBXFs6zeIUMulSYXvkaxlRxVNUEqXz84QS1hlh
         ei43FJYHkEf/s/LyLMUYeAJT6UXdpxzPc0EFg273eS9dm2LNlyQzFehc+3Di0C8MLDdc
         LAdN6Nw14anWlSnNvDX90x23v4ntd2aZIhv/nj09v35hLvtXYDEGcTHweSxR+OIcqXy+
         IUKj2uUNw0lwKvRbXY+z3/nqZEX+4oBXsmBsZmSSfwASZV5ZqWS++Oaj+JPn6iOUE0y4
         uN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521208; x=1772126008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=sT45uk+KtJEDHLhYsDs193pfhjjJQCywJcyXgKFndud29SmyXMePjrQEVnCa0ywNSH
         4aHcvCT8BVFNH9z56Mn3Juy6dn+khFnv0w/ARp5y8Dss2CNIn9roKi6lX95SxsgyXUHF
         CeUVdZ1vek0LtoltldrKf3UPTmMzWCUzRC17elVE7U0cs3Slgs1G+SnaQ9+S4Bo8Yobl
         c/PcozvAOU/aOjMryaKT84xTmnUWuD7rK2LrM1wnW65elp4PXQs96y90DEivcYcCCCsV
         8144n+bUdFwU0q/afQb4yKTALID6vx+NOVsDydDQfX4E9sNjsm7cbSmJhSACALdwafya
         4QBA==
X-Forwarded-Encrypted: i=1; AJvYcCUl2LwgFk+QUxOYWsWYWS2a/mTGSAWTB9DXnsxxdw0X6xXO6WN7+rKKwQso9aSMsW9jwumC/irr/dOV8+BYiMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOCQKBlln4j+DgWzZ7GSW6OEcWQyUk0xwzGnODYqNr0+S95/3
	+dTCismlgD7ZGiLmboF19x/Uepscbm/Tf4U+WpE/J8rAt9d0oPtqoPTr
X-Gm-Gg: AZuq6aKguE3QQR+N5IZdymDsJkR/26xBnjHi+1VZ5quQrlkvBin7Yl6xxpYp2GPhsmf
	LrvhLrYVdoHk4rMoPQPce5dsjgRoSaJ/uz33ULYS7MyV7soOespdQ4LVGalNdXzsLsa65prLcQ+
	pQqYgOMSDI8F+T2CuVFTKc/sHob2NgRZZTYXAaaYqdITGewmKQLav3iEnmnlAHbAhKWq0MTFT6T
	IC4IVzitjHnKMgGwOoZBt0qiRJKX9EFhKA/cgIvVuTG1AqEr2qg6MXaJXIdbcZJ7UtYyji4AYMj
	BCEuPPsYbK34K66KWylRbuobDQyW4e55m/Vtn4biJeQyl3Nb9kPaX5yA4x3sx0lgOtchX12gpKR
	qEuL37GPeYdypyLFDOzmue+JmS2OMxRjX6IngAgUlDgwGnqSUXW9KNUV669c7U16Fh13seWbArU
	E1An2WK0WXoVSKVJBOG1dmd54utWkYe1xs4abcXgjMBlDoxqI/QA==
X-Received: by 2002:a05:6a21:4c03:b0:38d:e9e8:25e0 with SMTP id adf61e73a8af0-39483897793mr17324026637.20.1771521208129;
        Thu, 19 Feb 2026 09:13:28 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:27 -0800 (PST)
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
Subject: [PATCH 5.10.y 03/15] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
Date: Fri, 20 Feb 2026 02:12:58 +0900
Message-Id: <20260219171310.118170-4-aha310510@gmail.com>
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

[ Upstream commit 73737a5833ace25a8408b0d3b783637cb6bf29d1 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to arch_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20221106212702.002251651@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.409832154@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.981725531@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.574672568@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fee1c4bf1021..ddcbf2b19651 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
 	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
 }
 
-static __always_inline int timer_shutdown(const int access,
-					  struct clock_event_device *clk)
+static __always_inline int arch_timer_shutdown(const int access,
+					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 
@@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
 
 static int arch_timer_shutdown_virt(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
 }
 
 static __always_inline void set_next_event(const int access, unsigned long evt,
--
