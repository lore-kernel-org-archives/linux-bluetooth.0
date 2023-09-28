Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B584E743C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjI1UjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1UjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 16:39:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036CF19C
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:39:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso12057550b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695933540; x=1696538340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AY5BVXbm4ubX1JZNRvTpReH2b5fYZxAwIwQHK1qihc=;
        b=Raa8Nhllhq+52FbFpOXBHmTc2gcyx/ZUyCuwSyasA4FKZz2sdJdO7EemGCSSrkLluc
         qm2ZtkxIVS/4ywB9GB+dSJFvd20ygh4M1h6HpykCqXvUQGL5fmSyei3qJ0ZuFhvCPV0U
         prkqZJkgx7Pf/46qspJaU3FnDo2kospBFs9fkR10CAAn89FmJHAAJUzqk3uU87Ukm/ft
         GQXBo8KR+pBHKizIzxJ980PTiU+IaVQ8BPpW8JmUt2qJVPNWDX33y5R4VX439ujDJHae
         4jyfNwJGlRuW5KlwT7O9mQkvHlVLosT8BSjJfx+i9uG+mpBx6zTI6LrTGjrkKZ846ujB
         zrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695933540; x=1696538340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AY5BVXbm4ubX1JZNRvTpReH2b5fYZxAwIwQHK1qihc=;
        b=hx49NcrLvtAfoiUja8/rCM+9UcTiO+bFmhItKemTZPhwbzMdT6J+R3O1fSWtg7aZQ7
         XJolosT/1rTkzxMV8kBdTGwPJUqhGOccZTNV7jecN55RGH1im5D7mJXgMpvoadSZRp2m
         98FU/CzsnXi6Sr3fM1icbE5Tnc2kNQMWyOQwGVOceUpJ1Umq1WFgtUiS6iVapzVzbFpW
         5hlTGdJm2Y5XRISadzLZsNPpbxheiI83LjZL+Sy2dHzTMY0hyJdJ5hP0VBHh2Q7KdnLd
         mJSUe5Rv4m88MZwCFYBK6INPwMLeOGpV419F7kI6eKQcRbWQ/WX8+Nc7ttn1/97WchhC
         RwMQ==
X-Gm-Message-State: AOJu0YwavZzNC///cwjXutqTWXvpyARCXbjVpWXW6Sb8qU7slnIJe+5q
        //mFIb27Z8/Rzk9gbRnCvtcCftCj8XxPSVwB
X-Google-Smtp-Source: AGHT+IEFRBD3OflIsRxl+CxJs/xtiF0v2om5tUVdIff4DQ2R2oJCObUcLzEIaKZet7uW5hsd+8r5zg==
X-Received: by 2002:a05:6a00:10d3:b0:692:a727:1fde with SMTP id d19-20020a056a0010d300b00692a7271fdemr2401206pfu.14.1695933540487;
        Thu, 28 Sep 2023 13:39:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00690cd981652sm13750269pfo.61.2023.09.28.13.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 13:38:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] shared/csip: Remove bt_csip_add_db
Date:   Thu, 28 Sep 2023 13:38:56 -0700
Message-ID: <20230928203856.2100456-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928203856.2100456-1-luiz.dentz@gmail.com>
References: <20230928203856.2100456-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_csip_add_db is unused since csip plugin does use bt_csip_new to
properly create the attributes for CSIS.
---
 src/shared/csip.c | 5 -----
 src/shared/csip.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index 7e90a3c97614..04a8d542b390 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -389,11 +389,6 @@ static struct bt_csip_db *csip_get_db(struct gatt_db *db)
 	return csip_db_new(db);
 }
 
-void bt_csip_add_db(struct gatt_db *db)
-{
-	csip_db_new(db);
-}
-
 bool bt_csip_set_debug(struct bt_csip *csip, bt_csip_debug_func_t func,
 			void *user_data, bt_csip_destroy_func_t destroy)
 {
diff --git a/src/shared/csip.h b/src/shared/csip.h
index 0f8acb1cae82..bc5519cfbc49 100644
--- a/src/shared/csip.h
+++ b/src/shared/csip.h
@@ -36,8 +36,6 @@ typedef bool (*bt_csip_sirk_func_t)(struct bt_csip *csip, uint8_t type,
 struct bt_csip *bt_csip_ref(struct bt_csip *csip);
 void bt_csip_unref(struct bt_csip *csip);
 
-void bt_csip_add_db(struct gatt_db *db);
-
 bool bt_csip_attach(struct bt_csip *csip, struct bt_gatt_client *client);
 void bt_csip_detach(struct bt_csip *csip);
 
-- 
2.41.0

