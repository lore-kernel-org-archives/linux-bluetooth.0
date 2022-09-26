Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44ECC32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 22:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIZWvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIZWvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 18:51:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698796E8AE
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 15:51:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so8404501pjk.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=lJQf3wss80NTmbHPj2kDj0gPnd5RVcmdUggFI+pXuCo=;
        b=fQKkpytWhiRJtApDsZ9FaOwsUXzmcmOkheEtBeVGXKELelEmVdh9x35ozb0h27GGN1
         Xi8MaWjEDQAYgynKA4MyX2eos2qNkavvlTE1uRDlNILmMoBIQ5wDlQ3mC226NTwUDGpc
         ODSIK4iWqc9Dpr2dpxMocJ0GiiKJZc4TqjpgekT9iIKq5aRJR/UljINr2mXx754y1nqi
         oHf0X2Unf8/G2gphws4wQQbj5XJyUR9EvSqXLsdKqDwJLZvnjLrlptJT8qLmhVWTRJu5
         y+9iYMNV/8qvS4mcJYJTDrRq28fti3kQdo91tZuEWwk5fs6EJMtFs2uq3gtj+w8JqhT2
         j1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=lJQf3wss80NTmbHPj2kDj0gPnd5RVcmdUggFI+pXuCo=;
        b=do/Pxd7PZHecjyQU4kHdchYgOgn6eGVGiGv2J3+KFvGYgKdmX4uGWOQKmmSHEzgK3T
         DreP5RcLxpU+DoCdTcelvWzT+ziBLuDIf3d2VkGLUav9EXm3SI4wyZ1EmrvtxGVtOYU9
         MmydMOOu7h25DBIO64bcK0V5G7b6aHt/LjOVOTNzHKYcNztzK7Cx0m2EsyNLZWrpQNBT
         AhV4xcQbzEP/kTL4ErMI+KbJ5yZHh9fPbeusGoGvGCgfnkbzfVyjNE81SngCSyCbujWO
         e55ZyXKA+dbikyX35k/arzNAkDbFtX9YOm3J4DbxhbK7PcwBGB/xeRPR+mhzPIyBBoIi
         fpcw==
X-Gm-Message-State: ACrzQf2rgEp6xlo5t9vgkTt6ElkHwY5WTF+j4WElp3upVVtnOCfPy164
        jClHJ6R3HBMc02aTMMe2AmSlu8CjYHVlIw==
X-Google-Smtp-Source: AMsMyM4JdRucD9yGZo17ZofTvtcgf7kUDpWduH0IBD04C46L5Ifp2+2sFsIyPpVP4sk4QrjGEW96rg==
X-Received: by 2002:a17:90b:4f8d:b0:203:747c:7b7e with SMTP id qe13-20020a17090b4f8d00b00203747c7b7emr1085630pjb.98.1664232669424;
        Mon, 26 Sep 2022 15:51:09 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902d2d000b0016f1319d2a7sm11907332plc.297.2022.09.26.15.51.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:51:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Fix not handling link timeouts propertly
Date:   Mon, 26 Sep 2022 15:51:07 -0700
Message-Id: <20220926225107.3226470-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Change that introduced the use of __check_timeout did not account for
link types properly, it always assumes ACL_LINK is used thus causing
hdev->acl_last_tx to be used even in case of LE_LINK and then again
uses ACL_LINK with hci_link_tx_to.

To fix this __check_timeout now takes the link type as parameter and
then procedure to use the right last_tx based on the link type and pass
it to hci_link_tx_to.

Fixes: 1b1d29e51499 ("Bluetooth: Make use of __check_timeout on hci_sched_le")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 66c7cdba0d32..063fbb8e07ca 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3485,15 +3485,27 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
 	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
 }
 
-static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
+static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 {
-	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-		/* ACL tx timeout must be longer than maximum
-		 * link supervision timeout (40.9 seconds) */
-		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
-				       HCI_ACL_TX_TIMEOUT))
-			hci_link_tx_to(hdev, ACL_LINK);
+	unsigned long last_tx;
+
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
+		return;
+
+	switch (type) {
+	case LE_LINK:
+		last_tx = hdev->le_last_tx;
+		break;
+	default:
+		last_tx = hdev->acl_last_tx;
+		break;
 	}
+
+	/* tx timeout must be longer than maximum link supervision timeout
+	 * (40.9 seconds)
+	 */
+	if (!cnt && time_after(jiffies, last_tx + HCI_ACL_TX_TIMEOUT))
+		hci_link_tx_to(hdev, type);
 }
 
 /* Schedule SCO */
@@ -3551,7 +3563,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int quote;
 
-	__check_timeout(hdev, cnt);
+	__check_timeout(hdev, cnt, ACL_LINK);
 
 	while (hdev->acl_cnt &&
 	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
@@ -3594,8 +3606,6 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 	int quote;
 	u8 type;
 
-	__check_timeout(hdev, cnt);
-
 	BT_DBG("%s", hdev->name);
 
 	if (hdev->dev_type == HCI_AMP)
@@ -3603,6 +3613,8 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 	else
 		type = ACL_LINK;
 
+	__check_timeout(hdev, cnt, type);
+
 	while (hdev->block_cnt > 0 &&
 	       (chan = hci_chan_sent(hdev, type, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
@@ -3676,7 +3688,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
 
-	__check_timeout(hdev, cnt);
+	__check_timeout(hdev, cnt, LE_LINK);
 
 	tmp = cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
-- 
2.37.3

