Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC6C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiHPWF4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiHPWFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 18:05:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB7572FFB
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 15:05:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x23so10419750pll.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=kQGO0sS9sRtaLSp95kykOALXFP1iVmlbPRjhN9fyz8g=;
        b=LE4bTFz/KAYHFGeQlKSvbvzF9fQkC2RlfJ7fY+to8lxgPBFSZ6FPXaq2NLAEV4Hozc
         VIQO2Mj7doBIqt6WIZ1q2NwfnjH4YeB12w1xIb2/SV3w1cU5RNl9lZ1tzBvCPTQjGML7
         Bj2Npqho1n85/hfEMEXPUJjdeE9lLXya2u3kUVWp/k1FyS4PxCL/FhcIx0xJYR008k6o
         O+wPq9xvO6XdpHET5EzWhbzCSmrwpO0RYwayOlwMUKNNwtPpVcx6o92DeVPgocrrh8hf
         cqbYXSas914pgVGKz5OtqhsbCmHdW/EwZ4+5fWfzhFIPy+KbJX0c7d8z2sK6yrDanoxc
         3cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=kQGO0sS9sRtaLSp95kykOALXFP1iVmlbPRjhN9fyz8g=;
        b=wG/o2rpN+22ANXABIHrJ75dGXjLQ91sgUA99b90Au0DsK8F/poqx4GDnnsbpDsra14
         9YbGqWRf+frhFi/Fk1fYo2gaj/4ePxx9GCVkLO096aY2FPkI5SBRRAIlwUfs18MiiUtz
         JtYsHps/H3oGzNrwzpEdJXTbrvCA6mFIHus3BLV1Sog11T+rvSeqOFpq7m1Yjy6sYnK8
         gaN7fKq4WI29BUgoPT0jNzgNHrK6WWAcPdkPfXvmJl5Z6uIY8azRXvV/y3RACvgLsrgG
         85dMpi2AReRbl0gvP22UNlt+iLzsaHMCPsuqx/ViAoEh28eOxDSWjPRQGRkuDbesEbTe
         obkg==
X-Gm-Message-State: ACgBeo34664Tj3dV0Qw+AJmxpmZUuDMRn7R0TBz/gHOa4blcFLb5RxUg
        LgNZXfWHLBKK/2/yJi8FVizyDz7WbkXMA3Aa
X-Google-Smtp-Source: AA6agR6nefEntwWXhj8ESP0Zh2iVaI4jSjryieantI9VX+0YBZ8kWOJwGOVbs3gA5bGYEOhweTxHxQ==
X-Received: by 2002:a17:90b:48d0:b0:1fa:b438:1b20 with SMTP id li16-20020a17090b48d000b001fab4381b20mr35097pjb.239.1660687552756;
        Tue, 16 Aug 2022 15:05:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a20-20020aa79714000000b0052d2cd99490sm8954286pfg.5.2022.08.16.15.05.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:05:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/2] hog-lib: Don't restrict Report MAP size
Date:   Tue, 16 Aug 2022 15:05:47 -0700
Message-Id: <20220816220548.1555673-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Although HIDS spec is quite clear the Report MAP shall be limited to
512 bytes it doesn't seem OS do enforce that on the profile/client side
and since there isn't any qualification test enforcing it either there
are quite many devices which uses Report MAP bigger that 512 bytes
(e.g.: Brydge W-Touch and Lenovo Duet 3 BT Folio).

https://github.com/bluez/bluez/issues/377
---
 profiles/input/hog-lib.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 4a9c601853f1..ace233d3ce8b 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -64,7 +64,6 @@
 #define HOG_PROTO_MODE_BOOT    0
 #define HOG_PROTO_MODE_REPORT  1
 
-#define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
 #define ATT_NOTIFICATION_HEADER_SIZE	3
 
@@ -103,11 +102,6 @@ struct bt_hog {
 	struct queue		*input;
 };
 
-struct report_map {
-	uint8_t	value[HOG_REPORT_MAP_MAX_SIZE];
-	size_t	length;
-};
-
 struct report {
 	struct bt_hog		*hog;
 	bool			numbered;
@@ -1096,7 +1090,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 {
 	struct gatt_request *req = user_data;
 	struct bt_hog *hog = req->user_data;
-	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
+	uint8_t *value;
 	ssize_t vlen;
 
 	remove_gatt_req(req, status);
@@ -1106,10 +1100,12 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	value = new0(uint8_t, plen);
+
+	vlen = dec_read_resp(pdu, plen, value, plen);
 	if (vlen < 0) {
 		error("ATT protocol error");
-		return;
+		goto done;
 	}
 
 	uhid_create(hog, value, vlen);
@@ -1120,6 +1116,9 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 					NULL, db_report_map_write_value_cb,
 					NULL);
 	}
+
+done:
+	free(value);
 }
 
 static void read_report_map(struct bt_hog *hog)
@@ -1394,7 +1393,7 @@ static void db_report_map_read_value_cb(struct gatt_db_attribute *attrib,
 						int err, const uint8_t *value,
 						size_t length, void *user_data)
 {
-	struct report_map *map = user_data;
+	struct iovec *map = user_data;
 
 	if (err) {
 		error("Error reading report map from gatt db %s",
@@ -1405,8 +1404,9 @@ static void db_report_map_read_value_cb(struct gatt_db_attribute *attrib,
 	if (!length)
 		return;
 
-	map->length = length < sizeof(map->value) ? length : sizeof(map->value);
-	memcpy(map->value, value, map->length);
+
+	map->iov_len = length;
+	map->iov_base = (void *) value;
 }
 
 static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
@@ -1415,7 +1415,7 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 	bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
 	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
 	uint16_t handle, value_handle;
-	struct report_map report_map = {0};
+	struct iovec map = {};
 
 	gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
 					NULL, &uuid);
@@ -1438,14 +1438,14 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 			gatt_db_attribute_read(hog->report_map_attr, 0,
 						BT_ATT_OP_READ_REQ, NULL,
 						db_report_map_read_value_cb,
-						&report_map);
+						&map);
 		}
 
-		if (report_map.length) {
+		if (map.iov_len) {
 			/* Report map found in the cache, straight to creating
 			 * UHID to optimize reconnection.
 			 */
-			uhid_create(hog, report_map.value, report_map.length);
+			uhid_create(hog, map.iov_base, map.iov_len);
 		}
 
 		gatt_db_service_foreach_desc(attr, foreach_hog_external, hog);
-- 
2.37.2

