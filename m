Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E052C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A5C61050
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhHBGNh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhHBGNb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:31 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A6C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:22 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t18-20020a0cd4120000b02902fbda5d4988so12010400qvh.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=sMjxVkFWkc+6QIO7dQqZ/AHWstJgjwoIptNZ2p+ax46uMv+ZXE+h2zlsJxOnmo61UX
         CXd7/wjm9ly4CVKoINDosLiWmlYKx7WJqSlKO7tMUj9dH3kJysnr8RCegWLEKikpyRNH
         yhe1OahejHrUZGu5jzOJaQT3rgk3pDv2CUmjXwJitf+qZoHpYwlgrdGlw7z3brFYYvmq
         78s+4UXEqavMaGUyD8tdRaigmc9ZVIg0crL2qR5h62ATvlZpfck10oxC2cS72kXC2lT0
         F/CdwfkwcvqWqPSoWh5hBv0IPp+KHC+Tmv8P5xbarpyvQMOo9ZNpqFqflmA+RGaVCypd
         rZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ov+ljL+WLImh2UNgqiJukm2dfT5futa1Kc0R7vlTCyc=;
        b=JwTnPCJbIJoeSW+/8lh64+rA+LWbUFXxicgeg7e4/b9RWsYywk4Su75NzcS657ikT2
         4ysVHnCXEsU6hkps0h0IBRCIHo5Bl1hK8jBaS7R75YK3DKHHxE9lie83nLsKr92aSyLP
         0m9G/2t89iUrw5ZDq6Kh5sJGwBkpql9tvXiV9KJbmvScdKrSQBmf0IwCBP6vgTaBcGDS
         /G0GYpqNTQUbQqoQyKsiP4vvT1WAohLGa6l53FJVrEtSvKlbZ+8xYx77G04SqBbtZKk+
         GwNUvd2LhDOiDiwRnQC8pChNm+w4zRKPQ1AB7Ig6xl9aJ2DL3Ex5Wz/z6TrRZ6UWFBKO
         /dgA==
X-Gm-Message-State: AOAM531TAYz+0fvpsLZ4LmkuL7v3DSGbFv6YLwBFwQEqaxh9/2AOf1kd
        LEoADK1wQLcn8gFsQlWiEuzbX3ioQXhTWaC4l8E77Ln6PZwueojWLsnTg8FqKb/G7Q9X05iBdZB
        jUlvJF0JHkwppsSthmMSX9lL+PY8V9GLtivZlmmjqfps29itBD0UQKZfh8+SIKE+CSWmzC7z3FU
        MVaHWlQIrSxyQ=
X-Google-Smtp-Source: ABdhPJwXkAQAYWfkTnJ1OpWpT8Pczpo1zpLmaM3Der3I0ByFzIxbUsM18oXBvuZdvRRoz1iR3KhvcfmGtEEc/vP13w==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a05:6214:a48:: with SMTP id
 ee8mr850968qvb.4.1627884801495; Sun, 01 Aug 2021 23:13:21 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:44 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.7.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 07/13] plugins/admin: add admin_policy adapter driver
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

