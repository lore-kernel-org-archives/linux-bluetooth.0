Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97119C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Dec 2020 23:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651D12336E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Dec 2020 23:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbgLKXcJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 18:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437194AbgLKXbj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 18:31:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A18C0613D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 15:30:59 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v1so2958953pjr.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 15:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38CFfTCM2EyKc+/MOMwe2PkHUOiKmrtbhIbIu3Pv1+4=;
        b=oH70Ygx9eEnT0rluN0p7yHvGo2Ph6o4I167YBYmkbsX9rhsYWpI0JAhtbU9HqbTFHS
         QVZfyemB70vET/a0ykK0IOvVUW25XY2wd44fzNfvufS1B9Aojb6rdwkaYaMPYuGn8SXw
         ZmM60601VlCjJpOKoyJS4BP0iZJFHSqGQmAG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38CFfTCM2EyKc+/MOMwe2PkHUOiKmrtbhIbIu3Pv1+4=;
        b=J+3EiLes0wSh0eCFmFf8bTXxG04zbTDnJfep9m7Er6ux57FaiJRI000QWOZF10xWcF
         PvnUOwpn0mohFtn0rpcOMXA3oOsq106ivslf4W82c2mV3tBCIJTFx3x1h+4ey3Z1NzWM
         DIXD1Odblfnjb+XAAK4tgMi8e+7/rJ71r47exhQZBUHkzFAAsRGDm/wiNf/IUqNbumM5
         hgO1TAe0TfgxDoCwQQBJLxUGJoj1tuqtwsDlKn9hyPp/HzgBXdjQ1RZXPnkbXHv34LMt
         kaJJ2KwnPKJSu9tDrb2bE1z8z9euNRfdqi3m2PD3exVLE7SSi9Bnt/VqDARS/mjYm2u6
         ezRQ==
X-Gm-Message-State: AOAM53360JML21tLX2cSAYLv93RahaWKm/rpGdj6L5hCbgfZKOTNFlHj
        +SsaATmlOkD0In3AbE+/aSzmg4pdiYDO0Q==
X-Google-Smtp-Source: ABdhPJykaubb+fjEKEFnUJftynih5m7EfHjQpN7lTK4H7hSSgakYwPgM8+eDkA8lLSZB5oWpEhlwdQ==
X-Received: by 2002:a17:902:a60c:b029:da:e036:5dbe with SMTP id u12-20020a170902a60cb02900dae0365dbemr12853967plq.43.1607729458781;
        Fri, 11 Dec 2020 15:30:58 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y15sm11015450pju.13.2020.12.11.15.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 15:30:58 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ v2 2/2] input/hog: Cache the HID report map
Date:   Fri, 11 Dec 2020 15:30:47 -0800
Message-Id: <20201211233047.108658-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201211233047.108658-1-sonnysasaka@chromium.org>
References: <20201211233047.108658-1-sonnysasaka@chromium.org>
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
 profiles/input/hog-lib.c | 142 ++++++++++++++++++++++++++++++++-------
 1 file changed, 118 insertions(+), 24 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index ee811d301..e5fef4c7c 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -95,6 +95,13 @@ struct bt_hog {
 	struct queue		*bas;
 	GSList			*instances;
 	struct queue		*gatt_op;
+	struct gatt_db		*gatt_db;
+	struct gatt_db_attribute	*report_map_attr;
+};
+
+struct report_map {
+	uint8_t	value[HOG_REPORT_MAP_MAX_SIZE];
+	size_t	length;
 };
 
 struct report {
@@ -924,33 +931,16 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 	return str;
 }
 
-static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
+							ssize_t report_map_len)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
+	uint8_t *value = report_map;
 	struct uhid_event ev;
-	ssize_t vlen;
+	ssize_t vlen = report_map_len;
 	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
 	int i, err;
 	GError *gerr = NULL;
 
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
-		return;
-	}
-
 	DBG("Report MAP:");
 	for (i = 0; i < vlen;) {
 		ssize_t ilen = 0;
@@ -1022,6 +1012,43 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	DBG("HoG created uHID device");
 }
 
+static void db_report_map_write_value_cb(struct gatt_db_attribute *attr,
+						int err, void *user_data)
+{
+	if (err)
+		error("Error writing report map value to gatt db");
+}
+
+static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
+	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
+	ssize_t vlen;
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
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
+		error("ATT protocol error");
+		return;
+	}
+
+	uhid_create(hog, value, vlen);
+
+	/* Cache the report map to optimize reconnection */
+	gatt_db_attribute_write(hog->report_map_attr, 0, value, vlen, 0, NULL,
+					db_report_map_write_value_cb, NULL);
+}
+
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -1269,12 +1296,32 @@ static void foreach_hog_external(struct gatt_db_attribute *attr,
 					external_report_reference_cb, hog);
 }
 
+static void db_report_map_read_value_cb(struct gatt_db_attribute *attrib,
+						int err, const uint8_t *value,
+						size_t length, void *user_data)
+{
+	struct report_map *map = user_data;
+
+	if (err) {
+		error("Error reading report map from gatt db %s",
+								strerror(-err));
+		return;
+	}
+
+	if (!length)
+		return;
+
+	map->length = length < sizeof(map->value) ? length : sizeof(map->value);
+	memcpy(map->value, value, map->length);
+}
+
 static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
 	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
 	uint16_t handle, value_handle;
+	struct report_map report_map = {0};
 
 	gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
 					NULL, &uuid);
@@ -1288,8 +1335,24 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 
 	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
 	if (!bt_uuid_cmp(&report_map_uuid, &uuid)) {
-		read_char(hog, hog->attrib, value_handle, report_map_read_cb,
-									hog);
+
+		hog->report_map_attr = gatt_db_get_attribute(hog->gatt_db,
+								value_handle);
+		gatt_db_attribute_read(hog->report_map_attr, 0,
+					BT_ATT_OP_READ_REQ, NULL,
+					db_report_map_read_value_cb,
+					&report_map);
+
+		if (report_map.length) {
+			/* Report map found in the cache, straight to creating
+			 * UHID to optimize reconnection.
+			 */
+			uhid_create(hog, report_map.value, report_map.length);
+		} else {
+			read_char(hog, hog->attrib, value_handle,
+						report_map_read_cb, hog);
+		}
+
 		gatt_db_service_foreach_desc(attr, foreach_hog_external, hog);
 		return;
 	}
@@ -1417,6 +1480,8 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 			hog->dis = bt_dis_new(db);
 			bt_dis_set_notification(hog->dis, dis_notify, hog);
 		}
+
+		hog->gatt_db = db;
 	}
 
 	return bt_hog_ref(hog);
@@ -1612,9 +1677,14 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 					hog->primary->range.start,
 					hog->primary->range.end, NULL,
 					char_discovered_cb, hog);
-		return true;
 	}
 
+	if (!hog->uhid_created)
+		return true;
+
+	/* If UHID is already created, set up the report value handlers to
+	 * optimize reconnection.
+	 */
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
@@ -1627,6 +1697,29 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
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
@@ -1660,6 +1753,7 @@ void bt_hog_detach(struct bt_hog *hog)
 	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
+	uhid_destroy(hog);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
-- 
2.26.2

