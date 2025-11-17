Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6532E6A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763410424; cv=none; b=As3XwOpMyoYuycBnxkypQZQFswfS8m29oUdvtZKVya2Agzj/62zSEpvoVLVGGH3Kf0aOgNFJiHdrhvxaWqfvBC+4t2t7J3KYlqkg3WOQll+0qXVXPzyuyMKpNokHWNcTZD1MO5SrK6ucgOuVRsNt5r0xqiPGuvwD9hL+W1kaEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763410424; c=relaxed/simple;
	bh=C2Bxwl7O/sQFhjbbIPmp8ziXMM0bes2CPvGAOv5ZyxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlOFaBUwufOzna8jzJccc0tIYyFMk1tBCxyQy8eL1WBridYh+eFejHtgmUawsRv9qG9G7pVHzQoxnIgqnKyHwwkmNb/lPkGtptZIDt+sOVkMCm+PwTpuySOw1nbbnAklyLOyZXiKdZmHaPbEi6hcrXQqvmopqqDpGcyfARF6UE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2SKwrGV; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2SKwrGV"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93917ebde8aso1853567241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763410421; x=1764015221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCjCj7ifL5hU4+9OUXm7u7V+0ruLEjys1RleyceR8Mk=;
        b=e2SKwrGVLicL83Oe/vIztL5J2nI4JzN4r2gEqcAXz78ZWCmsFCleuH4bwA0I6mUI9I
         rr2AIHnxw9DW7dYp5G4LsAZjVRZgJTTn66ET1HPKESx4nPS0IuP56hKnnCLsBcDBsexi
         JjA5+ImqrdbZTRwEg9OKjQHU+qVwYnV3nVRjakozHMxHpNXrXEEJ9N3e2sc1aGDddv0g
         GYXShUdgVjfr0elvf3Lq5du95KmtkFRANo1KSjAX7lcGp88STAZIJXctGpGJIH/mkiLf
         adQa8HRVesuSdqZ4+gjHfDQohLI1dqjCBZ0im4v4753ZBRD/6VsTtHxjlb5Ec+GT4fni
         G0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763410421; x=1764015221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCjCj7ifL5hU4+9OUXm7u7V+0ruLEjys1RleyceR8Mk=;
        b=sbRqZuamsZSSOp8eqEOmCjGWZCY1y5Fap1dPd4ANuoP54XSLoj8rsaDfXfh0j5RDj/
         rgpWPyy3audBhApeZxki+jYKZVKML7S/pDbnKKG3Gp3Gr9/dDRIcq0oBqA5kh2zMXxFV
         Tpn7ut+WwqYqkxLSH2Wrbcy7etxQ2WqsQ2dSKIUZdNaqbT8jW2kQ17hL+O77w3git0sS
         Qhnm0xmNMgtPwQYIZh1EsgWqCmV034qUrE0jq3CDPlqoHUSPnChiPq/fH1O1+Go6O+i1
         HEabX9uucNd+H8Y+T01KvobENsfOnKcpi4M2pmkr/v1lLmZ1B3fBm+C00QXgIaPxqXI1
         B3Ig==
X-Gm-Message-State: AOJu0YyRk52EK/jKvDiFAs5ewz3Da8PUnOCrb2/stMVrF4bI6xKkHibf
	ghioZ0dfh/OHqeiUmUQF8uUKOrYu37DAuMdrK0zWDX2iu0YxkKEpsvJg
X-Gm-Gg: ASbGnct+gpfz+fx6VJBJJpwa5U4A5TRr4fY6KJsE3clRY4rwTy5WO5CyrSEg12Jp5Mc
	4D54RF87xDR8VdYiJrXdHsCuj1XuP2kOsgP1lkSRkZnJocyI3niKv9iWzYa6f8b3QOYYoDeh8Dc
	5EoGNt5neeONLzS7Il5BZvOjjQAmwBjdZ/kwZoPLgqDGGktwcOlRRTiHk87S4Och8Jbv6sCqP0O
	3uVCk23HhCyRMH8OmWbHXknvf74Wl7+1kxQQKygbeRihW7kqhJvuiSTlxlrZiFuFpUTBVBEu9/3
	SKKFn4oLFj2We8SHKB1BKKeMA0bRfLCafWpiwqWIL8O/9qtfho1Da/QqckQH1gfCkkDAS9PdnMH
	XKSvujhADJTWbxyAJajKGqI1+2S1om5pK9cNkJRM7iB/UOoWYlA0EP6HrDluD7FAOqMgUxc+AzD
	W1/z16MkT903z57A==
X-Google-Smtp-Source: AGHT+IGdxrfh0bvMfjxv6IuyalBPshmnc+wbkjzua5+Z/x3PcHxlsNrE53OgdyAUxQHAkhcpXYSIHQ==
X-Received: by 2002:a05:6102:4486:b0:5df:aaa8:865f with SMTP id ada2fe7eead31-5e190dc653emr388414137.6.1763410421173;
        Mon, 17 Nov 2025 12:13:41 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb7232b03sm4838202137.11.2025.11.17.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:13:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v1] fixup! Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
Date: Mon, 17 Nov 2025 15:12:55 -0500
Message-ID: <20251117201255.3969812-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fixes: 486a25d25a4b3 ("Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP")
Reported-by: syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=25e9c406cbd26c66c417
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9f686e5903a1..dc318aa79c59 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4121,7 +4121,7 @@ static void hci_rx_work(struct work_struct *work)
 	}
 }
 
-static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
+static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int err;
 
@@ -4133,16 +4133,18 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!hdev->sent_cmd) {
 		skb_queue_head(&hdev->cmd_q, skb);
 		queue_work(hdev->workqueue, &hdev->cmd_work);
-		return;
+		return -EINVAL;
 	}
 
 	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
 		err = hci_send_frame(hdev, skb);
 		if (err < 0) {
 			hci_cmd_sync_cancel_sync(hdev, -err);
-			return;
+			return err;
 		}
 		atomic_dec(&hdev->cmd_cnt);
+	} else {
+		err = -ENODATA;
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4150,12 +4152,15 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
+
+	return err;
 }
 
 static void hci_cmd_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
 	struct sk_buff *skb;
+	int err;
 
 	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
 	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
@@ -4166,12 +4171,8 @@ static void hci_cmd_work(struct work_struct *work)
 		if (!skb)
 			return;
 
-		hci_send_cmd_sync(hdev, skb);
-
-		/* Don't trigger cmd_timer in case of HCI_OP_NOP since there is
-		 * no command pending.
-		 */
-		if (hci_skb_opcode(skb) == HCI_OP_NOP)
+		err = hci_send_cmd_sync(hdev, skb);
+		if (err)
 			return;
 
 		rcu_read_lock();
-- 
2.51.1

