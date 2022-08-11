Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CF7C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 21:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiHKVYu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiHKVYq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 17:24:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C869F756
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 14:24:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so18183788pgs.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=1QPj0z/Qx7jelduJGkvhcHUBIPKxbQMEWyLx9TGQ+aA=;
        b=TupTOtT6ChPnMEOIMLKcPXDA+gygO23Z3DZ7Q5//2fwxDeWHyIErC9Y01pW5kr2w3M
         rzUJVj/XkHikJxPoRcFHyHTafutuooI3r59LPJYMYmknY6xr66Ro37damXlKZkg2nV1T
         ZsKjK0tqEr/eJ3DnpGfwdYRqty6R5D0iTZrB+2ZkYMW/gS1aaw3YJvunkf6/Tt4R1TTK
         9y/ldIoPvJzQY742GTSXVhBgNhLX4WbcghBiV01BLvov+wch/9ECgBZ0NqwO2bjM62pK
         OP+on4lsrUu/FCoKCLlczoyKlRKYZJTd+jei0g2mdkvmkdvb/6eyHBtXvpwYEKKLzrg0
         zAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=1QPj0z/Qx7jelduJGkvhcHUBIPKxbQMEWyLx9TGQ+aA=;
        b=Cg+YHpTOwVot3sYeGjL1fGVdDNpVDL0EJbxF0IJ02RC6dIG3dzi+RuTLwk/aV81M/U
         +14KhTITxpUpIp2WsTLuDopE6jeeD+rGVWgrke1lGtKqOBvTWHFR0aIPeDFVh8Cgnm0U
         AMEQVIH2DinwAunmD0aDpbk4dLSZlxDaM9EumiDaUDMPxrTSK6gEVIeCwfjOR7V5NyUT
         sxd5RhdrkAKQLSWb6XsaLfUoDMUPBJq+M/d64nM+TKZtqAGL5FFR3UV8pcJf66n9Kqtq
         +54DCgJcG2EpSJ/FZ8ZVOhthrVxfbKED+ooRxy5Pe3byFAJBDO0KcudBBLVs5ykZEi4n
         duhg==
X-Gm-Message-State: ACgBeo11fO2yORS3lPAVfRvVpNJaAnnt5NHMQ/Dyn/joD8ClmS0W9GRS
        msQB1gZGW+OwE//uoMiUq0CXMX5PtxJdTQ==
X-Google-Smtp-Source: AA6agR47lz6Oi1cb1EkgDXhaBDuUG296cmwDKSA/b+SHaTcqIZGxjmUJL6QQ9UqnB3B7krQUNmiyuA==
X-Received: by 2002:a63:4d4f:0:b0:412:a02e:2896 with SMTP id n15-20020a634d4f000000b00412a02e2896mr683985pgl.337.1660253080007;
        Thu, 11 Aug 2022 14:24:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z7-20020aa79587000000b00528c22fbb45sm144846pfj.141.2022.08.11.14.24.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:24:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix suspend performance regression
Date:   Thu, 11 Aug 2022 14:24:35 -0700
Message-Id: <20220811212435.273142-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to fix suspend performance when there is no connections by
not updating the event mask.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6de2ad730995..74a0cd5d0b37 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5549,17 +5549,21 @@ int hci_suspend_sync(struct hci_dev *hdev)
 	/* Prevent disconnects from causing scanning to be re-enabled */
 	hci_pause_scan_sync(hdev);
 
-	/* Soft disconnect everything (power off) */
-	err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
-	if (err) {
-		/* Set state to BT_RUNNING so resume doesn't notify */
-		hdev->suspend_state = BT_RUNNING;
-		hci_resume_sync(hdev);
-		return err;
-	}
+	if (hci_conn_count(hdev)) {
+		/* Soft disconnect everything (power off) */
+		err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
+		if (err) {
+			/* Set state to BT_RUNNING so resume doesn't notify */
+			hdev->suspend_state = BT_RUNNING;
+			hci_resume_sync(hdev);
+			return err;
+		}
 
-	/* Update event mask so only the allowed event can wakeup the host */
-	hci_set_event_mask_sync(hdev);
+		/* Update event mask so only the allowed event can wakeup the
+		 * host.
+		 */
+		hci_set_event_mask_sync(hdev);
+	}
 
 	/* Only configure accept list if disconnect succeeded and wake
 	 * isn't being prevented.
-- 
2.37.1

