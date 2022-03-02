Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD788C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiCBTLq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiCBTLq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 14:11:46 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D2CA70C
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 11:11:02 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 195so3131273iou.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qxBTKkV75YbCL3c8TSFlrXFvLn8xOwC0jVlUfXV8A1s=;
        b=Ags6SPkGxD1Gs867NDBbpiLApvReOH+/UTMX/uUbL/3Cz7TT7zEAYjduZsp1vY95JC
         s7acqoTGu1IHVPpLUIsmQKOCTYG0B8U+MlAV2Av8pW9BkD3pW85k1IaX0bObDuzXDA5H
         xJce14hTpjdIeX+XWCsklFtfc1mV28OyysWGlyUKqV8bs42DpeEat2JoYfEDn2YotcRE
         MBWJBQ1s0/vb4435SLZmHKfFt3XDs+zVOk8pPU/60Ha96BgdqRgQwlcU3XGvGAU5/U4k
         FqCmUnEMLrc7DfqcHPC4t7Xl+7jSwNx1mH9K/Og1bisO8RqtYzFIuchrPbXdwsJQF7Le
         v5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qxBTKkV75YbCL3c8TSFlrXFvLn8xOwC0jVlUfXV8A1s=;
        b=DizVbtqzfF2mJeKPV/UqALucAiNPEXuwXTlNVUwrvO6crRxEiHtof6AQx1RaUgSj5x
         /H6pa7YE/KRQCQ4ZqM7LRaFoAbP70jhkCfSKiJTYXztF3BKBsZetIbMsd3UkPhHdiUmt
         xucScdIzkDJRPac/cUNANJrTIyxO3dojWfxsK4B4W1g7IZn5IKIlBkwqMpY/6m1eojhG
         RZMZv4Vl2kcdE8qM9mopEY/FabV6WkPV95PtAdLw8iNczbtt1WQdxqf3xyXS+xgo1ml8
         x3ae1X9HJTrygcAodDXDGGtBpSmwFHxCuYppnLg3PGadRjr87FJhSyvmU0eVjmzWYbvG
         ElIw==
X-Gm-Message-State: AOAM531yI8SgbPS7mwByK7Z9SvuQkJbw6G6RtUUIIeZ/XMotrcjg6duX
        1Zfjpb/P+VZgBo2Ph+ZvXrDScbdFX1Y=
X-Google-Smtp-Source: ABdhPJxXKCGIbMD+0jW+MlZZwc3ILRn3BrXRkfdnCDZ9VihCltbjIu6jkDb18vF+rx22Osxp68J8SQ==
X-Received: by 2002:a05:6638:378c:b0:313:f08c:e4df with SMTP id w12-20020a056638378c00b00313f08ce4dfmr26429788jal.192.1646248262088;
        Wed, 02 Mar 2022 11:11:02 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s13-20020a6bdc0d000000b006408888551dsm9135136ioc.8.2022.03.02.11.11.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:11:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
Date:   Wed,  2 Mar 2022 11:11:00 -0800
Message-Id: <20220302191100.364431-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_cmd_sync_queue can be called multiple times, each adding a
hci_cmd_sync_work_entry, before hci_cmd_sync_work is run so this makes
sure they are all dequeued properly otherwise it creates a backlog of
entries that are never run.

Link: https://lore.kernel.org/all/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com/T/
Fixes: 6a98e3836fa20 ("Bluetooth: Add helper for serialized HCI command execution")
Tested-by: Chris Clayton <chris2553@googlemail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 64 ++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d146d4efae43..121df2dcf2f1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -273,43 +273,55 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 }
 EXPORT_SYMBOL(__hci_cmd_sync_status);
 
-static void hci_cmd_sync_work(struct work_struct *work)
+static void hci_cmd_sync_work_entry_run(struct hci_dev *hdev,
+					struct hci_cmd_sync_work_entry *entry)
 {
-	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
-	struct hci_cmd_sync_work_entry *entry;
 	hci_cmd_sync_work_func_t func;
 	hci_cmd_sync_work_destroy_t destroy;
 	void *data;
+	int err;
 
-	bt_dev_dbg(hdev, "");
+	bt_dev_dbg(hdev, "entry %p", entry);
 
-	mutex_lock(&hdev->cmd_sync_work_lock);
-	entry = list_first_entry(&hdev->cmd_sync_work_list,
-				 struct hci_cmd_sync_work_entry, list);
-	if (entry) {
-		list_del(&entry->list);
-		func = entry->func;
-		data = entry->data;
-		destroy = entry->destroy;
-		kfree(entry);
-	} else {
-		func = NULL;
-		data = NULL;
-		destroy = NULL;
-	}
-	mutex_unlock(&hdev->cmd_sync_work_lock);
+	func = entry->func;
+	data = entry->data;
+	destroy = entry->destroy;
+	kfree(entry);
 
-	if (func) {
-		int err;
+	if (!func)
+		return;
 
-		hci_req_sync_lock(hdev);
+	hci_req_sync_lock(hdev);
+
+	err = func(hdev, data);
 
-		err = func(hdev, data);
+	if (destroy)
+		destroy(hdev, data, err);
 
-		if (destroy)
-			destroy(hdev, data, err);
+	hci_req_sync_unlock(hdev);
+}
+
+static void hci_cmd_sync_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
+	struct hci_cmd_sync_work_entry *entry;
+
+	bt_dev_dbg(hdev, "");
+
+	/* Dequeue all entries and run them */
+	while (1) {
+		mutex_lock(&hdev->cmd_sync_work_lock);
+		entry = list_first_entry_or_null(&hdev->cmd_sync_work_list,
+						 struct hci_cmd_sync_work_entry,
+						 list);
+		if (entry)
+			list_del(&entry->list);
+		mutex_unlock(&hdev->cmd_sync_work_lock);
+
+		if (!entry)
+			break;
 
-		hci_req_sync_unlock(hdev);
+		hci_cmd_sync_work_entry_run(hdev, entry);
 	}
 }
 
-- 
2.35.1

