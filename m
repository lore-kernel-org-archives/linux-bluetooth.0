Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B75C11F64
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 00:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B215261D04
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 00:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhF2Awu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 20:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhF2Awt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 20:52:49 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F0C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 17:50:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u190so16997588pgd.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 17:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA9Te1qiFJy4OLKAVsKR5gka81goQEvGgHmJjhez0o4=;
        b=ppwkPnPLIZNANUHbSDymBesTAKVrLjBRCIsjtyT2vX94Ur7Os9PPQeu1xwoEr5yL5+
         K6xGgiHZrisrq8ud/rLCBYxGm0sjGurpUQMx/UlrVeG+GEXEYRxYWNYZiNpvXV7tQj+Y
         yHcExYKFjXovF/9lZSd+Kx09paaKFfYNikjnk+Yy25Rpq468ZtTWMjKZcjEYsl800ZXI
         Zmoe1QHYLZFYWpbtjXiwQ/L5C5A8k5mShGZvRE6ePXS6REZZf0Urx+kToy0JZf/lQZqR
         SryBAbHLuJbzDLYrUjHCnyBFa0ycWuM3WQylKdm6m13ovulYmJB9pzoZednRm+zEGkUV
         Z/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA9Te1qiFJy4OLKAVsKR5gka81goQEvGgHmJjhez0o4=;
        b=i4D3x2bYUXq5RguciLaErPK5MTxIlpZlUK2WS8olDr1zdsAz1twLU1s9XjTJqjzTJh
         thqV538EXSb4jgm8WotUWeCi/6HevpsazouTW8WOTEw0ts6Y3bWh3xD0sDR1eg9ij8GP
         Q43JE+b5qRIKPOsxgj4ORy61Ni4niGQoI+2L1PtLi3qd9avwxCmILUFTE5Obq/BWn0Tu
         8K1sDoUO4iyn/j51Y7+ara9MbgBKYPQt01f/3WsYuVwz6hZiQYFLML0ATTmqOboylq7y
         JJ08kSWPwTc8wgDwMaBlZty4F9/2B9phaBPxX0vaej/QlUUakseie43tptAI/JnBHJ/i
         EpEA==
X-Gm-Message-State: AOAM530tccioNMKRH76n18thAmHxNcEqqIeb8vVG0MMAPbP4sJzJEp4c
        HThSqF6vhBxw12EZHPDDJaucOkOwIAaJig==
X-Google-Smtp-Source: ABdhPJzsjh2FjoVt9xhUlVRWFhOyteBQNkFW0tsad3fA2dcc96v6vl690gZDBYxqYmV0wATJQlr87w==
X-Received: by 2002:a63:f907:: with SMTP id h7mr25912430pgi.6.1624927822030;
        Mon, 28 Jun 2021 17:50:22 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s79sm8606126pfc.87.2021.06.28.17.50.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 17:50:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: Add proper tracking for enable status of adv instances
Date:   Mon, 28 Jun 2021 17:49:52 -0700
Message-Id: <20210629004952.569862-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a field to track if advertising instances are enabled or not
and only clear HCI_LE_ADV flag if there is no instance left advertising.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a53e94459ecd..d916729674a0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -221,6 +221,7 @@ struct oob_data {
 
 struct adv_info {
 	struct list_head list;
+	bool enabled;
 	bool pending;
 	__u8	instance;
 	__u32	flags;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c3018202564..d7e85049d49d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1277,7 +1277,9 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *set;
 	__u8 status = *((__u8 *) skb->data);
+	struct adv_info *adv = NULL, *n;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
@@ -1288,22 +1290,48 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
+	set = (void *)cp->data;
+
 	hci_dev_lock(hdev);
 
+	if (cp->num_of_sets)
+		adv = hci_find_adv_instance(hdev, set->handle);
+
 	if (cp->enable) {
 		struct hci_conn *conn;
 
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
+		if (adv)
+			adv->enabled = true;
+
 		conn = hci_lookup_le_connect(hdev);
 		if (conn)
 			queue_delayed_work(hdev->workqueue,
 					   &conn->le_conn_timeout,
 					   conn->conn_timeout);
 	} else {
+		if (adv) {
+			adv->enabled = false;
+			/* If just one instance was disabled check if there are
+			 * any other instance enabled before clearing HCI_LE_ADV
+			 */
+			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
+						 list) {
+				if (adv->enabled)
+					goto unlock;
+			}
+		} else {
+			/* All instances shall be considered disabled */
+			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
+						 list)
+				adv->enabled = false;
+		}
+
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.31.1

