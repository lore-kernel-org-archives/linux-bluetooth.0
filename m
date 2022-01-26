Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D08BC28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbiAZRaR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58417 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiAZRaQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:16 -0500
Received: from fedora.. (p4ff9fc34.dip0.t-ipconnect.de [79.249.252.52])
        by mail.holtmann.org (Postfix) with ESMTPSA id 67527CED0A
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 18:30:15 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increment management interface revision
Date:   Wed, 26 Jan 2022 18:30:12 +0100
Message-Id: <20220126173012.81238-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Increment the mgmt revision due to recent changes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 08d6494f1b34..5dd684e0b259 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -42,7 +42,7 @@
 #include "aosp.h"
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	21
+#define MGMT_REVISION	22
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
2.34.1

