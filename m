Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E5C4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB796104F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhHCLon (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbhHCLoA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:44:00 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5728AC061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:43:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a17-20020a0cefd10000b0290341c3c56ff4so7931452qvt.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=JZ18kj76DRajRy75DTS4X3KCHV+9sNb6aHTMFDiUJMjI96FZzcqqctKri8IQNB7EZZ
         FuWQM/HACx4eH0IlZGUh7AvH+q+2L8K8vcPNwoEDCueUP06aZpKLl/SjmiLUqrC7BPo3
         jacdbAHy5eZnsBP5a2Y8zTNIw6ds0r6qM2r9LEzSaVgeHvtrby3Y9MacHK8A8FC4o1IQ
         321SEXYnum27gP9t5/4m5fz5ZxHyKu3OPqyBqMQP8aivVna+qGtK7DyfVXx9ncJsg6ow
         dd5nleceVmQgqp7OCR69x2RpReacN0LKdkDxUgvwWsgKcndNgyGkK0xy3ocFfNd3SE04
         Bwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=EHc39mPZsdAH7PKW5+VNF6ie6xif8+hPog5d13HWzZkE8+thjVTThTpAzBjrbIsSqm
         OCLDZfFik8pAP/sM7UOoJU47fD/8A1M4XGxPJb6nqryLZDAp5ibvM/MYC3B60lIKMskQ
         vx7gp+CAZz3fd0RJMevwW2TmW+VjkVTzZ5tjQhlKa7G8VPp8+Kkf4EMWDvLLZyR6iCvX
         9vZIKvCjv8Q1DyDJ2JwmPos8i5sNa1YNyOleC9Cz8RNsPxU9yRDgu7svc3YZjOWa9OAr
         SM4gB1CHUTguEV85EwQ3aGIflwUWvuFGC9z6Wp9jnJTc9gSI5y0GajM3Dz/GudT0SFFZ
         DBCQ==
X-Gm-Message-State: AOAM532UVqp774HQSWGFPwOGGqQg5PbjClDf4YyIufcG+4Mv4xHrvA1x
        PwM+EZf90nkDaNXnTWE3QeTHaMY8Ifd/O/Wiri6U1f+IF8FxjqZ3i4iuZgN5/5y4yYotedIXjr4
        eBfHavYBYUDhodtn4jvWXQT5JY/GvJ5hcFEweWr5IgrlGCspMRcyjwkeApT7NLA7H4gtDLN3py6
        vGY93tAtaOydg=
X-Google-Smtp-Source: ABdhPJx+8LzL0qPbegqgAOq2XuBrX8GKXW68n9Nb01TYR3nvLUkRHHpXZWNBebDKQ7h5L2IWPIrh+XsKffK7Aq6iMg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a0c:ead1:: with SMTP id
 y17mr20992154qvp.12.1627991028514; Tue, 03 Aug 2021 04:43:48 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:10 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.6.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 06/13] plugins/admin: add admin_policy adapter driver
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds code to register admin_policy driver to adapter when
admin plugin is enabled.

The following test steps were performed:
1. restart bluetoothd
2. check if "Admin Policy is enabled" in system log

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 plugins/admin.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/plugins/admin.c b/plugins/admin.c
index 42866bcf7be2..923e08cb836b 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -12,17 +12,84 @@
 #include <config.h>
 #endif
 
+#include "lib/bluetooth.h"
+
+#include "src/adapter.h"
+#include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
 
+#include "src/shared/queue.h"
+
+/* |policy_data| has the same life cycle as btd_adapter */
+static struct btd_admin_policy {
+	struct btd_adapter *adapter;
+	uint16_t adapter_id;
+} *policy_data = NULL;
+
+static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
+{
+	struct btd_admin_policy *admin_policy = NULL;
+
+	admin_policy = g_try_malloc(sizeof(*admin_policy));
+	if (!admin_policy) {
+		btd_error(btd_adapter_get_index(adapter),
+				"Failed to allocate memory for admin_policy");
+		return NULL;
+	}
+
+	admin_policy->adapter = adapter;
+	admin_policy->adapter_id = btd_adapter_get_index(adapter);
+
+	return admin_policy;
+}
+
+static void admin_policy_free(void *data)
+{
+	struct btd_admin_policy *admin_policy = data;
+
+	g_free(admin_policy);
+}
+
+static int admin_policy_adapter_probe(struct btd_adapter *adapter)
+{
+	if (policy_data) {
+		btd_warn(policy_data->adapter_id,
+						"Policy data already exists");
+		admin_policy_free(policy_data);
+		policy_data = NULL;
+	}
+
+	policy_data = admin_policy_new(adapter);
+	if (!policy_data)
+		return -ENOMEM;
+
+	btd_info(policy_data->adapter_id, "Admin Policy has been enabled");
+
+	return 0;
+}
+
+static struct btd_adapter_driver admin_policy_driver = {
+	.name	= "admin_policy",
+	.probe	= admin_policy_adapter_probe,
+	.resume = NULL,
+};
+
 static int admin_init(void)
 {
 	DBG("");
+
+	return btd_register_adapter_driver(&admin_policy_driver);
 }
 
 static void admin_exit(void)
 {
 	DBG("");
+
+	btd_unregister_adapter_driver(&admin_policy_driver);
+
+	if (policy_data)
+		admin_policy_free(policy_data);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
-- 
2.32.0.554.ge1b32706d8-goog

