Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715081448E0
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892286; cv=none; b=toKsXpOEp55ENKaQDXUbbrQAa8RtXs13+MQUfOOZKJuv4xTozjinu9ZJTXuDaescRQLMEO6hxhkQVf60e5B8osiq4gKWozUUle48WFD1OgZwtjCs/G6lp0DZkaK3L+/qZn44W7KhRLdN6uRyWGfDuxzxpS5GZbSTPbf9JgPVeG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892286; c=relaxed/simple;
	bh=QsKRrCsZWr8/lzKNfRCUskDOOv/sjitJQhnjAeGo8u8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bnt8yVvIyDneVTq6wPO/SXwLJaeQWIeWlCsWB7zAbKqtvaw3xuIlYceFeK/6cmEX3bQcJfWj49mphSV2r2Oh8JOHBCvXH6YPBY+Hx+3uAmzyMPE6drdjY3frc7oGDdBNMQ+sHmBen1PCKddcJe6p8J/RqZLgP3OswCfCGAY/K9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evrrqQ4i; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evrrqQ4i"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so209931b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 17:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778892285; x=1779497085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPGBU7Rs1Xa9fzKJ3viMUG25IPn3blGqnzkTU/u/aEo=;
        b=evrrqQ4iwbevEJGNlKaghVcsi04lrOUgdO0vb/G/D/diudpMioTviJHwK4RJP9BlYM
         RrDpGV35BDQ6PHZvcxmlIAFGgTxjtgGXxhCgOJxCIYV8ZvhDCx+2eu+05unZCAFV+HCz
         4Weq+pTpqxd8fOy+5+kv5oEnC3sMhsu1nsijPr00Woifg5HJPoKQOTw8e80XpewPLF7A
         Hc9s97bNsOVxQAh2QTpODEJ1z1UivPNMgvUAq8j0iw/foHhWP7LoLC5gmrok3VF8A6ie
         HW7Wc89+5rtFBikc3VjqyIh/zhRSn9RPaG82u3vMbzkcqPRV6W+YX+r8689iakOSXT6k
         whRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778892285; x=1779497085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPGBU7Rs1Xa9fzKJ3viMUG25IPn3blGqnzkTU/u/aEo=;
        b=NKA34SAHVWUf05hisGmSAegATk4EwN/IA1+mMZh3nnJhVyjsGBG8Mnix6/GkDU0vVd
         zM7F/pctENtWI8RDjYegFWqdq3OtExQBy/gyN9A8dnBjkjgAULdb7SI5iQnZv67R7AKV
         Dm5n6f/YyTjIGTl1hycQ7+JIuXZkl07z+g5mya//v4/pZpNWQV7dCVFmmC3W9b14wclG
         hezAf5e8KeU8vCIUt+4DRXVFvPKuhFEMpwSSk+ZbTEhLzR5LQYmlgIKY+TLIGDch9C0D
         f5Ra5Mml1u7sO7y8BLMxpKQaYk1JI6s6V29XVzHUsBVd0tsQ7zRYKyAbFdsLW5h2IRfE
         7REg==
X-Gm-Message-State: AOJu0YwST5iKuhahKPyx+WmVZZafwjSJPv77khuQ7SLJitoMKqAtiqDw
	4nr2o1vEN5b84vouHNn5WQBPVFBm69tUg/8HWJpJmFxH2Si2WvS7dlq9NLPOGJGi7+Y=
X-Gm-Gg: Acq92OFtQ1+4GppGuPsd45w460OjvH3V/uD5mG7HROCSL2IK0HMLKvi33CCbJwGpK99
	ZHz+RQUx73anZ5Jq4fNEBF6/2dQtwEqst8BcCINjNRsolUSVKPw9YL+xGP6iOZMyBfZ3ScKsoNt
	T71PR5z9qwpmRd1Y9CGhIzhbKXXIGy9IGGH9i7tK2nbxEdUtlR0gU67OcZFsGcHRy1JFIgZrMZF
	qRt+MUuMTysX1lhtVbCTLTmXhrxyoQY3gStM8gP2dDwPxqvJhcvszpAEU5FcPVYZr2YxhZuIvIy
	R+AEv/zoAR5GWOYzYyq/5fhtgnAS2SUbjgjiA0DtRRiQQoBz36D4E7BeLQ5Lx2kZDKztbcPPZkq
	qTtksgW8F0BTGYyJXsQsbaAvIkIuz6gQpL2/hblLMJ60pqMHsShqmHn69i9E9PUqcgwBrZqIKuS
	LrBT6mE9lAYxYQdCICROQceN54n/j9Z1llmp7RAnfiPA==
X-Received: by 2002:a05:6a00:3907:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-83f33c25b5bmr7200610b3a.16.1778892284661;
        Fri, 15 May 2026 17:44:44 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c78844sm6747963b3a.47.2026.05.15.17.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 17:44:44 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v2] Bluetooth: bnep: reject short frames before parsing
Date: Sat, 16 May 2026 08:44:33 +0800
Message-Id: <20260516004433.3199522-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An L2CAP peer can deliver an empty BNEP payload or a payload that contains
only the outer type byte. bnep_rx_frame() currently reads the BNEP type
byte and, for control packets, the control opcode before it proves that
the skb contains those bytes. The BNEP_SETUP_CONN_REQ path can also read
the setup size byte before that byte is present, and bnep_rx_control()
dereferences the control opcode before checking that its control payload
is non-empty.

Reject empty skbs before reading the outer type byte, require a control
opcode before parsing BNEP_CONTROL, require the setup size byte before
using it, and make bnep_rx_control() fail zero-length control payloads.

Validation reproduced this kernel report:
KASAN slab-out-of-bounds in bnep_rx_frame()
Read of size 1
Call trace:
  dump_stack_lvl() (?:?)
  print_address_description() (mm/kasan/report.c:373)
  bnep_rx_frame() (net/bluetooth/bnep/core.c:306)
  print_report() (?:?)
  __virt_addr_valid() (?:?)
  srso_alias_return_thunk() (arch/x86/include/asm/nospec-branch.h:375)
  kasan_addr_to_slab() (mm/kasan/common.c:45)
  kasan_report() (?:?)
  process_one_work() (kernel/workqueue.c:3200)
  worker_thread() (?:?)
  __kthread_parkme() (kernel/kthread.c:259)
  kthread() (?:?)
  _raw_spin_unlock_irq() (kernel/locking/spinlock.c:204)
  ret_from_fork() (?:?)
  __switch_to() (?:?)
  ret_from_fork_asm() (?:?)
  kasan_save_stack() (mm/kasan/common.c:52)
  kasan_save_track() (mm/kasan/common.c:74)
  __kasan_kmalloc() (?:?)
  vpanic() (kernel/panic.c:576)
  panic() (?:?)
  preempt_schedule_common() (kernel/sched/core.c:7352)
  preempt_schedule_thunk() (?:?)
  end_report() (mm/kasan/report.c:219)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index d44987d4515c..f5070bbd6b57 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -208,9 +208,14 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 
 static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 {
-	u8  cmd = *(u8 *)data;
+	u8  cmd;
 	int err = 0;
 
+	if (len < 1)
+		return -EILSEQ;
+
+	cmd = *(u8 *)data;
+
 	data++;
 	len--;
 
@@ -303,14 +308,21 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	dev->stats.rx_bytes += skb->len;
 
+	if (skb->len < 1)
+		goto badframe;
+
 	type = *(u8 *) skb->data;
 	skb_pull(skb, 1);
-	ctrl_type = *(u8 *)skb->data;
 
 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
+		if (skb->len < 1)
+			goto badframe;
+
+		ctrl_type = *(u8 *)skb->data;
+
 		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
 			dev->stats.tx_errors++;
 			kfree_skb(skb);
@@ -326,6 +338,9 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		switch (ctrl_type) {
 		case BNEP_SETUP_CONN_REQ:
 			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
+			if (skb->len < 2)
+				goto badframe;
+
 			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
 				goto badframe;
 			break;
