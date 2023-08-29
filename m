Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD615C71153
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Aug 2023 21:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjH2VAH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Aug 2023 17:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjH2U7p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Aug 2023 16:59:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6ACC5
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 13:59:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso2276279b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693342778; x=1693947578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+itouVNHYEwADusjBpxc26P0Lsm8xQuCeanlvsP3+o=;
        b=kAGdkb92CNfBAfsI4n3PBPtcY30qLDhX5hLbUtYDThHwSqunaFeCDaVrwykO7fRxIz
         J//JVnAKW32YUqKQ41J8oBz6AXjyvYoQzZWIPMEgCdM2O/VBpeaHo2ajZtHkARA9AMeP
         Xf0zhqHXEkqY3F15Xhc2mJqsCCZIjjXVHa1xjpLxKYBwXs1QVAdMnG8ayx9SgW7nZD5z
         Iu1emmO/H3MGgzgBf4zTTm2AWwpaI8RC9V4nrRjCqGANMT10pnCNrtW7HKar7shsgmcw
         5/UkWvkwwXoaglLiXA2B9L+43NqfAIIMcRGvjOpWBIXdd0uqUgdWo5ZnckgKl3m3kjiW
         EOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342778; x=1693947578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+itouVNHYEwADusjBpxc26P0Lsm8xQuCeanlvsP3+o=;
        b=MpHi8UzgCaRf9VyI4ViLgEjkSFwhUmwnYHNulBI2DheEE15VsuIL+kPdyq1ZBBT+ue
         6uau4OoMebPXmvXn3ooW58jKsPuhtKx7ibwDgueFBKnyCKni/nfut9uUb6IXUFluIRrj
         xyzwh1VGjcLC89UaHxaA78mf8Xku19FpsLTBUkL/X7FmBbQuPUU8qK6FnFnpzZWQWA5u
         uc/ZBKbjR4LD8PsfIJ+cHzVDCDkGBGeQu2Nbt2GiwHfIAWyGabHkPViZ/fPr7VSHGv+f
         +k/Qulbp5j3cdvlD27KyeeD/1gLpNkucnjCMNHQRU8YUThNjWJMVVFnomFh1wl1xQRq6
         Ljug==
X-Gm-Message-State: AOJu0Yx9jLilrDnLh1eBC3xgCj6YM3DhD6aJ1R7ZFrpCyIuH/D/d/FZN
        nCUU9BnPt8/vq951xrkOikwDS8DiKho=
X-Google-Smtp-Source: AGHT+IFOsv/S6HLKLfARlrg6WVHHdx97QRsEnW1aFnt4YIZCAQwedCtLhi1dOAxP6sdg1YP7J4ufuQ==
X-Received: by 2002:a05:6a20:8406:b0:137:57fc:4f9d with SMTP id c6-20020a056a20840600b0013757fc4f9dmr619106pzd.10.1693342778420;
        Tue, 29 Aug 2023 13:59:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id ju14-20020a170903428e00b001b672af624esm9873663plb.164.2023.08.29.13.59.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:59:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
Date:   Tue, 29 Aug 2023 13:59:36 -0700
Message-ID: <20230829205936.766544-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning requires
periodic restarts of the scanning procedure as the controller would
consider device previously found as duplicated despite of RSSI changes,
but in order to set the scan timeout properly set le_scan_restart needs
to be synchronous so it shall not use hci_cmd_sync_queue which defers
the command processing to cmd_sync_work.

link: https://lore.kernel.org/linux-bluetooth/578e6d7afd676129decafba846a933f5@agner.ch/#t
Fixes: 27d54b778ad1 ("Bluetooth: Rework le_scan_restart for hci_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9b93653c6197..fd7c5d902856 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -413,11 +413,6 @@ static int hci_le_scan_restart_sync(struct hci_dev *hdev)
 					   LE_SCAN_FILTER_DUP_ENABLE);
 }
 
-static int le_scan_restart_sync(struct hci_dev *hdev, void *data)
-{
-	return hci_le_scan_restart_sync(hdev);
-}
-
 static void le_scan_restart(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -427,15 +422,15 @@ static void le_scan_restart(struct work_struct *work)
 
 	bt_dev_dbg(hdev, "");
 
-	hci_dev_lock(hdev);
-
-	status = hci_cmd_sync_queue(hdev, le_scan_restart_sync, NULL, NULL);
+	status = hci_le_scan_restart_sync(hdev);
 	if (status) {
 		bt_dev_err(hdev, "failed to restart LE scan: status %d",
 			   status);
-		goto unlock;
+		return;
 	}
 
+	hci_dev_lock(hdev);
+
 	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
 	    !hdev->discovery.scan_start)
 		goto unlock;
-- 
2.41.0

