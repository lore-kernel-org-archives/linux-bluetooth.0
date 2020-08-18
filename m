Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF7EC433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 05:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B1C2075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 05:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VP4Pyda8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRFpa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFp3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 01:45:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E8C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 22:45:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d26so21030410yba.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m9GCLS7/q73b2QMns45ZyBx9tX/LulwEUzquYmCfnIo=;
        b=VP4Pyda8cbhWNREa0MAVRbWMcxHtXzm0LeaChboPGHtSqXpVknm+O0rh6FFQFYXDi9
         BwIzT+RAfgvRbelRlrkJK2CTdVNDJeVs2u0eJPHCjsb9Mvnb+wnkStFk8qaevN2s/WaR
         tKBx0eELzba8DaVQqhdIPEI8tSQuZrzuJeGuRfejAFprjqPBxbt7+7VUQwp5BVBx4ndd
         JBZNXJR8zWxMtiGepD+nUUERYYe3s7XgvIY65/X8PxAq3QIw/QjijRUmq5LA4xILUzZz
         APGT3Tjk0K5h6mR44PPWwjsrJRN13mhu2yPed56aO5vRmcIwV8Gcwywb9ahV2MLVsL6+
         AdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m9GCLS7/q73b2QMns45ZyBx9tX/LulwEUzquYmCfnIo=;
        b=edKipcZSIFK4HBNaNEM6LwY+oV5hYKBsPNrKdb1/BXZ6VyDv93vvGoiDzlfV2b44SL
         TPs8mw69asdPYGYz7t58KEGeB7yjhhMJSvvEg/kC0xswZmaGNuZoWy88ECJ8Ag5Q2vB7
         eQZcKF5bgQA2xrKD/wCBIjpcsKRD71QLikb1vSpDKnCKKgJg1f16I0lnJEvSSppOi0N4
         CnE8dGioSyJUHJUHoq6f50/cIcGmGp9SylHPmsFKzQMkSkbG0w5s+lWTf62puNdogQ6T
         7fhbr9W2X58NWCLuK9tETw1FVST4Otrb1+HRCsiM/uV+B9RUAlvQJCssIhqmYvakhALD
         urDA==
X-Gm-Message-State: AOAM530J7kMwgQ25yMducMeUljtUeLNLC6GPuu05Wr3Z5xBUrKgWX0Bp
        n7WJv49l3klNsoUQ+JTlfD22TCZBzpuXVf5eKAVzj+4A4XAivE9m/wNLLhXDpEn1uCzpGdKUOfY
        GzV8QKJH6fD8lhPjV0Oh+LuV9EPW/r1uxFEmJTFQp+YiGUWxUmIBAirW30X4gzvThsWgjxrtqgG
        TN
X-Google-Smtp-Source: ABdhPJy+aJVF/cVFuD1eUiqKJ76uB0dHiyTS3TCu3OGZNe7gMxQRL3Wd7hhd4/roNeDLLTF0j988x7yVI64+
X-Received: by 2002:a5b:78e:: with SMTP id b14mr24933536ybq.408.1597729528421;
 Mon, 17 Aug 2020 22:45:28 -0700 (PDT)
Date:   Tue, 18 Aug 2020 13:45:23 +0800
Message-Id: <20200818134455.Bluez.v2.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [Bluez PATCH v2] device: Don't browse SDP if HIDSDPDisable is set
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to the HID1.1 spec, part 5.3.4.9:
The HIDSDPDisable attribute is a Boolean value, which indicates
whether connection to the SDP channel and Control or Interrupt
channels are mutually exclusive. This feature supports Bluetooth
HID devices that have minimal resources, and multiplex those
resources between servicing the initialization (SDP) and runtime
(Control and Interrupt) channels.

However, Bluez still tries to connect SDP upon HID connection,
regardless of the existence of the HIDSDPDisable attribute.

This patch prevents the connection of SDP after HID has been
established, if the device has HIDSDPDisable attribute.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v2:
* Renaming passive_sdp_discovery to refresh_discovery

 profiles/input/device.c |  3 +++
 src/device.c            | 11 +++++++++--
 src/device.h            |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6ec0a4c63..5e47b88f2 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1373,6 +1373,9 @@ static struct input_device *input_device_new(struct btd_service *service)
 	/* Initialize device properties */
 	extract_hid_props(idev, rec);
 
+	if (idev->disable_sdp)
+		device_set_refresh_discovery(device, false);
+
 	return idev;
 }
 
diff --git a/src/device.c b/src/device.c
index 2237a7670..52dfea18f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -195,6 +195,7 @@ struct btd_device {
 	bool		le;
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
+	bool		refresh_discovery;
 
 	/* Manage whether this device can wake the system from suspend.
 	 * - wake_support: Requires a profile that supports wake (i.e. HID)
@@ -1472,7 +1473,6 @@ static gboolean dev_property_wake_allowed_exist(
 	return device_get_wake_support(device);
 }
 
-
 static gboolean disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1805,7 +1805,7 @@ done:
 				btd_error_failed(dev->connect, strerror(-err)));
 	} else {
 		/* Start passive SDP discovery to update known services */
-		if (dev->bredr && !dev->svc_refreshed)
+		if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
 			device_browse_sdp(dev, NULL);
 		g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
 	}
@@ -2572,6 +2572,11 @@ done:
 		browse_request_free(req);
 }
 
+void device_set_refresh_discovery(struct btd_device *dev, bool refresh)
+{
+	dev->refresh_discovery = refresh;
+}
+
 static void device_set_svc_refreshed(struct btd_device *device, bool value)
 {
 	if (device->svc_refreshed == value)
@@ -4071,6 +4076,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	device->db_id = gatt_db_register(device->db, gatt_service_added,
 					gatt_service_removed, device, NULL);
 
+	device->refresh_discovery = true;
+
 	return btd_device_ref(device);
 }
 
diff --git a/src/device.h b/src/device.h
index cb8d884e8..5ba2d7fe0 100644
--- a/src/device.h
+++ b/src/device.h
@@ -145,6 +145,7 @@ void device_set_wake_override(struct btd_device *device, bool wake_override);
 void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 			     guint32 id);
 void device_set_wake_allowed_complete(struct btd_device *device);
+void device_set_refresh_discovery(struct btd_device *dev, bool refresh);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
-- 
2.28.0.220.ged08abb693-goog

