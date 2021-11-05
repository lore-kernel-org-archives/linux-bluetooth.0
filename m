Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF5B60EE9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhKEWaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 18:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhKEWaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 18:30:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5E7C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 15:27:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id r5so11963399pls.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wXT0AE6KNJe4yO+T+2zaKcXRVTLor83ZdZ3JBqCmjHY=;
        b=T8HWe7lPxz5avy9M36xfGCoL9sWFYPC7g4d3kTDLl/f4Dk5ltfM8kNCBNgXX5hlIr+
         N+Jvv8YK+j5eykp3mvPsJi4LB3iLDkDb/gMAZ6+upKjlAZRPnbEMstS+B51zGr5U2GEr
         xqA+4MSqA9eJ8iy8hJgmXtkSOOKdb2kaUcw1/9oksWZelkT9NE4ZXDx3wvHts0dV/CMS
         iRrl+ZyjKXEic7fo6PDTG44H+CM9hd1mmN5Nd2VfuXbEzK1DddPo4HXZRMHeJ8DH1cdb
         P+i22+xnJZ1GarSZcUjh+gyP8LMIZGPKMuHPTXvUeCFo9v4bplMJxel+ih4AkPSqWhRU
         Z5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXT0AE6KNJe4yO+T+2zaKcXRVTLor83ZdZ3JBqCmjHY=;
        b=abuPU8Vtt5FI7J8OLnnIgjiYgPcbqMSU/h8VAp5R6yzCbI4shrbqILG1VeQfjuCgYT
         neYrU8bIuXjFAr5+pQUbk4xoxucDCFw/HQvb2x4CWKXCIGpxQbkTOaHusOBIyaFiD7rb
         JDhIYDhhnIiz0sBx1m7zeP2okagtx4oEv5W/K/Kc557eO+XufytjTb/9Q/+QwEAytfh2
         vu3bhEg4ZqMMNSrLU2GAjuDsgli+Snb8d7F0QwyLYt5aUaJp+Rxls0/5XvZ0rv4Xz2GQ
         dpn9BopONVMms/Z6apzzZS+eR2fPUgtqpam7/rg49kyQcoW+5eYafJtUN0d9oQB4IiM2
         a4XQ==
X-Gm-Message-State: AOAM5339EANv8qmM0ZTuSnoZzM97+wpN5K0jVHwHc2gXxXlMKymcNwru
        w8bXgCTcq7o84XdZ7DJ6U70icYMMEJs=
X-Google-Smtp-Source: ABdhPJyBeMygm1GmJW8di9jkkbbd4BL59KvVKUaMBgywCpqqawhUY2L7p6r5lDUchsq2kneu4zgRAg==
X-Received: by 2002:a17:90a:fe84:: with SMTP id co4mr33099983pjb.211.1636151261485;
        Fri, 05 Nov 2021 15:27:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m22sm8027683pfo.71.2021.11.05.15.27.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:27:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list
Date:   Fri,  5 Nov 2021 15:27:39 -0700
Message-Id: <20211105222739.461398-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105222739.461398-1-luiz.dentz@gmail.com>
References: <20211105222739.461398-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Set Privacy Mode when updating the resolving list
when HCI_CONN_FLAG_DEVICE_PRIVACY so the controller shall use Device
Mode for devices programmed in the resolving list, Device Mode is
actually required when the remote device are not able to use RPA as
otherwise the default mode is Network Privacy Mode in which only
allows RPAs thus the controller would filter out advertisement using
identity addresses for which there is an IRK.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      | 10 ++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 29 +++++++++++++++++
 net/bluetooth/hci_sync.c         | 53 ++++++++++++++++++++++++++++----
 4 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63065bc01b76..979da5179ff4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1930,6 +1930,16 @@ struct hci_rp_le_read_transmit_power {
 	__s8  max_le_tx_power;
 } __packed;
 
+#define HCI_NETWORK_PRIVACY		0x00
+#define HCI_DEVICE_PRIVACY		0x01
+
+#define HCI_OP_LE_SET_PRIVACY_MODE	0x204e
+struct hci_cp_le_set_privacy_mode {
+	__u8  bdaddr_type;
+	bdaddr_t  bdaddr;
+	__u8  mode;
+} __packed;
+
 #define HCI_OP_LE_READ_BUFFER_SIZE_V2	0x2060
 struct hci_rp_le_read_buffer_size_v2 {
 	__u8    status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 07d2d099dc2a..cb5684da3ed4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -758,6 +758,7 @@ struct hci_conn_params {
 
 	struct hci_conn *conn;
 	bool explicit_connect;
+	uint8_t privacy_mode;
 	u32 current_flags;
 };
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4b75a6cfeee..9cadc543abcb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1300,6 +1300,31 @@ static void hci_cc_le_read_transmit_power(struct hci_dev *hdev,
 	hdev->max_le_tx_power = rp->max_le_tx_power;
 }
 
+static void hci_cc_le_set_privacy_mode(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *)skb->data);
+	struct hci_cp_le_set_privacy_mode *cp;
+	struct hci_conn_params *params;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PRIVACY_MODE);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	params = hci_conn_params_lookup(hdev, &cp->bdaddr, cp->bdaddr_type);
+	if (params)
+		params->privacy_mode = cp->mode;
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 *sent, status = *((__u8 *) skb->data);
@@ -3812,6 +3837,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_transmit_power(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_PRIVACY_MODE:
+		hci_cc_le_set_privacy_mode(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b794605dc882..32ed7da3b6dd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1580,8 +1580,42 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+/* Set Device Privacy Mode. */
+static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
+					struct hci_conn_params *params)
+{
+	struct hci_cp_le_set_privacy_mode cp;
+	struct smp_irk *irk;
+
+	/* If device privacy mode has already been set there is nothing to do */
+	if (params->privacy_mode == HCI_DEVICE_PRIVACY)
+		return 0;
+
+	/* Set Privacy Mode requires the use of resolving list (aka. LL Privacy)
+	 * by default Network Mode is used so only really send the command if
+	 * Device Mode is required (HCI_CONN_FLAG_DEVICE_PRIVACY).
+	 */
+	if (!privacy_mode_capable(hdev) ||
+	    !hci_conn_test_flag(HCI_CONN_FLAG_DEVICE_PRIVACY,
+				params->current_flags))
+		return 0;
+
+	irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
+	if (!irk)
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.bdaddr_type = irk->addr_type;
+	bacpy(&cp.bdaddr, &irk->bdaddr);
+	cp.mode = HCI_DEVICE_PRIVACY;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PRIVACY_MODE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 /* Adds connection to allow list if needed, if the device uses RPA (has IRK)
- * this attempts to program the device in the resolving list as well.
+ * this attempts to program the device in the resolving list as well and
+ * properly set the privacy mode.
  */
 static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 				       struct hci_conn_params *params,
@@ -1590,11 +1624,6 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 	struct hci_cp_le_add_to_accept_list cp;
 	int err;
 
-	/* Already in accept list */
-	if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
-				   params->addr_type))
-		return 0;
-
 	/* Select filter policy to accept all advertising */
 	if (*num_entries >= hdev->le_accept_list_size)
 		return -ENOSPC;
@@ -1620,6 +1649,18 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 		return err;
 	}
 
+	/* Set Privacy Mode */
+	err = hci_le_set_privacy_mode_sync(hdev, params);
+	if (err) {
+		bt_dev_err(hdev, "Unable to set privacy mode: %d", err);
+		return err;
+	}
+
+	/* Check if already in accept list */
+	if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
+				   params->addr_type))
+		return 0;
+
 	*num_entries += 1;
 	cp.bdaddr_type = params->addr_type;
 	bacpy(&cp.bdaddr, &params->addr);
-- 
2.31.1

