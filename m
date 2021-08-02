Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B258C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F32F60EE8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhHBGNY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhHBGNY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621C4C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso18019095ybg.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=Z0jGA02axnceegZ9cVMyiSZ9Kq/xbrdzPnRzVlTEMz+qKxoKx082Q7xJyUtCJFHkXp
         r+iBY23cJqiz/Xhr55SUUf2QkuQxX0fQ0Ad34/oBihJlY3h6Q3hZQtQJx3JWp58bb/Cf
         5Mtn+pucaYAl7SBNPG0XZoq+hpRObKHuIq6jlwnKfD+ywgbbnLrN3UOcHQ4ap6487Svv
         4tU8f0x2O//wt5Ri2ENe9FXW7wVXhE/TGAVXB82zRhWaVP6tpI2GYR1rRdODPqzZDRNs
         u3py85Os/k785I5oqi7d2HgAg1Adp9DLDQi5ifp8pdRtwV+wdZ2um1nP8sUUcYfDH801
         OneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=LsiO6/eLdQ9C5lOtGxt/10ZqYK/z2ICKhpCjt+D7gDNU24up43Uy36ncT3kwhQTVj8
         pjewr5mYTAB1UynQfTac+pJE/u31ytDJmJsnlYhCEIZ/k3PNauFnv5BM368PvO7H9YGP
         kMAT+rP8b+/N/tR0QPrW9R53y2h+zApyltmA8c9c0Pus54nuLXZTs9/Odh/+WoYsrHse
         1qUXMfAvUwuLYJaq1Zip8VsNnDXskJVq5KN+NtXxuP2bvNeS9WaSAhpaumn/vj7Jw86G
         jaV1JlAhvT/wIuUC3UxZhGtZX7geGa2xnpSvm8TJz73sOTvuT6ytqSo5VZY5UsItC5/C
         0NkA==
X-Gm-Message-State: AOAM533lDpveuQtYUH1KhTzGMpyTSj+G51wCI0fTXuewL3PxCkUPH5/O
        87hfAeD7YlKaAUww40pVeVwj9YyFxEfMxmhmUME/VKV4v34IkqjR3bvrBBghLKe/ecwtf9PlIXG
        1SfriswfxZBYkwdaB+jnAE+iQ91qWhrq7lOuJyqVS/XrkfiD5C0QEELntOkR8KDrP0JzUf9OgMt
        WYihWSxaGWr/A=
X-Google-Smtp-Source: ABdhPJwlDavUZHLz48+ev/LYl337p08Ds9aHdDOUDf5YeWYHUVZx4E4v1ie5iu0+AIhihC5Sg7o9oXC9K1+w3oaJZQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a25:dc10:: with SMTP id
 y16mr19741522ybe.115.1627884794494; Sun, 01 Aug 2021 23:13:14 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:42 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.5.Iee308dd18bfdfd3dae9e343e78b3942ee462314f@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 05/13] core: add device_added and device_removed to
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

