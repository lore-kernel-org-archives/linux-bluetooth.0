Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD7352952
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521252; cv=none; b=f2ICnVQYwDOA0Y/ndrp0M+26JDO/VL2p1NmenEgZyb3mszx5C8mbbitYf08+q4V3s35M4kf63LHDD2zIl+1EprUKbLe0tlOOIb+peHM5VpCfohALeKO/hixteRTyZTKx1vwhJi0AB6k6W1DcDrFGvq61KFHZUw184EmX6v73eo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521252; c=relaxed/simple;
	bh=KahrOTGFxHDsPLdgeyQZNnXk2bivNdYNaTpq/NJnvcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2UB7PyT4R8tHTI7z282eVfZm5Y/qi7ahk2FlbZcFuLTm9kJvXI4qXaaKO94ragXU92KL+A/mz8J1aKoH22Ct+Z+dWOslve2+J3DClMONaHEU+s/SlYIDEUOoYEN0Puxf/RGvRz6q2oUWkr1cm3qt78Wwz8Jd3wAJZk60AJ1Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+y3nH+5; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+y3nH+5"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so768877a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521250; x=1772126050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9Ys25lUX49p5aMZ9MF04Fc/6uWbxWTtkfKKvleWffc=;
        b=H+y3nH+5udxeJPaKUZRwmeUgCmqkm7YFHPnKJTNeDr3CfyNHftRhVT40mM/Petkfby
         JZUa9gBuCzTIEqAOkBue2YF9cPXtetwjNWQHnSKrtit/9mtFTjSTma2/ZwrqeZ5DW03c
         cOJ5LkbTZxAHG7UA0XvpzH3YSzmit8QsXOTyWxG8vpTX0j2QEX8jEsH4N0lsu+UVNt1K
         oFjhWbPktQv0rpIqayOEuhg93WaLjpJymoLlmVk8u3F66eBkFmfJRwDfdJbmWLBsdHJ/
         fiijiIpW6wDG0bb4sPKc7n/WCEIb5rwoe7/yzt9FSqbqiX5xiKOCfcVHye4eM8+BpTsg
         Su4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521250; x=1772126050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9Ys25lUX49p5aMZ9MF04Fc/6uWbxWTtkfKKvleWffc=;
        b=h8gdHTllbQiYjgqx9ufpyd9mpt/0RQyaq+qDdYyR8zykNvSbWT5J2rfYMYtI9Ukw24
         vwjwngOY/J4tRgCrRyvv+ggKkeBaHWeoKD0YVPkm4SiVrrs5mU8W4g5QXgQyhDCWjcem
         Cjc3h0aNCqDRiya1A9Cm9/Z87X9bkQ4mooTRKwmHDPrKKPplLzFdw+zSxoNjWG/BsLPD
         rNZVqAcjuqOu5LCZmxUoCX6F7zbBqPVQdGOLi8cHHQ0Wph7VSmmoU4GxWUgFUa6Hx1qQ
         x5IUrNlsH+NDkV4YIk5KqxSS0pUAl9zagV/m8OBi6WCgeJ7rPhREtfbQiSKYibKS3Fkl
         jVuw==
X-Forwarded-Encrypted: i=1; AJvYcCXNrEeojMV9K8DWKlXJcD97jDq4ncpFilD9pnOYfUf5jRTOMJtw65uILDXgyR9BcAuwFQ5MROIB9FkGlEWIZs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7l/GvquBNGUFqRHDP9vZRy63IuW8OhV+irtUzdyo7hWdDJWxw
	UuKuiSYi8dSqVWarzeF0A/P13hc+S3Tn2hivzckrHTlOq+8PGkfLI+aB
X-Gm-Gg: AZuq6aIfZqatZwOung8Rp4UVKN2BqLCtFlntyVJ6f0eRoMhT/aqUwah73qut/w9JVC6
	9oFScD4bgcG2C9rXlPCFeAnoWPvsXONbp79Fu7vcwRLU2WoL+vHU4e/N7oSTZHvRCfFjlZuddZS
	swR+ihosqn0AR3TTq8tc6V6FW2dMetErrn+uoW6/rSUDr9YrLwdg9g8XnUa3xnMSDdoFi9eu3zK
	ADiuojTnHU7H5aAgg4dAiEkP19DbvQTas+KR+gHk5DA5h8DTqL80kUtaZUuWuJwny1KAl02ICdt
	OgN1DqAl+AMJT3yRzMugbhe/00UQC9t1IxB0IOVqwHrN8ECxGRpWWIl3+PlSBC0oWA0C5BviYu9
	OGJOV8Mc3zMUi5rBr8n+7Rizh5um2fdAI4dqQEkisrWlm/MJwMUUQQ3ZmYEnhp+9oZW/BvzcCWl
	lZCj1sQARVXm22xinjlqSGWxYu/Qsae8oV8mFyTLsPA/OEMZse8w==
X-Received: by 2002:a05:6a21:7785:b0:395:1869:f63c with SMTP id adf61e73a8af0-3951869f8e7mr1782258637.18.1771521250511;
        Thu, 19 Feb 2026 09:14:10 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:09 -0800 (PST)
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
Subject: [PATCH 5.10.y 13/15] timers: Update the documentation to reflect on the new timer_shutdown() API
Date: Fri, 20 Feb 2026 02:13:08 +0900
Message-Id: <20260219171310.118170-14-aha310510@gmail.com>
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

[ Upstream commit a31323bef2b66455920d054b160c17d4240f8fd4 ]

In order to make sure that a timer is not re-armed after it is stopped
before freeing, a new shutdown state is added to the timer code. The API
timer_shutdown_sync() and timer_shutdown() must be called before the
object that holds the timer can be freed.

Update the documentation to reflect this new workflow.

[ tglx: Updated to the new semantics and updated the zh_CN version ]

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221110064147.712934793@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.375284489@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 Documentation/core-api/local_ops.rst                   | 2 +-
 Documentation/kernel-hacking/locking.rst               | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index ad2cc20131ec..e8af3dc3c95a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding ``mod_timer()`` must be dealt
-with via ``timer_delete_sync()`` or similar.
+with via ``timer_shutdown_sync()`` or similar.
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke ``call_rcu()``, the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index a84f8b0c7ab2..0b42ceaaf3c4 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            timer_delete_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 86ac2f4d24f7..4b8fd764aa7f 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1016,6 +1016,11 @@ calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
 use timer_delete_sync() (``include/linux/timer.h``) to handle this case.
 
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed. Any subsequent attempt to
+rearm the timer will be silently ignored by the core code.
+
+
 Locking Speed
 =============
 
--
