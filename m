Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA53C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 00:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbiELAzT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 20:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbiELAzS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 20:55:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8360AAB
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 17:55:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3526884pjg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BX892tcaztrJVl9+D6n14J5gNg1vXjFgEubxhIy/0Ck=;
        b=kIXjSGKqmNFN2dNa1a5KQKrWxaihZmTZKe7nHPp/fCgmaVpVsXLD3QlrthO+t2rL2m
         nhoSIf4RTE11x2vj/q5KMCSHX7N89xCyzbZai8FIkrTdy7EFm/npEKqu71qI+6pdU+Xz
         OokRdSHa0F+m4V6qylPYjq8h5WkLOlpxWXWrAWUzCUcUCWPawwV50d2XHe5gywU0iJUF
         /FFooOBmnb7MQkapRa+rDGKzJ+fQHAj+p6Vmu5j3wGLURs68kJkkzn+pSHUpsB3oW5YX
         TnW2WM+wzjsVPTqUkDNwNE9JlKYF0nwdCWmaHcpShz8q7L9MrG7MtqVoK3JTqWNY98Mq
         hLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BX892tcaztrJVl9+D6n14J5gNg1vXjFgEubxhIy/0Ck=;
        b=3QUoQFl1ZcBL99HJVvLNxY5eBay6e8zHxgtxfT31I7zb6FpgJIGJZ7aBwUmsYJtAhN
         noea7yPijtyNvh4zU1FA78WMs0YPLzHavj3hIuNfBEgWZMUrlEoDKPgaCun1S97/0nCL
         mS3b+Bb6LfmSGmle1F1LAqBvw5KjRP35J31enh7jraa1YNR/eu1eBf/fqeYUGjRtbVWH
         j+WDzQi0uh3SmRp52tCGuApn8F4H6WYTdpXPpvyqtJB3aBMoRr/MUUJ/tvnqn6XobDhB
         VTNc/Y333mETo4Mvd3g6iCRJR7EgEcmRN5ceIeO6cFr3W6VztE/VNwA5PhXnwihj23Cp
         Sv+Q==
X-Gm-Message-State: AOAM533TzDZVnG6TAuJnrFAy97gp4oCDfnB23OX/fyfpSBIpNxfFbtYJ
        dPe4vslBzVXBeh4x4RggQ1gV2TIU1Wg=
X-Google-Smtp-Source: ABdhPJzMUT+ANB/3VltHy9rS7bJ9d9DYK+30BmpxkvHA0/ZswcpdulYdF4/Rv7/CbXY3jLXO6Tt2pw==
X-Received: by 2002:a17:902:8644:b0:15a:3b4a:538a with SMTP id y4-20020a170902864400b0015a3b4a538amr27832893plt.146.1652316916699;
        Wed, 11 May 2022 17:55:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b0015e8d4eb2c6sm2590176plh.272.2022.05.11.17.55.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:55:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt-db: Allow passing Characteristic Value to gatt_db_attribute_get_char_data
Date:   Wed, 11 May 2022 17:55:14 -0700
Message-Id: <20220512005515.844857-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes gatt_db_attribute_get_char_data work with Characteristic
Value rather than only with Characteristic Declaration.
---
 src/shared/gatt-db.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 4f5d10b57..d3b5cec1d 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1528,7 +1528,7 @@ void gatt_db_service_foreach_char(struct gatt_db_attribute *attrib,
 	gatt_db_service_foreach(attrib, &characteristic_uuid, func, user_data);
 }
 
-static int gatt_db_attribute_get_index(struct gatt_db_attribute *attrib)
+static int gatt_db_attribute_get_index(const struct gatt_db_attribute *attrib)
 {
 	struct gatt_db_service *service;
 	int index;
@@ -1853,8 +1853,18 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 	if (!attrib)
 		return false;
 
-	if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
-		return false;
+	if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid)) {
+		int index;
+
+		/* Check if Characteristic Value was passed instead */
+		index = gatt_db_attribute_get_index(attrib);
+		if (index < 0)
+			return NULL;
+
+		attrib = attrib->service->attributes[index - 1];
+		if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
+			return false;
+	}
 
 	/*
 	 * Characteristic declaration value:
-- 
2.35.1

