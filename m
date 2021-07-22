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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D45C6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0E661249
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhGVGnK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhGVGnJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D31C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d7-20020ac85ac70000b029026ae3f4adc9so2920861qtd.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HvdHZncGc1VfMihgcLicxjQrJciR9sYvoNrkY1clreQ=;
        b=UV97h9mU/LMrcH7hiw1xDBgMN0zSstrtURIxe/uzLySwwcZlGGOiZhavNycARBdp0W
         3I651c8XsW6Tm2Qe9/ZYG172Vhf0noUuQfJDvqfiMfoSFw8BDCw/ocJ4zOJqv5EJCzQn
         noPIkLyuaTau1xcnAHbI9qSVrw/0zt28oXg8Zo/54eJme3tLcuQJ74aCD086CgE+lvu+
         FtOEQV+D4a8m1XwCGF44lDJILOznC74yG2mS3iUXG2icsaMx6dC6RZXMp7+yK0jjGAUT
         vZaOw+fTS24SaJwB7J06RgG8saLebM6L4YHk5MWS4esw8MSlM2cWzMP/rzKHV7vNp9Xg
         /9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HvdHZncGc1VfMihgcLicxjQrJciR9sYvoNrkY1clreQ=;
        b=n7bksVw3tGnPlE13Vcjr9ZlZ0RDlanyJYXCI+Sbdoaw83kQZ/6oW3FVzpg0E0VddwS
         I9Lo6acq2zqN4U67U2h2So5T0CXm3BO6Q08AuTEmlzbrhEtg3ZkPrEw4LlIFMTccsUn9
         1SbFs+DM3DhfsxNNPcqzyaZ92zItpN2Mz0wq2hGtg7Myu//KI5CxrcXo/kC25j33OsmN
         eHBvfoqFoU0zpODEj5vGBw0btE9GObGRjlcep9N9eVB73osSwSL2CLw2/eYssfiwywWq
         Sc9rqPA32YUH0bI5wmsIFdzUWciyMvl5IR+98i+Eg9skbAvJ84g7oBYNioqQ8VSngQhJ
         GVrQ==
X-Gm-Message-State: AOAM533bXm3RLJOWBryvmKmpXwWPQl4A2F0229h5OgCOXb1M93D9njgc
        xuUVg+V2xyUtCzb7RuB0VMzlATLI4vr3VxF18+WtOWj0kJ/TnealKZkF26aJNMA0fWNx+tHYBwB
        Ow5rNdiGcD40JvcyCuOfTvd1D45sQTR4+E5i8GhAAFJcy/S6Zp+X8anRWCye/RqhYVKg3RWfmV+
        NGQvUPGtptfeo=
X-Google-Smtp-Source: ABdhPJyT66pv1hkFYBTKPi/3GBqH3FOGoCR6WzxMvKLGrMFXnSA/3i4HxwaTI4KkF93MzqzKgwqaq70radhJlDFzLw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a0c:e313:: with SMTP id
 s19mr39613196qvl.26.1626938624150; Thu, 22 Jul 2021 00:23:44 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:15 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.5.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 05/11] plugins/admin_policy: add admin_policy adapter driver
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

The following test steps were performed:
1. restart bluetoothd
2. check if "Admin Policy is enabled" in system log

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

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
2.32.0.402.g57bb445576-goog

