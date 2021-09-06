Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7BCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 06:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95AC60F92
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 06:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhIFGEe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbhIFGEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 02:04:31 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD323C061575
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 23:03:26 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l3-20020a056214104300b00366988901acso10474039qvr.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pTDaSxJkExjIr9d5Cl6MptNCwx4AFUjqpvcw+0x4KLs=;
        b=MSWAGvQqQzO110b/zcJCPQiXnu0gGELOYu0PTcrs8DwTa4Mz2xSdQIXw876fkzukzP
         USDbx3TGwI2/Z56YnpRRxYHHjK62yAeVf2klNI385MRVPSKwOzBd3a+SeZXgVErg74Gr
         IslkmPXHZEkivRegfzjP0AshMjZEKgYUNu1VBfuNz4PjWhaeqymNDjscZzes6SwM0x8r
         8uOnmW2HPirvsmk+K7hs4iHx7W4/mvnaDfdrddZ9TkOfllFIK0AxU/gIKw5NZatxlvc7
         /xI/vffTSU96UFOQIhC9nOtgBN03ygm82ynMMc3HTJuOKS7P7nM0VPzUC795gEZ3DckG
         MpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pTDaSxJkExjIr9d5Cl6MptNCwx4AFUjqpvcw+0x4KLs=;
        b=T1bnwP3Bf7kAYVCnscmyIrBxEiwt1Mvc6tuSz0ElOZXEQwW03Z9/G+0itIlVGRpkhD
         +/oaXAbL66U1D2hljKEALb86463xKamb4WO8OXpeaQ1jLw/sHzCoZHUHv7YF5vxN+vEk
         pnW5SYG2Q5cYQ2cyYUZGW0E9FAlZQ2HaHVNy+VVGoO+0294kgRYSmxis/r2d/po1AP0R
         +WtKZ7TCozmi4zKEal8RHQM/Y5EVw1f3L/xzbJTWKBy3dhYzxE7aODcPIBJTjXGoDUQf
         T4ljc+54t1IBPptgoiao84nvKeiIh/L/g3nkB6pT/TsZvyHBjgZeTtt1q2XzZ6Q4+kql
         LLoQ==
X-Gm-Message-State: AOAM532aFntqJslI2fwaX9vtpdIvgAowm/K+zGKNzwdJRafFv5sID8pl
        YREM07+Y40oKm6EWOnxdalKBVHbPPCdBJT3pysEiMS0dPaWoapHQq6jU65Jcb1xnEQNtQ4bB4iW
        RfxhXnO6OYd6pSKeVT+0OcQw/fc1iqQdFsDsY7imvn2FGTPoRjaRwg0QeTdX3HXq0M55jB7poNJ
        cLSAOQyuSTywc=
X-Google-Smtp-Source: ABdhPJx0T8il61G8GCkJcYkWxIHJL50oT1yNKcedlX9perEkxZKKekGigJrdK9PHPiy+fsU/uqdnQ2vDYLHjIERRog==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:d42:c8a9:b5b9:8c48])
 (user=howardchung job=sendgmr) by 2002:ad4:562c:: with SMTP id
 cb12mr10144872qvb.6.1630908205758; Sun, 05 Sep 2021 23:03:25 -0700 (PDT)
Date:   Mon,  6 Sep 2021 14:03:16 +0800
Message-Id: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v2 1/2] plugins/admin: add adapter_remove handler
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Shyh-In Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

Currently admin doesn't handle adapter removed callbacks, which causes
interfaces AdminPolicySet1 and AdminPolicyStatus1 not being
unregistered, which in turns causes these interfaces can not be
re-registered once adapter is back.

This adds handler for adapter_remove.

Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
tested with following steps
1. rmmod btusb
2. modprobe btusb
3. read allowlist via bluetoothctl

Changes in v2:
1. Fix make errors

 plugins/admin.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 02fec04568ba..82c00cabdb6b 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -85,6 +85,17 @@ static void admin_policy_free(void *data)
 	g_free(admin_policy);
 }
 
+static void admin_policy_destroy(struct btd_admin_policy *admin_policy)
+{
+	const char *path = adapter_get_path(admin_policy->adapter);
+
+	g_dbus_unregister_interface(dbus_conn, path,
+						ADMIN_POLICY_SET_INTERFACE);
+	g_dbus_unregister_interface(dbus_conn, path,
+						ADMIN_POLICY_STATUS_INTERFACE);
+	admin_policy_free(admin_policy);
+}
+
 static bool uuid_match(const void *data, const void *match_data)
 {
 	const bt_uuid_t *uuid = data;
@@ -492,7 +503,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
 					ADMIN_POLICY_SET_INTERFACE,
 					admin_policy_adapter_methods, NULL,
-					NULL, policy_data, admin_policy_free)) {
+					NULL, policy_data, NULL)) {
 		btd_error(policy_data->adapter_id,
 			"Admin Policy Set interface init failed on path %s",
 								adapter_path);
@@ -506,7 +517,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 					ADMIN_POLICY_STATUS_INTERFACE,
 					NULL, NULL,
 					admin_policy_adapter_properties,
-					policy_data, admin_policy_free)) {
+					policy_data, NULL)) {
 		btd_error(policy_data->adapter_id,
 			"Admin Policy Status interface init failed on path %s",
 								adapter_path);
@@ -574,10 +585,24 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
 		unregister_device_data(data, NULL);
 }
 
+static void admin_policy_remove(struct btd_adapter *adapter)
+{
+	DBG("");
+
+	queue_foreach(devices, unregister_device_data, NULL);
+	queue_destroy(devices, g_free);
+
+	if (policy_data) {
+		admin_policy_destroy(policy_data);
+		policy_data = NULL;
+	}
+}
+
 static struct btd_adapter_driver admin_policy_driver = {
 	.name	= "admin_policy",
 	.probe	= admin_policy_adapter_probe,
 	.resume = NULL,
+	.remove = admin_policy_remove,
 	.device_resolved = admin_policy_device_added,
 	.device_removed = admin_policy_device_removed
 };
@@ -597,11 +622,7 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_foreach(devices, unregister_device_data, NULL);
-	queue_destroy(devices, g_free);
-
-	if (policy_data)
-		admin_policy_free(policy_data);
+	admin_policy_remove(NULL);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
-- 
2.33.0.153.gba50c8fa24-goog

