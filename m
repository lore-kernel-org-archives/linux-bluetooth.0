Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E84BB278
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005163; cv=none; b=N4Knr+KUOEMxZQ73NlxrCm2CcrHMO7dsDqe01GRgCS1Cxb4BoImb2xiktl8D21KDaAdjQL84Xt889s6Qfs4/8aDcKP2eOPSqioGeQ/heEtAIgttOu6VV3JY4yrS3yEaOj1LAB3X/PJn7jPP8y8jWu3u3ImO0X6niqtQY6gsFO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005163; c=relaxed/simple;
	bh=lJmFUvv1y720XfvJovLrsTCuIMar34mvrHnhguM16E8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ff1G26/6W7Kuf+ExQmovng5+6Xxcz7zGzGTC4CJ+/tg0ljuIq6qZ80jaZ/LDqKQTN64IOZHpFj0zAjPQG/ygDWWq5R4BrUlUJHdHxbAd6j1uqg0HR+I3PCskdpjyEEJerqRa5TxXNc0Ic3Z0vf4v80nzXR2+b4hkyv5mSN1PPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/29qR3i; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/29qR3i"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc147d86bebso29903a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005161; x=1790609961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3XTZ9CTE6oB6PdoqCRQ1HTKuKJNIEpv7/7Iapup7c0=;
        b=o/29qR3iKcg5Ry9P8efXUMukhuo0aUcZ/mKz63l4RNnhFmDFTk3en/x0KD3ixGrOGR
         OwkgI3Ab+/hoBnRbtb2Gb8HkUw+taY+1ENWWDpX5CWZ0X8rGtm4Q/HZFrZLyTPfSivV1
         o3AZRrcuJ9x3DsjxJo43e+RDqSGk5FoMOQP4FpP/0v8qwnNP7LH66wvrpRdP/2CDhi+g
         3uAIfNu5ONpff2gz6JCZjbRJhL57cq6wDw7pXg3nwU4ef/VXBwkkA2mmjszzx3H246Mx
         Yk7tAvqx7YuvEHgMt5y1fDvhdN0LIqHzRCX1C4AVvcimF5sKY1ys/dpM5tKUxx3sy2bx
         deuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005161; x=1790609961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3XTZ9CTE6oB6PdoqCRQ1HTKuKJNIEpv7/7Iapup7c0=;
        b=WYNWqor2ZJL4x/5c0xCo4877tXTaKa3rOos5Fs4GpmLVND6J0rRvXl3ejeNAVBt0hF
         Rlq+yERZurrSzLCAY8zbSZ3mXIrm9P5lEaTSO+XUyqK9KIFsWoQ79G5Wxn70BW8OdPTS
         SpE9vzrYAl9W34ad4B4JX/9t9Axj1GMzvMtZM/BB1bU5Y0NSgllNAs+JUPQLte91oQrO
         HPRdq3QTZFDdi6tDU1IM7GwtdTM00M5e47DyInirQ5fdy6H7qiAFHBzpUjvNTTodvNRc
         rdNGPMA6sCk6b9dLVOYlf22oVytLNAYiUE0uVTOxKrw0wsNTFvYUA2X3RIyDwyQfVRge
         lpIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP6ktvnRyVrqHtDrcDeaOGhZLgJJiO3cPgkH8xHCy+Ku+7Onyz5dRSyzRvYvGeyNIQEb4oekcRzqA5oNWkGJU=@vger.kernel.org
X-Gm-Message-State: AFuF++njfYDKkCjibhvy1XOAmVsL0bmXTNGoGIEoUGQOqM6w+3uXAElm
	a6r7IFEu4618wt5p49r/rNUgpppGyBK1eAGX1Rnq1ImWKeqzTC4U+r9j
X-Gm-Gg: AYBFou2+4p8V2kM6Yh17yfWQwBcc4APsc3K23cavup0ahNy181zYHgJF2TUU4kVQtti
	A6GwIrXD1wfJCcELSjS79wDGkRkjvSUbCX3DVheIoKBFuEAOZG+ITvEwwgwNXhCO6sjUCVIgr26
	g21gjJ+18MkEuXMxIl1lUpsramBxOQAxBgzPAjNcqKtU+lyd8kIMlZEvZhwWOt41JoMBxPX71fm
	tMDqrjyOuzJhWE3TpA8nOVfxKn86IcfRJ3Pb9s0mfdf9nZBgGE1N0v5UdqZUF1maqHok0+3JzxJ
	DL46Yao6wwZKGq18HMQYtfmZnrRhEODsCx4h8S0k31jnlULyD5JrjhN3wWg+MyJXlLlxXSmGHbG
	5XZwrZf0TEwjSHzGkj/0gyF7VxzD2/KzIAUBEPHDTQ9kYZ7b57zrhfXjaUVo4Nw3Eg6NlGNMgEf
	hKy+uWyPvSK17Z5o4BsgXsG5v1v0FGVdm9EBW+pTf7gpSsTBsgdvG658OqBq7h4hNwvnw=
X-Received: by 2002:a05:6a00:158c:b0:878:3705:5726 with SMTP id d2e1a72fcca58-87837055eb1mr4496461b3a.50.1790005161045;
        Mon, 21 Sep 2026 08:39:21 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm3448186b3a.2.2026.09.21.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:39:20 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marco Elver <elver@google.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/5] workqueue: add support for module-owned work
Date: Mon, 21 Sep 2026 23:38:59 +0800
Message-Id: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queueing a callback on a system workqueue does not take a reference to
the module containing that callback. A caller which releases its last
module reference after queueing work can therefore leave a callback in
unloaded text. Releasing the reference from the callback itself also
leaves its return path unprotected.

Add module_work and schedule_module_work() to hold the callback's owner
from queueing until the callback returns. Run the dispatch and final
module_put() in workqueue core, which remains present when the callback's
module is unloaded. Cache the function and owner before invoking the
callback so that it can free the containing work item.

6LoWPAN needs this for deferred network-device deletion after removing
the last peer.

Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 include/linux/workqueue.h | 15 ++++++++++++++
 kernel/workqueue.c        | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index c8a36423cb34..9920796c8822 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -128,6 +128,14 @@ struct rcu_work {
 	struct workqueue_struct *wq;
 };
 
+struct module;
+
+struct module_work {
+	struct work_struct work;
+	struct module *owner;
+	work_func_t func;
+};
+
 enum wq_affn_scope {
 	WQ_AFFN_DFL,			/* use system default */
 	WQ_AFFN_CPU,			/* one pod per CPU */
@@ -220,6 +228,11 @@ static inline struct rcu_work *to_rcu_work(struct work_struct *work)
 	return container_of(work, struct rcu_work, work);
 }
 
+static inline struct module_work *to_module_work(struct work_struct *work)
+{
+	return container_of(work, struct module_work, work);
+}
+
 struct execute_work {
 	struct work_struct work;
 };
@@ -634,6 +647,8 @@ extern void __flush_workqueue(struct workqueue_struct *wq);
 extern void drain_workqueue(struct workqueue_struct *wq);
 
 extern int schedule_on_each_cpu(work_func_t func);
+bool schedule_module_work(struct module_work *mwork, work_func_t func,
+			  struct module *owner);
 
 int execute_in_process_context(work_func_t fn, struct execute_work *);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ae3732a2c51..1a16bc5dfb68 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -48,6 +48,7 @@
 #include <linux/hashtable.h>
 #include <linux/rculist.h>
 #include <linux/nodemask.h>
+#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
@@ -4808,6 +4809,48 @@ int execute_in_process_context(work_func_t fn, struct execute_work *ew)
 }
 EXPORT_SYMBOL_GPL(execute_in_process_context);
 
+static void module_work_func(struct work_struct *work)
+{
+	struct module_work *mwork = to_module_work(work);
+	struct module *owner = mwork->owner;
+	work_func_t func = mwork->func;
+
+	func(work);
+	module_put(owner);
+}
+
+/**
+ * schedule_module_work - schedule work owned by a module
+ * @mwork: module work to schedule
+ * @func: work function to schedule
+ * @owner: module owning @func
+ *
+ * Take a reference to @owner before scheduling @func. The reference is
+ * released by workqueue core after the callback returns. The callback may
+ * free @mwork. @mwork must not be pending.
+ *
+ * Return: %false if the module is being removed or the work could not be
+ * queued, %true otherwise.
+ */
+bool schedule_module_work(struct module_work *mwork, work_func_t func,
+			  struct module *owner)
+{
+	if (!try_module_get(owner))
+		return false;
+
+	INIT_WORK(&mwork->work, module_work_func);
+	mwork->owner = owner;
+	mwork->func = func;
+
+	if (!schedule_work(&mwork->work)) {
+		module_put(owner);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(schedule_module_work);
+
 /**
  * free_workqueue_attrs - free a workqueue_attrs
  * @attrs: workqueue_attrs to free
-- 
2.43.0

