Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4FDC2BA1B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E75020757
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDIGF4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:05:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39191 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDIGFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 02:05:55 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0459FCECF6
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2020 08:15:29 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Clear HCI_LL_RPA_RESOLUTION flag on reset
Date:   Thu,  9 Apr 2020 08:05:50 +0200
Message-Id: <fcf08b7369564a522f5886a3cd945f851fb1b254.1586412226.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586412226.git.marcel@holtmann.org>
References: <cover.1586412226.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the controller is being reset or power cycled, then the flag
HCI_LL_RPA_RESOLUTION which indicates if controller based address
resolution is active needs to be also reset.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f3275f1d1c4..239ab72f16c6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -645,6 +645,7 @@ extern struct mutex hci_cb_list_lock;
 	do {							\
 		hci_dev_clear_flag(hdev, HCI_LE_SCAN);		\
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);		\
+		hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);\
 		hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);	\
 	} while (0)
 
-- 
2.25.2

