Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 21:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiCBVDd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiCBVDb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 16:03:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038113F9F
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 13:02:47 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i1so2662634plr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 13:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbkzLyak8N+Zd+GzODzJQy+LcSQ7ysxJC2ZVRmTWNic=;
        b=BY4XgjY36hIXOvGctbfyOw6znS85x8w+dyrXdlW8NsEi3HKiJvKI5PJpx3cJeq0qV8
         CkJ9A1wozqnl5PdzCD01O4vatEtQmymDZFte4iBKBjgPC7pm+Zut/dgpzMU3RdnTQ2uO
         vxixX5AGgsBcgjIEFLDNSGe7VhmabP5pR4E/cse3MR4VenL73DUdKGyFYAbeTXPCqYnp
         PN6KRRpnbt4srIigld5cDM6unEr63HniArqikwCusOaJvUTbDtp5icmsljJ+gPoF1+w5
         dB2OA91Qw5gXN3PPVuHuq8opKnCqHwaDgotqgdE0tjyh1egUrsJa2HZUTYrc6P8rVWaJ
         n3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbkzLyak8N+Zd+GzODzJQy+LcSQ7ysxJC2ZVRmTWNic=;
        b=pXfHvBOKI9ECXef4GNKo9+b0FCSpJ1voOwkP6esGHzl50pcElXvtattlx1Y835U8BN
         ukUTA1JkvtcmD2Dp5htdKMZQolr/jNUKtraucLmxuY/66VMt+6ZbXmuZ56vHcYjBjf0J
         kSMVoPWfjnuhESapMt+GR5fhFieGNB9M6oMo+4JMEleM9tLUSLz5zVfSBgLKUAnnqZab
         07hXVRUV7kN8EehpZE/TjwiIsK987o/uODeTKocw2Eq6VpJDo6qaUtGhU8hjyG+ufcbA
         XJOhwFuMs2kMUBWZ5edDsKg7jPi8m2nAbIAb74yTAJWGRUHCGSclLUIFjqbYS1ClAV/a
         mcAg==
X-Gm-Message-State: AOAM533MjYFb9fN2RvxATokDNsaasSk4KZgUQgm0Z2ndfDZxe2NF929p
        KTCj5daoHv7FaZm6LnnvNqfJRY2bbjs=
X-Google-Smtp-Source: ABdhPJwzP6xx9q/vjQc3+n+wzGtAm78ilU2WScgPUXGP9qID8m0LfHxW+NZ6OXnyartlzFad+hDbUA==
X-Received: by 2002:a17:902:e5c3:b0:14f:a4ff:34b8 with SMTP id u3-20020a170902e5c300b0014fa4ff34b8mr32010237plf.24.1646254966613;
        Wed, 02 Mar 2022 13:02:46 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id hk2-20020a17090b224200b001bf0a7d9da3sm195821pjb.9.2022.03.02.13.02.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:02:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
Date:   Wed,  2 Mar 2022 13:02:45 -0800
Message-Id: <20220302210245.392267-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d146d4efae43..06c6e954dcbd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -283,33 +283,36 @@ static void hci_cmd_sync_work(struct work_struct *work)
 
 	bt_dev_dbg(hdev, "");
 
-	mutex_lock(&hdev->cmd_sync_work_lock);
-	entry = list_first_entry(&hdev->cmd_sync_work_list,
-				 struct hci_cmd_sync_work_entry, list);
-	if (entry) {
-		list_del(&entry->list);
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
+
 		func = entry->func;
 		data = entry->data;
 		destroy = entry->destroy;
 		kfree(entry);
-	} else {
-		func = NULL;
-		data = NULL;
-		destroy = NULL;
-	}
-	mutex_unlock(&hdev->cmd_sync_work_lock);
 
-	if (func) {
-		int err;
+		if (func) {
+			int err;
 
-		hci_req_sync_lock(hdev);
+			hci_req_sync_lock(hdev);
 
-		err = func(hdev, data);
+			err = func(hdev, data);
 
-		if (destroy)
-			destroy(hdev, data, err);
+			if (destroy)
+				destroy(hdev, data, err);
 
-		hci_req_sync_unlock(hdev);
+			hci_req_sync_unlock(hdev);
+		}
 	}
 }
 
-- 
2.35.1

