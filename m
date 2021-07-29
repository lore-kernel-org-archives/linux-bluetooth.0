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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6782CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A26D60F59
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhG2DOE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbhG2DOD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:14:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD86C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q3-20020a25bfc30000b02905592911c932so4674135ybm.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=R06IcO215rneUEO8XsDGraLoVMuN2n+a8npHZxA8XZ7zHHVuMT20KRInyJrHlsZHXB
         qjwciwGruZD2DcK7y1ibOizrovJjRAdhbx+upFpRoWJrkeCF8637wictpPnYV6kHgfxi
         zub0p8uGAx9umtU8cS8yl2taQwmD0Mhc2YJ8ROyqzZuL8U8mnW51Yy7DMBCuwtOdKYep
         RDjcmZbuC7AldhwXYsiyNYA/V7BeKO/1ADdhFXbM+FpDsHlyZ+eXjvYACTyvyynTi5/e
         QQEeabbFW0bns61+FLziG0DnSDgabAf7/KyCyOJz30KvtkSsPb8kIgwwYBSUFOYheMB9
         Z7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=apHTva6hteSnzR1/I+nHqSnIQ1GzaV5CHOOsrrswy9YQfCzUFkAbWsGIWV4Fl826CA
         2nwzLb8qT9GbItfy7t1CI8MS4AZXjVYjz5kiMVjh8KJqM/0Xy6C6nihYkzeyIAO0pCOs
         MzwfIQ5XV+IdP3E+G6zZiAA/Q4yIvLE3teUSrx+FTJ05We+FN0CYDKdBiH+RM8WmgwBb
         ZztB+H6U097wtc/DBfVuWKMbKY4lcpcr81DXwOpvPhhJlm/s58zV9C0feNwlh339W7ry
         qKlPj3giiPkPDpuizVBlCSt22lJJ51RvpK4ZXkbYXRbxbjbiDabE41w5q7uwZ5F4Bz0c
         sfwg==
X-Gm-Message-State: AOAM531J6jlxjRocKdsty4VK4bRnskDU8IhivR9if1hXHsG2bF1/evGS
        ivzF1Q5Meyx1Twx6ahSdy/u1BZShOAgG0TiJBAeg26ZUswhsKPI3I1jFxm3GY/PbGhcxqziCekP
        sp+tkJ6+luMHHERjAN/+JQ3nKK5foCGLnfOPPl/lo7D9h664TWhan/Ayr7dkLuwCf/K+7H1Z3Rx
        KAP+u/0HevXS8=
X-Google-Smtp-Source: ABdhPJx1/fi5TTNEVKp59Yv20a0rpFhzDITWL4p8F6b6G2pnRluJK5ZlfoIJsMNC2IAvCht19WfeCTPtvIFkpmhyXA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:2ac4:: with SMTP id
 q187mr4032869ybq.74.1627528438938; Wed, 28 Jul 2021 20:13:58 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:53 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.7.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 07/13] plugins/admin: add admin_policy adapter driver
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

