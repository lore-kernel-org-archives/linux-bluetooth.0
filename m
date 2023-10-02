Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA9E776CB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjJBXNU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 19:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbjJBXNT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 19:13:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2691DB7
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 16:13:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c60cec8041so2312115ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 16:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288395; x=1696893195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aaaqJ139poo/qtsU22+bWZZ765/12Sgyv2nlisoT+0=;
        b=Fr/BsEVBpa3lRzYIBb7fDr/IcFzDfFG5BzOFj+29X5G7LQe5KLf7O/id4vhl3L2rmo
         EZmA+Tg53CYdXBVFc99jCi22q8rQnipcbncoopbQBpRbhv8tFygiOulEu/RcELXviBSF
         KOdnjY/t0Z5XfhRuiyCM34ommUcCM19qnZt8y4xjM8xbXas4GejnVdN5qVL0MQvtyl/t
         WzTdElcp1sOWiZhRndYsUdzRioHGI+14Lta+h6UJr/Jmlnn/wFF/BdEztQ0l+ZV6ij60
         jQTRC3TJnXyGpFldoVpEDNpl9a8ItCO/9Fd2cbVJJ7SR5baPZ+6JHIpl1AZCv3dcWSAt
         yngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288395; x=1696893195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aaaqJ139poo/qtsU22+bWZZ765/12Sgyv2nlisoT+0=;
        b=D5Y6rd74Od/lcCC4iApQR6yoah6JCadwFVoRjbfLrXFdhH+7tToZNMCWlvlEUaDod9
         L+NhFbD1uakt0+o0mBwDx5zBIRkIfLGtNsFcUODOj3rVdSRkbjFIdzOkzPT8imzK6yGF
         XAadi3Vxn/2CqqQaLQz7FFWdyluB3IO6iTKQsbK6ZWZD6J6PM+obc/S15mDk9ZfBGzTi
         0JfT/R/LvkVCK3cu7O6F+/6kIMWcOU1Q8yWG0zLeLoelbB61nBnw0EAU9bKnM1XKhX2O
         Ih0toF6Vx9sAd4E1vJwzLHD6fgSxVxjsQZy6Z8iBhoLajXulrcZfyR0N1hzMMrUPBw1D
         nszA==
X-Gm-Message-State: AOJu0YxGoXGUdLfBaJvQyb086iULLbuNwKzw+p6IenxcQDPWSQiTwoO1
        v87SEWl5R5X+jtny1m7gfMAdSYPZzWHlgwKs
X-Google-Smtp-Source: AGHT+IH2FdEdNVnbQ02u54alY3YTG+/p+ZNK6Zz5BQlSBflyAQP5DO7W0OVAKLyBO4VpKqasdoQeqw==
X-Received: by 2002:a17:903:41c1:b0:1c7:37e2:13fe with SMTP id u1-20020a17090341c100b001c737e213femr13314758ple.2.1696288394802;
        Mon, 02 Oct 2023 16:13:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b001c75627545csm5181817plk.135.2023.10.02.16.13.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:13:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] shared/csip: Fix not requiring encryption
Date:   Mon,  2 Oct 2023 16:13:06 -0700
Message-ID: <20231002231311.3104749-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002231311.3104749-1-luiz.dentz@gmail.com>
References: <20231002231311.3104749-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to CSIS spec all attributes shall require encryption:

  'Table 5.1: Coordinated Set Identification Service characteristics'
---
 src/shared/csip.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index 24d5d6a323bd..eb80bbc3b26c 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -721,7 +721,8 @@ static struct csis_sirk *sirk_new(struct bt_csis *csis, struct gatt_db *db,
 	bt_uuid16_create(&uuid, CS_SIRK);
 	csis->sirk = gatt_db_service_add_characteristic(csis->service,
 					&uuid,
-					BT_ATT_PERM_READ,
+					BT_ATT_PERM_READ |
+					BT_ATT_PERM_READ_ENCRYPT,
 					BT_GATT_CHRC_PROP_READ,
 					csis_sirk_read, NULL,
 					csis);
@@ -729,7 +730,8 @@ static struct csis_sirk *sirk_new(struct bt_csis *csis, struct gatt_db *db,
 	bt_uuid16_create(&uuid, CS_SIZE);
 	csis->size = gatt_db_service_add_characteristic(csis->service,
 					&uuid,
-					BT_ATT_PERM_READ,
+					BT_ATT_PERM_READ |
+					BT_ATT_PERM_READ_ENCRYPT,
 					BT_GATT_CHRC_PROP_READ,
 					csis_size_read, NULL,
 					csis);
@@ -737,7 +739,10 @@ static struct csis_sirk *sirk_new(struct bt_csis *csis, struct gatt_db *db,
 	/* Lock */
 	bt_uuid16_create(&uuid, CS_LOCK);
 	csis->lock = gatt_db_service_add_characteristic(csis->service, &uuid,
-					BT_ATT_PERM_READ,
+					BT_ATT_PERM_READ |
+					BT_ATT_PERM_READ_ENCRYPT |
+					BT_ATT_PERM_WRITE |
+					BT_ATT_PERM_WRITE_ENCRYPT,
 					BT_GATT_CHRC_PROP_READ |
 					BT_GATT_CHRC_PROP_WRITE |
 					BT_GATT_CHRC_PROP_NOTIFY,
@@ -751,7 +756,8 @@ static struct csis_sirk *sirk_new(struct bt_csis *csis, struct gatt_db *db,
 	/* Rank */
 	bt_uuid16_create(&uuid, CS_RANK);
 	csis->rank = gatt_db_service_add_characteristic(csis->service, &uuid,
-					BT_ATT_PERM_READ,
+					BT_ATT_PERM_READ |
+					BT_ATT_PERM_READ_ENCRYPT,
 					BT_GATT_CHRC_PROP_READ,
 					csis_rank_read_cb,
 					NULL, csis);
-- 
2.41.0

