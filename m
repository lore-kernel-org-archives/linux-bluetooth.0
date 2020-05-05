Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ACAC47247
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5EE206FA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgEEXUp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 19:20:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56231 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgEEXUp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 19:20:45 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 27584CECFD
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 01:30:25 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/7] Bluetooth: Add MGMT_EV_PHY_CONFIGURATION_CHANGED to supported list
Date:   Wed,  6 May 2020 01:20:33 +0200
Message-Id: <4470adb873fbc0f5874038e1d99a63df3a7b59b8.1588720791.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588720791.git.marcel@holtmann.org>
References: <cover.1588720791.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The event MGMT_EV_PHY_CONFIGURATION_CHANGED wasn't listed in the list of
supported events. So add it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f8c0a4fc8090..33b5640ea060 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -147,6 +147,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_ADVERTISING_ADDED,
 	MGMT_EV_ADVERTISING_REMOVED,
 	MGMT_EV_EXT_INFO_CHANGED,
+	MGMT_EV_PHY_CONFIGURATION_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
-- 
2.26.2

