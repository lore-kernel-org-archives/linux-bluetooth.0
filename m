Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A45DC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BD72074D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 15:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbgDAP7b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:59:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59687 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbgDAP7a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 11:59:30 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 837F0CECDD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2020 18:09:02 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: Move debugfs configuration above the selftests
Date:   Wed,  1 Apr 2020 17:59:21 +0200
Message-Id: <20200401155923.485359-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is just a cosmetic clean to move the selftests configuration option
to the bottom of the list of options.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 165148c7c4ce..77703216a2e3 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -93,6 +93,14 @@ config BT_LEDS
 	  This option selects a few LED triggers for different
 	  Bluetooth events.
 
+config BT_DEBUGFS
+	bool "Export Bluetooth internals in debugfs"
+	depends on BT && DEBUG_FS
+	default y
+	help
+	  Provide extensive information about internal Bluetooth states
+	  in debugfs.
+
 config BT_SELFTEST
 	bool "Bluetooth self testing support"
 	depends on BT && DEBUG_KERNEL
@@ -120,12 +128,4 @@ config BT_SELFTEST_SMP
 	  Run test cases for SMP cryptographic functionality, including both
 	  legacy SMP as well as the Secure Connections features.
 
-config BT_DEBUGFS
-	bool "Export Bluetooth internals in debugfs"
-	depends on BT && DEBUG_FS
-	default y
-	help
-	  Provide extensive information about internal Bluetooth states
-	  in debugfs.
-
 source "drivers/bluetooth/Kconfig"
-- 
2.25.1

