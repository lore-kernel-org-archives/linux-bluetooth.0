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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0456EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB2E60F23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhG2I52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhG2I50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:26 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC8DC061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:23 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id js9-20020a0562142aa9b0290310fecb5f78so3605300qvb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=tCiWol/FeTuqWk0PM0Baxj+Mg3OhPcnPEGZRABDK0Zj8r9TOEjJMNElTUlhp6wP045
         1NfCh2DAV8hdiTh6tUrmMHDILKkt1ESWu31EHkpEb3hOxFMQy7cQUCSGkkKOrm1NCcLI
         Lh7vpQtcOlLlUGCjIYIBcLvZ8yy5BOoBXG0uJVQdmy7F0DOLh0r+JYI5ngB1F9Fii51f
         Z1Hl4b4rM2PU03unUdlAzHEaJQ+mOb+ZivgLFte2r7lZl7RFnQZt8hkzIFURxTzDxoW/
         z43Yy5Pt30ift6J2Qiniz5rheA/U4m2L6YO7sIg12Cp9uGsz0n6ZedXpslWbD59GZBez
         PR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=TR3wU7SlOXZgh0rEMl+V0og7bx8i6Mebroq4e6KS8FzQ06KExAcfSgU4jVq1MlzcAg
         ukmR26LGnrDJhxC//9vD66UtQjRL4yQoG4JtDUz+sPhnn5wrj0EI6u7VKG+CszZU654V
         0RMWX5x/y6MZChnCL6FPdUr6xak8krMsXH35T+DYUk0rJj16R4WWs0nYxsODCraD/oi3
         SO4FTiMX7voNLaprM0c8rZhmgBZG4rzjCSL8x89+em9sUHn2Iw/VeIJ0BWvVjuX+D4tw
         oWYdJr8UxQX6Z+MJio6VYJzvoplgq9XsoM3EAeboY25ZJmDPtZuXOwNMJsZIo8aDiRh4
         9aLQ==
X-Gm-Message-State: AOAM533zE5E0J3+NHfNJ5gd/pKUZcJlrbuB81U9+5EXd547oftptaqwI
        ggbzXJ20NCAASrfFpvVlpp68oJJS4Go4HUqILp4miZw+Y0LZUd29zLHbeuy6TIPFuHqZ0hx2YRS
        MwK1I8WXDDVmTOR+cs11nF+7Ce3/u77TFFnTeoPPBJqQjNHmUcfLsCsToLxGR4cAK/6ITYS5mK1
        ZYcil5Nsh8utQ=
X-Google-Smtp-Source: ABdhPJxaPPc8Hajr473jSBf2MVlnaeG95Cwf/CF0gqwMLigmfpaABgc28qmkEx7DrY2xx4DcJdskn1ChGFlGNRHe/Q==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a0c:ef85:: with SMTP id
 w5mr4371572qvr.22.1627549042875; Thu, 29 Jul 2021 01:57:22 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:43 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.5.Iee308dd18bfdfd3dae9e343e78b3942ee462314f@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 05/13] core: add device_added and device_removed to
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

