Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C2AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 01:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbiEMBEJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 21:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359861AbiEMBEC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 21:04:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D03201324
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 18:04:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e24so6729006pjt.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lm+mOLJ2m2ybqJYXizE8gL10Q+mb1a99FCfxgS7X2mk=;
        b=QXlzbBTQJdoicm+paSxnqEt4A22SMNRrJO8LIirblIstoSFbnitWE1F8697TvXrU1L
         f3YsdYvg4ksyxT7TH935wICbqrT2xY2LcLY7oxR1vwv4v3fTMlrzK/OvhKjGM4PI522R
         2dK7rtj4ymhxMLoqVtEWiPJEoZed/RkEmOuProWmf2EsexDgwiWzLJp1LShwvzPUMzgg
         rrK7DIAl7w4KSfK80+7JGZJnicBxx0BUlDTFa4OZ7Mj7TNRfxwLtL/9LtnD5SqIA8WRw
         6ti18FwIWegJxxwCIQQZW3CY6MiX7reFZr8Ut2Y+s/wi5FlJe1CEJGSvf49ZMaIj67/V
         NfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lm+mOLJ2m2ybqJYXizE8gL10Q+mb1a99FCfxgS7X2mk=;
        b=CfJzPub986AKow016eLDasMTPz2avu4Lwf8HZ+/gcI15tYhZUDbGX//oakJt5CdM07
         K3ATxgOvr+CoQQJClKRywXieSl5+qyObTWTh/pNGRLJvtq+uLfcT/00e6bTzanXtzGOG
         3L+1PnFk/NI2uJ9I1xbyZCN0+yhrbYTfg9IFOmwiMuHSOxW2alQaxTq0piQwoosB3iUM
         yj6iUkObz2+rRLFddyDP8b3EiXMPEFjnCdvQ8CmN//4mdJ3oJKjw/r/mU9l5WGWUXI9J
         lfDuFdi/VLKQG7POUcG3XNq5yX38w6C2TnqsFCNDl3Xa5HAAAbMLCe2UJAzw1OSjAjuK
         WQBg==
X-Gm-Message-State: AOAM53127uu1Gm4uNN/k1oIXZDmtXRHeFapb7txO8QIcO1tHshmInbDB
        C0ZfgJrC/yEbZuAovN2HoVR9ObeZaV0=
X-Google-Smtp-Source: ABdhPJxMKdjfK32TtuQmugQ5/k5WnPwdHSFU6W9JuwLm1V6UFddRLmVE1XifZAp4QZlLzsEnEaul9w==
X-Received: by 2002:a17:902:e353:b0:15d:4ca:90c3 with SMTP id p19-20020a170902e35300b0015d04ca90c3mr2201106plc.171.1652403840432;
        Thu, 12 May 2022 18:04:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t10-20020a62d14a000000b0050dc7628155sm436414pfl.47.2022.05.12.18.03.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 18:03:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog-lib: Fix not able to read report_map of instances
Date:   Thu, 12 May 2022 18:03:59 -0700
Message-Id: <20220513010359.1061926-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there is multiple instances the gatt_db of the instances was not
initialized causing the report_map_attr to be NULL.

Fixes: https://github.com/bluez/bluez/issues/298
---
 profiles/input/hog-lib.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index e69ea1ba4..4a9c60185 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1518,6 +1518,7 @@ static void hog_attach_instance(struct bt_hog *hog,
 	if (!instance)
 		return;
 
+	instance->gatt_db = gatt_db_ref(hog->gatt_db);
 	hog->instances = g_slist_append(hog->instances, bt_hog_ref(instance));
 }
 
@@ -1557,6 +1558,8 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 	if (!hog)
 		return NULL;
 
+	hog->gatt_db = gatt_db_ref(db);
+
 	if (db) {
 		bt_uuid_t uuid;
 
@@ -1573,8 +1576,6 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 			hog->dis = bt_dis_new(db);
 			bt_dis_set_notification(hog->dis, dis_notify, hog);
 		}
-
-		hog->gatt_db = gatt_db_ref(db);
 	}
 
 	return bt_hog_ref(hog);
@@ -1675,7 +1676,8 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 	}
 
 	instance = bt_hog_new(hog->uhid_fd, hog->name, hog->vendor,
-					hog->product, hog->version, NULL);
+					hog->product, hog->version,
+					hog->gatt_db);
 	if (!instance)
 		return;
 
-- 
2.35.1

