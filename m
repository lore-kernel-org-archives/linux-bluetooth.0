Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F537C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Dec 2022 01:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLQBLP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLQBLJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 20:11:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D3D89
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 17:11:03 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so7725584pje.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCSK/IoOanFM+auOGprFlEbLamMv4z8UmQFLxuyC/BY=;
        b=FyDQnUZ5xSAdDeTyzNZ7/UH0ndn079KwM0LeAMOEyMK6VR7PGRqttxiwN4Kdp1b8XK
         veLCnHkV32NhkiAgnJkLhBaC1WXERBzekDY7q751/fowRpmQJaYzquJTXxJR00WnI2LZ
         BQpbR88ZeClTRrfHGYBLOkzQKR4HLX3FNyyOMQB+k0O45PIz5NEYuf4TEHgznHnVc//P
         LVwq8mKiywVUk47zVEHYFERz9bMMbYDlBS4GaTeEY8JjdOJgzvzimh36+uyFNDgjFC77
         +vukzso26mh5k/gexj1KZgWZC7FiqJlH5vRbpf1o/aUnlQLZxDKwXXH7GGOLt9lfNCgy
         Ru2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCSK/IoOanFM+auOGprFlEbLamMv4z8UmQFLxuyC/BY=;
        b=JQ4maNnAL2Dw0iT6kQWSRtjdUjiM857B4nFNLTYWXqDkIEGTWhUUIcRBTg0CbQmAzD
         f9voJUY6owxhYVdfBIEwujFCNYP0p9nB1uYsUkXFC0gwXW8l3Mqz9yLu6QLJYSqSyJzA
         /39yikStla9FiH1UlX4vbJXCl4/dfk6jbSYfrBUsYvjvaTFyB+E70RWG0BLWHdYwpGC0
         613Z5vCVojqk77d3VWHwv8N0RtAGL2cWHD61r++us4/AW2+yKWWsmTi6XnUngtcbPUJf
         gk20xxIaQuHrrBXun4deixDjXoYYYmgutua+natYfeFY/EteKC83U07ykuRhnTuYGpy/
         dW7g==
X-Gm-Message-State: AFqh2kqgN7ye6QP/ertE3Qk2PhsszC2W+uw6UDwiFEga21Dtb0EDrluL
        YOIi+zYLv8QHKH6x3PKZMxn86TgK480wsA==
X-Google-Smtp-Source: AMrXdXsUOM6azeJ+oYFDPZRzp8jBjpwTpof2PoNTu2SIKXgIs6frL48OCel6Q4jMVzvMBm8cnWnNow==
X-Received: by 2002:a17:902:ba8e:b0:189:db2b:ac1a with SMTP id k14-20020a170902ba8e00b00189db2bac1amr377698pls.36.1671239462831;
        Fri, 16 Dec 2022 17:11:02 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b00188f07c10c9sm2232781plx.192.2022.12.16.17.11.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 17:11:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/2] shared/gatt-db: Add gatt_db_attribute_get_service
Date:   Fri, 16 Dec 2022 17:10:58 -0800
Message-Id: <20221217011059.3087848-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds gatt_db_attribute_get_service which can be used to get the
service which the given attribute belongs to.
---
 src/shared/gatt-db.c | 9 +++++++++
 src/shared/gatt-db.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 9a92090ec493..b696fe33da93 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1712,6 +1712,15 @@ uint16_t gatt_db_attribute_get_handle(const struct gatt_db_attribute *attrib)
 	return attrib->handle;
 }
 
+struct gatt_db_attribute *
+gatt_db_attribute_get_service(const struct gatt_db_attribute *attrib)
+{
+	if (!attrib)
+		return NULL;
+
+	return attrib->service->attributes[0];
+}
+
 bool gatt_db_attribute_get_service_uuid(const struct gatt_db_attribute *attrib,
 							bt_uuid_t *uuid)
 {
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 41464ad3e7e0..163a981df233 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -225,6 +225,9 @@ const bt_uuid_t *gatt_db_attribute_get_type(
 
 uint16_t gatt_db_attribute_get_handle(const struct gatt_db_attribute *attrib);
 
+struct gatt_db_attribute *
+gatt_db_attribute_get_service(const struct gatt_db_attribute *attrib);
+
 bool gatt_db_attribute_get_service_uuid(const struct gatt_db_attribute *attrib,
 							bt_uuid_t *uuid);
 
-- 
2.37.3

