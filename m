Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5E34DB5F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521222; cv=none; b=JzVTqc1CqF040LJD4YSEmws8ayU6plKn+AlnVOu9pfegeBfTEdxqh6ytLvtwLWvNJTcZGUpdPWAYZUf6WnljTgPHJFK0Zq0DZrHU189HPfsIZrMMfxMzABg9i+Sf2kdNanmNMonttss7DiEOjzunvPW2oo0ZLQ5Fwz98l0KBV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521222; c=relaxed/simple;
	bh=p4TRIPhh7eCXg4oL8eEB5Ly0L/lmhP7XDzG06yVs7As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lH7A8C3HouRdbG5B2ktQjrzCvLHr4fi5lR2p+4tTwWP2D+WWXTT0vWl97BKUJPq2WcDGUZ9IbuQppzLidFyY4KsGf0aESGsyiHlSpK3P9En8s4D05SqvnNj78stQR6FJ91tRqIOxX/p/dZ099xFDSTZH0e6nTrDFZX/RbQSU1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKrlFlES; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKrlFlES"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823c56765fdso560947b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521220; x=1772126020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=FKrlFlES6e6BGVghY8oWZK3LyO/CF2mkwPfSWj/5/7ziUBrV/6mOMLEE4QxJhCxaTH
         rYroFZ7raOj9l3ErtFIcEsYuf9wEeRGhKYtOGGPtYx03vQTwlWZ2qQLisyp9oblOJgmB
         nsBL3dek3d9pUUCuJui1cgLaAZFn+rH8uAHED239238h1tkqfP+c/OblFrIFd7cz/PbN
         6wHvW+KpCBtAqEIgEVMMjfwfw5yNViW9z70tJ6nNTQ2EMAUq7Mn8Sgzg8cnjTylhvOTj
         +NpxcrorjQkmpHvYV6nlX0NQs6Mig/akS0/zKWfu2fVGPpKj5HKGNkrqW52dPflxiVvf
         WnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521220; x=1772126020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=YVqX35FVjSbYon5w06IS/Pqy0pfsaaBmuq3IPzeiPH9ZOCdH0EtIPjR4gD1UGiRCZZ
         zmSU35Iw1p/3HHiGLVakK6XPctFsArZextwE/L3DN0GYQHpbi8fg1Cq4HSDFHVHkb7IH
         R09ab66GZLwbZ0NZXKdMnOe42CR2guq/yfkCRJ+Laa2O3coU1s259iQonvNyMRN7G+Cu
         YV42KylhtvkDlY/pSFDw0UDrGm3KZjUkYeUdmbbqWHUpWPkr/dxO5Ow9g1QnU1JmAWy5
         3sNOlQlqff3ZnWiCd+xxIVEAVpfzUW3EjsOPkTXDD5/8FcQ93nzLveFKdhbEb2Dpf7AO
         FevA==
X-Forwarded-Encrypted: i=1; AJvYcCVO29Aot46QSlmTUAVzgOAk4ViQSoulb4otnBgyfJAIWSLUPQX5DKOPAgfare9lpAp3EKqb22SlN5O0ztE464Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9ScY832m4PNihuCeYlaigy1gKOQ0ivjaVWNNbCQ+DX0FCM5K
	exhYQwdlNqYmXRUhGnJJCMUClEssmbVtvPC+dRzhJj0LQ4m5Y0+X42+l
X-Gm-Gg: AZuq6aKBnFMtCtug9kyq/2mc20E/itCHgq6JZIAjESK/niyCFOd9kYgeMd6U7qeZLBt
	qD4u7EXVzb+k6wrSa+tg77UrJK7RcPwgDl19bVkMR+H0AxshxmqEX4921gzQ5nRnEBDkELqkPxW
	pvOq1uH6Ik17jW+adDrHsjMpKIIPQz8CjCfR7tG7aoP4ayEF0QxeZ76QNz1tKzCx1YBx/yZfysc
	G0lUKQzPw97fI9nrScCOtkKGBS22pv5J2KR+43wAs6tHd9GhPHhraZDxnH53oN+IbM/1D8Cl2Yx
	EcMhUSHrCfhUJHwBV7WXegPZ90b/uQBE1J4sWnf7ky7ApjgK/M6C8XPCopSBKEtxBE1LuJK1Baf
	kx3O0uZP//vt6WU0YZxVuVJhPDV6F11erzKSyEIP7YmERy2toKuJGUjhrUcEY1iYHTJViuvJgrd
	CTVYEoBa9vXsykxXACr9Jq3IuM25g9mL7NPZvcXmaS2KfQvJZxGw==
X-Received: by 2002:a05:6a21:330b:b0:394:6023:a0f2 with SMTP id adf61e73a8af0-394fc21a2d7mr5528099637.21.1771521220510;
        Thu, 19 Feb 2026 09:13:40 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:39 -0800 (PST)
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
Subject: [PATCH 5.10.y 06/15] timers: Replace BUG_ON()s
Date: Fri, 20 Feb 2026 02:13:01 +0900
Message-Id: <20260219171310.118170-7-aha310510@gmail.com>
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

[ Upstream commit 82ed6f7ef58f9634fe4462dd721902c580f01569 ]

The timer code still has a few BUG_ON()s left which are crashing the kernel
in situations where it still can recover or simply refuse to take an
action.

Remove the one in the hotplug callback which checks for the CPU being
offline. If that happens then the whole hotplug machinery will explode in
colourful ways.

Replace the rest with WARN_ON_ONCE() and conditional returns where
appropriate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.769128888@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e09852be4e63..7094b916c854 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1208,7 +1208,8 @@ EXPORT_SYMBOL(timer_reduce);
  */
 void add_timer(struct timer_list *timer)
 {
-	BUG_ON(timer_pending(timer));
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
@@ -1227,7 +1228,8 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	BUG_ON(timer_pending(timer) || !timer->function);
+	if (WARN_ON_ONCE(timer_pending(timer) || !timer->function))
+		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
@@ -2047,8 +2049,6 @@ int timers_dead_cpu(unsigned int cpu)
 	struct timer_base *new_base;
 	int b, i;
 
-	BUG_ON(cpu_online(cpu));
-
 	for (b = 0; b < NR_BASES; b++) {
 		old_base = per_cpu_ptr(&timer_bases[b], cpu);
 		new_base = get_cpu_ptr(&timer_bases[b]);
@@ -2065,7 +2065,8 @@ int timers_dead_cpu(unsigned int cpu)
 		 */
 		forward_timer_base(new_base);
 
-		BUG_ON(old_base->running_timer);
+		WARN_ON_ONCE(old_base->running_timer);
+		old_base->running_timer = NULL;
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
--
