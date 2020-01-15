Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3FBC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 20:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C841A2084D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAOUfi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:35:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59064 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgAOUfi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 15:35:38 -0500
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 005C2CECF2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 21:44:54 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increment management interface revision
Date:   Wed, 15 Jan 2020 21:35:32 +0100
Message-Id: <20200115203532.136198-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Increment the mgmt revision due to the recently added commands.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 339c762eb6fd..0dc610faab70 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -38,7 +38,7 @@
 #include "mgmt_util.h"
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	14
+#define MGMT_REVISION	15
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
2.24.1

