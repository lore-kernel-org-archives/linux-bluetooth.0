Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A30C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 21:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiCNVva (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCNVv3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 17:51:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5A344CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 14:50:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z16so16331305pfh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=njAUkH5dFFKuqO+juI/HLGmCs3nd2qaoyWds8EGJd78=;
        b=YE6lKpEeqWWr7bxVddJNsxSeXHOsfubyQgK5FMK2g021xkXIq7LtC5F/WcOQgXufx5
         mLyh8hhgNV8LUmwEgFeJBL+q+zv2OIItg1FLqHy66MI7LGJowUDsvK45gnESLLVTmCqu
         Bu2TlFZKYyRdWQFI7CBAw+R+2vpSYG1HqWpGYOU/kJEx67i6jH2RrMJRiryi+kxhayDY
         gZN8RJ72YgE4GaOfk+Qd7IHmwo4Wv3Of4RBsLmMnyCexXopJNG5OJ2f3wkJhYFUWdk3j
         0INGwWDo1uGqkDNPEbIMU/KEwq7H8UxNFDrp/o/MS7wyIEpirTiYeiNPv6+y2xkHOF0S
         XNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njAUkH5dFFKuqO+juI/HLGmCs3nd2qaoyWds8EGJd78=;
        b=ya31GS/qiqUkYQw5I4QPNCpnX1yc8HBWfR3HZyMIPtlxQfIXuPFMuQkczvd2FVL6kR
         ffhc1GIKiyCwihZHvddOrXdK/9EaDZdSUfZZYU7rcWno2H0iyApA12m/LXsOf+ypG+FG
         wLqS7EKqdGHZHEA/ZjMOdCOILhswLVr27mmaj9HtM06h79a/WTVaJiyzkKZaDbKXuYXZ
         v1BsQpfSTsW7E2HZk7/NkvouKEzDCHiJrZ20b/MjvgZUkZKBVVxWpuB+erkyRfwy6UkN
         +zYysavFrnkzz9vFE/WvEFQAg3tkv4tN3MXiXhn6UL03CWL4jfxQFhNrVpOzik+Mxf5+
         f+dg==
X-Gm-Message-State: AOAM530CTE4E1XxIr170FuiDFIYng4HLjJqhSb3mrWKsKvoC5R9rXbqv
        VntVv9nvYYK9jz20KkenE16WXz4eq6A=
X-Google-Smtp-Source: ABdhPJwnxh+wn5h6pi3UtQc9xuPn+VaEkwEDjFUcy9/H6hnHms8tu5Pzr4LyCtElRjOxgbR9rw4jhA==
X-Received: by 2002:a63:2358:0:b0:380:e306:f0bd with SMTP id u24-20020a632358000000b00380e306f0bdmr19906066pgm.594.1647294618357;
        Mon, 14 Mar 2022 14:50:18 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s15-20020a63af4f000000b0037c8875108dsm18029032pgo.45.2022.03.14.14.50.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:50:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt-db: Fix gatt_db_attribute_notify
Date:   Mon, 14 Mar 2022 14:50:10 -0700
Message-Id: <20220314215010.23822-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314215010.23822-1-luiz.dentz@gmail.com>
References: <20220314215010.23822-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_db_attribute_notify was only accepting passing the Characteristic
Declaration instead of accepting its value as well,
gatt_db_service_foreach_desc also have similar limitation so both have
been updated to allow working with both value and declaration.
---
 src/shared/gatt-db.c | 63 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 53d3e1243..be07cdbe4 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1528,32 +1528,71 @@ void gatt_db_service_foreach_char(struct gatt_db_attribute *attrib,
 	gatt_db_service_foreach(attrib, &characteristic_uuid, func, user_data);
 }
 
+static int gatt_db_attribute_get_index(struct gatt_db_attribute *attrib)
+{
+	struct gatt_db_service *service;
+	int index;
+
+	if (!attrib)
+		return -1;
+
+	service = attrib->service;
+	index = attrib->handle - service->attributes[0]->handle;
+
+	if (index > (service->num_handles - 1))
+		return -1;
+
+	return index;
+}
+
+static struct gatt_db_attribute *
+gatt_db_attribute_get_value(struct gatt_db_attribute *attrib)
+{
+	struct gatt_db_service *service;
+	int index;
+
+	if (!attrib)
+		return NULL;
+
+	index = gatt_db_attribute_get_index(attrib);
+	if (index < 0)
+		return NULL;
+
+	service = attrib->service;
+
+	if (!bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
+		index++;
+	else if (bt_uuid_cmp(&characteristic_uuid,
+				&service->attributes[index - 1]->uuid))
+		return NULL;
+
+	return service->attributes[index];
+}
+
 void gatt_db_service_foreach_desc(struct gatt_db_attribute *attrib,
 						gatt_db_attribute_cb_t func,
 						void *user_data)
 {
 	struct gatt_db_service *service;
 	struct gatt_db_attribute *attr;
+	int index;
 	uint16_t i;
 
 	if (!attrib || !func)
 		return;
 
-	/* Return if this attribute is not a characteristic declaration */
-	if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
+	attrib = gatt_db_attribute_get_value(attrib);
+	if (!attrib)
+		return;
+
+	index = gatt_db_attribute_get_index(attrib);
+	if (index < 0)
 		return;
 
 	service = attrib->service;
 
 	/* Start from the attribute following the value handle */
-	for (i = 0; i < service->num_handles; i++) {
-		if (service->attributes[i] == attrib) {
-			i += 2;
-			break;
-		}
-	}
-
-	for (; i < service->num_handles; i++) {
+	for (i = index + 1; i < service->num_handles; i++) {
 		attr = service->attributes[i];
 		if (!attr)
 			continue;
@@ -2163,8 +2202,8 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 	if (!attrib || !attrib->notify_func)
 		return false;
 
-	/* Return if this attribute is not a characteristic declaration */
-	if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
+	attrib = gatt_db_attribute_get_value(attrib);
+	if (!attrib)
 		return false;
 
 	ccc = gatt_db_attribute_get_ccc(attrib);
-- 
2.35.1

