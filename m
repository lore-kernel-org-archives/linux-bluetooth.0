Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86934EF13
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521230; cv=none; b=PCT/gXs1OL0DdytNJ5fHCQ9VwwMWGlGe7d0Kn+pQ3nebjtRv0dSYCZIdqtThTBKYl2aBR9CAVqHQCjZr8PHpiDrybWAEz0ahBSjFYN78UI0Dw19w6tS+4K081kDGJ1D/EmbqXQoFkOc/4Lh3hkMon7xwAUn4mMKAFdLoDdwV1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521230; c=relaxed/simple;
	bh=k6En+RE2oEi/aaa6/FdQNRaFuxL1eHAD2YO7U6RNZuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSqqiOQKdlvNswhzJh+h1/9eqikKeDkN3mkntK8oPsEkDhjtDaP1DsMh0hEWBxqKyKB0SQLS2QYqBTyx4MhjRA5mN0715/T3Pz1mV7Yq9wrDO27Q97baxEAbrhcxOOWXZey1KjabatJwGyO2j+LoB2vnw858sFJFM4T4F9zmslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avz554fD; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avz554fD"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso479190a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521229; x=1772126029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXffZK0HVFgBoSDOar6/ghoDeSLCHeI4/7cALkB4cBE=;
        b=avz554fDOj5t4gD6HzwzZvW1Q/5Og6Zl0BE73q5KQrxCqB4K3dgR3owYJdhBXPfCqr
         BjuBNqtxXfxP319WQMn62s4TL/EUe/hZB+Fus4LvKnv4c1O4808lkRHnV2tkcxC4r3Ue
         X6prBEXYz1fOncRT/5NgPSticPLrzYrbOhSozZZU+kkGmIs5Wu2Koki8CqTw9eZRAx1i
         yxbrNBM/7f9HMHH+HL0U9EE9Zm4Lisl4PL8aRkMFuU7C+XOqrKGd79bin6nrSEEd7FLA
         WZv8lQAwVFqK8ljMPFyiCEOFqDHp0wBypigEm6L42lyQMhAdCMqw13fVqfcqaAHJWpbt
         DS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521229; x=1772126029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXffZK0HVFgBoSDOar6/ghoDeSLCHeI4/7cALkB4cBE=;
        b=K+heYBgaqWkcUEHtAFKP2YjZ8sC4bZlQY7MOQ4MeITjTIRRlDIS4+gGgx1g01ZkrMy
         io7H77qo2p1Syqd3504HFY+iVRYCwSNp0zKoBs91ulIdi1ia0+vLCRUoWbSWJ+dTzcrc
         DCsq/Y9B3TgPx10cW/Crlp9a5WoQx8nDDPf4yA3b5MSLaIfsllkgnQos6Qv2qoeN5Teh
         ubXj5qRY7yd+uSeBlNqIzgs6ICXaJFBUDLTWCo1eBWoLjHNxoH3vTO1x6KhClIRe1oUs
         /d0UmHsK+xP0eeN7uCVbQt+Btm3VfYvZPOWLT9lLBJsUvtkVqPUjLWTT+J1jqOSjMui1
         FEKg==
X-Forwarded-Encrypted: i=1; AJvYcCVQXoJGGoJOvpAnyrzz2/OtHCVgZ+ieLdaX7ICfvVeaQXO0tZrApD4DUFSyZSz8lnLZrKDVNg6McrhoF3/W7Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLo1+mS2ur3l9mdPffipKG3fJxTc4aLKJyAnhHHQq1MesGYoMv
	eSEv8zpP4h3zTn0l5JLFuVlY11PEKiDasrsIuvJixcE2brZpHx1Jym9B
X-Gm-Gg: AZuq6aKo+LsBYLUkBQVn37b9v2sd1ebm3GnaJr9T16aZdBlz1QGqi1SR9lGzvXYgY1D
	bo98ICb3UPx/CS80iSgnoOEJoW2F4rzIuH5VoxMfsyaZDeshJGPhs8eZuH5ZI3MNgrLsNPYn2YR
	dMORbjGfIYx6L4j8RzaRJMC/wIElru8C3K1BKP4TReXeRt2D7tlagqENRQa5g8bTxRJ3eysqgpu
	WptOyIQwX56oRzeIn1lBL0jhppzKn8aombJHC28Wag2f8UEwCMplk6Rm0UXhHEJhtgJM6x4nk11
	9t+3P1UcZvVREeeQcae59ps0Gt4FQ7k1r1fDB6gDQwP5tJH18bskpaw8XyIze2t1LDgZXhQfFvD
	WBiW9rQKkviBFlXnjwtm98/tU52XoDyr1CCl9shpxuuQiJmCmtIQiVGR2BT48yoJYjuUvZWD6/6
	bWf2JUrI5Ocb3W7mjSqSP7tC2zZZI8i+OTZX4nN/K9sFFE41ErOA==
X-Received: by 2002:a05:6a21:328d:b0:38e:c789:4f39 with SMTP id adf61e73a8af0-394fc339e83mr4954575637.49.1771521228655;
        Thu, 19 Feb 2026 09:13:48 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:48 -0800 (PST)
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
Subject: [PATCH 5.10.y 08/15] Documentation: Replace del_timer/del_timer_sync()
Date: Fri, 20 Feb 2026 02:13:03 +0900
Message-Id: <20260219171310.118170-9-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 87bdd932e85881895d4720255b40ac28749c4e32 ]

Adjust to the new preferred function names.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201625.075320635@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 .../RCU/Design/Requirements/Requirements.rst          |  2 +-
 Documentation/core-api/local_ops.rst                  |  2 +-
 Documentation/kernel-hacking/locking.rst              | 11 +++++------
 Documentation/timers/hrtimers.rst                     |  2 +-
 .../translations/it_IT/kernel-hacking/locking.rst     | 10 +++++-----
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1ae79a10a8de..ad2cc20131ec 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding ``mod_timer()`` must be dealt
-with via ``del_timer_sync()`` or similar.
+with via ``timer_delete_sync()`` or similar.
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke ``call_rcu()``, the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index 2ac3f9f29845..a84f8b0c7ab2 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_delete_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index c43204b99df7..86ac2f4d24f7 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -976,7 +976,7 @@ you might do the following::
 
             while (list) {
                     struct foo *next = list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list = next;
             }
@@ -990,7 +990,7 @@ the lock after we spin_unlock_bh(), and then try to free
 the element (which has already been freed!).
 
 This can be avoided by checking the result of
-del_timer(): if it returns 1, the timer has been deleted.
+timer_delete(): if it returns 1, the timer has been deleted.
 If 0, it means (in this case) that it is currently running, so we can
 do::
 
@@ -999,7 +999,7 @@ do::
 
                     while (list) {
                             struct foo *next = list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1014,8 +1014,7 @@ do::
 Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
-use del_timer_sync() (``include/linux/timer.h``) to
-handle this case.
+use timer_delete_sync() (``include/linux/timer.h``) to handle this case.
 
 Locking Speed
 =============
@@ -1343,7 +1342,7 @@ lock.
 
 -  kfree()
 
--  add_timer() and del_timer()
+-  add_timer() and timer_delete()
 
 Mutex API reference
 ===================
diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
index c1c20a693e8f..7ac448908d1f 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -118,7 +118,7 @@ existing timer wheel code, as it is mature and well suited. Sharing code
 was not really a win, due to the different data structures. Also, the
 hrtimer functions now have clearer behavior and clearer names - such as
 hrtimer_try_to_cancel() and hrtimer_cancel() [which are roughly
-equivalent to del_timer() and del_timer_sync()] - so there's no direct
+equivalent to timer_delete() and timer_delete_sync()] - so there's no direct
 1:1 mapping between them on the algorithmic level, and thus no real
 potential for code sharing either.
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index cfd0bbabb113..adb17d3ab67a 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1000,7 +1000,7 @@ potreste fare come segue::
 
             while (list) {
                     struct foo *next = list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list = next;
             }
@@ -1013,7 +1013,7 @@ e prenderà il *lock* solo dopo spin_unlock_bh(), e cercherà
 di eliminare il suo oggetto (che però è già stato eliminato).
 
 Questo può essere evitato controllando il valore di ritorno di
-del_timer(): se ritorna 1, il temporizzatore è stato già
+timer_delete(): se ritorna 1, il temporizzatore è stato già
 rimosso. Se 0, significa (in questo caso) che il temporizzatore è in
 esecuzione, quindi possiamo fare come segue::
 
@@ -1022,7 +1022,7 @@ esecuzione, quindi possiamo fare come segue::
 
                     while (list) {
                             struct foo *next = list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1036,7 +1036,7 @@ esecuzione, quindi possiamo fare come segue::
 Un altro problema è l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo è un problema abbastanza comune con una propensione
-alle corse critiche, dovreste usare del_timer_sync()
+alle corse critiche, dovreste usare timer_delete_sync()
 (``include/linux/timer.h``) per gestire questo caso.
 
 Velocità della sincronizzazione
@@ -1384,7 +1384,7 @@ contesto, o trattenendo un qualsiasi *lock*.
 
 -  kfree()
 
--  add_timer() e del_timer()
+-  add_timer() e timer_delete()
 
 Riferimento per l'API dei Mutex
 ===============================
--
