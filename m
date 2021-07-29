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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2FCC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9843F61059
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhG2I5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhG2I5i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF37C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:35 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s3-20020a1709029883b029012b41197000so4442959plp.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=Ei2LzhhbFDGpL2UZ5sdXkZpMtAVao1jlskm46uHWPGQvPV6u6AqKhC5bX0pMl4K3vt
         4dN0ajIw1v1GxVJpmZ19NDW0l5CRoqQQFKLoewCs2QhrnVZ/uETKMzESGJ/NKpsePWfM
         d8pNpbolegdVrRh0UnCixRyz2qQPskI7AeUOc5U9fR3RfJ4UZJyVZybYyFUkaH82IMP4
         dsVy0QuuxaCOQVWLB6OuWZLco0XumSAtYTbcowVHEBKHu2+s0c2OZ9ld3t5ihZfAM/rE
         IvwrPFKNak8lZgZ1nWPcZLju1+b12OJDB+NHSFNBuocFf0v81ftOS8azVwQCG3q83fP/
         tOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=SJu2qfJcqynpKLt65sqH8eVawraMfarB7MHgDJyeYeyhEfC2Pb8Zy4eKhTyui+yCxX
         OfS0lENMp1Doxozn4BXeQvnrACGBWU+64sreFWl66660tPkWDCy7IKtKa/FhAPthi86H
         lQDiKsg+ZGc/QGX+NBGbdu5CdzYqZKqSyG6+txo8l5LfR7KNxCAJNMW9B5LJUxxH+9+Y
         ZtpyvOWKVagvfTX2DMsk370gXYfAmFINalmGq6m5jJIu+nLCVnA20levgLCu7QJidCxo
         DBYtD0iX22EZA4LYgkK1G2BEYOuunhJL6pmqhZLhoxheV30bql7tvvh3GyCBegPHD3EL
         K94A==
X-Gm-Message-State: AOAM531rFcu54rH63mYUWAGfl65KjxuvndQPbcxNL1UwgTlWlpE0B/p3
        Jh70fz7UDGTaD+BdWXW9gvv8FP8/dmMUkJJPeqSlNTOx+3oULCBo2BE4qzW1tdnXbkxyEjnTjAY
        kGAB87StwBQm6IIC7in4qMP+fnf8SjTGs9B7/6j+M7xoP6oJjoTVZQAID4fEA103Z7JjXCDf+AL
        AZxOHVghnQLHs=
X-Google-Smtp-Source: ABdhPJxI+Hqour84IGwJRyecH+WGxtZoA8BPZ66cgO6Sg4vnSI21WipnrdqroQd+hYQJux/gaMitEZ2ry3p8XEd4OA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:aa7:9541:0:b029:32c:cefa:123f with
 SMTP id w1-20020aa795410000b029032ccefa123fmr4057472pfq.24.1627549053947;
 Thu, 29 Jul 2021 01:57:33 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:45 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.7.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 07/13] plugins/admin: add admin_policy adapter driver
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

