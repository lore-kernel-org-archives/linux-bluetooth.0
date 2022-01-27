Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 01:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiA0BDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiA0BDa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 20:03:30 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEA4C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 17:03:30 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s18so1685512ioa.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 17:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w13OtZuLnufOL+Nooi/s7gbqMgCLp+sd7S9aWsXUu5s=;
        b=RRtOvc/xS77xciQKzto1hRB+LH3DeFPGImQ+jFR2EJ7cxj4Rf/Qvf4bvo5mX2EL0Pj
         VC8Z6BXBPsedu7oiEPciGJr0JaUhG1tW4VVLaFppqPiwYattnd2aJP+e2eXSXpkvZCHm
         CvEqk5uHzb8V41rt8Fbl5/vCYVN5xnLKqkpw0Nq2D9S1RxO4ZgVUfyTD/ecXByzYhwm6
         dh+UWE7UKm4cM1ZSCqHrpax3cGz+X77d5E0+QSQ1NBJ/LJuPp6UIdyNOhQ7aFehS0Lyg
         cSzReID/XTiyzNcYmybcCRi/7InrZu4gLIVzyFu6fWaLCQum+tvYBh3ZpcNuR8jK3b+J
         4tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w13OtZuLnufOL+Nooi/s7gbqMgCLp+sd7S9aWsXUu5s=;
        b=3YPgseTfemrTH2NKbcpzr1mNMFJC0+FUXE8uYyyNTsS6UlqSklCgdUszRDyhE/EvLt
         G+VEqrnoeg1IZJFVfxYmAlX08vXB0xtI+TuFYEI+2bcleRUWNMn70+6DbSm1/L2KzLcf
         FUtvKvR31EuFQUjje5/nfCyZXbCAFVCPczkVoTJYXNPIoLd9eKXjVMWwY9MRVh7ilTzS
         /kkPNDlGkPINFvXBzLU/Z6pSdBG1jM/ZG4lX3Gn68rYXx2iI/EoHu6+7IYUgoi1xcAR9
         r1VX0BWE5cNRzwb/leXYZ0H1f8k7FfjUnhyuA6waZkuMIklViVePhRt03vjHEc+SyQcZ
         u4aw==
X-Gm-Message-State: AOAM533+DaMmBasWts49a6LVWvspqexy98hXB4Zv78Y5EO7OiA40cj/q
        3HOl3o4gj5x+2eFFF80eIB4AEUWORZ4YOQ==
X-Google-Smtp-Source: ABdhPJx/QAyp65GTe9rGRfzc/dskUdTHQvCFZB0vjVYZ6L/y0XC1IQ80mrHvZx9+LnRHN/fDHyqm4Q==
X-Received: by 2002:a02:7f53:: with SMTP id r80mr662733jac.295.1643245409268;
        Wed, 26 Jan 2022 17:03:29 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g8sm11346666ilc.10.2022.01.26.17.03.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:03:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Add implementation for BT_HCI_CMD_LE_TERM_BIG
Date:   Wed, 26 Jan 2022 17:03:27 -0800
Message-Id: <20220127010327.3087364-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds handler for BT_HCI_CMD_LE_TERM_BIG and generate
BT_HCI_EVT_LE_BIG_TERMINATE to indicate to the host stack that the
BIG has been terminated.
---
 emulator/btdev.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 002ebf3e7..0ef840a95 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5733,8 +5733,24 @@ static int cmd_create_big_test(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_term_big(struct btdev *dev, const void *data, uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_DISCONNECT);
+
+	return 0;
+}
+
+static int cmd_term_big_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_term_big *cmd = data;
+	struct bt_hci_evt_le_big_terminate rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.reason = cmd->reason;
+	rsp.handle = cmd->handle;
+
+	le_meta_event(dev, BT_HCI_EVT_LE_BIG_TERMINATE, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
 static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
@@ -5953,7 +5969,7 @@ static int cmd_config_data_path(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_LE_CREATE_BIG, cmd_create_big, \
 			cmd_create_big_complete), \
 	CMD(BT_HCI_CMD_LE_CREATE_BIG_TEST, cmd_create_big_test, NULL), \
-	CMD(BT_HCI_CMD_LE_TERM_BIG, cmd_term_big, NULL), \
+	CMD(BT_HCI_CMD_LE_TERM_BIG, cmd_term_big, cmd_term_big_complete), \
 	CMD(BT_HCI_CMD_LE_BIG_CREATE_SYNC, cmd_big_create_sync, NULL), \
 	CMD(BT_HCI_CMD_LE_BIG_TERM_SYNC, cmd_big_term_sync, NULL), \
 	CMD(BT_HCI_CMD_LE_REQ_PEER_SCA, cmd_req_peer_sca, NULL), \
-- 
2.34.1

