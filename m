Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A572FA0DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108606; cv=none; b=gzZt/nFud/e6JsTCBmVHHu9MuDb1X3PwF3fDfLhukiI4p4Xq0bDFIoRXViadNrG4UyNMHo3GHIsLUo7Q+BqboTUxpB3Q5mU40TcQ4rdf0W6D7xKuabT/IKHwnyn83uZmEM/PIP16Rb//+uFRN2HuSikS2diErbBM55kyJONkhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108606; c=relaxed/simple;
	bh=p4TRIPhh7eCXg4oL8eEB5Ly0L/lmhP7XDzG06yVs7As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imozT/xrbpM6PO6VlkEXCjLRoIGyse/XsQSwr8qqshL87y7OeuJ0+tiTBoIvJSgy7f4n5e6QbN7Ii0SNsfGFPGI+OeQIRaPWRdR3OmCDWjRwslu8l4GnCZeDXva6ZXZbERQeomtIJ/blCHDgNiDbjtK1IbG/NKsFOV+MssyI3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrfMpSKU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrfMpSKU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782e93932ffso2065928b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108604; x=1760713404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=lrfMpSKUbUjEpAhkOdhyxOzbwWCStTQD5zINmPlgCaAjvcDQNF8b6fqSOzagx+8xrL
         yn4rCuIJnksruMQkHfOJxaxTNFJKkRL3QfYMVFNwLW11Fuf6ToX6EHivKBDbyqN0HWNv
         wndMKDHC/YrMBQK5ZGhAuP7r7mba9cc1xDXYr7VWrTnTTCiSnEx0UFoSGO6pMnore1sg
         SaaORTKpLNnHa2JXAe0hTiXD/uiPd39mkzaKA5j7jWTNvvolT5t3CFIxDsKhqeOEY8h/
         fWdSEGTjIRIOVr+LC0My0gzVc4cTYtncixbekm3uiazrk/cipyZSFCqcFOeNxwGDF5nF
         H4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108604; x=1760713404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=ZhZeTtXiPTZTkBESHEvdBsuf/LIgREuKDbFfH22dM8ZXN29FmfpAXvQ50ZUsyAPnrU
         4rUNwLAAdoFkNTYpbwb48054u+lMzWeEyd9Nd07ESZ/Mgu63588fkcwgmNDRO/Z6Hb37
         rsu3szq4d/7/Pgb6wKhminFzANMAH8ZPERqICwUEkKiUH93F7wkOaSSz26zhy3xjM8tI
         jvFNgbrzOwZXHVdBS6JPpN9K3kBC4aeYlz1KF6hQVw1p0s5YFDXeW6jIA7gF9r4j6tgq
         8hjIXFA4vNtBxSZHYChkspi4VGVRNPd4eMPmryW+vmJby0a7EezYqiOlZWfv4WzRDdPD
         F5AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWban4B4cnOv5fYjpXGXlUrkS3GzS1dCdZsomYvMCKopQIggJRscAHYQJ0Wq65eL8wJaZfR3sUsaXJ/RQef7l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsyx3cwlgeV9jED5Da10jvEfR5jlsPc0BHNKSys87fM0fsUeNf
	t6NXI8eTlhFotqUZyeFpNtOWq5bkhW2bx5HtXBMmnEQAUPNQXtNQ5Aj8
X-Gm-Gg: ASbGncvFdSrch3KgdvJFMHXtd2/s7suCtOBfzS82/hitT07vzfltah/oW9PrclDDidw
	RnzWfzAPWn8WExJtQmXJ72vx1F0iP6jmXlfAJOMOoUum/qwWjOqYezCJatHISApUWt45yO4B2Ol
	boO0xd8mVrrcLkH2RBHXUpO/+yNYlsiQROtWVAJMKMW5tUSmoupJf0KqMehegtYWXlf6rhuT64a
	PXG9lzr8iZyLKOXQopvgof0L21YTPYi0FcKyq0+98+cPv4qAeg0AvU1nplCSeDNneMqjQ+RSX5f
	WSLJZBwU0mnfUJYgsJ0OebPme901vL0tL4MWKtxvnyvsajo59DeeFnrnH9fWw+K7Cr7rPBkVY+F
	eUIHxgTgDqZuH6Y2xZjGmOeiHkV2NuYFkTHmxPI95owvVcbT6hQhn3kdmjdSojDDkBuiEz0yh1Y
	MHRHM=
X-Google-Smtp-Source: AGHT+IELW+N04rDkMObEwVIfZgJNbEyKA3LpK3B2L+BmTESRw/chxA53UDFR+d8y2R41yQMRdNNmzQ==
X-Received: by 2002:a05:6a00:992:b0:78c:99a8:b748 with SMTP id d2e1a72fcca58-79382a7d3femr15159457b3a.0.1760108603729;
        Fri, 10 Oct 2025 08:03:23 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:23 -0700 (PDT)
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
Subject: [PATCH 6.1.y 05/12] timers: Replace BUG_ON()s
Date: Sat, 11 Oct 2025 00:02:45 +0900
Message-Id: <20251010150252.1115788-6-aha310510@gmail.com>
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
