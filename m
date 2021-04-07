Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B66C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2356121E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 22:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhDGWfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhDGWfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 18:35:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A9C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 15:35:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y32so10938032pga.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0W0S+BklYkH2JwKgMoATRJz2kgJOT7a5wwQMUj1rys0=;
        b=kSgZfY3cR/r/tZYgWssEPPA5LNxGbyAa6COL8dMlxnB6WYfmYxH/iWBEFn/SDBYGAo
         DW4W8DYFzlKPy1KznJgjXVYnjcuQ27ZO8cMjmrtiTmykXWs2fVan8wIC/KoVmG7ycIbi
         k3/++vZ091z9jjBBQyMDrd903j6ZBLQkpXE6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0W0S+BklYkH2JwKgMoATRJz2kgJOT7a5wwQMUj1rys0=;
        b=uYTDITVDH8POk0noKZQ8rCURqDOeFWwAjx9rpJXKvzmbJ92fOyMbf7o4h+dbTWnO5T
         a1Aror2R263wTLY4VFtLE7gqk88bW7iCyGYiH4ZKSpv/v+OF/06G34WUi+2ldD+Yqsid
         s3DkNSp2gJKpQIo9KA9hF5ERy8NhQbHgmvzVQv4sT5euaAMlt4BuzLgGlN5TpU5CAARM
         j+2nCFYCtH7Ys5dnCJafzAlz3GyEmmstEnne90og4cxK+ev8CWMTZhdY1OWCo0/zoHD8
         Xl+m1AmbrE7qKMpA2Vh0ARmvdYK71kNzeTa5EA/PjkVTWHYllBXq5WLPelqUYAZOwOts
         7rEQ==
X-Gm-Message-State: AOAM531IrODmW2h7VHUBHnnnjiu61/DO8eOLwCVaTnsuP3RRz8lb4s4P
        fUYopjftqNpmUI+PKHKlMG8pJMQEb/WJWw==
X-Google-Smtp-Source: ABdhPJzmOkyUGD0E6SVmQp2W19BshF7174V2a76Vtq7GN2VHSDNjOG2Glv2hww1NF1Ar3Tb7hnNTTQ==
X-Received: by 2002:aa7:9533:0:b029:241:9d92:92e1 with SMTP id c19-20020aa795330000b02902419d9292e1mr4890057pfp.14.1617834913464;
        Wed, 07 Apr 2021 15:35:13 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:c572:df03:d9fe:57c5])
        by smtp.gmail.com with ESMTPSA id r26sm16382115pgn.15.2021.04.07.15.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 15:35:13 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH BlueZ] input/hog-lib: add error handling when calling into gatt
Date:   Wed,  7 Apr 2021 15:35:09 -0700
Message-Id: <20210407223509.28997-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

When calling gatt_write_char(), gatt_read_char(), etc, id == 0 indicates
error. Let's recognize this fact and log it instead of queueing request
that will never be completed.

---
 profiles/input/hog-lib.c | 77 +++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 6ac14e401..668f8047a 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -166,13 +166,16 @@ static void write_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
 		return;
 
 	id = gatt_write_char(attrib, handle, value, vlen, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
+	if (!id) {
+		error("hog: Could not write char");
 		return;
+	}
 
-	error("hog: Could not read char");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	if (!set_and_store_gatt_req(hog, req, id)) {
+		error("hog: Failed to queue write char req");
+		g_attrib_cancel(attrib, id);
+		free(req);
+	}
 }
 
 static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
@@ -190,13 +193,16 @@ static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
 		return;
 
 	id = gatt_read_char(attrib, handle, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
+	if (!id) {
+		error("hog: Could not read char");
 		return;
+	}
 
-	error("hog: Could not read char");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	if (!set_and_store_gatt_req(hog, req, id)) {
+		error("hog: Failed to queue read char req");
+		g_attrib_cancel(attrib, id);
+		free(req);
+	}
 }
 
 static void discover_desc(struct bt_hog *hog, GAttrib *attrib,
@@ -211,12 +217,16 @@ static void discover_desc(struct bt_hog *hog, GAttrib *attrib,
 		return;
 
 	id = gatt_discover_desc(attrib, start, end, NULL, func, req);
-	if (set_and_store_gatt_req(hog, req, id))
+	if (!id) {
+		error("hog: Could not discover descriptors");
 		return;
+	}
 
-	error("hog: Could not discover descriptors");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	if (!set_and_store_gatt_req(hog, req, id)) {
+		error("hog: Failed to queue discover descriptors req");
+		g_attrib_cancel(attrib, id);
+		free(req);
+	}
 }
 
 static void discover_char(struct bt_hog *hog, GAttrib *attrib,
@@ -232,13 +242,16 @@ static void discover_char(struct bt_hog *hog, GAttrib *attrib,
 		return;
 
 	id = gatt_discover_char(attrib, start, end, uuid, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
+	if (!id) {
+		error("hog: Could not discover characteristic");
 		return;
+	}
 
-	error("hog: Could not discover characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	if (!set_and_store_gatt_req(hog, req, id)) {
+		error("hog: Failed to queue discover characteristic req");
+		g_attrib_cancel(attrib, id);
+		free(req);
+	}
 }
 
 static void discover_primary(struct bt_hog *hog, GAttrib *attrib,
@@ -253,13 +266,16 @@ static void discover_primary(struct bt_hog *hog, GAttrib *attrib,
 		return;
 
 	id = gatt_discover_primary(attrib, uuid, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
+	if (!id) {
+		error("hog: Could not send discover primary");
 		return;
+	}
 
-	error("hog: Could not send discover primary");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	if (!set_and_store_gatt_req(hog, req, id)) {
+		error("hog: Failed to queue discover primary req");
+		g_attrib_cancel(attrib, id);
+		free(req);
+	}
 }
 
 static void find_included(struct bt_hog *hog, GAttrib *attrib,
@@ -274,13 +290,16 @@ static void find_included(struct bt_hog *hog, GAttrib *attrib,
 		return;
 
 	id = gatt_find_included(attrib, start, end, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
+	if (!id) {
+		error("hog: Could not find included");
 		return;
+	}
 
-	error("Could not find included");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	if (!set_and_store_gatt_req(hog, req, id)) {
+		error("hog: Failed to queue find included req");
+		g_attrib_cancel(attrib, id);
+		free(req);
+	}
 }
 
 static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
-- 
2.31.0

