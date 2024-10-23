Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DBB13AA2B
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716964; cv=none; b=OdPr/awVJZ8UVb73HLHBgUslQaKcB2t/Cg2ItC2JzzMj7esN6VhFAyvU9hzG1b/h8ZzJ4/BFzcocRoNJcfY3E1kDr6q5hfqkFLLxpl3BhLwVS/cWxK7w3FW5xFjjVOK6Kss6FpoaNlj+nzhl+guhxOJsUQrW5lUC/gHFKuvoidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716964; c=relaxed/simple;
	bh=MNje4lVwfTi7itVUA51CkiV616DfgK13LHESsNg/0T4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CvrVbJXMloCos6+oQmvgMgpY6c9VVJ6myGU7QYKjsBBbgKzIi025NQn7qjedf556kFTxnS+kETJMMlVjYXbaxA9SywGtRxUrww1WXaxHx3QlQpqunWxcKNFpX4Li0KdS/i9dbTxzzuS3+fz1YH5p6SmhJzCau7O8bRgThK9g24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2PCb5QZ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2PCb5QZ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50d525be53eso63626e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716961; x=1730321761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RW+dCYMaZc/VV1QA2sZoDMhk8vjQIqeTqQZy2asMuio=;
        b=e2PCb5QZ2zVpER2+8D89JJzmq4ZGBfoaaJSsxtwjRjhXfQHJRpIp96unQxJ/oE6mBS
         pqal0uqmOq92UNc+YSykgav7xCXX1ClJqLE5xFl6SJEXdWXPztIr3280TUsPIFuzKXjo
         dbGQ1WFLsQMDpE/rWrI5CUVkOCU2QokvLtpWUAnZueOC8jlBoVMHv+CjOgSoF9yQ2FkA
         Qq3FU+VQvUVvzYGgIqG1p5ylb0XhI5KTuF4B9BrbThN/uACnXAmhg9H1AKNBTJyYTUsQ
         gtKc9o1fjKzhE4a7A90WXv/FYbqOiEjG+yG0YkkhxPb5IL1XO1N1+6Wa8rkgtmp6vV3j
         xKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716961; x=1730321761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RW+dCYMaZc/VV1QA2sZoDMhk8vjQIqeTqQZy2asMuio=;
        b=hRruBzLMtMjGXxEXfAvnkuCIalrudjiDMzmTasxEdwEmrK/mBb7IBpvvNPoNmU/h4M
         Inu+9JHicOJPE0hypSd6A17q4GxKVr6DpUKV7JikDYDFZuF8c7kzJRXJjNyBefVwPDXh
         deZD27K5am7BN1NIBUMWMoaIf4U8j1l09q857QcpHyFTnVRSKHUivpULsJpJORdEAQ/K
         qFmVf43a5zJY/Fz0yqtdTs0ABuFIUc4laju7c4h0pGI0pil32RoQTtz56ymS8wl/zMMX
         omGhtFYdcsb+ltKsFa2c8rPeVZb2XmM1rE/KlrQrZgE2GsgJFWHxHtlvlUlVil8d3/wy
         4zsQ==
X-Gm-Message-State: AOJu0YydCjTxh+uXt1xDCA4jRXoGrWit8IP8l+W8lmASp9wrz/TVPNZA
	DGhe+QENhrjLqZiiIeHuiJLVNIyEtUDN6r1vk1NZw5liGyI7iBAOQu2DeQ==
X-Google-Smtp-Source: AGHT+IFziYQY+J3GgrIupzg4CqpahNW8wTRnppe8+fBnpkj1n7lhgvdKDcnK33OO0ar5U2wpC99lxw==
X-Received: by 2002:a05:6122:2013:b0:50d:7a14:ddf7 with SMTP id 71dfb90a1353d-50fd0328b0dmr4985425e0c.8.1729716961212;
        Wed, 23 Oct 2024 13:56:01 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19ea1829sm1159775e0c.31.2024.10.23.13.55.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:55:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1] Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC
Date: Wed, 23 Oct 2024 16:55:57 -0400
Message-ID: <20241023205557.2425924-1-luiz.dentz@gmail.com>
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

