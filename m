Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9264C4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5951606A5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhDAK2M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhDAK1u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC5C061793
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y19so2804379pll.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cO4AVl4n279ebsWSUVFtNX9Qx+EUeBMaQw67JXUvSvY=;
        b=OCei/5zVNsnGKUZw/jxr29YLvkaNFnXaGn9oEn8VZeExRh/oEitNruJq0TT/H6TMVP
         CSdFhCApRUSTeUeRho4mWiRZnS4LNz8Fa/XrU3K0tLtPl8PC+9KVyBm/al/LpK2mBkiM
         ipleuFc1WT4I2xh23BNAfXrYLgRUpsx4ntoRuppC4UjuhJzKEgKprH0Pl1bbh1g2mLKV
         7PMM8KIRLXFAZx77k/zYWGGfqKW/BA7vqexli+EWxvHTS2LRExUarCWsK5jsjjgleRpt
         Q4g5EtoUf7DpgfEr5GZ/Qr2wphwSA8gmae+Tb/aP2f5iRCljdPXjVAteFAPHGiJNqZqB
         LeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cO4AVl4n279ebsWSUVFtNX9Qx+EUeBMaQw67JXUvSvY=;
        b=FAXaMYoY7kRqKC891n1W7r+HoB3wzN+r/V/++867GndhefHMiR8eQ9qycjtO+dZ27n
         8epB0D0zfdtHlYULDscpho4zECeTBwKq6lXiOF/f/l2QGuqUcGUUi1NHfkPN7Cmsj5kr
         Y5bC/ns2z4EULaSYjXh2gNsm4tu7I4W8Vn7WTv7oKlMK7v0mNxYr21XsAtNrcJl6RqPD
         ZNWxFkov3x/lBoJwFlqg+t0gzbiKAa2przNnJG9C1pLe3NGCCASgGlIrF46PJmRLv91w
         vl2aF+CInUSNCtNVJsspVgKwECewLPZS+T4VXQS93qTh7ymlY4Bkz8ACfwbmHhf1Tq/E
         8W2A==
X-Gm-Message-State: AOAM5303C0tMxFXM13L6GlONTHfFQFnhD6QpY0ebp6SwgXryhwVs9fcE
        nbYt1G/Rn5Tjv2lItzuKbP2eSw6ueYzq9Ne4iGwCjB8bxoia4we9HrwglSB6fTPPQxuGKKsa/Z0
        NGl7w4TDV6EURQlu7yxl4fbv2rriq/Y6Z0HJOCb8WV5mAQ6ZtpSd9nyWQVIc9kdR1jER9cxD63W
        D2jwV7B09/SEk=
X-Google-Smtp-Source: ABdhPJxrmGyVPY6/ctS/LJ6ng7gEpEp623G11Mme8vTJgQ0RZE2FGlUu712qVrpFjYoqZww06MHPtbL2CInCxTRwtQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a62:7f86:0:b029:20a:a195:bb36 with
 SMTP id a128-20020a627f860000b029020aa195bb36mr6976280pfd.4.1617272723719;
 Thu, 01 Apr 2021 03:25:23 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:41 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.2.I2d1b00997951634dac9ea09da39fc9340ba7256b@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 2/8] lib: add hash functions for bt_uuid_t
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds function GHashFunc and GEqualFunc for bt_uuid_t.
With these functions, we can add uuids into a GHashTable with bt_uuid_t
format.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 lib/uuid.c | 21 +++++++++++++++++++++
 lib/uuid.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index a09321dc6ed1..0b0ddb3fc9d2 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <glib.h>
 
 #include "lib/bluetooth.h"
 #include "uuid.h"
@@ -120,6 +121,26 @@ int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
 	return bt_uuid128_cmp(&u1, &u2);
 }
 
+guint bt_uuid_hash(gconstpointer key)
+{
+	const bt_uuid_t *uuid = key;
+	bt_uuid_t uuid_128;
+	uint64_t *val;
+
+	bt_uuid_to_uuid128(uuid, &uuid_128);
+	val = (uint64_t *)&uuid_128.value.u128;
+
+	return g_int64_hash(val) ^ g_int64_hash(val+1);
+}
+
+gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2)
+{
+	const bt_uuid_t *uuid1 = v1;
+	const bt_uuid_t *uuid2 = v2;
+
+	return bt_uuid_cmp(uuid1, uuid2) == 0;
+}
+
 /*
  * convert the UUID to string, copying a maximum of n characters.
  */
diff --git a/lib/uuid.h b/lib/uuid.h
index 1a4029b68730..e47ccccb9fd2 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -17,6 +17,7 @@ extern "C" {
 #endif
 
 #include <stdint.h>
+#include <glib.h>
 
 #define GENERIC_AUDIO_UUID	"00001203-0000-1000-8000-00805f9b34fb"
 
@@ -167,6 +168,8 @@ int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value);
 
 int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2);
 void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
+guint bt_uuid_hash(gconstpointer key);
+gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2);
 
 #define MAX_LEN_UUID_STR 37
 
-- 
2.31.0.291.g576ba9dcdaf-goog

