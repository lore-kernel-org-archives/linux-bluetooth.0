Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40968C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjGLTjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGLTjG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 15:39:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1A1FCC
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:39:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53482b44007so12971a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190744; x=1691782744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6153T5ieEnaG37eYeGkcbX1K38aAKSTQ2AYPcqQcsRE=;
        b=aadf56kdHNMP9H3lgiWOx9ZEkE5cbj0eshPjkBbj8GlnwvM4fZSRyFhtnv4TMrE12k
         8Li6lzfeSMsyNM2LzFKRFiDSgUwcj7g3QANOVVDhPb5aBeBsKQEyJ9mEWmTajB7fukC4
         NfFab8NPoFACnsUDEaIyMu625RlOjqw3lljHGC95MhSP2XkXtsm1UMlQ21plKrVElI5T
         U9GWNVCDMK+U+tJHQfZniYi0EOsL4bqmZrrS4C+lqbALYE7hM7Vnz5GEQbOHjfDDIRQt
         7zu5osmXaFnzBIdAPJivvKfHuqmZvOUvd9b04G7xfnfScOT+cp1O7kmGPTxwqzwXe1Fc
         9aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190744; x=1691782744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6153T5ieEnaG37eYeGkcbX1K38aAKSTQ2AYPcqQcsRE=;
        b=ZskOVQWXFOkT6B5xJqKQxHduK9L4pLmPX5UASjAXIKMJDl/D2h1RiKaPO/DSApYtkx
         SHUbmLA13CD3cu/zyP64vVxBQYkg1L7CwJngdY72EAu7lZZAzTJZDSi6lQLkWnFXOO/S
         HZv8XdrPx9/D35sHE5P/CEN25UDWKkJ4HO4af3EDBoZaX2pCBg4Q7BItnuWlszDRrBZ+
         rcGrkdYevygkUFucNpzpjy6T7nx+Qe2MMv5iwpXfgY3vJ+3ROBmo2qOghIxVvi7BAWS5
         F/0jGNcYkUbrOHaxYMzRgdF+apZv9zsYHUhu0lgAmwEMTmFoSY2aLtkhBdahuwaKmXbI
         KuLQ==
X-Gm-Message-State: ABy/qLYdEh3p7zwWXsg+sMJsFaTR3KL5F64hnogWSgx2HhOwdXaBkhs1
        WKyWmUpJbRALH4fm5tRhHynS7/BF870=
X-Google-Smtp-Source: APBJJlEIpfejWxX3X2hVqKjekzLOx/oeCHXYOILGZTcLk6BGrHuc9l2ki1vn5a2deuhcoZytN+WzRQ==
X-Received: by 2002:a17:902:e74b:b0:1b8:9b5e:a218 with SMTP id p11-20020a170902e74b00b001b89b5ea218mr19590307plf.42.1689190743988;
        Wed, 12 Jul 2023 12:39:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id ij12-20020a170902ab4c00b001b84cd8814bsm4413264plb.65.2023.07.12.12.39.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:39:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] test-eir: Run tests using bt_ad
Date:   Wed, 12 Jul 2023 12:38:54 -0700
Message-Id: <20230712193854.1862996-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712193854.1862996-1-luiz.dentz@gmail.com>
References: <20230712193854.1862996-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the same tests done with eir_data using bt_ad.
---
 unit/test-eir.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index e05a37d01306..49ce65f24bc9 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -21,6 +21,7 @@
 #include "lib/sdp.h"
 #include "src/shared/tester.h"
 #include "src/shared/util.h"
+#include "src/shared/ad.h"
 #include "src/eir.h"
 
 struct test_data {
@@ -539,6 +540,54 @@ static void print_debug(const char *str, void *user_data)
 	tester_debug("%s%s", prefix, str);
 }
 
+static void test_ad(const struct test_data *test, struct eir_data *eir)
+{
+	struct bt_ad *ad;
+	GSList *list;
+
+	ad = bt_ad_new_with_data(test->eir_size, test->eir_data);
+	g_assert(ad);
+
+	g_assert_cmpint(bt_ad_get_flags(ad), ==, test->flags);
+	g_assert_cmpstr(bt_ad_get_name(ad), ==, test->name);
+	g_assert_cmpint(bt_ad_get_tx_power(ad), ==, test->tx_power);
+
+	if (test->uuid) {
+		int i;
+
+		for (i = 0; test->uuid[i]; i++) {
+			bt_uuid_t uuid;
+
+			bt_string_to_uuid(&uuid, test->uuid[i]);
+			g_assert(bt_ad_has_service_uuid(ad, &uuid));
+		}
+	}
+
+	for (list = eir->msd_list; list; list = list->next) {
+		struct eir_msd *msd = list->data;
+		struct bt_ad_manufacturer_data adm;
+
+		adm.manufacturer_id = msd->company;
+		adm.data = msd->data;
+		adm.len = msd->data_len;
+
+		g_assert(bt_ad_has_manufacturer_data(ad, &adm));
+	}
+
+	for (list = eir->sd_list; list; list = list->next) {
+		struct eir_sd *sd = list->data;
+		struct bt_ad_service_data ads;
+
+		bt_string_to_uuid(&ads.uuid, sd->uuid);
+		ads.data = sd->data;
+		ads.len = sd->data_len;
+
+		g_assert(bt_ad_has_service_data(ad, &ads));
+	}
+
+	bt_ad_unref(ad);
+}
+
 static void test_parsing(gconstpointer data)
 {
 	const struct test_data *test = data;
@@ -599,6 +648,8 @@ static void test_parsing(gconstpointer data)
 							"Service Data:");
 	}
 
+	test_ad(data, &eir);
+
 	eir_data_free(&eir);
 
 	tester_test_passed();
-- 
2.40.1

