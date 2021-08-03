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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1CA60F93
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhHCIXg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhHCIXg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:23:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A1C061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a6-20020a25ae060000b0290551bbd99700so22164341ybj.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=Un1Nj8F9VASL8QrrWVLDNJB3gcL2U7EVeYH1dGrP1FgBrEFgSHbjg/g6Yx5Htz90pE
         ipS8Nhe5r2IO7aDr1wXbY7co8KEz8Hf1ChL5Juv+XV0895wiSvG8kVixTTpfTwM/m8a5
         SQPscy+UU6jdnpqXNDPcop88dxbWZVkIRrtTd0vsW3JVMSTmume4NUD+c5mQYHP/lnVl
         MHuK5oeqwvpQqCnHH+54qZO3wc85U3KlpKSVKA0TBUnkR8t1s2zq+KZ5CpXyeszDsSqT
         GVnQO44Ja7ZDOPX4Ym1TjM05txODQbWH2BEVfEejbAOE+e2POabkWJBXIL5N6g1itri0
         WnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=gw5p9fZUlCRu6OzxX7sg9Pl/RUWY/JfPT0wUHMflMbJJA34xNc1J0b5IRYrxsNTK72
         43bH9iaVDggSd9breYuiQznpe7zkowU+gMOM//gJLnaFPuNbE6pC+4PJOEimemiZFL5u
         OTVtTC4km4L2cG5zY493WVAuoqFpreNHz1CRnHaHmUYVbx6koV66U0w/j0DHnuwwISX7
         H/ItkT7eBnML91IqsQsePuN54JGycKFnJpHzde+d4/GfALxqCOuX1d4p64Xm3uq6dPzM
         VEV+ggre3+5MItztgRlRmNjFFtIeXLYVi9scOemfDF81E1HaVA1YxjZELYDZ8hK31hgx
         NdjA==
X-Gm-Message-State: AOAM533cFMGE+fBrqk9GxgcJD0pxkB8BMhDvnmdH3dCwX13wF5ef6K5V
        aYZ9BuvGmDms7xy7lHsYpkgxSR4bK55eljY1o27YVqrAaXlntZhP9PfSwqR48iJBuyTUmZoFfuA
        BzCi33yAu/mcOrJfLGKTao6Ox64KbNg1uR8itivA7wVUYenRBq0ZtN6iQ6THB3eSr0K8Ptm8F8o
        hl6RdoAprY2fw=
X-Google-Smtp-Source: ABdhPJx7Lal1FFpsg0dQ5omrLtS+0eUN2qxeF3o/fFSQ0WF7bkyTSsbEKcVUFZu2bCPKcFWzd0cl9573j8pGWeDu9A==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:aaf1:: with SMTP id
 t104mr27000063ybi.516.1627979004960; Tue, 03 Aug 2021 01:23:24 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:30 +0800
In-Reply-To: <20210803082237.723766-1-howardchung@google.com>
Message-Id: <20210803161319.Bluez.v8.6.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210803082237.723766-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 06/13] plugins/admin: add admin_policy adapter driver
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

