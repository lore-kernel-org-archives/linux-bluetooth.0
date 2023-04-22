Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B4C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Apr 2023 17:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDVRGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Apr 2023 13:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDVRGD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Apr 2023 13:06:03 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C32702
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 10:06:01 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 457C32401B6
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 19:06:00 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Q3d875qPLz6txJ;
        Sat, 22 Apr 2023 19:05:59 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/bap: add function to get location from PAC
Date:   Sat, 22 Apr 2023 17:05:56 +0000
Message-Id: <3cc705b0fa000b4cfc5071ae13f4c0fcb31bfc25.1682182441.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add function to get the PACS Sink/Source Audio Locations field relevant
for a given PAC.
---
 src/shared/bap.c | 14 ++++++++++++++
 src/shared/bap.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1fff7e0fd..5a12a64d2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2442,6 +2442,20 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
 	return pac->type;
 }
 
+uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
+{
+	struct bt_pacs *pacs = pac->bdb->pacs;
+
+	switch (pac->type) {
+	case BT_BAP_SOURCE:
+		return pacs->source_loc_value;
+	case BT_BAP_SINK:
+		return pacs->sink_loc_value;
+	default:
+		return 0;
+	}
+}
+
 static void notify_pac_removed(void *data, void *user_data)
 {
 	struct bt_bap_pac_changed *changed = data;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index bd13abef9..0d419aa74 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -128,6 +128,8 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
+uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
-- 
2.40.0

