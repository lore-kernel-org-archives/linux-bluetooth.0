Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97EFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 10:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED83613BD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 10:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhDFKUN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:20:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38823 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241335AbhDFKUL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 06:20:11 -0400
Received: from localhost.localdomain (p4ff9fed5.dip0.t-ipconnect.de [79.249.254.213])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BA05CED1F
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Apr 2021 12:27:45 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set defaults for le_scan_{int,window}_adv_monitor
Date:   Tue,  6 Apr 2021 12:19:58 +0200
Message-Id: <20210406101958.197421-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The le_scan_{int,window}_adv_monitor settings have not been set with a
sensible default.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6f171f47c82c..520718d7679b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3814,6 +3814,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_scan_window_suspend = 0x0012;
 	hdev->le_scan_int_discovery = DISCOV_LE_SCAN_INT;
 	hdev->le_scan_window_discovery = DISCOV_LE_SCAN_WIN;
+	hdev->le_scan_int_adv_monitor = 0x0060;
+	hdev->le_scan_window_adv_monitor = 0x0030;
 	hdev->le_scan_int_connect = 0x0060;
 	hdev->le_scan_window_connect = 0x0060;
 	hdev->le_conn_min_interval = 0x0018;
-- 
2.30.2

