Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02201C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 23:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA15361A81
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 23:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKRXQF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKRXQF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 18:16:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC7C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 15:13:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so7149394pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 15:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYdUcxwZgdoNimqI0BNpqpVCtxd7ojVPvU/h10KvHIE=;
        b=fuv4IaVBUjjRpVK9Hdptuw76wI2g5oacHREiqV+llmDdva/N+kfLX6BzoC/YeHIWKd
         182RY29UaODQiYoybLXnXgkxkONsDxbfXi6fOPSgRhOn56DWkBtpi29r6pd7vxERH2Mb
         KlXjkE82m6/lxASEdmjZ64EE+VbE1Q6bO+mxG3eYDs9reG0U5xuQH+PGQzBHIPVIcFdy
         DI5YPEh098le+H8uu9nbHx4InWOKFHq7Hly8hrVCPjzUejOlpyT70uDP98iockb3eLMS
         giwGDdFtqIQ/fBNJ7Ah2M4OLr80got/3pBqPHp4lSoDq4HrdMpE0U7MGg76aV00rDsc7
         5+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYdUcxwZgdoNimqI0BNpqpVCtxd7ojVPvU/h10KvHIE=;
        b=Jh2/Yqc2xvxfHqomfIOAREXOvLxE4k1tR78U2ZNtt4VNSvtYKUZ/B28AUHDRTc8wcV
         XKnBHTz17qDwyyV9A4PGfEAI93jPvu8f3kwcqV0TZfBO2pxAzeJsALMm3pwhzJHfupP1
         uJnW5rNhyKS6esnWHtuPGqsUE7FyDKruLRBWreAJEjZaDdugDZVeje2gluasCywVtnwZ
         /W1OiTtcnyRBOMLvO0xhsMMLKBq/iEy7mOQ+AfT7QyHvEDksBy/MNeLruYHgxDW3zSV2
         e1He5s9Qwz1ah1pcoM41jO2MZP5fdIrSdqQ5W3tF0DGPqbPsdzq86yQ0XEk6NYmGC1YZ
         ZUMw==
X-Gm-Message-State: AOAM531c8L7eqwOl1a85AffspZjhKJi2g197dlhslamtu0e+Xwa0fYpF
        DPFFDfIaOsb+NL/TyYaMAzDDVIDyhyQ=
X-Google-Smtp-Source: ABdhPJxFon+XKcVXWFvxyMwSz04jAUp4hLu6EnMalpe+CVX+CQRORa17f5NmoXEQvqyuCFwfXGNRkQ==
X-Received: by 2002:a17:90a:800a:: with SMTP id b10mr15121344pjn.162.1637277184034;
        Thu, 18 Nov 2021 15:13:04 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c6sm626956pfd.114.2021.11.18.15.13.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:13:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag
Date:   Thu, 18 Nov 2021 15:13:01 -0800
Message-Id: <20211118231302.1000168-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
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
v2: Fix supported flags not actually checking if the hdev really
supports the flags.

 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/mgmt.c             | 30 ++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2560cfe80db8..42ba40df6e20 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -160,6 +160,7 @@ struct bdaddr_list_with_flags {
 
 enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_DEVICE_PRIVACY,
 	HCI_CONN_FLAG_MAX
 };
 
@@ -1465,6 +1466,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
 			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
 
+#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
+				   (hdev->commands[39] & 0x04))
+
 /* Use enhanced synchronous connection if command is supported */
 #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f8f74d344297..d82d1a62754a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4349,7 +4349,22 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			       MGMT_STATUS_NOT_SUPPORTED);
 }
 
-#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
+static u32 supported_device_flags(struct hci_dev *hdev)
+{
+	u32 flags = 0;
+
+	/* Check if adapter can wakeup the system */
+	if (hdev->wakeup && hdev->wakeup(hdev))
+		flags |= BIT(HCI_CONN_FLAG_REMOTE_WAKEUP);
+
+	/* Check if Privacy Mode can be set */
+	if (privacy_mode_capable(hdev))
+		flags |= BIT(HCI_CONN_FLAG_DEVICE_PRIVACY);
+
+	bt_dev_err(hdev, "flag 0x%8x", flags);
+
+	return flags;
+}
 
 static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 data_len)
@@ -4358,7 +4373,7 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_rp_get_device_flags rp;
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
-	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
+	u32 supported_flags = supported_device_flags(hdev);
 	u32 current_flags = 0;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
 
@@ -4422,7 +4437,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
-	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
+	u32 supported_flags = supported_device_flags(hdev);
 	u32 current_flags = __le32_to_cpu(cp->current_flags);
 
 	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
@@ -4455,6 +4470,13 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -7060,7 +7082,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
 	device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
-			     SUPPORTED_DEVICE_FLAGS(), current_flags);
+			     supported_device_flags(hdev), current_flags);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				MGMT_STATUS_SUCCESS, &cp->addr,
-- 
2.33.1

