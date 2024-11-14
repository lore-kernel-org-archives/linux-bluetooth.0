Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043B19AA58
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609654; cv=none; b=i/8Waw06k/2vt/sdPkt1hUKNshBQBebv2dj9ElxUjhQN0OEfJnVuxtwfDrlbCjU2wOKD1L1bFQ3XkWMHg1r7zSlG5aFRWbZMTDH7vYv/tJeCqWSXBngRXMw5wcU0S336ttLO0UBSZ8oQymXxKl3AniSWNz3AAC3PsAbMGwu1fD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609654; c=relaxed/simple;
	bh=MNje4lVwfTi7itVUA51CkiV616DfgK13LHESsNg/0T4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qw9fO/i3aj7CfZze635ME9jjHcPIiWeC7IfBEod9F3VuqreCFa2E9jxS9YGAPejQQps89hyc23qiflW1iXt0v7GyJPQ3jb7+gRbG1OfGlvHmBEOxlmdYnKjepfao5Qk8siwL/gAuTtKXkukTIvjqJHAINo09Q7XJT9U5yxjoTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgcAFK+p; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgcAFK+p"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d3998923dso455506e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731609651; x=1732214451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RW+dCYMaZc/VV1QA2sZoDMhk8vjQIqeTqQZy2asMuio=;
        b=bgcAFK+pg5XtdWercpKqrM/stiFQKgjd5eKm3ZCIP6GUFfbrRNBKYM4TJlXtJGtW5Z
         XjIkBf+El7c88HSxVHWjCOcfL5+erXRxhrbgW4dzBlkFKxx8vujEJHlPPYB2JPkBNsbX
         mZiN2pIh5ZD8ytno8PWngVPIk/9SONaXhJen8SFmczlxVqBUwVXN0H4u7ibxozJnO2uj
         Rvh4l7Kt7/zFiB3E/AADAB7O0uI2r9ihUVTxUCQgAejo8bht/6dFXW/nzw4sk9whIlzz
         uCJZ3Punl+TE5KtrafOnmwpR+4xbdsXBuia6RAdWm3v+OSuG34lhXizcVfk2znNx1s6/
         4xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609651; x=1732214451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RW+dCYMaZc/VV1QA2sZoDMhk8vjQIqeTqQZy2asMuio=;
        b=o/HR2jAFUpdY5nh7RLN+isCrTSC9aGY2wKN7meV1fLIHUTRAcjpHSWvNPS0sQe4Fy3
         WJmUmIc7Ox6/lMaaKZNsgreIo0FbXHzNzGAyKiTji9xobXn8LX3dDrWs2v8YF3Z7OygZ
         7F8VuTHzxvivB10Pq7DZGI5IkxcFzCZW5aRvkAwwjidY4VxPPxdZQJXQUIqGtpy0oFW7
         qT0MBQLilTQVTt6p9A0O1tc4YSHiE44HL74z6jwsqa6NsfD8ENrcrs63XrxgzvNNhRXX
         qpSW+qOHezcEu6wWLVMUpX4H568dWmZpCxMQ10xq6J5uNts0wjyWRdiM/PB2ZXpUr/r7
         WY0w==
X-Gm-Message-State: AOJu0Yy+/GqQdVNtxokKrFlt/7S71aUVqMh4WLi1ThyoxK/Eq1JM9JN6
	yQ3SIEjtt1XEHpAszOt6/AR4hyQUF9Ald4b+LS9VCZRhhvCEb6mHj41LnQ==
X-Google-Smtp-Source: AGHT+IG3jOIE5O1D4U5V2xhs/fPZwxl/obUdFKSeCvP+Mk77V6b9XYWOUXXpMmHxP3bt2lAMByS9GA==
X-Received: by 2002:a05:6102:370d:b0:49b:cfbc:63ac with SMTP id ada2fe7eead31-4ad62b6574fmr147004137.6.1731609650551;
        Thu, 14 Nov 2024 10:40:50 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ad5976085fsm227608137.18.2024.11.14.10.40.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:40:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC
Date: Thu, 14 Nov 2024 13:40:46 -0500
Message-ID: <20241114184046.1690311-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial implementation of MGMT_OP_HCI_CMD_SYNC as
documented in mgmt-api (BlueZ tree):

Send HCI command and wait for event Command
===========================================

	Command Code:		0x005B
	Controller Index:	<controller id>
	Command Parameters:	Opcode (2 Octets)
				Event (1 Octet)
				Timeout (1 Octet)
				Parameter Length (2 Octets)
				Parameter (variable)
	Return Parameters:	Response (1-variable Octets)

	This command may be used to send a HCI command and wait for an
	(optional) event.

	The HCI command is specified by the Opcode, any arbitrary is supported
	including vendor commands, but contrary to the like of
	Raw/User channel it is run as an HCI command send by the kernel
	since it uses its command synchronization thus it is possible to wait
	for a specific event as a response.

	Setting event to 0x00 will cause the command to wait for either
	HCI Command Status or HCI Command Complete.

	Timeout is specified in seconds, setting it to 0 will cause the
	default timeout to be used.

	Possible errors:	Failed
				Invalid Parameters

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/mgmt.h | 10 ++++++
 net/bluetooth/mgmt.c         | 60 ++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d382679efd2b..affac861efdc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -878,6 +878,16 @@ struct mgmt_cp_mesh_send_cancel {
 } __packed;
 #define MGMT_MESH_SEND_CANCEL_SIZE	1
 
+#define MGMT_OP_HCI_CMD_SYNC		0x005B
+struct mgmt_cp_hci_cmd_sync {
+	__le16 opcode;
+	__u8   event;
+	__u8   timeout;
+	__le16 params_len;
+	__u8   params[];
+} __packed;
+#define MGMT_HCI_CMD_SYNC_SIZE		6
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a429661b676a..1f6d083682b8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -132,6 +132,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_MESH_READ_FEATURES,
 	MGMT_OP_MESH_SEND,
 	MGMT_OP_MESH_SEND_CANCEL,
+	MGMT_OP_HCI_CMD_SYNC,
 };
 
 static const u16 mgmt_events[] = {
@@ -2515,6 +2516,64 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	return err;
 }
 
+static int send_hci_cmd_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_hci_cmd_sync *cp = cmd->param;
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cp->opcode),
+				le16_to_cpu(cp->params_len), cp->params,
+				cp->event, cp->timeout ?
+				msecs_to_jiffies(cp->timeout * 1000) :
+				HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
+				mgmt_status(PTR_ERR(skb)));
+		goto done;
+	}
+
+	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_HCI_CMD_SYNC, 0,
+			  skb->data, skb->len);
+
+	kfree_skb(skb);
+
+done:
+	mgmt_pending_free(cmd);
+
+	return 0;
+}
+
+static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
+			     void *data, u16 len)
+{
+	struct mgmt_cp_hci_cmd_sync *cp = data;
+	struct mgmt_pending_cmd *cmd;
+	int err;
+
+	if (len < sizeof(*cp))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+	cmd = mgmt_pending_new(sk, MGMT_OP_HCI_CMD_SYNC, hdev, data, len);
+	if (!cmd)
+		err = -ENOMEM;
+	else
+		err = hci_cmd_sync_queue(hdev, send_hci_cmd_sync, cmd, NULL);
+
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
+				      MGMT_STATUS_FAILED);
+
+		if (cmd)
+			mgmt_pending_free(cmd);
+	}
+
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 /* This is a helper function to test for pending mgmt commands that can
  * cause CoD or EIR HCI commands. We can only allow one such pending
  * mgmt command at a time since otherwise we cannot easily track what
@@ -9371,6 +9430,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ mesh_send,               MGMT_MESH_SEND_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ mesh_send_cancel,        MGMT_MESH_SEND_CANCEL_SIZE },
+	{ mgmt_hci_cmd_sync,       MGMT_HCI_CMD_SYNC_SIZE, HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.47.0

