Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D3BC41513
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 21:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjHIVjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjHIVjV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 17:39:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5D1BD9
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 14:39:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686ed1d2594so220513b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691617158; x=1692221958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mf8UaUQ/L32XIlNjn4sfg2KP/sVO7iobJQCjvT+8PM=;
        b=UDM8iTNEsU7YkUziUa6UGCfypnaMKFl62szBz9w9w43y87tHIVeaPMF+YDMChAHSXp
         oQGk0QPZQXVOZeYeHVDQi1gpL+koqZFROanY8z9hSrd0Jq8cnbEpYtlfODmzS040foWI
         UcZ6siLcZOgn+a6JFYwV4z9ohJOo2guuaoreFgotFYEN620cRH0bDQNQ1gbgt/icdKg1
         gWEIvI5/5ISXuwLRb2rWLWXoRfOuIvXD9y70x+jnuNaes0/K/Q3RpnlJS6b6E2u1q40Y
         fk89sJQt9JzAf4sOSJuGJ3l5s2Viwp05/qpTQOtfsYM1o3cTOrmkqCWg5/nuqAVb5S7+
         Ngxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691617158; x=1692221958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mf8UaUQ/L32XIlNjn4sfg2KP/sVO7iobJQCjvT+8PM=;
        b=f59+tUxihVplhQfhNCGjnttpqrgOYF3l9yFilx6G3Lo7rKEDJzyRedSWudzXDPAklh
         I5TpHQs8urqsZ7IJ7PU3jONCs9rS3swbXfUzsXzq4rFYsyoDwnaYgrXnd5ejXQ5Gp0B1
         qQJ9D+nQfjCub2PFooRdgJfswocjjQy1dxPeYY89SGqUVApj0AMieP4SPNb6QD/9wChb
         BvDxfnrB5uLHAZ29u0jb6lJX553WQ1u4LvfTzOD889ALbaYurWg0MVvxNMvGZs4H6HEd
         Rw6e18YxnzM00f4ORjLnBpyR/dTIGBbNzE4TvS/XbeKei++l3YlJF29+W9T3VG7/6IvY
         e/lg==
X-Gm-Message-State: AOJu0YxoXJ+PGuoV6Eq0m/jdaTp2c/+ZFlqgGkZUPtpV+Dgz1B+he3jc
        e4XUQzl812M4mn6e0PRHK2uP7nZo/9s=
X-Google-Smtp-Source: AGHT+IEwv02ETNybXsOnl6IDW6ShPga9tLN/lJawjxKezIsf/y0NMQSgOw0EcEgJChck8wM1BMIULQ==
X-Received: by 2002:a05:6a21:3e0c:b0:13d:54cd:63e7 with SMTP id bk12-20020a056a213e0c00b0013d54cd63e7mr457434pzc.33.1691617158032;
        Wed, 09 Aug 2023 14:39:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79108000000b00686da0e163bsm64883pfh.11.2023.08.09.14.39.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:39:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_sync: Add hci_cmd_sync_queue_once
Date:   Wed,  9 Aug 2023 14:39:16 -0700
Message-ID: <20230809213916.1636311-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds hci_cmd_sync_queue_once which can be used for callback that
shall be schedule only once.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  5 +++
 net/bluetooth/hci_sync.c         | 56 +++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 57eeb07aeb25..3d2ffcb6c461 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -48,6 +48,11 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
+bool hci_cmd_sync_lookup(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			 void *data, hci_cmd_sync_work_destroy_t destroy,
+			 bool cancel);
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5eb30ba21370..32fa9006f381 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -639,6 +639,17 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 }
 
+static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
+				       struct hci_cmd_sync_work_entry *entry,
+				       int err)
+{
+	if (entry->destroy)
+		entry->destroy(hdev, entry->data, err);
+
+	list_del(&entry->list);
+	kfree(entry);
+}
+
 void hci_cmd_sync_clear(struct hci_dev *hdev)
 {
 	struct hci_cmd_sync_work_entry *entry, *tmp;
@@ -647,13 +658,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->reenable_adv_work);
 
 	mutex_lock(&hdev->cmd_sync_work_lock);
-	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
-		if (entry->destroy)
-			entry->destroy(hdev, entry->data, -ECANCELED);
-
-		list_del(&entry->list);
-		kfree(entry);
-	}
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
 	mutex_unlock(&hdev->cmd_sync_work_lock);
 }
 
@@ -740,6 +746,39 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
+bool hci_cmd_sync_lookup(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			 void *data, hci_cmd_sync_work_destroy_t destroy,
+			 bool cancel)
+{
+	struct hci_cmd_sync_work_entry *entry, *tmp;
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
+		if (entry->func == func && entry->data == data &&
+		    entry->destroy == destroy) {
+			if (cancel)
+				_hci_cmd_sync_cancel_entry(hdev, entry,
+							   -ECANCELED);
+			mutex_unlock(&hdev->cmd_sync_work_lock);
+			return true;
+		}
+	}
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	return false;
+}
+EXPORT_SYMBOL(hci_cmd_sync_pending);
+
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	if (hci_cmd_sync_lookup(hdev, func, data, destroy, false))
+		return 0;
+
+	return hci_cmd_sync_queue(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_queue_once);
+
 int hci_update_eir_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
@@ -2949,7 +2988,8 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return 0;
 
-	return hci_cmd_sync_queue(hdev, update_passive_scan_sync, NULL, NULL);
+	return hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
+				       NULL);
 }
 
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
-- 
2.41.0

