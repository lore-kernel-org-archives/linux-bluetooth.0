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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3B60240
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhG1NQI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NQH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F0C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so2741442yba.19
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YNwxtFl+Q5xNneMOHue6J/67p8nZOPpKbvtqaiUgyEs=;
        b=kvICbf05hP2Nhr9lA9T5YPAcSMxDW27m5xiVdSeZOuvHheu4iHz5BqxBjOETVeYONW
         V81aXzaHFVDwdDiSHI2jfg7CgxTxzuv2zt7D6t0+ZeJD+ym/H2lKT4O1YU1o0+Y7GIpM
         CZiptpTTkhngk/o1tQ5WMILmdS5RNRIUhYHpQbB0kK6U0b4aN6+5R7yq76uNDjdQAUim
         V6oOZU+sS9armeuVxwQo/GtBdngSXQZOhPt7d6Q/85MWPlrQvrNL7Zr8NiFb6RVrAAUy
         4bsHLz8yPEhhSZ6bMJZGbU/XlPxNmzPYdIArVyxru3Y7qHHehbi3DWk659l5ky9vkW3q
         kvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YNwxtFl+Q5xNneMOHue6J/67p8nZOPpKbvtqaiUgyEs=;
        b=NA17u7DomgF/BmSgaLbVoQNYLRsu5Y1cduRI51ui3x0ECbRaca28OGc41+VWGj2QJA
         61UhSMkoFtjeEWIE/P+3WBFNdCUHiL8/KrYRVAHtCC6hnL4dcMsUnoAYSQIjvOVgdS+/
         YZ/eFcCdRlWcSuz5xkcbWxPKEIRJBNqK02ZSlAFzGrkCYdPyqlYTWzvmEZOss6L+aIkB
         OmboJzHgFAp7jcaVdNWU2nsGj05IpIb1CnzOiryAXg8co6v1Fq2sI79v/HGNcvLhdKCF
         peJBjNibb3JOTuP/j4SYR885qdwlqXke6eRp55Yxi6ovw1uTzfv5uAuU4J5RlH2hMxbt
         yBcg==
X-Gm-Message-State: AOAM532jPG7hx3U9swLHVfI98YbxMTo1ejNgxVFTfVGG3ahJGDYmRrGd
        wVT6Z0y/GUiGZ07OwlyRTQY2YMuv4mpbZNUbCKrQAmKhSK7EOjvY6MX0dtGdV+4vV4FQfKp5UCO
        kymZJ7HlgzGp79+XkJt9/HGMPUHRYhMhDuB3JTjY7ZLFdqLamR64o0S1FDCG4y1w95JHidnLPsF
        OIj2IxU8pDr7A=
X-Google-Smtp-Source: ABdhPJx4BysB1mTistNHKJ8OuWJ5MgneKIm1XDIih8G4Blt43XsxDLvviIne9Rv83SNzmqUXwK1v7crafOm76iDhPA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a5b:648:: with SMTP id
 o8mr4237312ybq.260.1627478164145; Wed, 28 Jul 2021 06:16:04 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:21 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.5.Iee308dd18bfdfd3dae9e343e78b3942ee462314f@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 05/13] core: add device_added and device_removed to
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
index 6c8096147..5c556b569 100644
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
index 7cac51451..a2567330d 100644
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
2.32.0.432.gabb21c7263-goog

