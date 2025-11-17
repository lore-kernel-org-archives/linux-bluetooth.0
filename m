Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842D2BDC00
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416278; cv=none; b=XniDud/pn0bSTNSVk2ga0xrapAISaz8DQ5jKvaIdK6Q2boUVtyXSnAyr5WzdwQFU6zBpine1Hqt+t7GPjhj/qodAzrrPYCTE72s7tnJpO2BwJ4ATT2gwYB7qwvpNwfROJiAsuYszAjggh1KxUySangFGctBXQIXo+0/L5E4UiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416278; c=relaxed/simple;
	bh=RODPyx1/EmyE6g+sNL/t5Vx1Y5Rb998Ekd2Ayg6FZz8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eyLuVE+v0A5dTGjuUD9ZPypQbBhr3gN9diPOvaAUEPRvEBZh6LXq3MhLyO5/K2RK878qSB2+gti1Ep3qu5VSoing6MI/pD2mTXtkVXM/VVbEhGw1pViCd7kcjwotYDebOHVLayJuGm9urj3gXMSpWmbNJryHt0lnTd3JdPIiKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flVG9Hcm; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flVG9Hcm"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b24eedd37so2087282e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763416275; x=1764021075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=edQEMEw63Kyo0nSM75zPzpH4ct1MYmJERTy6rIEvMXE=;
        b=flVG9HcmgWOP1wYi/S59ipfwKSoRj+8Jom8FLTtGg+tSwnA2/K7VkD4kMgOZe4Us3y
         U3XP9MOBw1e15MCb9JORvVt0Ak1Z1ctjSlc+eH1iqb1XpWP5s5XrGwpmUpTvdF2D5L9D
         vZ4zTKuj9ERXMQZ2/VEF8RztxT63c3cwsyZmumlssCfCx4lRS3NhD2UfEs47QWW13w+6
         RvLeaGeutZFPW9WM2wBToKKcPkJKsT8zhJbtWWAlnl/43dbpMjVRdcDaK7dtk2UHO/Hq
         lvgJlr06oHhiW6YTo/C5GgeES5ttH+mLy7QGFPyPrIHllTcTOwIXmZe+DUc9lVwz2FEz
         iRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763416275; x=1764021075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edQEMEw63Kyo0nSM75zPzpH4ct1MYmJERTy6rIEvMXE=;
        b=G03X6bfQTw6FGbUQwqVzaK0BEld0B2lYMEpuJrVxz4mDH1WXzS4Yv3thxGF9cYhWgx
         Hb9Hq01EwAhZ7r29BnhhPIyq7cugeCuNVtpyf9TAA3yLunPJkGIror7GY9he+jYbMnSH
         18S7frlcDSlWnMkBbcKBUhqdZk47nibry1NUZD5KQQE+SEdZL0P2j3M/iaorwL4crADG
         kW1pFusHRojJA7p677iIuF0yU7nCHM/rTPcxySKLVvS8c3CHsyGz8jdeS8pnODr2h2Z4
         Yf9mQQwTF59bEgUXvnrE3ad13wYc0yY6FCCj0EJ+o/ULP4cc4UdWoH5CkgsynbdHli2A
         3cJA==
X-Gm-Message-State: AOJu0YzE54g+jP/msyHpjDe4iYBqNayiph2lY2ZvvHeSe/i6RAsRUXsa
	+kjjwHCBbeXKhiIVY2Cig+umne7V/qbGo2m2ZwZfyFB3dzZpsYW02p20v7X0ZInQ
X-Gm-Gg: ASbGncuDGk4waI0ExIHOy19fraU37NmkSP1krh3AU+oZeH8FVTbdELQ6a7XJgCbA4Cg
	5qK17gZ1wEqTw6j2H5sq2hkiwYN6lSCCRWaQlVCsPFmXM00c9ZzReBcHUPS/IdzVNOhxJy1uY7Y
	l1V7/DLaKoTWE2BN48pHgzrxT3jbngBUkHYTgJOlreyuh+j38JGE6y/RzhcLZUpAFPxCEGOfzEf
	qOxjIKAWR32gI7hbOW0p3hkvvLlxc+rKwrLFcf/1yQk5ZG7BGnbDpXKcpqYnjtabJTLNkp85ClQ
	u83RMCcHeHqmJyggDVMP0zrZ2Py9aIPy+LYdgOiCaY/ysxKvRF4SwfUD97Z1c0ZSzY3xU+395YO
	kOXebUGq5+n8s+GHI/debSpuVVf848akTqbS2wIeGtSCuabrW5fxSkG/lurqI6f3hoCOHd1OuMO
	m/UpctgDFwwJ2YBFT42hz8KHR+
X-Google-Smtp-Source: AGHT+IEMK91xqbf7QPpgODJBJDGLdq4/VbQWrmWEY+MzxrYu321ZuHRAmZL3AGMWB6m6KBsTb88D+A==
X-Received: by 2002:a05:6122:83d2:b0:559:79d8:27a5 with SMTP id 71dfb90a1353d-55b1bb60637mr4151806e0c.0.1763416274680;
        Mon, 17 Nov 2025 13:51:14 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f46234fsm4705923e0c.18.2025.11.17.13.51.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 13:51:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] fixup! Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
Date: Mon, 17 Nov 2025 16:51:03 -0500
Message-ID: <20251117215103.3990708-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9f686e5903a1..1920e3d62bda 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4121,7 +4121,7 @@ static void hci_rx_work(struct work_struct *work)
 	}
 }
 
-static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
+static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int err;
 
@@ -4133,16 +4133,19 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
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
+		kfree_skb(skb);
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4150,12 +4153,15 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -4166,12 +4172,8 @@ static void hci_cmd_work(struct work_struct *work)
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

