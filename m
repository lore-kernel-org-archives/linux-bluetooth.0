Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80196112D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhKEWaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhKEWaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 18:30:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F1C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 15:27:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x16-20020a17090a789000b001a69735b339so4340750pjk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXh6LcS8WuM/Nwc8Y03F4QEMAbQojxTk3+OuikepvHY=;
        b=DnVix+6uvn02irV3C14RRJmMPY7AgRPkO2brsTMAj0SLdMHta2SjYV/s34Ky0Gqt4M
         5qQ06S3JqwC0q2Etk6WM4fF38v3Ll84pQWzfFQhKPJ1dSLL6hRQvSUqi9HTyJ7JqyA58
         AlAuUlqcHU2L8pz3+cFSnjdkVv7lkb7fYSS/YGZc+5HZwWqe1/c/zUoSWH1pg0zJi1P5
         rmN7DTWDLya1aNYGuQ+R7xRkcxSN1TDmvxo+7HbFU9IpFXgef4HfxPtaDsuwr2mSPCBB
         9KONlfdpxt5s7JT8HITI/bQQ7Me8iOKrAN3q5zEUvkdHFayvzBwhr4+DHZc+xpBqUeYp
         /I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXh6LcS8WuM/Nwc8Y03F4QEMAbQojxTk3+OuikepvHY=;
        b=B/s4cj0xQobPv3ewhRqPlt2hjrM0qJ09sIVtiKU6Dy3xyx8xD0rN07fCXwCFhjR8TC
         u5tTYooWv5ps0JDO4DdKmeGTpKow+2fNo84ybAaKXZlUxtrdfUxrx/8DPnnt5wKSU1El
         CD+Q5jXlKaevIj9M9rzyV+sOMpO4Fnvgr+KJIG8yk6j+4KAJF6SYC7LPierPGkAyCt3r
         eacp+Z5HCJTVhjmqUzKeCd93x9cqHoGuxUy7mO1WG9g9b/dKCPdfGQkdFOCNGWfUgAfC
         iDD62AP4y7kraQAkyQ5hSoD7vBhXVK3rYOvX5UzhVCbh/m/ryeEoIfeLyGv+jLAjxhKA
         xCkA==
X-Gm-Message-State: AOAM530FyLjqJKH0HKSHo0jV5SfqdL9ysA4TKT7bUTkgu1RBq/qJrj5R
        02/JeEDN1/lTw7usui7EVCM8jl6tXNY=
X-Google-Smtp-Source: ABdhPJwdcC16IXXpUk6MAVbeOMdbIDjuaC0HTQVWeWeLb6vtFNinymY2T4swpKauO1EeFgfNNM4CFw==
X-Received: by 2002:a17:90b:38c1:: with SMTP id nn1mr33050552pjb.91.1636151260546;
        Fri, 05 Nov 2021 15:27:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m22sm8027683pfo.71.2021.11.05.15.27.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:27:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag
Date:   Fri,  5 Nov 2021 15:27:38 -0700
Message-Id: <20211105222739.461398-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
userspace to indicate to the controller to use Device Privacy Mode to a
specific device.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix marking Device Privacy Flag even when adapter is not capable of
handling Set Privacy Mode.

 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b5f061882c10..07d2d099dc2a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -160,6 +160,7 @@ struct bdaddr_list_with_flags {
 
 enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_DEVICE_PRIVACY,
 	HCI_CONN_FLAG_MAX
 };
 
@@ -1468,6 +1469,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
 			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
 
+#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
+				   (hdev->commands[39] & 0x04))
+
 /* Use enhanced synchronous connection if command is supported */
 #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 06384d761928..8a8376d32be3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4350,7 +4350,16 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			       MGMT_STATUS_NOT_SUPPORTED);
 }
 
-#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
+static u32 supported_device_flags(struct hci_dev *hdev)
+{
+	u32 flags = BIT(HCI_CONN_FLAG_MAX) - 1;
+
+	/* Check if Privacy Mode can be set */
+	if (!privacy_mode_capable(hdev))
+		flags &= ~BIT(HCI_CONN_FLAG_DEVICE_PRIVACY);
+
+	return flags;
+}
 
 static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 data_len)
@@ -4359,7 +4368,7 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_rp_get_device_flags rp;
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
-	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
+	u32 supported_flags = supported_device_flags(hdev);
 	u32 current_flags = 0;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
 
@@ -4423,7 +4432,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
-	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
+	u32 supported_flags = supported_device_flags(hdev);
 	u32 current_flags = __le32_to_cpu(cp->current_flags);
 
 	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
@@ -4456,6 +4465,13 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (params) {
 			params->current_flags = current_flags;
 			status = MGMT_STATUS_SUCCESS;
+
+			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
+			 * has been set.
+			 */
+			if (hci_conn_test_flag(HCI_CONN_FLAG_DEVICE_PRIVACY,
+					       params->current_flags))
+				hci_update_passive_scan(hdev);
 		} else {
 			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
 				    &cp->addr.bdaddr,
@@ -7061,7 +7077,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
 	device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
-			     SUPPORTED_DEVICE_FLAGS(), current_flags);
+			     supported_device_flags(hdev), current_flags);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				MGMT_STATUS_SUCCESS, &cp->addr,
-- 
2.31.1

