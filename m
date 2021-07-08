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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8716C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF26A619A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhGHG0e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhGHG0e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:34 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F027FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:52 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i190-20020a3786c70000b02903b54f40b442so3253205qkd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CYGomBsBa31x4CSWwMfChvCx9H5IkyuUUeENh4oF3Zw=;
        b=vQNKxKg6OT2X7E/fh+1B6UanU9Fy45pfFC4CBhpI+79I7lvtj0p+i0O3BmdaB5pZlB
         8CBBLubYz+YkXVdNbI605ccOcwasfVe9E5TDEnTsMqZ+xd4v4eK1cSdknGTR5iMQdGpK
         LRIbTehPmwbrBxTkOOXHg3hhCOfHhbySr8u1/YJB4Ccb253gIoDftnzQsl4YwSyrku8h
         Vaf40ZKupBSrfi8qBeB7xyxTfChglcs+KJQ4t83CTi+iAPcaHYvvTpcxWDgKQXnbPngA
         kTeH3bHRRdrYoqRyt492+2RJIwo0Yt0guQ9snn7uYFYRzntVtqy4QUxyuiChgn0dquK5
         7pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CYGomBsBa31x4CSWwMfChvCx9H5IkyuUUeENh4oF3Zw=;
        b=Ys81EwzBv5RXWcZWuCB5QpnpKs25DFFq6NPqlwwDczKdK22rEy622La69WgJXjk10E
         dZsJgMMpGgRzLidz1B4eFlLr4NaBIgXEsckCqJ6U6HxTKyFrZsu00d43ZeeX+fhDW7wg
         vk8oTBe88Uxa54QefIQs1pvpD+vUmDz8TOHyvhYP5m6dgBdQc6top0J/SoYlcGyNGq60
         VexSzhB1nxL87km2j1amwODuo4g5tAlHEed62K7TuMA0bcGb+oKj5jOUYJOnV2bKXVcs
         kbW6K/m4uT91wIfxp/gi9aeZr68tAJEjTDI052ktb7leEpmk+bXpkNHt6+T/dIjHvdpI
         bfeA==
X-Gm-Message-State: AOAM53212JPeu4iYOgDlCMq/uvR1pnHZzGnP7ahQdfHJZ1sWwqXj5wzi
        505DW5w4RZSdZyRObVbB8PCCDceN6tDYsRfHQG9tj6Z3SzuuDJi7d4vzKkz/njUNZJrWkHoTcjI
        0AtwAKIiy4d9QDH55FxXkA63diGjr3eSULUxrcZaTwiBxYldrmOF4q8qeQJ8jAJoN/FalBQERQe
        NQWzTsiamE6PA=
X-Google-Smtp-Source: ABdhPJzDTaTrXMbN9/QW+5MXGS5VY3EElQnN8BWnzFDZIzw9GsvbviVVBZXmzEXqd2VZa2MtHSgEKQMMEYB7ciWYzg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1028:: with SMTP id
 k8mr28427293qvr.13.1625725432052; Wed, 07 Jul 2021 23:23:52 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:08 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.8.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 08/14] plugins/admin_policy: add admin_policy adapter driver
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
admin_policy plugin is enabled.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. restart bluetoothd
2. check if "Admin Policy is enabled" in system log

 plugins/admin_policy.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
index dd8d8973636f..2ece871564e6 100644
--- a/plugins/admin_policy.c
+++ b/plugins/admin_policy.c
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
 static int admin_policy_init(void)
 {
 	DBG("");
+
+	return btd_register_adapter_driver(&admin_policy_driver);
 }
 
 static void admin_policy_exit(void)
 {
 	DBG("");
+
+	btd_unregister_adapter_driver(&admin_policy_driver);
+
+	if (policy_data)
+		admin_policy_free(policy_data);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(admin_policy, VERSION,
-- 
2.32.0.93.g670b81a890-goog

