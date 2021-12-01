Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbhLATxw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245471AbhLATxX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 14:53:23 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCCC06175B
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 11:49:57 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 200so24746265pga.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 11:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lwnjwWYZUXyv89BDhlHGsxhU+Iojma1jI1bg6g/VIKA=;
        b=Cn7mrB3/fG4F3l2C5BVIYIC5a9pl7Q+d/BXve9aIkbwUVacHhP9+M3wEuqlgk+4N+Y
         a3rZLf/3QMWayGG0FzdSWmo0ogJzpz4xBVUwkJ0x2rg2T2lys5fZfNv5RO/3iKvTLtcd
         EUKcoI7DipTZ/V1GHDe0oFhb6QqKZNwNiGACsqppprLwcywi692cfsYaJxNq0SH2fxP0
         9U4uTnxigeF3fTisHWQfXVYfZhz90iVrnSBST3K9Uh56vBaJ1FFZQJg8GlttirB/CY5/
         F+0KLpDRu6QIGnW7R9cgX6kuafOhN/ntIya/D1Na70Th1mIMpgwedlRwqkowwwMUJPSx
         c9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwnjwWYZUXyv89BDhlHGsxhU+Iojma1jI1bg6g/VIKA=;
        b=eavUUG56TCE2cXWuqXyVjLp7WTctJYXpCt8Fy+BQfyP6us7JPctTh+mMeAOp8ZkVx0
         8dT4DC7BltrNe5XEH5cy6jbIUSonR9qKaVVW1sjUsJWtjtf23BC5bqllyD61cLrk03Fy
         czI/MqDNe1YkFOSKZkXUSC7JEcXQ7h4Y71CkirZTrX7z4DNLS1siKGNhOC5j8LFMTpMM
         MwD9yVlhlEdHQjaJj34Kze3HJmTyQMt6crskhA7kxKkxqf35HHL7OCmAbnsqMmYOfEED
         hHVLwrkxGtmC9dp/nV0LI8P9aAEJN23I7PKSNqS0o8qRqFw0unRBq7W0XnUFRz2HCy/c
         E7IA==
X-Gm-Message-State: AOAM532S0rmTqoR4B60bk5gwwqN8umvA1mpvHi/B9iIKWaPuEn8HJQzx
        omOIjUjPS7bCs790o+Dp8KTKzfQmmXU=
X-Google-Smtp-Source: ABdhPJw+Pndk+ddLOtyy3f8tyvVUUYt4Lm+T+Tg4HyOkHzYSduDiwmmiDA678THfEgie5cHNziV7Ow==
X-Received: by 2002:a63:b608:: with SMTP id j8mr5921434pgf.519.1638388196302;
        Wed, 01 Dec 2021 11:49:56 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ip6sm122208pjb.42.2021.12.01.11.49.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:49:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list
Date:   Wed,  1 Dec 2021 11:49:52 -0800
Message-Id: <20211201194952.1537811-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201194952.1537811-1-luiz.dentz@gmail.com>
References: <20211201194952.1537811-1-luiz.dentz@gmail.com>
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
index 0d2a9216869b..3c6a1c5f3aed 100644
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
index 9d8d2d9e5d1f..90587aa29714 100644
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
@@ -3816,6 +3841,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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

