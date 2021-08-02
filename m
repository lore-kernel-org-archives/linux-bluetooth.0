Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E8C4320A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 23:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A0560EE8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHBX4e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 19:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhHBX4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 19:56:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40987C06175F
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 16:56:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so27388424pjv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Aug 2021 16:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIV/jOLZXW3e+AoNpqxHs2tTs2yzMdGcFlZnIDBtNQw=;
        b=vSA/B2QN6nBW6/xtYXQtDmMPUcRtVyCyJQ+6Epi0163jobw/N/wMdyh2ITnripIkDz
         9bVWWHFJ0q8Hy+gSH8BaMRqR6Hjd2cmj/Fwg1+J0OY1v6lZdVEli8WIrvQEdGjxtq0Tc
         NHLdAaqRaFuaZhRLgI+r4vhwPKIbe5GFL1KXnQejcvLM78650YPCOsGRlDlauJKPQK/f
         lgCoqWiD+NAGCvoLbrp9W1YYvg8XEp0TJt9VuXLDJDn90a7QDM20nHOeH07OJLIog7Xx
         QQxZ3vZ18WO4Rzwjm/unBaDYOm4TNy9tdEnaf3FBOzxKdqyBSfJjr+jiqTFRKmEkG2VG
         3xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIV/jOLZXW3e+AoNpqxHs2tTs2yzMdGcFlZnIDBtNQw=;
        b=E+hPWdwEDrG+y/dXxZSbGqtqHu81qHig/Wpco+/2Ww5xnIKSwt8UfnezQq/vmpEIX5
         x5B637olYcY+wKfE1HZnIHt7KvyzY39fkawBjfOa2S7vnbVaBp0RVIv91iwEa+sJdX40
         81vBKeqotEpPZ2n1Q8pQcG81xSP7MtFuVUivNylZl215Kt32RBo4L8bn+9awg9+VPmoA
         K/t4DeVw8kuT971cJDbqfrJrKHbpeOEfB4qvM3ZE0J1rGjKnoyN34T41nPWDvR1r8oaN
         kA6tCLcgJnpyP75yxFaZ/7BouEqwph42qVRIAcCfeRRocOMHD72EbNG0Mt5RNgYiok6V
         vQeA==
X-Gm-Message-State: AOAM530AKWDkwHpsnj0jE4mCqQDzwnO914qpZeHFXadmxYzMUNvr2j44
        EBMk41hEv7msS4ewgK/oDM3tOu3lXGE=
X-Google-Smtp-Source: ABdhPJxJNNWLeURGmLfDszdnMxva69lAI8JWFWDKOgIVBdPhqFxE9Wv/8t5OHHe2nVGakdBFhWpWhQ==
X-Received: by 2002:a17:90a:c713:: with SMTP id o19mr1322777pjt.23.1627948580570;
        Mon, 02 Aug 2021 16:56:20 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y24sm12358676pfp.191.2021.08.02.16.56.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:56:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND 1/2] Bluetooth: HCI: Add proper tracking for enable status of adv instances
Date:   Mon,  2 Aug 2021 16:56:18 -0700
Message-Id: <20210802235619.238065-1-luiz.dentz@gmail.com>
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
index 4abe3c494002..b79b31359bf8 100644
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
index ea7fc09478be..35c5cc9f91b0 100644
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

