Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E936CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 05:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED8260F4B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 05:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKBFxx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 01:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBFxw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 01:53:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FABC061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 22:51:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 127so18540025pfu.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glQswEOcHw9XGuPa3ESO7PVEzT52H3+EJo0OoWVWAOg=;
        b=eABnaUabcLnK7/9yHXuGP8gprCcpDPXrajOS5Q80WXvEpLjOO14mF9huSdqZO0wF4U
         vwqSNd9XoUIyTCj4eI0OEeaKk8y58bEDo1c3UeFfdjxe0lg9zA8RPe/WCxgAsuD0UyiR
         R4YAOl7sln8wdlHxfTRq3t63n/ERL4ALxv5pz8iNkdTHPvKYh4cIY6IdS6tImlJech9v
         IJuvcRQF4RwE9pM7gHZ6g0fQMP0rTk2DeNM97WjBBFUEg/0cBlpGfdU0HKTNNzEHuOj4
         4t5OdCHaZN9rCe4RJZITe3m9pzCGJZ+RW7auBhP93tuMUi4aIuy1GJU8jqXsW6OR99eL
         +dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glQswEOcHw9XGuPa3ESO7PVEzT52H3+EJo0OoWVWAOg=;
        b=6bOtHdXJO3ajvkGDL8tFlgLin4vjuUDygKZ9IhFXAh0k9urA64gDZOuxirNAuCq4XU
         WZ5G9Z6O1a1w2zCKFIgRb+umX2Ay9V0O3oxMrwGOjV3MFPs6WaOsL4B7/lrETEyDu+Mr
         6aOvZHmCzteYdtbDzLxL7tRWf68vUIREbZE93etkjGr9euQE6B064mkuarAAPANHpcYR
         KzSi8Bp6ULuWMvBhFs0eT3OUMD8brFxRTJ2S48XvnZkv4Cnv7nk24ABGa/b0H66j6clQ
         kPLRf+u3T/pttLfh8xat0gKl6PxPfFOswxUaq4Z7+0qVj932ssLKBTXPLzAZnJe0GKAg
         aQ3Q==
X-Gm-Message-State: AOAM530f8uKMGZHVNVdRQodrG3s9VoHBSjl6bfkli3ApJLZx0jRIQw5S
        RPmf+mBaOKYROd2yxb+zcQ9rE6F/qfE=
X-Google-Smtp-Source: ABdhPJxPi7RmzZVZD95r6WvjG9r0V1n0UMKKW140G8OaXIy5ze6gB0R3ztkdhrNb2ffOybhoA1uVdg==
X-Received: by 2002:a05:6a00:2353:b0:47e:64c3:57c3 with SMTP id j19-20020a056a00235300b0047e64c357c3mr28340849pfj.72.1635832277320;
        Mon, 01 Nov 2021 22:51:17 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u12sm17377862pfi.18.2021.11.01.22.51.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 22:51:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list
Date:   Mon,  1 Nov 2021 22:51:16 -0700
Message-Id: <20211102055116.2898794-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Set Privacy Mode when updating the resolving list
when HCI_LIMITED_PRIVACY so the controller shall use Device Mode for
devices programmed in the resolving list, Device Mode is actually
required when the remote device are not able to use RPA as otherwise the
default mode is Network Privacy Mode in which only RPA are allowed thus
the controller would filter out advertisement using the identity address
for which there is an IRK.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  7 ++++++
 net/bluetooth/hci_sync.c    | 48 ++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63065bc01b76..aa856dfd5b9f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1930,6 +1930,13 @@ struct hci_rp_le_read_transmit_power {
 	__s8  max_le_tx_power;
 } __packed;
 
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
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b794605dc882..43173d645436 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1580,8 +1580,37 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+/* Set Device Privacy Mode. */
+static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
+					struct hci_conn_params *params)
+{
+	struct hci_cp_le_set_privacy_mode cp;
+	struct smp_irk *irk;
+
+	/* Set Privacy Mode requires the use of resolving list (aka. LL Privacy)
+	 * by default Network Mode is used so only really send the command if
+	 * Device Mode is required (HCI_LIMITED_PRIVACY).
+	 */
+	if (!use_ll_privacy(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
+		return 0;
+
+	irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
+	if (!irk)
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.bdaddr_type = irk->addr_type;
+	bacpy(&cp.bdaddr, &irk->bdaddr);
+	cp.mode = 0x01;
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
@@ -1590,11 +1619,6 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
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
@@ -1620,6 +1644,18 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
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

