Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B87EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 01:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhKTB14 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 20:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhKTB1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 20:27:55 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57CEC06173E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 17:24:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g18so10749803pfk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 17:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=If8FJGg63DqnvU7+4I0Jh+c2EGLFpFlzl03qagd5DJQ=;
        b=oHVE9j3hD/IIeB/9RDabz1qGIuShem/dmIftSfmBnxjOSdOHjg0N1sl7OCtuDMFHXS
         /9w9jxsvvGTwp3wqv2CHx6lw4lmwATQCJCwWc6zO3Wxg5qHsomBIFbNcNoRqAYtDLiZi
         xcGjr0wVxGGy5WImmoZBEicmqqx4qW8YGl2rpjOBvIkTlNcLfVxF44C0TCRlrUDzsleV
         UX+rRVPg2yoMXCf8LNDaFFxvFh7hvPSil18zLy8tnvdWU1Ozd9NVHGFizC4LrBNq3TQE
         MbvOCRwZNHwhPtHFJThk18KrZJAKt9R6oLbUK9gGJDPb/WdDXcYSi5pxr0rMbT/WiUpW
         zreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=If8FJGg63DqnvU7+4I0Jh+c2EGLFpFlzl03qagd5DJQ=;
        b=u+vhQ8zhS20KTsL74laLLwliiiyxFBheQDjoQfO2KOW1s+P/KohPuUY3slhtVLOF6P
         TFy8h+dCHZB8i0DtlahH3IT4JydCd4UCo4Gqvwc4MF/O35ldfCBQM3Hl5WHZkLJ1I4d1
         Z5l3O1iNzOwAIR9D1rmkuRsAzkuJE4VEPQRsL7BVIzGS+qr/plNPHo10e6AvFedtqx6G
         nWwIJReKX5jDL8T/0qwhIMLpxNm/nfSfNDNfAjdrvxX228QhFpeYcLO1xfkFJMRtbUhO
         X8nrmzchYbOrYEQG/WgIuxU3Z8kZfb89ff+VE+ouLBkNHze9/sFdaEfdlXX8ZNJOWn8U
         a9Ig==
X-Gm-Message-State: AOAM532ekQvl8GrlJiib+WF0ypTihGaOY0GrVDRRQA84gkLSo49IEJGO
        cItW7IFy2MRoeiHOKonMczn+Stf5KcI=
X-Google-Smtp-Source: ABdhPJx8EH5lOmR9hUdAfxphpBALvl7rniOHrdPO0u1eD1g69dU80wJP07/vhQaIbHu7o5LWiKW+fg==
X-Received: by 2002:a65:4209:: with SMTP id c9mr20177712pgq.399.1637371491838;
        Fri, 19 Nov 2021 17:24:51 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c2sm801970pfv.112.2021.11.19.17.24.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 17:24:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list
Date:   Fri, 19 Nov 2021 17:24:48 -0800
Message-Id: <20211120012448.1476960-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120012448.1476960-1-luiz.dentz@gmail.com>
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_event.c        | 29 ++++++++++++++++++
 net/bluetooth/hci_sync.c         | 51 ++++++++++++++++++++++++++++----
 4 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 84db6b275231..7444d286e6be 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1931,6 +1931,16 @@ struct hci_rp_le_read_transmit_power {
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
index 9c94d1c49b25..427c5af9eb41 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -756,6 +756,7 @@ struct hci_conn_params {
 	struct hci_conn *conn;
 	bool explicit_connect;
 	DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
+	u8  privacy_mode;
 };
 
 extern struct list_head hci_dev_list;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index efc5458b1345..51c88f4f1274 100644
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
index 5f44ff0b8910..eada6a39068e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1580,8 +1580,40 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
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
@@ -1590,11 +1622,6 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
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
@@ -1620,6 +1647,18 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
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

