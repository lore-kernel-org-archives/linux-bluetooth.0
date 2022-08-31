Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB3CECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 22:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiHaWZB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiHaWY7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 18:24:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C95DF89
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 15:24:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so647611pjj.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=XCiC8Ts/d5dBk2zUECSrJTog2ReRQOnfpRX63+MjdvM=;
        b=p71fX1AwchpPt6URtynhlWSrcmz2UsVb8cTfOwE2B153bFaKzh/iq9tl4mo/Yl+Rm2
         x2sjnLariZWCoFfg7BU+UxWhsuD6HCXBqmLNKGUgPm/484hho7iP8I9af0qs+4MVIOQ3
         UZZt+EDw9f044MsFHQ4Hpm+OjWp2yx1Bp6bCrIXCyDJR/6rv4dEndem2QpB0hUah3Lre
         taD2RZ3XwiM155j9tflxZEUY2OOoiTDMRJ5rCOfpiFRvH5RA5PaJaWp4r0zdGfyGnfMD
         4su0Z2aYO0WtCm9xmTDIq3Nyn6CXB8AZvlFGy+SG5p7dSesrNrmHT2rRPragXccN6eQm
         +ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=XCiC8Ts/d5dBk2zUECSrJTog2ReRQOnfpRX63+MjdvM=;
        b=LyY2uT9N42EhMpjCYTP+6Zm5rSN3IRGUgXJP0bDhlT+Saf2qNB/Yd2aTvAQYyrgQ76
         9YzpV/p9jRrNqmZSvjpfMMgjWDjcnbKPwUcDrDS7cwHGdze2xKNMipj8Is69hi2Vcpuu
         sWQHbgE1AgvWRXJciXcsRcwgnGTbwHgJr2lfvMYibES9mYmpjMtYITDMlxEjlRzbijq3
         NJk7pTWo/1yOBwtkC3B/TubEQKnvXG/2WI/QO/Tp3ZyXhYE6r2l4WwTzZ72yzFbEcQxw
         0VepRRlXFXagotXJyAw0yQ9BJLpkyPGtBL4xKcxpHa0OIiyDTVTohxXlp8/CEPcdhkfY
         sPmg==
X-Gm-Message-State: ACgBeo0ZCCQg1ZXt9AqF2j1ziqSghoGTCNvLcOwxS4ZWisSxKTSMnt9W
        FjIT7eHg/rFuAxTCZDGO/bETVxN+Up0=
X-Google-Smtp-Source: AA6agR40YWSBfcWY5d8JyxvWYUOhWoAtKxJmZoomzNUwyCskeXL9u+LDYAd/pqKSDoBVJyzJ//3sJA==
X-Received: by 2002:a17:903:18a:b0:16f:9027:60dc with SMTP id z10-20020a170903018a00b0016f902760dcmr27565456plg.147.1661984694717;
        Wed, 31 Aug 2022 15:24:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090aa60c00b001fd8df95decsm1809823pjq.27.2022.08.31.15.24.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:24:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH V3] media: Fix scan-build warnings
Date:   Wed, 31 Aug 2022 15:24:53 -0700
Message-Id: <20220831222453.1369940-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

profiles/audio/media.c:1465:6: warning: 8th function call argument
is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3012:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3015:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 profiles/audio/media.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index a7fa85d60310..c9328ab9bd6e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1440,7 +1440,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	gboolean delay_reporting = FALSE;
 	uint8_t codec = 0;
 	struct bt_bap_pac_qos qos = {};
-	uint8_t *capabilities;
+	uint8_t *capabilities = NULL;
 	int size = 0;
 	int err;
 
@@ -3005,14 +3005,25 @@ static const GDBusPropertyTable media_properties[] = {
 static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
+	GSList *l;
 
 	queue_destroy(adapter->apps, app_free);
 
-	while (adapter->endpoints)
-		release_endpoint(adapter->endpoints->data);
+	for (l = adapter->endpoints; l;) {
+		struct media_endpoint *endpoint	= l->data;
 
-	while (adapter->players)
-		media_player_destroy(adapter->players->data);
+		l = g_slist_next(l);
+
+		release_endpoint(endpoint);
+	}
+
+	for (l = adapter->players; l;) {
+		struct media_player *mp = l->data;
+
+		l = g_slist_next(l);
+
+		media_player_destroy(mp);
+	}
 
 	adapters = g_slist_remove(adapters, adapter);
 
-- 
2.37.2

