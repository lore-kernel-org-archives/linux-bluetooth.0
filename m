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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78ADC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAB360ED4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbhG2M2j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhG2M2i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:28:38 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBFC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:35 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s14-20020ac8528e0000b029025f76cabdfcso2656154qtn.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=hcZMh79E9OWIm2eWx6osQS+1cV33cHE4TVbSaBPVx01aT5uNQV8QY5gX+wOzB4yp+D
         z/S3TN1mWToaNoTDydTga7ys7OHZ+exnhLRcR4Tzmnag8gEziaL5DCJw0m+73o6S140Q
         w/XOmm4tZTLzBKRN7Nu4tgauIgJgBqqYUDhpaafmO3Y2FX5CFDmcnOEMHw67KN3a410n
         34etZ0FcmVfNmKOnqacM8D+0llMrUAO3WfnhNArYhiOslrAPsZvHnIjhE3/jDgd9JUJW
         9IeZY5gnAZ1arp4HCNtXHdMsemgrB4T6bWpJMX+Ebhu2pb6ZUaypGbs0L/GdNxTwbbWM
         /4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=FD5Oeqo6WFpqoj3er4tamHbt7CTDakYvm+zLTrUDZ3RF+ZILnNv488VxH/mamgC3GX
         JK9vzOvz+Z5SWYzaP9/jDJzHUJ5/jk/78dHX8lQ7hUYKlti7MjTylHFkFbZij7Bqj+fh
         uyyJ/Wcx6Wga0TuzHWGfbJuAsQBFl4BG2rmp4P2dtOfcrv5L8jJd2gzQe56alEn/NEEm
         MgXzN5JhgjPYIV75ReLDOqf4zA6aHfrC+PTooI94BbDdzP2shTOPvsuXUa8NEM4kyF+z
         neQr6lQfRE9UoJXO3QtOZjOOWbiF9BKwcJlObldMdpnMF0ZlgAhaQdLyXfhopIrGyDfN
         u7LQ==
X-Gm-Message-State: AOAM530nW9SMZMTWfHueQFq35pv0C18ucZIvHU4rCyWcUlYm/cUa8gbt
        PzWh37fRc8ulebsHdkseVSqe7LiHMHUnm2IBN5hBHZfR0fUdKUqbBP3IBEE4QcyUUwzZgol84LC
        7aHR/wvS8nOmswStzBEt4qIjYDwEB8A9NHuzPXCsy2pP9eqw8zmIHhDRWwDd46EErX9a3sN5Ct+
        3WjmJNlFe6eHk=
X-Google-Smtp-Source: ABdhPJwkT1l4Z1Da3ILDyu2tDRlHhJHN2CSXRZexJ1eOCbW8W/amLd7mBJpyKDLDgKJjBcvtIkk6jlzPp8BLrdkqOg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:b87:: with SMTP id
 fe7mr985589qvb.39.1627561714943; Thu, 29 Jul 2021 05:28:34 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:45 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.7.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 07/13] plugins/admin: add admin_policy adapter driver
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

