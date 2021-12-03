Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0903C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 22:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383335AbhLCWKv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383333AbhLCWKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 17:10:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1D4C061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 14:07:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so6184044pjb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kGvP+yY35MjOJ56AmGd6APYmqXWKHNXhOu3ZawARdQc=;
        b=hvd7YhJrCURUgusqSWAiHheQo14JIMgFtFvgZDs6TdpjXcS39jsH3Zy40jJEouK4po
         CVFG3ZrV43c6fhiKfnGDwtPgsXZ+zCTwvVWrO9F3VSKp5+FenwksWPzWTZ1Qa+OGu5oz
         diM8n4II2wqfY4hsRM8vC2y+MxSmS5thU+BnkISVw/jIyziYmIdfbG8RWm937PkfoiIK
         UuqYTqTJACSCMgRF5uJsmk9MXKOxul6zZ9xIzS/cXneqf+yW6LZAKgIK/flPLeIQDgiS
         njiB+Ni4GL+WcMeMb9a37WWqmJIDWCgE3OMQL/dW6cEyxk9WvkE4khNk4/KslAmtxD+Z
         343g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGvP+yY35MjOJ56AmGd6APYmqXWKHNXhOu3ZawARdQc=;
        b=O92h3quDrRGkoK8dXB3x0DzIcJc2r/1GVcMNZ52g3DavMaPkJi+jr4CwSGTT19mLjo
         K4mTMqUe7jwUgXtBlLNzs5vNY1Qh/cmLI9tljHhe5tpY8QvDyu8mFr/i1tyw2o1TXKLi
         qDqyN24KOfU1L1GwSNBlIS7k0YZeGiYBoTtTdIIcybaj/7PV3voQ32ucc1b9fZePZJH2
         fR7+h9FijGZPdOUcmUwoscgNw3dNIjRXvhY1OT/pOnnlo/kRceUGWRYhFKeLr8lKfU3c
         fJLAv9Zc1s3bPp24k4I7FEOl2SdsAWu9s6SE0dmkvORMlKlGRZ7Jpoyl1v50NePC8clw
         w3zg==
X-Gm-Message-State: AOAM533A+hxihOQF34j0/EYXH0n1uVhiHKl9TJoqH/QTZUwUYrRCpXCs
        vacBUMReRQYkMZ55XwnZfZX9IoNDWq8=
X-Google-Smtp-Source: ABdhPJxD/ppyG6n7ck9KTD3TTpjAopP4RSB1EBL1BemPGJaxb6RykKHhZR0THA6TWqdbgbXSAw9UqQ==
X-Received: by 2002:a17:902:e749:b0:141:edaa:fde1 with SMTP id p9-20020a170902e74900b00141edaafde1mr26158349plf.72.1638569245771;
        Fri, 03 Dec 2021 14:07:25 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m15sm4274389pfk.186.2021.12.03.14.07.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:07:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list
Date:   Fri,  3 Dec 2021 14:07:23 -0800
Message-Id: <20211203220723.2302153-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203220723.2302153-1-luiz.dentz@gmail.com>
References: <20211203220723.2302153-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci.h      | 10 +++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 30 ++++++++++++++++++-
 net/bluetooth/hci_sync.c         | 51 ++++++++++++++++++++++++++++----
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c5f6b82b9d11..7f5f00ff53da 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1940,6 +1940,16 @@ struct hci_rp_le_read_transmit_power {
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
index cf24af649c7f..4d69dcfebd63 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -757,6 +757,7 @@ struct hci_conn_params {
 	struct hci_conn *conn;
 	bool explicit_connect;
 	DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
+	u8  privacy_mode;
 };
 
 extern struct list_head hci_dev_list;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index df1aca5f28da..c15289b59c3c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1489,6 +1489,33 @@ static u8 hci_cc_le_read_transmit_power(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_set_privacy_mode(struct hci_dev *hdev, void *data,
+				     struct sk_buff *skb)
+{
+	struct hci_ev_status *rp = data;
+	struct hci_cp_le_set_privacy_mode *cp;
+	struct hci_conn_params *params;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PRIVACY_MODE);
+	if (!cp)
+		return rp->status;
+
+	hci_dev_lock(hdev);
+
+	params = hci_conn_params_lookup(hdev, &cp->bdaddr, cp->bdaddr_type);
+	if (params)
+		params->privacy_mode = cp->mode;
+
+	hci_dev_unlock(hdev);
+
+	return rp->status;
+}
+
 static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
@@ -3887,7 +3914,8 @@ static const struct hci_cc {
 	HCI_CC_STATUS(HCI_OP_LE_REMOVE_ADV_SET, hci_cc_le_remove_adv_set),
 	HCI_CC_STATUS(HCI_OP_LE_CLEAR_ADV_SETS, hci_cc_le_clear_adv_sets),
 	HCI_CC(HCI_OP_LE_READ_TRANSMIT_POWER, hci_cc_le_read_transmit_power,
-	       sizeof(struct hci_rp_le_read_transmit_power))
+	       sizeof(struct hci_rp_le_read_transmit_power)),
+	HCI_CC_STATUS(HCI_OP_LE_SET_PRIVACY_MODE, hci_cc_le_set_privacy_mode)
 };
 
 static u8 hci_cc_func(struct hci_dev *hdev, const struct hci_cc *cc,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c1b01718a797..3d28ca7ebe45 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1597,8 +1597,40 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
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
+	/* Check if HCI_CONN_FLAG_DEVICE_PRIVACY has been set as it also
+	 * indicates that LL Privacy has been enabled and
+	 * HCI_OP_LE_SET_PRIVACY_MODE is supported.
+	 */
+	if (!test_bit(HCI_CONN_FLAG_DEVICE_PRIVACY, params->flags))
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
@@ -1607,11 +1639,6 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
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
@@ -1637,6 +1664,18 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
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
2.33.1

