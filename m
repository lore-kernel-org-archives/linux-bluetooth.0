Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A394C07E99
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F2619A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhGHG0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHG0K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:10 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8D9C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a6-20020a37b1060000b02903b488f9d348so3196250qkf.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4YlKuUBAVCzUya4qwzfjFYw41CES3ee8lmcRt7kpXbI=;
        b=YjpgoJ++8h/jrhemV9NdBxNEswKo0ShewItkHTOHerfRpB4zqK5pZmUaa1m/j4vVY9
         +CnakWFM4MsxevmVOZDL4PUl7ugBS02g3KtIBml08PsU8Dvlf+amAN2JyPDQCq1mHVzG
         g3aJtF7CzYsn0dzHqmu9PWpnK0et60TJb2EZPZJo0PzdgfaLv9SDXTxJB1ozxJ/cdcMd
         PR+PdP7CU5sMK3RnUPbmFfUfFrH40kaBmKEv+4D0VUrdOQ9ViWr0Ck1R4nn0Ww4KdeF/
         DoBlCOZOMcfQFfZPh/aQ8JhDRpE0DHt4R2hdYCewGrddsrA9Uk9XKF8WQnZV0S8knWrK
         aqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4YlKuUBAVCzUya4qwzfjFYw41CES3ee8lmcRt7kpXbI=;
        b=Doh7CNYtRJBbZrBl0a+H3RGBf0ayEZrqf/qtKsbqAXslu35bVSu5zZ8NXZ22glfNu/
         6sln9z/gidHrAKQgqSEIlSG271FlDh5QpAo9DZtLAyfXB6XMwXoS5kJMN49XAWLvER2M
         VCgAx3Z+4vaIcj8M4Qa/lqkspU7+RBcq88KUNkxt5HB5lzNOj4NGzbowjOnzFb1X/Rmy
         G65EcNdul+iiuMmn+dJBAQGKaPiCk12khJ5JkINYnzr+4poUZygTJTFpZzTZz94wrT+5
         efWNj+DkQIonvvJt20fl3y8H8qLDt86TbDh3hve1kMJtrYoUkwgoldHMugAQPFKhWfVi
         4Tmg==
X-Gm-Message-State: AOAM5301EPoomY4XH0ZenY8Rz3mczPYgiOuiOD4NSvcBOgZxnPA8ny8Y
        ZxgHdFdGLWbYVGn3+3km7dUeTrUbn2I1oB1DfqLJlj6F07yd4SGfVTFYOra81xe0yuhG7nMUoVt
        C3OXBRbDY4eWOeNYOLdXmrFL64NrURaejEZwLxN8lw7DZ6pg6IRZZYIHIKWVblNX2bAGlHLp1QF
        p8HZyUDS8pNW4=
X-Google-Smtp-Source: ABdhPJzm8od7VacDhYINIXkVLRvPU+xAmRsb1Fo2MqJTqgrUoifTaJPxtV+cyQ4TNCuZ9VB8s8AqfY35PEEImWeFSA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a05:6214:15d0:: with SMTP id
 p16mr28088061qvz.21.1625725407489; Wed, 07 Jul 2021 23:23:27 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:01 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.1.I69278fab3bf86adb578c5cba0a39e5bcf7f9581e@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 01/14] lib: add hash functions for bt_uuid_t
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

 lib/uuid.c | 27 +++++++++++++++++++++++++++
 lib/uuid.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 3d97dc8359c7..a09f5c428b87 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <glib.h>
 
 #include "lib/bluetooth.h"
 #include "uuid.h"
@@ -120,6 +121,32 @@ int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
 	return bt_uuid128_cmp(&u1, &u2);
 }
 
+guint bt_uuid_hash(gconstpointer key)
+{
+	const bt_uuid_t *uuid = key;
+	bt_uuid_t uuid_128;
+	uint64_t *val;
+
+	if (!uuid)
+		return 0;
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
+	if (!uuid1 || !uuid2)
+		return !uuid1 && !uuid2;
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
2.32.0.93.g670b81a890-goog

