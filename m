Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF0391E66
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641988; cv=none; b=NPecp+kC4O+/7IwFgPFfJXTqD4lYF9DpQsq1cNpDr5eZB8TH3G8A8eMf+WByUjST+T1xVMYHXjHRmqVOKreAk9uDThqs/AwgWtoW1W8HS3eVbiyNza5t1HqdNcrRBTvF/3w2LNNyQykHnKsQ/vEM8Kxf/h4YEGguwLJj2KJw+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641988; c=relaxed/simple;
	bh=3jyMf4YQe7LloZwYO+qq/3QqYv5SZ/8ELYvdc7UTfKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LVb/wPNrAhRlvq6bFXo0eENhZ1FgsAFyXAhm+43xqFSiWD5QZkkI+IFEf+qChKY7jK2mh+M2zHzPiUTJvg3NMhZJZjfoOcrJa8plgK65tF+JfmuSKNcZ8nEFS8L8IP+Y7rK7gk4I/QCI+lePCLe25a/pxWAzu5xiV0kXT3KZbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaP0Bksz; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaP0Bksz"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-83945063f70so3357115b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 20:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778641986; x=1779246786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5PuE0GNhnbIqlYAFwEGtvGgzGg7kilah+ZL5RNKSSg=;
        b=WaP0BkszWsxnHMZ3J2OV6M3//BFanwaYtlAT7bLmWpmqboQTFwsCypQaV71Lx2Qmjy
         a8DMwHbmSfrT39b94mkJhK6eZT3mpsGO7oVAiXkKidMV/9nqvsBU5vltGh1V+rDVAmm2
         fpBSYpEzeo6OGbrui2g670c/T16/XwuKlDXl75H6lhcP7/6XhVUirNTxMN7h0thZRuiL
         00SZpnwu87DMuWwH+iz/1UEwtzUqOhSY/5Yhj5kJ/EyHoiRwUUE6qMoFBO6uV8KgcQgt
         aPeT6B8L5SLjPBsUWw/xLMVQ+BvvmUucnaydVoN4RZZb+U+KKhyWuc1Zg5/FGfV2gSdZ
         F87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778641986; x=1779246786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5PuE0GNhnbIqlYAFwEGtvGgzGg7kilah+ZL5RNKSSg=;
        b=MV3dAbXpW2Lav9uMRv6uNxR9dIflko1DMBtaAv9iqafPo5KejeiLEhuiC5TtTfsF8R
         dC5X0MgQh/kR8J52DRitd/QTanVT5v+IxDmqERB/h6FWs4BAyxzcB5uo9m1N2Y8lfBtU
         o/t4LO5ry+WWbYlgrS8Uy48oFgPPpmc7LcYZ+YNawwCI4jwMV0229RS/BCT+WEc/f8Kl
         vqTmNM41PJEvLw/dOMFzkjRWtYzH2ofA8c0vmTiJ/SkPFhH46CnwaKW9JEz3SOfsRt9U
         pGVTcSg9lZTgO7DlNWS3qtQh2lGMGa+wzjXg2FULxBI5L9Px6/7wP8vKSp2JBYuqAm7a
         vebw==
X-Gm-Message-State: AOJu0YwWQmC7F3SfrRNg1NaqFCQZCXPutl6+QVameQg0+aPLnCreaO8n
	ZQjOHzFV2Lqj8DXFE4ACjmEQzIo3jhJInHFzOBPuIhVlzN+vZc2mjwce
X-Gm-Gg: Acq92OFpcUFT6FuJbmM/YStdBDScXDnZZHSee0HnmKTSM1L/u1p6tw2/Mfhc3Br1465
	KvPYbmfpJNVzhvkddmHSK5UXo2HglDoClW9m52pTh8LW9ZciQv3XSTDjXRnutjClIvLQrvCqZ2B
	aFkEL+8Espsbo9oAOnkO27BsWwdOmcN0yJxZq86qPbhzpijsc2E0S6TythVOt1c3rvd3ybYdmrM
	2F1bKrVrDRRWv1D090tF4oILgX5D060OQFAQIpt9WDzKIhZ9Ib22+xGfhRrHPA9TQnV4k+8nbI8
	VnGYA7aNOjLlwNly6e0jVKVltKbujqVpIOzdym7a0fU5HbB4jaEOSY6Ezbo/IThCqlPGfRTGje4
	i47jRSRwyJ9vdCrH36NRrG4I9Zl6tGdhbDuMmYn4jB2aZfHfX8aG6L3aOX9CBVDDbv6uPArOyiU
	y/EkUcOjWNBA9TlkNOoS3JIkyJRnmYF5I=
X-Received: by 2002:a05:6a00:1886:b0:829:b08f:7353 with SMTP id d2e1a72fcca58-83f02d2e731mr1461990b3a.7.1778641985850;
        Tue, 12 May 2026 20:13:05 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d35b3bsm23227883b3a.24.2026.05.12.20.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 20:13:05 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH] Bluetooth: bnep: reject short frames before parsing
Date: Wed, 13 May 2026 11:12:46 +0800
Message-Id: <20260513031246.651762-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An L2CAP peer can deliver an empty BNEP payload or a payload that contains
only the outer type byte. bnep_rx_frame() currently dereferences the type
byte and, for control traffic, the control opcode before it proves that
those bytes exist in the skb. The setup-connection control path can also
read the setup size byte before it is present. bnep_rx_control() has the
same problem when it is asked to parse an empty control payload.

Reject empty skbs before reading the outer type byte, require a control
opcode before parsing BNEP_CONTROL, require the setup size byte before
using it, and make bnep_rx_control() fail zero-length control payloads.

Sanitizer validation reported:
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
