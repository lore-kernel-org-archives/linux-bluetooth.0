Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAFDC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23E961A15
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 14:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhCXOLX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:11:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38350 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbhCXOLF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 10:11:05 -0400
Received: from localhost.localdomain (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id 72DC8CED00
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 15:18:43 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: Move the advertisement monitor events to correct list
Date:   Wed, 24 Mar 2021 15:10:56 +0100
Message-Id: <20210324141059.88009-2-marcel@holtmann.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The list of trusted events should contain the advertisement monitor
events and not the untrusted one, so move entries to the correct list.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3c0bec06828a..6b5bdf1f39ca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -168,6 +168,8 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_PHY_CONFIGURATION_CHANGED,
 	MGMT_EV_EXP_FEATURE_CHANGED,
 	MGMT_EV_DEVICE_FLAGS_CHANGED,
+	MGMT_EV_ADV_MONITOR_ADDED,
+	MGMT_EV_ADV_MONITOR_REMOVED,
 	MGMT_EV_CONTROLLER_SUSPEND,
 	MGMT_EV_CONTROLLER_RESUME,
 };
@@ -198,8 +200,6 @@ static const u16 mgmt_untrusted_events[] = {
 	MGMT_EV_EXT_INDEX_REMOVED,
 	MGMT_EV_EXT_INFO_CHANGED,
 	MGMT_EV_EXP_FEATURE_CHANGED,
-	MGMT_EV_ADV_MONITOR_ADDED,
-	MGMT_EV_ADV_MONITOR_REMOVED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
-- 
2.30.2

