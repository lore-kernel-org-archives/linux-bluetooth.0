Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F43C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 19:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiHPTL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiHPTLv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 15:11:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1407CAAA
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 12:11:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o3so10058226ple.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=PLdHDjgFCmY8wCF4AMUEtpVpL/we+6MJ2PVgChJNeqI=;
        b=fW2BR6CfHu/RgIYIPVbabTsN7J4hbfMl8OD857l7WwPh2Tia8qib9JZ0zoS1DZeWHD
         VGr7ofac4oWpi29GYJkaXkfC+25VmzqFtFAcvHJGFYWo1rOOz0s4ref2AbN4KHwfHWLl
         wE48Fan5CYvJOjoohVXITzf97My7e9UK+zX6OUp4v1MfEYnIgCWHoxzDxR36HkrtStqO
         HJPK6xZaz+1LY1UpZvg1IYqswC3DgHQxV/fBeuufmzr9mQv+C9KnemaOCVuC/wtiuHM2
         qBczNmW7r9AwwiP2ajEjaKULzrJfGJQRsbNccaTEAUjoqD/LduicB3YDGv/uNLG7pmSj
         RZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=PLdHDjgFCmY8wCF4AMUEtpVpL/we+6MJ2PVgChJNeqI=;
        b=06PYj9RVnoeDLFem9AFPoePHP2M+SZ5JpgA4VTvCzXCBGGIHY7FwA8hS0G32XSJB3q
         fOTGEZrpPsBe7kRleyHgsdV3QWZq8W1y07HAav8SzX3qtfW9Ew6CLwWso2WbGU3dcojg
         B93S1Za7cp7856UHeJENKX1IsS287aiTv4J0Qbxn71wkg37M+2PloEd33FgkQ0ykGDSH
         bA2nU6zIwf0JfU7Utj7DT4K0fyZVFfYtJupKdxtYflEslVhydweoRA4XtOh2yj+crWcv
         67diZb1m6ORpo5mYHbis44cd5NUlzKw1HJFiIie/hIGDloblzUeEZEkAwBV388fVg5s9
         ti2A==
X-Gm-Message-State: ACgBeo3KdtgasROhTCcn4xePd6cOso6bHmASpE8PExZbGOwes3sJPxpI
        k5b4voeocC92BMVfHz2qmadNj46oufQYhQ==
X-Google-Smtp-Source: AA6agR4v83vCZA/wy8qKXfN8zAxKeKh9EijoE+IzcZxdsbVtmVEPf8bT/ttzsvN0gZW4tFuT9PCtJw==
X-Received: by 2002:a17:902:a982:b0:170:d646:5851 with SMTP id bh2-20020a170902a98200b00170d6465851mr23997152plb.134.1660677109162;
        Tue, 16 Aug 2022 12:11:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b00170a6722c79sm9450214plg.247.2022.08.16.12.11.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:11:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog-lib: Don't restrict Report MAP size
Date:   Tue, 16 Aug 2022 12:11:44 -0700
Message-Id: <20220816191144.1515498-1-luiz.dentz@gmail.com>
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
index 4a9c601853f1..0aec84775950 100644
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
+	struct iovec map;
 
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

