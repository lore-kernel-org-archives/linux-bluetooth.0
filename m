Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA541C79
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207422; cv=none; b=jVedyvmd5GmZT+9exy9g3j1kHT7GilwfGK2h/80/n+zMMsqCxqtHPIRrcY9xIXBe4I/Yn41KBFgOD5mmLxIf+ZkH7ddBzd6gDg09ldYQtYTd7ZkzgZ+iLtCY7lVwesg1tjc00LxrsNelcXIUWrteIj+rFtsTmKMe5m109jY9ZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207422; c=relaxed/simple;
	bh=GLmHya0jZyce9R3rMlhq4PBNArr/3ebxGVXJwETOlSQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kFsu1olxs3IL7e2O3UpBQ2sZjl8Z8uD25suV4fuLF5CBbLgnOp3RP5ynN2pGkY/0FusxJQgQxrC0TLzdAr/voR9thv6cj6/oh9OQ73pk4Rt18P3kyikYi9lItIrSIxM5yrCM4r5fJ8wY6SmO21F0siWfx/6egnhqJdy592WKjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkvI6Qsq; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkvI6Qsq"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718065d6364so550035a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732207419; x=1732812219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAhot2BxPoDPIlnZQtZkYCrBuXstc8+fHj4sOq+XRAA=;
        b=CkvI6Qsq+fZdVXDl/Go1xsDREffwCtlVRMw8fWkA5pR+4zEIKbP/u/LdZ1iuFU1AfH
         ucrkUTeWbUTdcTvANaJyhZrxiN6HwlNvMZgHaEhmzeCPMEdmoNUUnd7g9RGS2bOb2+b4
         rTCN+k9ylStNoW1GuyT24DaPUQbBVMRvahsmEN4rkXExfEWrVAIMglPSt0utEhCnPGSN
         dsQ33CkORHKrBY8UDqkvh4tdrtS0laxDDCs3FEi3ErE9XkGLtRSxHF83ltGKmX9j1kiD
         ycObB6PZlY8mtqUYmEf15eqiNxC9glmKFzugNEc+QZcEJdMnIm8JpPNve0HN4UHMu9b/
         tKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732207419; x=1732812219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAhot2BxPoDPIlnZQtZkYCrBuXstc8+fHj4sOq+XRAA=;
        b=ZnRGk2b40FLOmQLIc07taNhHHYyBkeYPzXz2wKJ3381QCkOXzNmtoxaOiIBwfpRCa0
         BYrO7qsF9DDDg8gP+cWSG0gja/4Jy8dyUIQXpCxE5wm7Q376hN5gyNhxNLrpaLS6A50c
         4mgCNMl7PwVGGs2xBqFK3p1RhTfX2UdUlh8n+WLou6E9aLqisl0oDDi48Jg/NdncpViP
         G+hTBMFn8d9WJjaP/O9WqkksTidMqHNK0D7KHvJJIMW/lIy84apITV/fH85JpPLaqnTJ
         c1DWyF0BN7AOk8eMKeY7m+ioHqOQn5FESGScbkELdDxYFtDfbvZd6+HgDQbciZ7xRyNv
         E3gA==
X-Gm-Message-State: AOJu0Yy1L2UwXkJaZcX51I5W3zHiFYCYERmJ76mpVNiPPfBnBqcqc3AM
	t2S1FaqsmvB8/eEBFhwqsppIYYIciNwqgaR9KKjG9KUM+RFS4daDM/MJ1Q==
X-Gm-Gg: ASbGncsbK0jwvBz1JDSVw+5m524ddD7KzS1msIkN8OQ8CjuMTIRK3VBMmf2Wh5Gf01o
	0PxpYSzCoiJRLkffC5qBHtJ8HMkLiW1cbYchQTaJo78T3fZy1RohXCZKmJwtcfdRFtRTE5iOaoP
	wMQdylN8b7dRht8KaFuXtFcAj9UZMhaNQhVdkY3pNJVq56mwHKADIY5z9FmhyrbzMAHCa0NI1aw
	S9nHv6ewz8w3K+UM9SXUPFEeF+nkf6YDrqEnAW3X4Ka//Yu3VQ2bGT+kOMC93TDxSrMWgYHv+FS
	mIBhy1KnFe0EPGPKHSfoOQ==
X-Google-Smtp-Source: AGHT+IHySICeFw0LfIHKGnEqgzpV8MJAcRmOR1LWvYdy8yJV/U1ehx7lz//N+84zXL4lWfcHDwJYfw==
X-Received: by 2002:a05:6358:5d87:b0:1c3:7ee0:1e4e with SMTP id e5c5f4694b2df-1ca664947f3mr493926255d.6.1732207419246;
        Thu, 21 Nov 2024 08:43:39 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856dfbf123asm2210183241.8.2024.11.21.08.43.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:43:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix possible deadlocks
Date: Thu, 21 Nov 2024 11:43:35 -0500
Message-ID: <20241121164335.3848135-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes possible deadlocks like the following caused by
hci_cmd_sync_dequeue causing the destroy function to run:

 INFO: task kworker/u19:0:143 blocked for more than 120 seconds.
       Tainted: G        W  O        6.8.0-2024-03-19-intel-next-iLS-24ww14 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u19:0   state:D stack:0     pid:143   tgid:143   ppid:2      flags:0x00004000
 Workqueue: hci0 hci_cmd_sync_work [bluetooth]
 Call Trace:
  <TASK>
  __schedule+0x374/0xaf0
  schedule+0x3c/0xf0
  schedule_preempt_disabled+0x1c/0x30
  __mutex_lock.constprop.0+0x3ef/0x7a0
  __mutex_lock_slowpath+0x13/0x20
  mutex_lock+0x3c/0x50
  mgmt_set_connectable_complete+0xa4/0x150 [bluetooth]
  ? kfree+0x211/0x2a0
  hci_cmd_sync_dequeue+0xae/0x130 [bluetooth]
  ? __pfx_cmd_complete_rsp+0x10/0x10 [bluetooth]
  cmd_complete_rsp+0x26/0x80 [bluetooth]
  mgmt_pending_foreach+0x4d/0x70 [bluetooth]
  __mgmt_power_off+0x8d/0x180 [bluetooth]
  ? _raw_spin_unlock_irq+0x23/0x40
  hci_dev_close_sync+0x445/0x5b0 [bluetooth]
  hci_set_powered_sync+0x149/0x250 [bluetooth]
  set_powered_sync+0x24/0x60 [bluetooth]
  hci_cmd_sync_work+0x90/0x150 [bluetooth]
  process_one_work+0x13e/0x300
  worker_thread+0x2f7/0x420
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x107/0x140
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3d/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>

Fixes: f53e1c9c726d ("Bluetooth: MGMT: Fix possible crash on mgmt_index_removed")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e406eb8e4327..b31192d473d0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1518,7 +1518,8 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1692,7 +1693,8 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1924,7 +1926,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 	bool changed;
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_SSP, hdev))
+	if (err == -ECANCELED || cmd != pending_find(MGMT_OP_SET_SSP, hdev))
 		return;
 
 	if (err) {
@@ -3848,7 +3850,8 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (cmd != pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
 		return;
 
 	if (status) {
@@ -4023,7 +4026,8 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 	struct sk_buff *skb = cmd->skb;
 	u8 status = mgmt_status(err);
 
-	if (cmd != pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
 		return;
 
 	if (!status) {
@@ -5914,13 +5918,16 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
 	if (cmd != pending_find(MGMT_OP_START_DISCOVERY, hdev) &&
 	    cmd != pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev) &&
 	    cmd != pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev))
 		return;
 
-	bt_dev_dbg(hdev, "err %d", err);
-
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
 	mgmt_pending_remove(cmd);
@@ -6153,7 +6160,8 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
-	if (cmd != pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
 		return;
 
 	bt_dev_dbg(hdev, "err %d", err);
@@ -8144,7 +8152,8 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 	u8 status = mgmt_status(err);
 	u16 eir_len;
 
-	if (cmd != pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev))
 		return;
 
 	if (!status) {
-- 
2.47.0

