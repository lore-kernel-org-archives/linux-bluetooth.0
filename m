Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9A1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EBB610C8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbhIIVLn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhIIVLm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 17:11:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36865C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 14:10:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83-20020a251956000000b0059948f541cbso4135032ybz.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EzCly2IhLub3yTPz+QJq5talI0o62yb80+Qjbtl+nGo=;
        b=VcAtSABG8BEMujD8A4rqWdUl6SqduWjgen5J92loVfZupWYpQlz0dsarhBO6KFVas6
         v3ANAk9xNSiT+NFdvJF/upmik7QwYCTyjX5kGkD5UV2Fj2q1adZyaZzZXGQRc8Q+l+Sb
         SL9ajCFZvHvFmfaeNz9AePBWfrs6dmHz7GggB57OcsAhzEyQCsckw9EnkT4Gu5jM3bvY
         U4lYzboNafeBs5xS2jI0jzoepEIfl3JwM3S8ks0+xRW5s77+UoQmKgYV5k5pjOKEaT3P
         zI7hNX7fELKX29JtgK5jyjBLSX4x6ZkJchA9ybMb0XJLpWlXpKgmXiuZ4PF98SZiZxpi
         wSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EzCly2IhLub3yTPz+QJq5talI0o62yb80+Qjbtl+nGo=;
        b=1+wMRwUQrXrm9aVtXFgUN3cWGm4Dj+T9h6yh7EhZqXiFPPmY7TtTXxcoJP8qgU9DJw
         8Co57BF96dy0tW3XKm2wzMsdxTvrqyKmyCdzafy8h2R1J44/NaO4urRMI9UgTaDaxMBn
         GmNDmlbxNAE8nxheTfa9+H8xQKvHunSrY6wI7e9Fec30BIZDMQmSprZRDqx3lDB4+faD
         58KbOTae6a2HaHQhIqOWlmxll+H5XkabBnc5G+KeQTLSZcWWDJLKokDAxA6NkgO/EhgN
         2VfqtSmFj10RXdwHzf20yCgRoPHOaJkXJVSy9UG5bY7bw64OOEWH5FTfehwRr+hqIbpl
         t/zg==
X-Gm-Message-State: AOAM532DGy9K0A5sCaB7vlABfaLyGCOZ1WnnyP7z6+FTBpegQ8Xk7EH8
        1ji8aKzY02yZ6+n+RJhfKz+rqZd7eTunzA==
X-Google-Smtp-Source: ABdhPJxvK5ranT6MxNAe5Mc/fRvKp1dd0o1kpt1R3HDrhrsOWph308zl38W+FiemuvpLdabMCSteRpO/XcnWNA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:dee9:aec5:bbc1:a71e])
 (user=mmandlik job=sendgmr) by 2002:a25:478b:: with SMTP id
 u133mr6274796yba.532.1631221830276; Thu, 09 Sep 2021 14:10:30 -0700 (PDT)
Date:   Thu,  9 Sep 2021 14:10:23 -0700
Message-Id: <20210909140945.v6.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v6] Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This splits the msft_do_{open/close} to msft_do_{open/close} and
msft_{register/unregister}. With this change it is possible to retain
the MSFT extension info irrespective of controller power on/off state.
This helps bluetoothd to report correct 'supported features' of the
controller to the D-Bus clients event if the controller is off. It also
re-reads the MSFT info upon every msft_do_open().

The following test steps were performed.
1. Boot the test device and verify the MSFT support debug log in syslog.
2. Power off the controller and read the 'supported features', power on
   and read again.
3. Restart the bluetoothd and verify the 'supported features' value.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v6:
- Split msft_do_{open/close} into msft_do_{open/close} and
  msft_{register/unregister}

Changes in v5:
- Rebase on ToT and remove extra blank line

Changes in v4:
- Re-read the MSFT data instead of skipping if it's initiated already

Changes in v3:
- Remove the accepted commits from the series

 net/bluetooth/hci_core.c |  3 +++
 net/bluetooth/msft.c     | 55 +++++++++++++++++++++++++++++++++-------
 net/bluetooth/msft.h     |  4 +++
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb296478b86e..8af0ea0934fa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3994,6 +3994,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	queue_work(hdev->req_workqueue, &hdev->power_on);
 
 	idr_init(&hdev->adv_monitors_idr);
+	msft_register(hdev);
 
 	return id;
 
@@ -4026,6 +4027,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		cancel_work_sync(&hdev->suspend_prepare);
 	}
 
+	msft_unregister(hdev);
+
 	hci_dev_do_close(hdev);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index b4bfae41e8a5..21b1787e7893 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -184,28 +184,36 @@ static void reregister_monitor_on_restart(struct hci_dev *hdev, int handle)
 
 void msft_do_open(struct hci_dev *hdev)
 {
-	struct msft_data *msft;
+	struct msft_data *msft = hdev->msft_data;
 
 	if (hdev->msft_opcode == HCI_OP_NOP)
 		return;
 
+	if (!msft) {
+		bt_dev_err(hdev, "MSFT extension not registered");
+		return;
+	}
+
 	bt_dev_dbg(hdev, "Initialize MSFT extension");
 
-	msft = kzalloc(sizeof(*msft), GFP_KERNEL);
-	if (!msft)
-		return;
+	/* Reset existing MSFT data before re-reading */
+	kfree(msft->evt_prefix);
+	msft->evt_prefix = NULL;
+	msft->evt_prefix_len = 0;
+	msft->features = 0;
 
 	if (!read_supported_features(hdev, msft)) {
+		hdev->msft_data = NULL;
 		kfree(msft);
 		return;
 	}
 
-	INIT_LIST_HEAD(&msft->handle_map);
-	hdev->msft_data = msft;
-
 	if (msft_monitor_supported(hdev)) {
 		msft->reregistering = true;
 		msft_set_filter_enable(hdev, true);
+		/* Monitors get removed on power off, so we need to explicitly
+		 * tell the controller to re-monitor.
+		 */
 		reregister_monitor_on_restart(hdev, 0);
 	}
 }
@@ -221,8 +229,9 @@ void msft_do_close(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "Cleanup of MSFT extension");
 
-	hdev->msft_data = NULL;
-
+	/* The controller will silently remove all monitors on power off.
+	 * Therefore, remove handle_data mapping and reset monitor state.
+	 */
 	list_for_each_entry_safe(handle_data, tmp, &msft->handle_map, list) {
 		monitor = idr_find(&hdev->adv_monitors_idr,
 				   handle_data->mgmt_handle);
@@ -233,6 +242,34 @@ void msft_do_close(struct hci_dev *hdev)
 		list_del(&handle_data->list);
 		kfree(handle_data);
 	}
+}
+
+void msft_register(struct hci_dev *hdev)
+{
+	struct msft_data *msft = NULL;
+
+	bt_dev_dbg(hdev, "Register MSFT extension");
+
+	msft = kzalloc(sizeof(*msft), GFP_KERNEL);
+	if (!msft) {
+		bt_dev_err(hdev, "Failed to register MSFT extension");
+		return;
+	}
+
+	INIT_LIST_HEAD(&msft->handle_map);
+	hdev->msft_data = msft;
+}
+
+void msft_unregister(struct hci_dev *hdev)
+{
+	struct msft_data *msft = hdev->msft_data;
+
+	if (!msft)
+		return;
+
+	bt_dev_dbg(hdev, "Unregister MSFT extension");
+
+	hdev->msft_data = NULL;
 
 	kfree(msft->evt_prefix);
 	kfree(msft);
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 6e56d94b88d8..8018948c5975 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -13,6 +13,8 @@
 #if IS_ENABLED(CONFIG_BT_MSFTEXT)
 
 bool msft_monitor_supported(struct hci_dev *hdev);
+void msft_register(struct hci_dev *hdev);
+void msft_unregister(struct hci_dev *hdev);
 void msft_do_open(struct hci_dev *hdev);
 void msft_do_close(struct hci_dev *hdev);
 void msft_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb);
@@ -31,6 +33,8 @@ static inline bool msft_monitor_supported(struct hci_dev *hdev)
 	return false;
 }
 
+static inline void msft_register(struct hci_dev *hdev) {}
+static inline void msft_unregister(struct hci_dev *hdev) {}
 static inline void msft_do_open(struct hci_dev *hdev) {}
 static inline void msft_do_close(struct hci_dev *hdev) {}
 static inline void msft_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb) {}
-- 
2.33.0.309.g3052b89438-goog

