Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530CAC54FCF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC412074F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 18:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDTSkj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDTSkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 14:40:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA45C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 11:40:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: scerveau)
        with ESMTPSA id 5CA9E2A0467
From:   =?UTF-8?q?St=C3=A9phane=20Cerveau?= <scerveau@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?St=C3=A9phane=20Cerveau?= <scerveau@collabora.com>
Subject: [PATCH 1/1] add hog ref before adding to instances
Date:   Mon, 20 Apr 2020 20:40:29 +0200
Message-Id: <20200420184029.22891-1-scerveau@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To avoid a double hog free, need to add a ref
when adding the hog to the slist.

This bug has been reproduced with gamepad-8718
which was connecting/disconnecting frantically.

Fix also a typo in the method hog_attach_instance
---
 profiles/input/hog-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 9c5c814a7..8fb0283ca 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1357,7 +1357,7 @@ static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
 	return hog;
 }
 
-static void hog_attach_instace(struct bt_hog *hog,
+static void hog_attach_instance(struct bt_hog *hog,
 				struct gatt_db_attribute *attr)
 {
 	struct bt_hog *instance;
@@ -1373,14 +1373,14 @@ static void hog_attach_instace(struct bt_hog *hog,
 	if (!instance)
 		return;
 
-	hog->instances = g_slist_append(hog->instances, instance);
+	hog->instances = g_slist_append(hog->instances, bt_hog_ref(instance));
 }
 
 static void foreach_hog_service(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 
-	hog_attach_instace(hog, attr);
+	hog_attach_instance(hog, attr);
 }
 
 static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
-- 
2.17.1

