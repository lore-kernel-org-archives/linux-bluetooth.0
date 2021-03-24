Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B5C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B061A1C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 14:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhCXOLY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:11:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43956 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhCXOLF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 10:11:05 -0400
Received: from localhost.localdomain (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id 49975CECFF
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 15:18:43 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: Add missing entries for PHY configuration commands
Date:   Wed, 24 Mar 2021 15:10:55 +0100
Message-Id: <20210324141059.88009-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The list of supported mgmt commands for PHY configuration is missing, so
just add them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 90334ac4a135..3c0bec06828a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -108,6 +108,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_GET_PHY_CONFIGURATION,
+	MGMT_OP_SET_PHY_CONFIGURATION,
 	MGMT_OP_SET_BLOCKED_KEYS,
 	MGMT_OP_SET_WIDEBAND_SPEECH,
 	MGMT_OP_READ_CONTROLLER_CAP,
-- 
2.30.2

