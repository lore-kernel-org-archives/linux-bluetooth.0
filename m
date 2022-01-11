Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jan 2022 01:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbiAKBlh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jan 2022 20:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiAKBlg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jan 2022 20:41:36 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC0AC06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 17:41:36 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t18so5330763plg.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2BEZovxVvOiIEBQjGaTU+7GguTAN5tCeELfrIKs1Ps=;
        b=S9q5sN0jxDBHn2BuC3HbXqsoql+tZFSYV6PJSaoxResmnkH0mJZL/CWdmwLOgROdP4
         cU16uu0UWION4b9eYOLqgS3fU3sofiSe4lO5DdE2nQ2B+MzeGuAR5XFKpTItFm7/C063
         AhprGPbyRxv1p5JuVtNpfa7C+DKTjQYrw3KzjHgfDZ1B2mj3WvMVQle1zbNc7jkRAe5n
         YNwgOvXGKluQ7PBP4zCEakeycviocIGFr9/CV9jj6nK6i/dYhQxu1KDanJw0T9oGQ0UE
         WBMDD159k2dQzCmDRAcwKIXlWm7hRHyEy+3PYj8sGJf0X7/cVG0TNWWmrLjXIwEhjxuG
         OYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2BEZovxVvOiIEBQjGaTU+7GguTAN5tCeELfrIKs1Ps=;
        b=MSEQr+iyn501aY3uDqRoR92140GozLLLqgOCal1g4xLGfAVzTas58dDbld9M6Gecr5
         wjlB+9w+6KEvOMlZWTzKk5bVoNqLiq5LZuUdMRMyykTWCiQVVLpiOsTvPiX1vhspKsdG
         EmqOREVqBAOp2Z2Zs0YfiW+/MrGN8BfJqsifJETVsq7Wdgns69BGWCqIRpt4E6nhVf9z
         yrIW44tSSQ9F11ky6Uo00WczVSFBa60yaTcx8ppYBPuhNG73WUVwJqzHOuZD05AhhZCL
         kEfLtprG0hQEVp4R8s1THqT2jm2TDXqWpLRFE9c5es7Mv2JIOIdnzuZwtuoSkY1etr4W
         ULgQ==
X-Gm-Message-State: AOAM530YSnp7OfN8iS9G8MQSJGDSHixiunYkle8PpzzXJQOTCFgMuhng
        TzcNTCry4egqUqqs+U311X1YWK4qQK8=
X-Google-Smtp-Source: ABdhPJwGCJzsHLv6nu8wzJwfZ8mwMG+oyVKSRndjwAyEVb2+S4ZjjYoxyr9dvjBE6tQt50joeDV8Dw==
X-Received: by 2002:a05:6a00:8d3:b0:4bc:3fe0:98d2 with SMTP id s19-20020a056a0008d300b004bc3fe098d2mr2275758pfu.3.1641865295695;
        Mon, 10 Jan 2022 17:41:35 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s20sm4109323pgv.56.2022.01.10.17.41.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 17:41:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog: Fix read order of attributes
Date:   Mon, 10 Jan 2022 17:41:34 -0800
Message-Id: <20220111014134.128632-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Report Map must be read after the Report Reference otherwise the
driver may start using UHID_SET_REPORT which requires the report->id to
be known what attribute to send to.

Fixes: https://github.com/bluez/bluez/issues/220
---
 profiles/input/hog-lib.c | 43 +++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index d37caa1f1..f32b791b3 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1349,24 +1349,17 @@ static void db_report_map_read_value_cb(struct gatt_db_attribute *attrib,
 	memcpy(map->value, value, map->length);
 }
 
-static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
+static void foreach_hog_report_map(struct gatt_db_attribute *attr,
+						void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
-	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
+	bt_uuid_t uuid, report_map_uuid;
 	uint16_t handle, value_handle;
 	struct report_map report_map = {0};
 
 	gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
 					NULL, &uuid);
 
-	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
-	if (!bt_uuid_cmp(&report_uuid, &uuid)) {
-		struct report *report = report_add(hog, attr);
-		gatt_db_service_foreach_desc(attr, foreach_hog_report, report);
-		return;
-	}
-
 	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
 	if (!bt_uuid_cmp(&report_map_uuid, &uuid)) {
 
@@ -1392,6 +1385,23 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 		}
 
 		gatt_db_service_foreach_desc(attr, foreach_hog_external, hog);
+	}
+}
+
+static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+	bt_uuid_t uuid, report_uuid, info_uuid;
+	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
+	uint16_t handle, value_handle;
+
+	gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
+					NULL, &uuid);
+
+	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
+	if (!bt_uuid_cmp(&report_uuid, &uuid)) {
+		struct report *report = report_add(hog, attr);
+		gatt_db_service_foreach_desc(attr, foreach_hog_report, report);
 		return;
 	}
 
@@ -1706,10 +1716,19 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 
 	if (!hog->uhid_created) {
 		DBG("HoG discovering characteristics");
-		if (hog->attr)
+		if (hog->attr) {
 			gatt_db_service_foreach_char(hog->attr,
 							foreach_hog_chrc, hog);
-		else
+			/* Report Map must be read last since that can result
+			 * in uhid being created and the driver may start to
+			 * use UHID_SET_REPORT which requires the report->id to
+			 * be known or order to send the request to the right
+			 * attribute/handle.
+			 */
+			gatt_db_service_foreach_char(hog->attr,
+						     foreach_hog_report_map,
+						     hog);
+		} else
 			discover_char(hog, hog->attrib,
 					hog->primary->range.start,
 					hog->primary->range.end, NULL,
-- 
2.33.1

