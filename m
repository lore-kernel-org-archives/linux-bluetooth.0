Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B88C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48EE860ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhHCLoD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbhHCLnr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:43:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E109C061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:43:34 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p123-20020a378d810000b02903ad5730c883so16336639qkd.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=daRTlPam7ySTQ23fYq3GAxDt76pKQh//ucrhRFErG2E=;
        b=A2Mj34uxwMpk3gK2mAmOcX6ETbWJA4uSqvmUwSwz2yr551imLdDIhUb8qRwwEGTm+1
         cSgbutlvQDSX73uSJ/ak1mTUigpU9b71KY1eXtPTczOXUn9lvQfXX7uPpt6C+lacqrUz
         3kzdhAvQxo8D+C7XB90hXGqpagI9VUXViw+7y0es/wvQ6+2u9ulxcqtatyAtiAifwe6q
         5quxBbTPFk4p9rlRS0ih484eBFua962PUYLQQ7ES45MrP+26AcdUtYvefEaDv105eJPo
         qO9Gnys/C/xWSDd6iJGtN2fXcJqHu2mrVf+k/596jRzYtQ+i8M+KZDwlJcsopA5lGHc7
         /VOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=daRTlPam7ySTQ23fYq3GAxDt76pKQh//ucrhRFErG2E=;
        b=hxsVtqGnveI+3zdvqMbnZ+h0JlUDK4HeBq/cbgilM46xyA8JFH4dyOW8K867gPMYWy
         NS2wZ7Is1eZopurhm+Chy1X0v2bZUnH/ZjrEteN+Q8kpydIoSJ/QbclGFTZ3S05eHEFd
         1izXMXbTUM4M0KazoW5o4hZr3XH3MPbL2LWwl/LxTnKzJG7TG9JYQbeRbAZpBOLgXg4a
         2xF5Gbn/5fPg1lUuBwrWtz4sr6jOjle3WUgkptoruRnUV7ekz2Cn48oHt4Ez1J8Gwn6a
         s4xkd41afI8+yAC4wUlLcBsHXUGj8oSx/VLQiy8Cnmqe+xAJpFDo18z4aQYVf9P6dpJi
         Zygg==
X-Gm-Message-State: AOAM533COabP2LNS/T7bvcSqINAHqltBitb+a52zZdYSgpvcv1fEZKMb
        1uD9SCRzZ6caIWkRntOLZDlYMZvIPG/CrkXkP/wAD4p8Gd+EEP4PHpuNxFMOHiQFGqlP17Rwykv
        O/lP+UlNSbnVu32IP0cfsWv1+Dj0lfTB/BHtHQYL0xX0H/62+f2a1Azi+dbQ8HoQ/nwok6xzCy3
        7n7pnpZg935x4=
X-Google-Smtp-Source: ABdhPJw8hfdlHUZ8Mek7lsKiaC66tkCAAtzFnrAeLtXh6snVCEDpN57AuQodyMd5ZkNhb9vC8WjQwVnZRsFXmE3klw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:3a4:: with SMTP id
 m4mr20773324qvy.17.1627991013694; Tue, 03 Aug 2021 04:43:33 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:06 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.2.Iee308dd18bfdfd3dae9e343e78b3942ee462314f@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 02/13] core: add device callbacks to adapter driver
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds the following callbacks to btd_adapter_driver.

device_added:    called when a device is added to the adapter
device_removed:  called when a device is removed from the adapter
device_resolved: called when all services of the device have been
                 resolved.
---

Changes in v9:
- Fix gitlint error

Changes in v8:
- Add device_resolved.
- Remove space before function pointer arguments.

 src/adapter.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++----
 src/adapter.h | 14 +++++++---
 src/device.c  |  2 ++
 3 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 663b778e4a5d..5a20f4c6239e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1216,6 +1216,9 @@ void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle)
 	remove_record_from_server(rec->handle);
 }
 
+static void adapter_add_device(struct btd_adapter *adapter,
+						struct btd_device *device);
+
 static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 						const bdaddr_t *bdaddr,
 						uint8_t bdaddr_type)
@@ -1226,8 +1229,7 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 	if (!device)
 		return NULL;
 
-	adapter->devices = g_slist_append(adapter->devices, device);
-
+	adapter_add_device(adapter, device);
 	return device;
 }
 
@@ -1254,6 +1256,9 @@ static void service_auth_cancel(struct service_auth *auth)
 	g_free(auth);
 }
 
+static void adapter_remove_device(struct btd_adapter *adapter,
+						struct btd_device *device);
+
 void btd_adapter_remove_device(struct btd_adapter *adapter,
 				struct btd_device *dev)
 {
@@ -1261,7 +1266,7 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
 
 	adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
 
-	adapter->devices = g_slist_remove(adapter->devices, dev);
+	adapter_remove_device(adapter, dev);
 	btd_adv_monitor_device_remove(adapter->adv_monitor_manager, dev);
 
 	adapter->discovery_found = g_slist_remove(adapter->discovery_found,
@@ -4222,6 +4227,7 @@ static void probe_devices(void *user_data)
 	struct btd_device *device = user_data;
 
 	device_probe_profiles(device, btd_device_get_uuids(device));
+	device_resolved_drivers(device_get_adapter(device), device);
 }
 
 static bool load_bredr_defaults(struct btd_adapter *adapter,
@@ -4576,7 +4582,7 @@ static void load_devices(struct btd_adapter *adapter)
 			goto free;
 
 		btd_device_set_temporary(device, false);
-		adapter->devices = g_slist_append(adapter->devices, device);
+		adapter_add_device(adapter, device);
 
 		/* TODO: register services from pre-loaded list of primaries */
 
@@ -4738,6 +4744,62 @@ void adapter_remove_profile(struct btd_adapter *adapter, gpointer p)
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
+void device_resolved_drivers(struct btd_adapter *adapter,
+						struct btd_device *device)
+{
+	struct btd_adapter_driver *driver;
+	GSList *l;
+
+	for (l = adapter_drivers; l; l = l->next) {
+		driver = l->data;
+
+		if (driver->device_resolved)
+			driver->device_resolved(adapter, device);
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
@@ -6355,8 +6417,10 @@ static void adapter_remove(struct btd_adapter *adapter)
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
index 60b5e3bcca34..3d69aeda14fb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -105,11 +105,19 @@ void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 
 struct btd_adapter_driver {
 	const char *name;
-	int (*probe) (struct btd_adapter *adapter);
-	void (*remove) (struct btd_adapter *adapter);
-	void (*resume) (struct btd_adapter *adapter);
+	int (*probe)(struct btd_adapter *adapter);
+	void (*remove)(struct btd_adapter *adapter);
+	void (*resume)(struct btd_adapter *adapter);
+	void (*device_added)(struct btd_adapter *adapter,
+						struct btd_device *device);
+	void (*device_removed)(struct btd_adapter *adapter,
+						struct btd_device *device);
+	void (*device_resolved)(struct btd_adapter *adapter,
+						struct btd_device *device);
 };
 
+void device_resolved_drivers(struct btd_adapter *adapter,
+						struct btd_device *device);
 typedef void (*service_auth_cb) (DBusError *derr, void *user_data);
 
 void adapter_add_profile(struct btd_adapter *adapter, gpointer p);
diff --git a/src/device.c b/src/device.c
index b29aa195d19b..49dd57166532 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2633,6 +2633,8 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 							dev->svc_callbacks);
 		g_free(cb);
 	}
+
+	device_resolved_drivers(dev->adapter, dev);
 }
 
 static struct bonding_req *bonding_request_new(DBusMessage *msg,
-- 
2.32.0.554.ge1b32706d8-goog

