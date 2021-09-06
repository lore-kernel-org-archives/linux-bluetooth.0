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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F095C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 03:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D463160F13
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 03:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhIFDlR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Sep 2021 23:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhIFDlP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Sep 2021 23:41:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608FC061575
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 20:40:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r15-20020a056902154f00b00598b87f197cso6896180ybu.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=x3GlFajUou3coCVzNSFSVgk7ZuYqV7NEAl6VxBnWJN4=;
        b=RiZXbGMdANaM1088FXELuzXSpcK9D7ix92VUPXvrfSM0hxxrb++HC5y+UDPGRbNX4l
         4v4hBbAsv5KQJRy7HFk5euEkFB+Pp+tGiFjQlGcyu0L5QZ8U0VMWW21ueNF408a6UcOp
         zbCSTVntZ15FVnXzbQ33UgwwGy9bj6Kkm9oCdFOmNallP4X+5SEKg1ASWbY8x6qatfWK
         N0yvNz0gqVjCUvMSH+RaL1BW9XbvN3UGdVdNyDwJxneYBZXfB5csGb52ndb1q/EexQT7
         nDOTuBYgPhspa+flFcA8RgG8rdblquenk/kndLqYMeL/RBm1m2tMvQE9jCZA7iKCrGeu
         paiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=x3GlFajUou3coCVzNSFSVgk7ZuYqV7NEAl6VxBnWJN4=;
        b=hAZMFpTrN9TuvMKV7IbkgvALQeBVpaIwuL6XZulIf3zl2ATi88IEsJ1EyvCWwcBi9H
         BYrIyHUwd48JwTZ00XTQ2QeY+0bcXx9f6Muz/GFXvUdjcTe4Bw4dHJuaENC8jytclpoR
         yUBe35VQTuFPCGjR+Vh9kt8SJsxU/VP4Z0RcxJYVlzhupyDXYdhMkvYGtWFy2MraKWn6
         ziRT5pZ4KwCdvfo0jUkGSLjmV15KSFuPsBnz59Yyrr2Ty7btjAQWEcgbwG0Te8/+iZxH
         kd0kRUzAkZMRqtKRMF2iusMt2wKtO5NB5UG1oLCvAgM4KyzZKSxSpA+waxh1be9lKQaw
         G2hg==
X-Gm-Message-State: AOAM532/cFKmdb+GNFbyX4v6lfkpUhnOLv+0LD8cDBhc5FPbUKsOSYO7
        aSBCIRNUQMSs31LL5ldfJcFhibShNAOjJoyIys8R6lOYIR8agGvAq9YTphIvAcn3klhx2mtI15V
        x97qVJwIwSx7udOcbm8LyZMgXDL9XvLyR6FIBchNnfKm6cfXzewn6YVDCpXMePb+iEKVb4rPiKL
        44abv/cclUnEo=
X-Google-Smtp-Source: ABdhPJw79wWG6NqYDO84k5WEfK4WqNF4GOXHow1rb/Ao6f1ANK2DF7PxTVudKrSSjWiRi631T//mOptBBkSdngwlpw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:d42:c8a9:b5b9:8c48])
 (user=howardchung job=sendgmr) by 2002:a25:5283:: with SMTP id
 g125mr13511860ybb.423.1630899610701; Sun, 05 Sep 2021 20:40:10 -0700 (PDT)
Date:   Mon,  6 Sep 2021 11:40:05 +0800
Message-Id: <20210906113953.Bluez.v1.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v1 1/2] plugins/admin: add adapter_remove handler
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

 plugins/admin.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 02fec04568ba..9440581409fa 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -85,6 +85,19 @@ static void admin_policy_free(void *data)
 	g_free(admin_policy);
 }
 
+static void admin_policy_destroy(struct btd_admin_policy *admin_policy)
+{
+	char *path = adapter_get_path(admin_policy->adapter);
+
+	g_dbus_unregister_interface(dbus_conn, path,
+						ADMIN_POLICY_SET_INTERFACE);
+	g_dbus_unregister_interface(dbus_conn, path,
+						ADMIN_POLICY_STATUS_INTERFACE);
+	g_dbus_unregister_interface(dbus_conn, path,
+						MOCK_ADMIN_POLICY_INTERFACE);
+	admin_policy_free(admin_policy);
+}
+
 static bool uuid_match(const void *data, const void *match_data)
 {
 	const bt_uuid_t *uuid = data;
@@ -492,7 +505,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
 					ADMIN_POLICY_SET_INTERFACE,
 					admin_policy_adapter_methods, NULL,
-					NULL, policy_data, admin_policy_free)) {
+					NULL, policy_data, NULL)) {
 		btd_error(policy_data->adapter_id,
 			"Admin Policy Set interface init failed on path %s",
 								adapter_path);
@@ -506,7 +519,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 					ADMIN_POLICY_STATUS_INTERFACE,
 					NULL, NULL,
 					admin_policy_adapter_properties,
-					policy_data, admin_policy_free)) {
+					policy_data, NULL)) {
 		btd_error(policy_data->adapter_id,
 			"Admin Policy Status interface init failed on path %s",
 								adapter_path);
@@ -574,10 +587,24 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
 		unregister_device_data(data, NULL);
 }
 
+static void admin_policy_remove(void)
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
@@ -597,11 +624,7 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_foreach(devices, unregister_device_data, NULL);
-	queue_destroy(devices, g_free);
-
-	if (policy_data)
-		admin_policy_free(policy_data);
+	admin_policy_remove();
 }
 
 BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
-- 
2.33.0.153.gba50c8fa24-goog

