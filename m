Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ABF30D3EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231158; cv=none; b=huLjGTqxQ07KNX8c//DbVBN+4TrcEqR8/SOiQ+Xn1JHLwY5SpCrYwoTszGbynApE/j5+yB84aLlkkoGGrpBBdzqSgED7A7jRXQvUJW4kGiTKTaVzD2Z48vEtBsOU39pJtBSj7wnTBNlppk6dUh2+H8GuMLM3XrnG3+qYdrVLV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231158; c=relaxed/simple;
	bh=1M8YyDfaz1w+LKiqXP2doP/R/TOE6VLW0PHN2roXYBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SPCpBQ4ga/YFjA48ZsVMLeqR5zcHJ0ZIPtsRjWEconfWKwtkoIQuXLGi4340gTFxOu5kQ1NtV4UOGbvEk9JojgDX6NktfBol2FrgPvG+ihPWH0d4reLxW+JnVS9h5X4XLit7DM+H2RIl37H+vKB8tA5nt8Y5ks+L5Yu6xGieZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZuLHP5a; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZuLHP5a"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c69921bd15so96495ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231157; x=1782835957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDEgpC9wykmJssSOhbmhRIHMgaSzKaJTLQi/kpCV6Ic=;
        b=fZuLHP5a9ZddwoPE1YE1VXrJhPsDJ825fBfA3ChJpFZcyc3UaLw9sqyj9G3s6MKVYk
         FjfDLNbPoVNBThyRulOOH2oiBhDACzA9z8hP2Ut9Wig1yXqZjd7oDV1t50G4eYUQk5q7
         KQpcbvW1BelTBvpKdGriFV8yTvOicep0HL5falzRLWb78619sLzea7a5Dij3OjxzmO+2
         V3UwOYg+RDhTmjChqsI5CN2byGX5VZL2QJ4PKbhqKevzPkxi8y/lyer/cvXrG1sisIS8
         VMWk8+XV7F7w/H1wx+mbKhWlRxFfFKQW8GWC8Qgu5qe5DJfAhlyqyylcVgXLVzcZLF2z
         wpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231157; x=1782835957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDEgpC9wykmJssSOhbmhRIHMgaSzKaJTLQi/kpCV6Ic=;
        b=K8EyoXT49IUV1+ytIX6oX/ntX1iJIFl4e5lZsGAhFI9NUnMZbIrmPL4EAaMFuuZVaf
         OAX4kw5IjDSOt6h707edCQPBgM89Fo94i8RzTKTPhGHqf5FIKtw08HiGr6LuAQ/B1M24
         e73rxUY11nkfGC327yMZqEQtfTQ59wPfJiYcXPUeLx8izn07Gr66S/rYX8fUvBZ0IiIt
         1UVBLKpRXDwaIGT9grLC2ZOb0idXpPWmWLkV5eHQr/2sdbiQHxNPdywTS0vNxFjThAEm
         hRgjIFJJZGpJ3dHYEbMFJkDKONsN3MOYrI6WdFAJIaBRrJ2mbOa0OXyjS6o09/MnRV1k
         4lmw==
X-Gm-Message-State: AOJu0YwDR6GSR1AhhnmH73XtqE6qG9W0oskqBlhXCb/N6+Q9TEXmg2+B
	4LAle8qFunIaARGZ87/FT3TP/A6+PZV/4/UgeQsE2jyR7I9n2wpD2SKq
X-Gm-Gg: AfdE7cn9aqmH3AzhPgGL/85K5Ro5dxnYqccR/xRhdA8Q9I3mKs0uDae34xENYIGCULb
	M0IFA6Q4+jsdCoBsdq6NSkFBeZ9BszHisB4wk6+AYBxFr3zMgXfDEL9RfnQx5ndtdtZZmm0EXGN
	Tr7UXhMYR3GLhidcwYU/EFy6Vk/OajG2t0y6fBp5jrMmVVd8cPErPwWV+LpVbFdA7W+okH43Go4
	j0S2HYStkY3am0OMjcc+fkl/BeOSAeOZRjkGB4e9T7vFrTuRhO2Wfh//ZipAADCzP4dTbyAfgl+
	BSvGwV0TrdEWfY31WhjHU6AYsOSeLJgwR9grZFniZF5HLHDnTG5lmvcf3x0dNJGg3cvEL0Dnb+m
	xIXJ7Y749MualHuSVNbiaETqeyDY/zlLxJElffhvSd7Nhlcxze4BXsofElJPP98DsF/lMAnM+6n
	Ugyp+eFas=
X-Received: by 2002:a17:902:e742:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2c7c9978aa8mr34510985ad.13.1782231156388;
        Tue, 23 Jun 2026 09:12:36 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfdcb6sm107054185ad.57.2026.06.23.09.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:12:36 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: 6lowpan: avoid untracked enable work
Date: Wed, 24 Jun 2026 00:12:29 +0800
Message-Id: <20260623161229.2174546-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lowpan_enable_set() allocates a temporary work item and schedules
do_enable_set() on system_wq, then returns to debugfs. The debugfs active
operation has ended at that point, but the worker still executes module
text and manipulates enable_6lowpan and listen_chan.

bt_6lowpan_exit() removes the debugfs files and immediately closes and
puts listen_chan. It has no pointer to the queued work item, so it cannot
cancel or flush it before tearing down the state that the worker uses.

The buggy scenario involves two paths, with each column showing the order
within that path:

debugfs enable write              module exit
1. lowpan_enable_set() allocates  1. bt_6lowpan_exit() removes
   set_enable work                   the debugfs file
2. schedule_work() queues         2. bt_6lowpan_exit() closes
   do_enable_set()                   and puts listen_chan
3. the write operation returns    3. module teardown can continue
4. do_enable_set() later runs
   against stale state

Run the enable state transition synchronously in lowpan_enable_set()
instead. The simple debugfs setter can sleep, and this file already handles
the 6LoWPAN control write synchronously under the same set_lock. Once the
setter returns, debugfs removal covers the whole operation and exit can no
longer race with an untracked work item.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in do_enable_set+0x113/0x2e0
Workqueue: events do_enable_set [bluetooth_6lowpan]
The buggy address belongs to the object at ffff888109cb8000

Fixes: 90305829635d ("Bluetooth: 6lowpan: Converting rwlocks to use RCU")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/6lowpan.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cb1e329d66fd..249feca42501 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1093,23 +1093,15 @@ static void disconnect_all_peers(void)
 	} while (nchans);
 }
 
-struct set_enable {
-	struct work_struct work;
-	bool flag;
-};
-
-static void do_enable_set(struct work_struct *work)
+static void do_enable_set(bool flag)
 {
-	struct set_enable *set_enable = container_of(work,
-						     struct set_enable, work);
-
-	if (!set_enable->flag || enable_6lowpan != set_enable->flag)
+	if (!flag || enable_6lowpan != flag)
 		/* Disconnect existing connections if 6lowpan is
 		 * disabled
 		 */
 		disconnect_all_peers();
 
-	enable_6lowpan = set_enable->flag;
+	enable_6lowpan = flag;
 
 	mutex_lock(&set_lock);
 	if (listen_chan) {
@@ -1121,22 +1113,11 @@ static void do_enable_set(struct work_struct *work)
 
 	listen_chan = bt_6lowpan_listen();
 	mutex_unlock(&set_lock);
-
-	kfree(set_enable);
 }
 
 static int lowpan_enable_set(void *data, u64 val)
 {
-	struct set_enable *set_enable;
-
-	set_enable = kzalloc_obj(*set_enable);
-	if (!set_enable)
-		return -ENOMEM;
-
-	set_enable->flag = !!val;
-	INIT_WORK(&set_enable->work, do_enable_set);
-
-	schedule_work(&set_enable->work);
+	do_enable_set(!!val);
 
 	return 0;
 }
-- 
2.43.0

