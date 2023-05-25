Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD87C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 00:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjEYAMH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 20:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYAMG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 20:12:06 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8F139
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 17:12:04 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d138bd759so928954b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684973524; x=1687565524;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CuGzP4jvcFhZR0qNDB5MEw2qn9YAXXZ3upPhfuHloLo=;
        b=QyP5/8p7Gy/PZSdwURtv5JC7lUyDeFZAlQgrfKUMESQAz11X9jTC701MmiWTjBTWvF
         IAuICHYBgGOZqQeEcyVQjQpaMAQYEio+n0H39WxwzhfDxbpisBUkNZjpTJD5ubWRy1Iy
         c6nUdTAJEBFUNl/+Byq7Cyfiw0sqvpVQLlvMrz2cFsUwhoccvg3tiIsUCPORX8Fr1MC5
         u000gRpAjzCP6n671I4By3AFo3+L3eeMmeRAwC87rjDfLnqU7Xk3YbbsJ516rCo/V6py
         UEzelwVRqWiBazvdg4pIdomKH5G/lutEBpQNw1JZ8k27mpiU74Cz5jr01Ri8TpDddZUW
         QLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684973524; x=1687565524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuGzP4jvcFhZR0qNDB5MEw2qn9YAXXZ3upPhfuHloLo=;
        b=O2xB9G47+BKzu7g2KwXpYWdfdu6WObyvkqOmzVp4aELbVsxaQAD9D8ROXdHWcUZmmU
         MekDsjRx7VttZm0r964D7JPrV9/asbCYtvqnfqLZpgyYbF8ht4DtOCsoL8IToItNEscn
         xRVyNszWrQ2w2IzNoh7RClj9tje2ZDBtBXJqXZIa1MIweLwOBcHy42cczLd3QffAxhUE
         2FDsLJH2Piv1/JMu/hkv4j/hyEFxgKQ6T37AlIz/JdYpnpyDGVEOb/b/mA58V+DjN81p
         av+myUsDJCOaRwxefHIktkJSkFiXwKisQLOQJn26+u+FREKlssKiMEBAQACYsGgo8K17
         s1Iw==
X-Gm-Message-State: AC+VfDwlvW37qROhpmr3shXZwRWb4+GQokWHIKBh59ArAmgyI+W10ADN
        EusukxnrCs7EnhvCUCNPlpYOlMsKxnHiA14OaXGJXnUHCuIE6YPsYoy7xblL0PgN/S5EW8bG6SS
        dE+3AtxEXRsg25FUZeTF/+Y8KDUMfqyz7XOfMVr5/w2i6kVUy4QQJKpojMFRjYFtt6tZiV9ajHf
        /Q
X-Google-Smtp-Source: ACHHUZ5L4U6ncBchHbVPNxt3jSblZwPArf1Lu6PXIrUka0L1XTGS+c1Dcdl+Z/M7MxNvOvoT5Wxs5g76s7/Q
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:1514:b0:63d:397a:8fdd with SMTP
 id q20-20020a056a00151400b0063d397a8fddmr1747469pfu.0.1684973523938; Wed, 24
 May 2023 17:12:03 -0700 (PDT)
Date:   Wed, 24 May 2023 17:11:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524171158.kernel.v1.1.Ie9c81a5f8bbdb4f9a2007c56f05001d7e674dbe0@changeid>
Subject: [kernel PATCH v1] Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the HCI_UNREGISTER flag is set, no jobs should be scheduled. Fix
potential race when HCI_UNREGISTER is set after the flag is tested in
hci_cmd_sync_queue.

Fixes: 0b94f2651f56 ("Bluetooth: hci_sync: Fix queuing commands when HCI_UNREGISTER is set")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Add a lock to protect HCI_UNREGISTER flag

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  2 ++
 net/bluetooth/hci_sync.c         | 20 ++++++++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c86ecce34854..9a21b4787df5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -515,6 +515,7 @@ struct hci_dev {
 	struct work_struct	cmd_sync_work;
 	struct list_head	cmd_sync_work_list;
 	struct mutex		cmd_sync_work_lock;
+	struct mutex		hdev_unregister_lock;
 	struct work_struct	cmd_sync_cancel_work;
 	struct work_struct	reenable_adv_work;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a856b1051d35..216c78656133 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2686,7 +2686,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 {
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
+	mutex_lock(&hdev->hdev_unregister_lock);
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
+	mutex_unlock(&hdev->hdev_unregister_lock);
 
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 647a8ce54062..2038335bdc85 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -629,6 +629,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
 	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
 	mutex_init(&hdev->cmd_sync_work_lock);
+	mutex_init(&hdev->hdev_unregister_lock);
 
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
@@ -692,14 +693,19 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
+	int err = 0;
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		return -ENODEV;
+	mutex_lock(&hdev->hdev_unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		err = -ENODEV;
+		goto unlock;
+	}
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
+	if (!entry) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	entry->func = func;
 	entry->data = data;
 	entry->destroy = destroy;
@@ -710,7 +716,9 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 
 	queue_work(hdev->req_workqueue, &hdev->cmd_sync_work);
 
-	return 0;
+unlock:
+	mutex_unlock(&hdev->hdev_unregister_lock);
+	return err;
 }
 EXPORT_SYMBOL(hci_cmd_sync_submit);
 
-- 
2.40.1.698.g37aff9b760-goog

