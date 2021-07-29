Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D54C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA2A60ED4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhG2M2a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbhG2M2a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:28:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719EC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:26 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q9-20020a05620a0c89b02903ba3e0f08d7so3751538qki.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=Upam9157F1DAgkqV8tGfg9Xrmuz195NlzDyf4OBWTRyHQG6o6Pz3VkRjfRc9gnOeBG
         4xKSAZ+Zn0V+kbvu2aq2AfUuuSzEl8jATmi1lo6irK1AoUix9vTaaDkp5UY3jUFN5lnn
         H17xR5uvqoqkH+K/N6iqRvgGvoxnrGLvy1TsJI9vhM3t3GWgiFm1+Y+bu9lu9ofHp4m0
         vZ2nTpOwG8qeDdqIeiKfjQ6gxbzeki0A82hjYt1MsMdkzYipX/c1uPj8gwYM7Bmkz8kg
         GVNRsF2+FTJPA95AvJ9v4VA9mgAtwV8o0vcp9l5eY/kT+RG1dCO9yfJJsjFGNW5cYr79
         bW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=uWs2Dp8cb8kRoKYkZwJNgYp/5+ac1PmjF8DP8ZfESBCsmphRlhRFylMSCL49nasAeV
         gxfgI+5vTZLcRv1nPoaRZYCB9+X/SEhnm7rnwriNQaeMRw7KtmF095rEy/FVr7w57wLy
         jd6QAtowOLvK+2W821L7F33mft7b4L6ZcTq60HH6qChjn5Ne/4EvHgOFbyL0qpfgGBs/
         7Y8RLI3VhmKTNtz9xvR38IeGGmNFR7YSLiao5++59h2dQZWpKT0tNC8sePh2KE9p9V8V
         Iz6v8dnKrDLVED3YDDbTxz1+IKv8+lEhfyC32VSC8Mj2ejEf2Q0Iawcrtf9g+5e8q90H
         5/rw==
X-Gm-Message-State: AOAM533Fo7WceHYL6VXHBcWAxoM2txZrZXwDwyqZIgQt8WxoeNxnelpH
        B+xt6mM4cswZ3fho5NWYBMcNHqlOzyHdmSQCeHdl12gjLon0hor1qidlpGpaT5aDm+yGxhg6XXh
        bWUFdTRw8a34JNEl4Q6e2onFRWFwKZyvbcfMeiv+fJ+1lrJF7li7BPxNmZuZKiOQQHDjtkVNKjw
        ltZ1hddzenmoI=
X-Google-Smtp-Source: ABdhPJziXipuKqPs0lrRHXIMgjBm+Bc2CGdgxt2w+kLjBUH/q+lVX/lLDYKqDLQVJtUNJ2z4ixYRv0m/PfVPB4yJgQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:2482:: with SMTP id
 gi2mr5116344qvb.51.1627561705100; Thu, 29 Jul 2021 05:28:25 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:43 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.5.Iee308dd18bfdfd3dae9e343e78b3942ee462314f@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 05/13] core: add device_added and device_removed to
 adapter driver
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds device_added and device_removed to btd_adapter_driver so that
a driver can get notification when device is added or removed.
---

(no changes since v1)

 src/adapter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++-----
 src/adapter.h |  4 ++++
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6c8096147bdd..5c556b569ca7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1218,6 +1218,9 @@ void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle)
 	remove_record_from_server(rec->handle);
 }
 
+static void adapter_add_device(struct btd_adapter *adapter,
+						struct btd_device *device);
+
 static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 						const bdaddr_t *bdaddr,
 						uint8_t bdaddr_type)
@@ -1228,8 +1231,7 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 	if (!device)
 		return NULL;
 
-	adapter->devices = g_slist_append(adapter->devices, device);
-
+	adapter_add_device(adapter, device);
 	return device;
 }
 
@@ -1256,6 +1258,9 @@ static void service_auth_cancel(struct service_auth *auth)
 	g_free(auth);
 }
 
+static void adapter_remove_device(struct btd_adapter *adapter,
+						struct btd_device *device);
+
 void btd_adapter_remove_device(struct btd_adapter *adapter,
 				struct btd_device *dev)
 {
@@ -1263,7 +1268,7 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
 
 	adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
 
-	adapter->devices = g_slist_remove(adapter->devices, dev);
+	adapter_remove_device(adapter, dev);
 	btd_adv_monitor_device_remove(adapter->adv_monitor_manager, dev);
 
 	adapter->discovery_found = g_slist_remove(adapter->discovery_found,
@@ -4665,7 +4670,7 @@ static void load_devices(struct btd_adapter *adapter)
 			goto free;
 
 		btd_device_set_temporary(device, false);
-		adapter->devices = g_slist_append(adapter->devices, device);
+		adapter_add_device(adapter, device);
 
 		/* TODO: register services from pre-loaded list of primaries */
 
@@ -4827,6 +4832,48 @@ void adapter_remove_profile(struct btd_adapter *adapter, gpointer p)
 		profile->adapter_remove(profile, adapter);
 }
 
+static void device_added_drivers(struct btd_adapter *adapter,
+						struct btd_device *device)
+{
+	struct btd_adapter_driver *driver;
+	GSList *l;
+
+	for (l = adapter_drivers; l; l = l->next) {
+		driver = l->data;
+
+		if (driver->device_added)
+			driver->device_added(adapter, device);
+	}
+}
+
+static void device_removed_drivers(struct btd_adapter *adapter,
+						struct btd_device *device)
+{
+	struct btd_adapter_driver *driver;
+	GSList *l;
+
+	for (l = adapter_drivers; l; l = l->next) {
+		driver = l->data;
+
+		if (driver->device_removed)
+			driver->device_removed(adapter, device);
+	}
+}
+
+static void adapter_add_device(struct btd_adapter *adapter,
+						struct btd_device *device)
+{
+	adapter->devices = g_slist_append(adapter->devices, device);
+	device_added_drivers(adapter, device);
+}
+
+static void adapter_remove_device(struct btd_adapter *adapter,
+						struct btd_device *device)
+{
+	adapter->devices = g_slist_remove(adapter->devices, device);
+	device_removed_drivers(adapter, device);
+}
+
 static void adapter_add_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
 						uint8_t bdaddr_type)
@@ -6445,8 +6492,10 @@ static void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->connect_list);
 	adapter->connect_list = NULL;
 
-	for (l = adapter->devices; l; l = l->next)
+	for (l = adapter->devices; l; l = l->next) {
+		device_removed_drivers(adapter, l->data);
 		device_remove(l->data, FALSE);
+	}
 
 	g_slist_free(adapter->devices);
 	adapter->devices = NULL;
diff --git a/src/adapter.h b/src/adapter.h
index 7cac51451249..a2567330ddc9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -111,6 +111,10 @@ struct btd_adapter_driver {
 	int (*probe) (struct btd_adapter *adapter);
 	void (*remove) (struct btd_adapter *adapter);
 	void (*resume) (struct btd_adapter *adapter);
+	void (*device_added) (struct btd_adapter *adapter,
+						struct btd_device *device);
+	void (*device_removed) (struct btd_adapter *adapter,
+						struct btd_device *device);
 };
 
 typedef void (*service_auth_cb) (DBusError *derr, void *user_data);
-- 
2.32.0.554.ge1b32706d8-goog

