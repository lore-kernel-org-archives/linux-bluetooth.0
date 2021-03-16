Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA41C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2356507B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhCPO3E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:29:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41896 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhCPO2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:28:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 381AF1F44BF6
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH Bluez v2] android/handsfree: Fix g_timeout_add_seconds_full call
Date:   Tue, 16 Mar 2021 15:28:44 +0100
Message-Id: <20210316142844.23872-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The call uses the default priority value and doe not set a destroy
function, in this case g_timeout_add_seconds can be used.
---
 android/handsfree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 2365356c2..977803111 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2330,9 +2330,7 @@ static void phone_state_incoming(struct hf_device *dev, int num_active,
 	/* send first RING */
 	ring_cb(dev);
 
-	dev->ring = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
-							RING_TIMEOUT, ring_cb,
-							dev, NULL);
+	dev->ring = g_timeout_add_seconds(RING_TIMEOUT, ring_cb, dev);
 	if (!dev->ring) {
 		g_free(dev->clip);
 		dev->clip = NULL;
-- 
2.18.0

