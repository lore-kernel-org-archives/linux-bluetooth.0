Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ADAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 06:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiCBGoh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiCBGog (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 01:44:36 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8A60DA8
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 22:43:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a5so1037809pfv.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 22:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZ9QuUbnnno5e4ENBA2QznXjOtydSkfYpGbBShy0RE8=;
        b=pMF/TrCa/4PxjbnGy7SGmUdmUx6DmahYDGZp7lWS5JPkiR/1WmErq8MJrvso5UQvPd
         TnJPJg4U/ph4eKUS8gyqVp/K5+QWcBFJw1eU4DibLs9iUjRff0gs5vm7BjN5Nxc+E70e
         Y+ekEUVUqAAF+Fz0NWCiRtrJpFI+ZJtOLyuw3idCIjh8tUF66WHVWIhBamQT5Sfd/Ocm
         VZWRrZXrflfrYm9M42JnNITPerAaWWzeGwFKXppcaw05ae44aWOPzlwM/HAcTY8qAk41
         E4zmfIxQMY43/CoNSxtwY6dGbSmsxO89TdhZv/ROFpAOtZLSVo81WfR3LmWO0+Ad8HaD
         zVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZ9QuUbnnno5e4ENBA2QznXjOtydSkfYpGbBShy0RE8=;
        b=fdRjNpgYAvoemrWtpTRMpTv8e1yH1QEXcODwYPAEfgVbnC8+zrxo826heTW1su0Xyx
         NbUSVYX+3zFXkT2eHCK78VhGrCgSEaX4Cv3gwnPExM8r13s/c3ygyB3PWxz4BXCXh4rF
         3fOCE6lmAOdKVgl86JTt4xmTNme62m/yUB3YexnE6Z81GXFzBzIoEbEUlJ1h/pg6mY9w
         5/JdWtwHiw0A0/V/XwLW4K6kfTg+y1TP+eu2+p+vMoSQ6na5cMOsyIUGVxmmfrRdbnvP
         3KScuQMLs8wIIrBeFzc7xgI4DiLBB34hYESHjG3F9LP4q9YgFuw4alIL6ddAvlrYHc2S
         j+Rw==
X-Gm-Message-State: AOAM533bSfs6CR/UEz4rBgvtSEKsNteWGBISt1WxcvcDfkvWle7zrE5D
        6LAUtuH2c2M/zrePYkHc3GEClnOu7Ic=
X-Google-Smtp-Source: ABdhPJz8OSnc/EOzxa51Bmu/mQclN+5y9XmCGWOFITl0XI3k4HmXQrXyexZ7FUjHS7cZwKJsHYv3aQ==
X-Received: by 2002:a63:515:0:b0:379:460f:7bda with SMTP id 21-20020a630515000000b00379460f7bdamr2201239pgf.534.1646203433402;
        Tue, 01 Mar 2022 22:43:53 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a2c0c00b001bc4cf0107esm3962205pjd.53.2022.03.01.22.43.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:43:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
Date:   Tue,  1 Mar 2022 22:43:51 -0800
Message-Id: <20220302064351.225212-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The could be multiple hci_cmd_sync_work_entry enqueued when
hci_cmd_sync_work is executed so this makes sure they are all
dequeued properly.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 65 ++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d146d4efae43..724d34bdd62a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -273,43 +273,56 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 }
 EXPORT_SYMBOL(__hci_cmd_sync_status);
 
-static void hci_cmd_sync_work(struct work_struct *work)
+
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
+
+	hci_req_sync_lock(hdev);
+
+	err = func(hdev, data);
 
-		hci_req_sync_lock(hdev);
+	if (destroy)
+		destroy(hdev, data, err);
 
-		err = func(hdev, data);
+	hci_req_sync_unlock(hdev);
+}
 
-		if (destroy)
-			destroy(hdev, data, err);
+static void hci_cmd_sync_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
+	struct hci_cmd_sync_work_entry *entry;
+
+	bt_dev_dbg(hdev, "");
+
+	while (1) {
+		mutex_lock(&hdev->cmd_sync_work_lock);
+		entry = list_first_entry_or_null(&hdev->cmd_sync_work_list,
+						 struct hci_cmd_sync_work_entry,
+						 list);
+		if (!entry) {
+			mutex_unlock(&hdev->cmd_sync_work_lock);
+			break;
+		}
+
+		list_del(&entry->list);
+		mutex_unlock(&hdev->cmd_sync_work_lock);
 
-		hci_req_sync_unlock(hdev);
+		hci_cmd_sync_work_entry_run(hdev, entry);
 	}
 }
 
-- 
2.35.1

