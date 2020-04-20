Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2047C3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 13:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D330B2070B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 13:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDTNPr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:15:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49484 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDTNPr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 09:15:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: scerveau)
        with ESMTPSA id 4773A2A0DCD
From:   =?UTF-8?q?St=C3=A9phane=20Cerveau?= <scerveau@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?St=C3=A9phane=20Cerveau?= <scerveau@collabora.com>
Subject: [PATCH] [PATCH BlueZ] add hog ref before adding to instances
Date:   Mon, 20 Apr 2020 15:14:48 +0200
Message-Id: <20200420131448.21796-2-scerveau@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420131448.21796-1-scerveau@collabora.com>
References: <20200420131448.21796-1-scerveau@collabora.com>
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
 profiles/input/hog-lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 9c5c814a7..b9b5d565c 100644
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
@@ -1528,7 +1528,7 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 			primary->range.end, find_included_cb, instance);
 
 	bt_hog_attach(instance, hog->attrib);
-	hog->instances = g_slist_append(hog->instances, instance);
+	hog->instances = g_slist_append(hog->instances, bt_hog_ref(instance));
 }
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
-- 
2.17.1

