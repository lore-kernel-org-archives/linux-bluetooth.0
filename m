Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C868C76195
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 23:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjCXXjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjCXXjA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 19:39:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB9158AB
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:38:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so6536937pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679701138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t80pHO+36rMIEHfz7QCiKbhx6ropjLKoecM2a23jtnk=;
        b=UCfO7MSR56AWTRTK+rh/Y/Opw49BVmDJXxNBPR6L6sAoCjS2tMcgB1hjs0seG8jorm
         oWnM7UzsjkoNI6imVQiFElEJkIcSLx9hCazuU6pa1J6oIQ6ssakOQEYtH3fP4PhOsip3
         1QNjZ07ahTq9frP8Y+W0K8+veSwao0xF7WVIO+eG2vrQt6tXaCjz5bmURA2J1wa3RYgp
         WfASRDfq7oC3f9+SVY1pRrm9r//h3t2B38uuOIbttTnJ8nqVR2+hA6OlBUkWJg1Qoq7w
         +IH775gW6ukPL3pu3H6SL+HNRZNX6DJJoHTUwUe7cspp+dl4BKpaeCjuBprKlnUb9HSn
         eWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t80pHO+36rMIEHfz7QCiKbhx6ropjLKoecM2a23jtnk=;
        b=voeLm4k/oUAkcD6INy4kkLpBDsMisEdbt3BvQvRnFRF1InVoS7+KfKyYgZ78xtsP4N
         O+EzR4wWt1JZGwmos49k/nmadU88+AwGrTJzmL53A4JakAOAUcJgC5/mX2X5DGy/jzAt
         oVBrHPaMKlYyEH5aleSug8K5KOxv1xtQj/ez9psXK/6Bx2p/UBfkLFstbix7HueAoyq2
         PhhBnq0pJ8q6fPU5cdpiQYX8PJqcGrHfv5gkEm7jPbw6GkR0d1B7xem2VMMK9L3ShrNv
         2RItRSNRV0/nk2HxrpXRDecyku6AyCncPemS6xxwzGXLvf6jb0GAbXRVf7KQaLkV/lVH
         9d5g==
X-Gm-Message-State: AAQBX9fPKLs1nUYDqXcUGMggpaFGiKiO6jf57teljw6NQLceCLA1ry7n
        XnPbm0QTjc+U+FBO/gz2sroic5O53CQ=
X-Google-Smtp-Source: AKy350Z2+/sDvSHwYbUa84jbJyZjx9I/HGzLjZCn3Q29EEQyNVJcL7BRZnn15o/eZL2EYHReSeHurw==
X-Received: by 2002:a17:902:c941:b0:19c:e405:4446 with SMTP id i1-20020a170902c94100b0019ce4054446mr4385078pla.30.1679701138365;
        Fri, 24 Mar 2023 16:38:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902aa9200b001a1add0d616sm13666771plr.161.2023.03.24.16.38.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:38:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/gatt-db: Make gatt_db_attribute_get_value public
Date:   Fri, 24 Mar 2023 16:38:53 -0700
Message-Id: <20230324233856.3693370-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes gatt_db_attribute_get_value public so it can be used by the
likes of btmon.
---
 src/shared/gatt-db.c | 12 ++++++------
 src/shared/gatt-db.h |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b696fe33da93..676f963eca94 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1549,7 +1549,7 @@ static int gatt_db_attribute_get_index(const struct gatt_db_attribute *attrib)
 	return -1;
 }
 
-static struct gatt_db_attribute *
+struct gatt_db_attribute *
 gatt_db_attribute_get_value(struct gatt_db_attribute *attrib)
 {
 	struct gatt_db_service *service;
@@ -1559,18 +1559,18 @@ gatt_db_attribute_get_value(struct gatt_db_attribute *attrib)
 		return NULL;
 
 	index = gatt_db_attribute_get_index(attrib);
-	if (index < 0)
+	if (index <= 0)
 		return NULL;
 
 	service = attrib->service;
 
 	if (!bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
-		index++;
-	else if (bt_uuid_cmp(&characteristic_uuid,
+		return service->attributes[index + 1];
+	else if (!bt_uuid_cmp(&characteristic_uuid,
 				&service->attributes[index - 1]->uuid))
-		return NULL;
+		return service->attributes[index];
 
-	return service->attributes[index];
+	return gatt_db_attribute_get_value(service->attributes[index - 1]);
 }
 
 void gatt_db_service_foreach_desc(struct gatt_db_attribute *attrib,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 163a981df233..fb939e40d40e 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -284,6 +284,8 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
 						unsigned int id, int err);
 
+struct gatt_db_attribute *
+gatt_db_attribute_get_value(struct gatt_db_attribute *attrib);
 struct gatt_db_attribute *
 gatt_db_attribute_get_ccc(struct gatt_db_attribute *attrib);
 
-- 
2.39.2

