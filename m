Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7810C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 18:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjBASlq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBASlm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 13:41:42 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9F3ABD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 10:41:39 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id DC53D240690
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 19:41:37 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4P6W3P1Nkcz6tm6;
        Wed,  1 Feb 2023 19:41:36 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] media: set default value for BAP endpoint Vendor field
Date:   Wed,  1 Feb 2023 18:41:18 +0000
Message-Id: <d23190507e9c7131481648848d0afd62448226d3.1675276185.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The "Vendor" field is optional, and should have an initialized valid
default value.
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index d96367454..a62755f69 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -2551,7 +2551,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	const char *uuid;
 	gboolean delay_reporting = FALSE;
 	uint8_t codec;
-	struct vendor vendor;
+	struct vendor vendor = { 0 };
 	struct bt_bap_pac_qos qos;
 	uint8_t *capabilities = NULL;
 	int size = 0;
-- 
2.39.1

