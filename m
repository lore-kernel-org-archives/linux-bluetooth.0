Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E58C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 09:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9154C239D1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbhAVIkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 03:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbhAVIip (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 03:38:45 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283BEC061223
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:54 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t16so3335201qvk.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lRQEkkyjpAQm1nKfuRC1QOgmElpLdb2DZOiHX/C9MNY=;
        b=IkWUZrHp5KiQa8G9MJ3i4JiDn9C87pJ/kL572UWFbcmrshi7D7wAa2HqnpcC5hst7q
         mt0h5dpxq133sFO+E4NlMAJtis+QsiId+IXUOS+XA8FyDH2/iXvQsyKvfBq9gJyy3J6f
         dibjcDUVaB+4Q3WOL8tIkdnfY8pH7Yy/ggzRWmHIf2iW2f2uNuG0ecDCb3zOmhHiYyHk
         W//kOLoMQJjvO9yzhoC4k+rvkj1+HAry/2QfrY4APuHYWDBG38P1d7gVjBZqb4gaRzBn
         AqHBGjGD31CutWF8iV+kQF48PhU2vv5TqBjCPHRVfVECmnRyRULOHrhhNL6bywUyYXbt
         SEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lRQEkkyjpAQm1nKfuRC1QOgmElpLdb2DZOiHX/C9MNY=;
        b=feqNA8YrUIRIHqe+ipp9BDLmynSSUOdlqWfdmf46keBzphzmQGVIlYLVwLtuM+qECT
         DmWre6HimdP9XjXH8pPF3sPzEuwNoKRuvwonVhaomaz78Q8jG3t5Z4jIjkqxHpgjIl4w
         PwhzsvIdVL6TSpc5kkfNR5rzp4ppWP3Ffma+gU4EyUwxPcCPcUbDuE9bucCW7dzxyj+Y
         Hl0ppceN0I+a0P26be6x7tg4iF9KtbZXWgXfT50ArUNjeCwOPYziotslYNlR0Wkq7dhJ
         D1ElatqgmVjlNzxABGrwCLuW7HHt4BAKUnR4AZc/fwpD9QtcaIbgiwydPzCyFs13fBAz
         EFoQ==
X-Gm-Message-State: AOAM5316vjJ74qtHlcC83RfeAQw2w0OpxMg3ONjDXwWIIFMGBjn8GnoX
        rht8aFHpwKVbQKy7Wnfew5rXPsFxLAjLqhOFhXGsFLe+xxlKGChrgcCWTioOgQx+ICG84vw7jWm
        esMBmPhz5Bp/Uf5rCeYC0YUmjLhq4eOHpB/zEUqxY3tSNjKkwT7yX7mrMYnTew5nOetUuebjBaG
        KL
X-Google-Smtp-Source: ABdhPJzE3xo/+kzABEL/SdwaMDGi7G78uCtqpQIckT8cwzgmqeNUknYkvXFGnk/yqqkthaXLWnOXiYbXoHMe
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:c30e:: with SMTP id
 f14mr3599792qvi.48.1611304613217; Fri, 22 Jan 2021 00:36:53 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:36:17 +0800
In-Reply-To: <20210122083617.3163489-1-apusaka@google.com>
Message-Id: <20210122163457.v6.7.I21a23acb8380fe0fe88a47ebba030acfc587725c@changeid>
Mime-Version: 1.0
References: <20210122083617.3163489-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v6 7/7] Bluetooth: disable advertisement filters during suspend
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Howard Chung <howardchung@google.com>

This adds logic to disable and reenable advertisement filters during
suspend and resume. After this patch, we would only receive packets from
devices in allow list during suspend.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v6:
* New patch "disable advertisement filters during suspend"

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 29 +++++++++++++++++++++++++++++
 net/bluetooth/msft.c             | 17 ++++++++++++-----
 net/bluetooth/msft.h             |  3 +++
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 29cfc6a2d689..fd1d10fe2f11 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -105,6 +105,8 @@ enum suspend_tasks {
 	SUSPEND_POWERING_DOWN,
 
 	SUSPEND_PREPARE_NOTIFIER,
+
+	SUSPEND_SET_ADV_FILTER,
 	__SUSPEND_NUM_TASKS
 };
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d29a44d77b4e..e55976db4403 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -29,6 +29,7 @@
 
 #include "smp.h"
 #include "hci_request.h"
+#include "msft.h"
 
 #define HCI_REQ_DONE	  0
 #define HCI_REQ_PEND	  1
@@ -1242,6 +1243,29 @@ static void suspend_req_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		clear_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
 		wake_up(&hdev->suspend_wait_q);
 	}
+
+	if (test_bit(SUSPEND_SET_ADV_FILTER, hdev->suspend_tasks)) {
+		clear_bit(SUSPEND_SET_ADV_FILTER, hdev->suspend_tasks);
+		wake_up(&hdev->suspend_wait_q);
+	}
+}
+
+static void hci_req_add_set_adv_filter_enable(struct hci_request *req,
+					      bool enable)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	switch (hci_get_adv_monitor_offload_ext(hdev)) {
+	case HCI_ADV_MONITOR_EXT_MSFT:
+		msft_req_add_set_filter_enable(req, enable);
+		break;
+	default:
+		return;
+	}
+
+	/* No need to block when enabling since it's on resume path */
+	if (hdev->suspended && !enable)
+		set_bit(SUSPEND_SET_ADV_FILTER, hdev->suspend_tasks);
 }
 
 /* Call with hci_dev_lock */
@@ -1301,6 +1325,9 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 			hci_req_add_le_scan_disable(&req, false);
 		}
 
+		/* Disable advertisement filters */
+		hci_req_add_set_adv_filter_enable(&req, false);
+
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
 
@@ -1340,6 +1367,8 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_clear_event_filter(&req);
 		/* Reset passive/background scanning to normal */
 		__hci_update_background_scan(&req);
+		/* Enable all of the advertisement filters */
+		hci_req_add_set_adv_filter_enable(&req, true);
 
 		/* Unpause directed advertising */
 		hdev->advertising_paused = false;
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index b2ef654b1d3d..47b104f318e9 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -579,9 +579,19 @@ int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 	return err;
 }
 
-int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
+void msft_req_add_set_filter_enable(struct hci_request *req, bool enable)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct msft_cp_le_set_advertisement_filter_enable cp;
+
+	cp.sub_opcode = MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE;
+	cp.enable = enable;
+
+	hci_req_add(req, hdev->msft_opcode, sizeof(cp), &cp);
+}
+
+int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
+{
 	struct hci_request req;
 	struct msft_data *msft = hdev->msft_data;
 	int err;
@@ -589,11 +599,8 @@ int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 	if (!msft)
 		return -EOPNOTSUPP;
 
-	cp.sub_opcode = MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE;
-	cp.enable = enable;
-
 	hci_req_init(&req, hdev);
-	hci_req_add(&req, hdev->msft_opcode, sizeof(cp), &cp);
+	msft_req_add_set_filter_enable(&req, enable);
 	err = hci_req_run_skb(&req, msft_le_set_advertisement_filter_enable_cb);
 
 	return err;
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index f8e4d3a6d641..88ed613dfa08 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -20,6 +20,7 @@ __u64 msft_get_features(struct hci_dev *hdev);
 int msft_add_monitor_pattern(struct hci_dev *hdev, struct adv_monitor *monitor);
 int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 			u16 handle);
+void msft_req_add_set_filter_enable(struct hci_request *req, bool enable);
 int msft_set_filter_enable(struct hci_dev *hdev, bool enable);
 
 #else
@@ -46,6 +47,8 @@ static inline int msft_remove_monitor(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline void msft_req_add_set_filter_enable(struct hci_request *req,
+						  bool enable) {}
 static inline int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 {
 	return -EOPNOTSUPP;
-- 
2.30.0.280.ga3ce27912f-goog

