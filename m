Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298437708
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868547; cv=none; b=k7VtCsdFy6SdHzfjZAkZ3R0EPSfRzwgzhPi0CkLoweg0SVK0C2+1V5sV3MBqxrgloVLWP5IUPXfz1p8k+EkzvdP03przG8+drmtYWmkRbuGTf4wtLmh0uAqC3XzXrm6i0eCuTVXt2500bJGoiBSLOfQ/SMzkwe9GVAg4ojpJSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868547; c=relaxed/simple;
	bh=JLRXG9LVSLuUNy2F0GMsZUv8E2r3RV+oSqPBHaxRI0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rby7ekQ2F5Q7Upj06iBZoTsBaqIHhPpjCLO0pAOz/aqr8rMIipUxlNSfrpx3BtZs+EIZTg8SXSHtVfHgYbuJxJRoBEaliwpwHwnUUFht1dsHfVRVBHIFC9BZJCwezTqmy+Ea3R7p1LeDmd9dztdX8NaPfgIoxB3h3Yb4HH2OEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBv/cUYM; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBv/cUYM"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4ef76f04977so1207819e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868544; x=1720473344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfbipm9DmgdNAzJD1K22aCdtDiv3jVM/nAKl/yajcU0=;
        b=SBv/cUYM8zPfBvHUluVV6dWNdIcRK2EWKaAZKPyp/jbG0NPvW79t+GbPQNIqtsugVu
         TFAK9cDPeAFN7dGptDLmT7JGxAjWaz38j56sbDjlddQ/IHZqZ6fX3PCx9SuU6R5k4oJ4
         JmVB/+cQIU4YJpDFsfijYXaArG7uh43hnH92YVSwpFP6W9dYYXeKIUsL8JLv/W7Dt5SB
         tZErR1SxTUszsGMBSjLedisd2jrJWpnJ61ULEsAwzp/s6W9TApaAXkfQIRF//dLGuCOt
         MnZgKOAuTvfv6E1eQmIwYPDRHwrgPyxLcsc+hGQ7vqhC/ItqAp7ZFZFUHgFuoUWIClxD
         NtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868544; x=1720473344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfbipm9DmgdNAzJD1K22aCdtDiv3jVM/nAKl/yajcU0=;
        b=p7Rj0dntqixZIOB7rPzfE8OfGRmJ33lWrqjv2uZgvw0h8Ptn/lRT6J1nMght4reB9/
         vxRC3kSW2vuKMSio6ZsHHl4Uz0IXkABFngPXVDOZFKwhAiC2aJ+vzCj9XmuMBSb9NP8E
         TOzXkj0hj5DEOttz8UxLyZU/JOOlahjvz6DNr3BGmXANEH6LIbJhl9bfcyBAPTluBVxm
         JW2iR1VWWpYO6IY1RrVbc+KEMU8ARHanEjt3BpgYS0+MCD4QKQ6gL7YPd9EHqL0wJMTS
         DptTYHIb02ht8NqIWTCZFR0lpHH3HYwZwSz8lJw/kRlUzgTiFIpJFdD5CfyF66iViImw
         QPrA==
X-Gm-Message-State: AOJu0Yz8LcDCTFEfaSJ4vvQrk9izBYa3vqsmAKRagDGqU6kl3IfB4L/K
	jYxsYpMOB7kyl5D19YN5uxKhCKT0dW564lwnlASV2FseMpuCl++qlLYWHg==
X-Google-Smtp-Source: AGHT+IERLeNOOC/e9dbn+hY4HSX9j7XehPFmmc19M6SbAYNHDMsCAQ+O2HrLR6KEniiPEjVYbonZCQ==
X-Received: by 2002:a05:6122:4d1c:b0:4ef:5947:3fe5 with SMTP id 71dfb90a1353d-4f2a566eebbmr7936552e0c.3.1719868542978;
        Mon, 01 Jul 2024 14:15:42 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292271514sm1144827e0c.51.2024.07.01.14.15.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:15:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/5] Bluetooth: hci_core: Don't use hci_prepare_cmd
Date: Mon,  1 Jul 2024 17:15:35 -0400
Message-ID: <20240701211538.1420913-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701211538.1420913-1-luiz.dentz@gmail.com>
References: <20240701211538.1420913-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the instance of hci_prepare_cmd with hci_cmd_sync_alloc
since the former is part of hci_request.c which is considered
deprecated.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h | 4 ++++
 net/bluetooth/hci_core.c         | 4 ++--
 net/bluetooth/hci_sync.c         | 5 ++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 620e6014beb2..a8d88247ac89 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -20,6 +20,10 @@ struct hci_cmd_sync_work_entry {
 };
 
 struct adv_info;
+
+struct sk_buff *hci_cmd_sync_alloc(struct hci_dev *hdev, u16 opcode, u32 plen,
+				   const void *param, struct sock *sk);
+
 /* Function with sync suffix shall not be called with hdev->lock held as they
  * wait the command to complete and in the meantime an event could be received
  * which could attempt to acquire hdev->lock causing a deadlock.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff60c3617ebd..1e8e84017e1e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3057,7 +3057,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 
 	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
-	skb = hci_prepare_cmd(hdev, opcode, plen, param);
+	skb = hci_cmd_sync_alloc(hdev, opcode, plen, param, NULL);
 	if (!skb) {
 		bt_dev_err(hdev, "no memory for command");
 		return -ENOMEM;
@@ -3092,7 +3092,7 @@ int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return -EINVAL;
 	}
 
-	skb = hci_prepare_cmd(hdev, opcode, plen, param);
+	skb = hci_cmd_sync_alloc(hdev, opcode, plen, param, NULL);
 	if (!skb) {
 		bt_dev_err(hdev, "no memory for command (opcode 0x%4.4x)",
 			   opcode);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 46b394842a27..0c8888448d3c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -49,9 +49,8 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	wake_up_interruptible(&hdev->req_wait_q);
 }
 
-static struct sk_buff *hci_cmd_sync_alloc(struct hci_dev *hdev, u16 opcode,
-					  u32 plen, const void *param,
-					  struct sock *sk)
+struct sk_buff *hci_cmd_sync_alloc(struct hci_dev *hdev, u16 opcode, u32 plen,
+				   const void *param, struct sock *sk)
 {
 	int len = HCI_COMMAND_HDR_SIZE + plen;
 	struct hci_command_hdr *hdr;
-- 
2.45.2

