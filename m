Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BA7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 20:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiEZU7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiEZU7k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 16:59:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7CDE733A
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:59:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f21so2674949pfa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKHRNfeN49vK2aKZDtzsKp50eqPBJNLL30heiyMDxb8=;
        b=Rw6g7/067gzdoouYUVCu38cw15itKLw/+M5N5Elveg8IBmi2rExryPNi8Uusf7XlOd
         eIKbMfejiJ7sBU1jKKLcSgsQyqG8fvZgHKvz296jqZqoeCyuWGBx9dnM4qTGA/KyBci9
         Bjb3nyMjQ46Efm01UPY4OnHDyuL80yw9JIAW2/cj8FU05u74ppfalw2DoSWmCDtILqxB
         esRWJWJ1GottTZig/93yAKgF+eIVfmzTr61sj3fJdXqVFs0P2d9Kb/yRRyeFvuLKBoYX
         Lsy3vyTg+oXNSbO0zDYa8NqrNF/nRBllnl+OIMBLjtfeKbLwGNOO70Ua8NA0YhVtwoa3
         vh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKHRNfeN49vK2aKZDtzsKp50eqPBJNLL30heiyMDxb8=;
        b=lHA/8U0ezdUE9pk7fiAVEUJbQu3kEyoM7I4lm0YgAkAj/CXHQaKz5244BRKeC2CtSG
         z8EZs20zMOGui+LsLTqgIYPxqy356LEbRaRY87gdw8m/2gDV8/M9jfIXt2Vvtr/TWBr6
         SK3IS2/sYr2ljwenGfKrd/870O8vAm4Buz9zPXMuSTVflZ2BFi9WQxwuB8C9eQFGgPEA
         mkQh53CVUnL4kCuaFOMWG5QKSHq0jaHhkwzDsoZy/dE7iISoIPkb9F3hof4uq+6AT7Zk
         7p3Iurm+dhkC1ZYZ28u6Vq5rfD6sN2wFkH8v7xdc81JUtKAC0pZAnvi1d3fC2lfED7Yt
         FUng==
X-Gm-Message-State: AOAM531jtbnTn4UFZI5jQzLtzxtJM2wJDgb7fDbfsIO3cjjDNruXIWWk
        vHq9dMQiB8xptlYZRuLbfB3ucSE8ASQ=
X-Google-Smtp-Source: ABdhPJyKpWOWqN6CUah7uXU/xC90Q6aco6OyCUSbxuUstlymKjP/CqPc68zKvDUOWIIyTA4iBgYUBQ==
X-Received: by 2002:a05:6a00:23ce:b0:50d:823f:981 with SMTP id g14-20020a056a0023ce00b0050d823f0981mr41447994pfc.10.1653598778580;
        Thu, 26 May 2022 13:59:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0015e8d4eb25bsm2080064plg.165.2022.05.26.13.59.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:59:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] monitor/att: Simplify CCC decoders
Date:   Thu, 26 May 2022 13:59:34 -0700
Message-Id: <20220526205937.4159665-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplify callbacks moving the decoding of the value to
print_ccc_value.
---
 monitor/att.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index df3e65057..0223af210 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -221,9 +221,15 @@ static const struct bitfield_data ccc_value_table[] = {
 	{ }
 };
 
-static void print_ccc_value(uint8_t value)
+static void print_ccc_value(const struct l2cap_frame *frame)
 {
-	uint8_t mask = value;
+	uint8_t value;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
 
 	mask = print_bitfield(4, value, ccc_value_table);
 	if (mask)
@@ -231,28 +237,14 @@ static void print_ccc_value(uint8_t value)
 								mask);
 }
 
-static void gatt_ccc_read(const struct l2cap_frame *frame)
+static void ccc_read(const struct l2cap_frame *frame)
 {
-	uint8_t value;
-
-	if (!l2cap_frame_get_u8((void *)frame, &value)) {
-		print_text(COLOR_ERROR, "invalid size");
-		return;
-	}
-
-	print_ccc_value(value);
+	print_ccc_value(frame);
 }
 
-static void gatt_ccc_write(const struct l2cap_frame *frame)
+static void ccc_write(const struct l2cap_frame *frame)
 {
-	uint8_t value;
-
-	if (!l2cap_frame_get_u8((void *)frame, &value)) {
-		print_text(COLOR_ERROR, "invalid size");
-		return;
-	}
-
-	print_ccc_value(value);
+	print_ccc_value(frame);
 }
 
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
@@ -272,8 +264,7 @@ struct gatt_handler {
 	void (*write)(const struct l2cap_frame *frame);
 	void (*notify)(const struct l2cap_frame *frame);
 } gatt_handlers[] = {
-	GATT_HANDLER(GATT_CLIENT_CHARAC_CFG_UUID, gatt_ccc_read,
-					gatt_ccc_write, NULL)
+	GATT_HANDLER(0x2902, ccc_read, ccc_write, NULL),
 };
 
 static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
-- 
2.35.1

