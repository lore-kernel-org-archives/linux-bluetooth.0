Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F0ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Sep 2022 21:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiIFVx6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIFVx5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Sep 2022 17:53:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFE8857CD
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 14:53:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so11408441pjf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Sep 2022 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=b9MIfHEFtPY9WH2QYfb4K6O5Stgr/WQc36FsgB4nUYY=;
        b=S8KziIDi14HULOlKfK/rqik3n6iYEh3ZHG5RfKDKH7k1d9WZMG2qtH2qJA/vUkV4tb
         YIOjaHcCxsGLi7QKbF13kjddZzCcQIxX4dcf0bVjxXikD5N50+BIA0jSYYpdB2iLmiqa
         Yu5b2otS381gLAVRhN2lESD96eiCxhbAcao81FOqk9f01+8gH1Ld1wTg/dkTK1eyR85Q
         XquBZv9BlGkq9n6NsSLkXi8AXJIoFq47Ag4Ca5t9qcP+J0wsK7UsoH4KFIs2AC4RCLd7
         JYLWoPHjygmxV+siKtPHajxkzsm+qTuqdVfUKaIe0VQqV/JC5qA9XpuQ4z4HNuUI6MX5
         rlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=b9MIfHEFtPY9WH2QYfb4K6O5Stgr/WQc36FsgB4nUYY=;
        b=X5m2M85xRwDBC0KKZ6+20lu4tLWWiZ84Lctu5w2yPUeXwDQcLFwFWyna5Q3UsJRKHt
         HmSCZsOBvyecGIb3mXrCKwzCP3+IDZBPQJN23ZLubRRHex5ncxiKFE2qmnA5lNoYOcwb
         +cGM+IGc9aIAkqDNJvcXX2NQNXlgUclOrTzvC5rnllp1ICwaYkmbLPnhLlJnsnd/9vki
         EsnBYNydk+/+p2gpLDI9PJVJSx1S//5MjjMurQMtIMbbn6wGN81ETPQfrPKrgJRUQq2h
         RO2DImvyIqz5mimq1LnwRJIUKG9E1IifY2BbRmLHDviGyfa+2pQW4R6c1OoOpdVjmDzi
         fqyQ==
X-Gm-Message-State: ACgBeo1CUBgD7KhLTjpClcK0w/ywK2R7KNpZFCdn7vL1nz+hrJz+/qtQ
        IrgREqcLklUh/2G+NoyGpoyBrptMa0k=
X-Google-Smtp-Source: AA6agR7hM9E0dggGFXvFTPQODXnhKBatZZBbIgOaFtX6HAQeAyrNRBRR3N/l3RLW/gLoIwoEU7wF+g==
X-Received: by 2002:a17:903:2406:b0:172:a576:51c1 with SMTP id e6-20020a170903240600b00172a57651c1mr563000plo.106.1662501235107;
        Tue, 06 Sep 2022 14:53:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79474000000b00535da15a252sm10811333pfq.165.2022.09.06.14.53.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:53:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable LE 2M PHY by default
Date:   Tue,  6 Sep 2022 14:53:53 -0700
Message-Id: <20220906215353.2820044-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables 2M PHY by default and in case the controller doesn't
support HCI_OP_LE_SET_DEFAULT_PHY then default to just 1M PHY.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++--
 net/bluetooth/hci_sync.c | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3803e54f23c0..d2d017621c08 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2469,8 +2469,8 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->le_max_rx_time = 0x0148;
 	hdev->le_max_key_size = SMP_MAX_ENC_KEY_SIZE;
 	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
-	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
-	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
+	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M | HCI_LE_SET_PHY_2M;
+	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M | HCI_LE_SET_PHY_2M;
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
 	hdev->def_le_autoconnect_timeout = HCI_LE_AUTOCONN_TIMEOUT;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41b6d19c70b0..4eab893cb10e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4348,13 +4348,18 @@ static int hci_le_set_write_def_data_len_sync(struct hci_dev *hdev)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-/* Set Default PHY parameters if command is supported */
+/* Set Default PHY parameters if command is supported, if not supported default
+ * to 1M.
+ */
 static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_default_phy cp;
 
-	if (!(hdev->commands[35] & 0x20))
+	if (!(hdev->commands[35] & 0x20)) {
+		hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
+		hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 		return 0;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 	cp.all_phys = 0x00;
-- 
2.37.2

