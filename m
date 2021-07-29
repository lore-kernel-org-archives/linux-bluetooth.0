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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6527AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3B060F59
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhG2DNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:13:54 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19377C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t35-20020a05622a1823b02902647b518455so2114949qtc.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=vu5z/nxxFbriAu1c3zuZWwleNuCQxiQ2DrbJ19TxYpYQtosGk/iQl4ik7zNN07G6hf
         ShjCj7lmIHllgxQ+a8gQZyV9CsYI+ibN8uMUZRRfJF45+IoX82pfc9CPhgIahVUt7L1k
         wzMV0PFjeX+/EeFJZTyj80NSOFRMlkR2euaqPcLz7VCynzAf9noKTfrmpnwa3hn8KckG
         KzI0OMozfeJ1uKsklX8Cuz1pqAATamCxiMrqFG3p2SJHde9LSlIWti6itxHKxSp+y8SI
         kD8E1IEOfXNwN0ThG0zYDjNe4GKH8EsD0kZq4b89lMQ0uftM7eefpNU2nMT9EeaATsOJ
         9JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/e+0IQlyiwFsKtb7qCWpUP84WxAop8SbAryiByocQw=;
        b=JbxFxV+ytL3BqYLsOsLKGsLxnmhwJp49OCn67d4wSTJhypQbE+Rq5ze5Y/vFK6Omgq
         A8/yUw7h8uJmjLTaYHk6aLzE32Ki6u6my4cgroT22E/J5W9/PjfzDVKNXXlE7SXJpoH2
         HyGAGKabjGsZEM3Z/KpAUsWcOgtw8dyiB7svMZ+/xOdnBuYxIBLEjL38rcKHe15ynh++
         efnmOqKuiyoo3WBxLD3eJ4/41WDA547cv5/Y/OiMlGHUYqB4AKgLv0/LWNibZojq32Ni
         dKBPMGZ6xBp0mTdN8VqCgZVUpbdWH/Sw1H3TCW/TL1NKfPNo9liAY5YdHPBAH7SCjHVT
         cP7A==
X-Gm-Message-State: AOAM532z+r/7ygbRIVJaK1/N6vT3zHO6XlBbjU2HvStzwWnMgrMXx39L
        +mpNW9/qoh4H5R1r5bw3NUd/8kdiVWlrUdX8s7iJ+ckFqugQe1jQT2a/DN/RxH9eNsYd22Jz88d
        QtCL0g/zkjHqqYxHCSaVnAkMtjk0F5bK5Mnny1izbzftKGnhYPdh8m7MMN1hu8dvKTu+0R2ufnn
        +bfuZK6/7bTew=
X-Google-Smtp-Source: ABdhPJxik0uicRqPv5YB5ozNbFc/KO++IQM37u1GQm058XUSTkdLQWQQcUnnSO1ub9vzr7H1kS/1hcGFgz4zEFqoXw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:a0d:: with SMTP id
 dw13mr3309708qvb.41.1627528429131; Wed, 28 Jul 2021 20:13:49 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:51 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.5.Iee308dd18bfdfd3dae9e343e78b3942ee462314f@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 05/13] core: add device_added and device_removed to
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

