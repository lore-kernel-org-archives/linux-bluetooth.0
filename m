Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E2EC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E9D239FD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLIBB1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgLIBB0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 20:01:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA9C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 17:00:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so49544plk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 17:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57I8J+9Sz1z5XdfhWdkGcileeg/1hRiY8h7G9YrC+8w=;
        b=eacvLjFhNnhnAcM4COcFMhmfUvwmsFAFcrtKu+F7dk2mYtruQ7jFT9S21kIsbBfMb+
         EwIgGUe4l6h96y/Ugux+4+JOnZkRuk9vu2nkRpMpFVeGPySbxV653zH393ug8kPF8MUZ
         BL7NgJZ8Q3XlHO2g60H15YznGQvF37qDynlPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57I8J+9Sz1z5XdfhWdkGcileeg/1hRiY8h7G9YrC+8w=;
        b=jiAFRFsVcDLuvj5e2NWjExdfQ0CMwYff7FTDAnj2U4PA7nBe3IdgASipSdP7cawOmB
         lfsdtMYLFxdkdCNARzJAUzsOqrE1cOzFgN/QfXcn+VciqgZaxLokqwd77FKBFmJ6YXKZ
         OBadlgZ5q7JpKRMPva7sOvdBdhboOHa9GeO6u8toSZ2zrB8Z6Yp8QgUcloQ0EqiLWutS
         LbVFc0KkABV4sgPExOc1tD0V0AecitQ38jDy3sGpFtv4g4AO95OMO1hnBCsny4Sol/Q/
         0XV+hTt8YKJR1bz91B9mvtgMUxJMKC7vAZzvIrCvIotllO2AEB82je0wXRnej7zzbpOS
         wqUg==
X-Gm-Message-State: AOAM532hcFvCeYRBqlyEMCfn3rfHmK2/f+LZQVsv005NLgRntHvGUY0M
        Iy/cnh9apYJrojFxmTpbidiXa6rDnEgu6Q==
X-Google-Smtp-Source: ABdhPJyJ5icm4tjopsai6NkVBYnuAtE0drBgTiAcW4z8uEU9UwZCfcWdILDmKYYO1R7GWeWL7UhE7g==
X-Received: by 2002:a17:902:52a:b029:da:989f:6c01 with SMTP id 39-20020a170902052ab02900da989f6c01mr493409plf.45.1607475645875;
        Tue, 08 Dec 2020 17:00:45 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id 5sm28052pfw.12.2020.12.08.17.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 17:00:45 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ 2/2] input/hog: Cache the HID report map
Date:   Tue,  8 Dec 2020 17:00:30 -0800
Message-Id: <20201209010030.342632-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201209010030.342632-1-sonnysasaka@chromium.org>
References: <20201209010030.342632-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To optimize BLE HID devices reconnection response, we can cache the
report map so that the subsequent reconnections do not need round trip
time to read the report map.

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 profiles/input/hog-lib.c | 142 ++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 46 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index ee811d301..1e198ea64 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -95,6 +95,8 @@ struct bt_hog {
 	struct queue		*bas;
 	GSList			*instances;
 	struct queue		*gatt_op;
+	uint8_t			report_map[HOG_REPORT_MAP_MAX_SIZE];
+	ssize_t			report_map_len;
 };
 
 struct report {
@@ -276,6 +278,8 @@ static void find_included(struct bt_hog *hog, GAttrib *attrib,
 	free(req);
 }
 
+static void uhid_create(struct bt_hog *hog);
+
 static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
@@ -924,57 +928,17 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 	return str;
 }
 
-static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void uhid_create(struct bt_hog *hog)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
-	ssize_t vlen;
-	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
-	int i, err;
 	GError *gerr = NULL;
+	int i, err;
 
-	destroy_gatt_req(req);
-
-	DBG("HoG inspecting report map");
-
-	if (status != 0) {
-		error("Report Map read failed: %s", att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
+	if (!hog->report_map_len) {
+		warn("Failed to initiate UHID_CREATE without report map");
 		return;
 	}
 
-	DBG("Report MAP:");
-	for (i = 0; i < vlen;) {
-		ssize_t ilen = 0;
-		bool long_item = false;
-
-		if (get_descriptor_item_info(&value[i], vlen - i, &ilen,
-								&long_item)) {
-			/* Report ID is short item with prefix 100001xx */
-			if (!long_item && (value[i] & 0xfc) == 0x84)
-				hog->has_report_id = TRUE;
-
-			DBG("\t%s", item2string(itemstr, &value[i], ilen));
-
-			i += ilen;
-		} else {
-			error("Report Map parsing failed at %d", i);
-
-			/* Just print remaining items at once and break */
-			DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
-			break;
-		}
-	}
-
-	/* create uHID device */
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
 
@@ -1004,8 +968,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	ev.u.create.version = hog->version;
 	ev.u.create.country = hog->bcountrycode;
 	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = value;
-	ev.u.create.rd_size = vlen;
+	ev.u.create.rd_data = hog->report_map;
+	ev.u.create.rd_size = hog->report_map_len;
 
 	err = bt_uhid_send(hog->uhid, &ev);
 	if (err < 0) {
@@ -1018,6 +982,62 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
 
 	hog->uhid_created = true;
+}
+
+static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
+	ssize_t vlen;
+	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
+	int i;
+
+	destroy_gatt_req(req);
+
+	DBG("HoG inspecting report map");
+
+	if (status != 0) {
+		error("Report Map read failed: %s", att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, plen, hog->report_map,
+						sizeof(hog->report_map));
+	if (vlen < 0) {
+		error("ATT protocol error");
+		return;
+	}
+
+	hog->report_map_len = vlen;
+
+	DBG("Report MAP:");
+	for (i = 0; i < vlen;) {
+		ssize_t ilen = 0;
+		bool long_item = false;
+
+		if (get_descriptor_item_info(&hog->report_map[i], vlen - i,
+						&ilen, &long_item)) {
+			/* Report ID is short item with prefix 100001xx */
+			if (!long_item && (hog->report_map[i] & 0xfc) == 0x84)
+				hog->has_report_id = TRUE;
+
+			DBG("\t%s", item2string(itemstr, &hog->report_map[i],
+									ilen));
+
+			i += ilen;
+		} else {
+			error("Report Map parsing failed at %d", i);
+
+			/* Just print remaining items at once and break */
+			DBG("\t%s", item2string(itemstr, &hog->report_map[i],
+						vlen - i));
+			break;
+		}
+	}
+
+	/* create uHID device */
+	uhid_create(hog);
 
 	DBG("HoG created uHID device");
 }
@@ -1602,6 +1622,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 		bt_hog_attach(instance, gatt);
 	}
 
+	/* Try to initiate UHID_CREATE if we already have the report map to
+	 * avoid re-reading the report map from the peer device.
+	 */
+	if (hog->report_map_len > 0)
+		uhid_create(hog);
+
 	if (!hog->uhid_created) {
 		DBG("HoG discovering characteristics");
 		if (hog->attr)
@@ -1627,6 +1653,29 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	return true;
 }
 
+static void uhid_destroy(struct bt_hog *hog)
+{
+	int err;
+	struct uhid_event ev;
+
+	if (!hog->uhid_created)
+		return;
+
+	bt_uhid_unregister_all(hog->uhid);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	err = bt_uhid_send(hog->uhid, &ev);
+
+	if (err < 0) {
+		error("bt_uhid_send: %s", strerror(-err));
+		return;
+	}
+
+	hog->uhid_created = false;
+}
+
 void bt_hog_detach(struct bt_hog *hog)
 {
 	GSList *l;
@@ -1660,6 +1709,7 @@ void bt_hog_detach(struct bt_hog *hog)
 	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
+	uhid_destroy(hog);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
-- 
2.26.2

