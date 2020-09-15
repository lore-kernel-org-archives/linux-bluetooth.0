Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C378C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 03:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63377208E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 03:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="afh7Ohz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIODEi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 23:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgIODEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 23:04:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93AC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 20:04:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 193so1963559ybi.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 20:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bEfG59MOHeBRkMqWRj6tWVU09859XSfXvoiJ0BUkxNU=;
        b=afh7Ohz0yqOkDJtgWZOxXgbKwgn5dSHhgEDmkfjbMoN2QlqMyO1OyRwiMoSkewO9p7
         PxdWy0d+sg6ChGPwSK4dlGIaVvynxmdBVgdvpJLOFJ1uMH0M6qV2LTaWwKmFLajAuoId
         Z5todCNC2oBsGAZLXLWGAS62hdJNK+wfKXtlkCwKrJUOl16Ap8vW3uDvRs+30NSHi+DG
         7Fjeb6VFGK57jp2OEuQFL824HfuAMDuMKL69zyaBDR7ByO2f4OzQxnRum5Vv8o4QZlHP
         y3E9Rbs88pJbDuN9xCiK20zWEZ7RBs83wAjsSms9BrqP0WbQf2gLu8B061Uz5SfUixAE
         0EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bEfG59MOHeBRkMqWRj6tWVU09859XSfXvoiJ0BUkxNU=;
        b=ZKS/JtQYDkoVcQ4qsXxUHJPNLqVy4AiKS2P0YPvNtIOp+jisHb4SOhyT8+bQ89Ww6m
         GbzyfSnZepA6saWKyaEtxIi88+apFNBnF3d7CQwAiRUWsVj+3/Hl/l7P/7Vj6Ea8qk5/
         ArLQNRCv3p/p5mrvM9sFVAjlGDCHe79cZjn74igy1Gt7VYbx6HyL7wdIqyohSSg5efWC
         6JtMtQu/sFSAJQufz2JaXPQ8txzwtGyeC95pT/ydCmwdLfhfUPFZmaerD43M8dN/wtXj
         ymUuW3A3/tADzhCxSOqtPHHaV4rzcSn51yrq2X5RyNe+KwynfTatiePOi+n0NEWcPsdT
         LnLg==
X-Gm-Message-State: AOAM530oDZFIn0hgCPaVOCzDxjJoheJpmiZpJNLuUaV+Xh4txPgdFobl
        lGd+tTyhWnONsE9kfLyv8chrWNdZrYoztQKq54zC52l9zojWBqYkIPbrHizESDWXndjvGEosSV4
        SdryDbjPNKqwxPfjnJV32C6p4+miDIaf94R8mQM3hCVm/vu088naLzt1uiXXLTCc0vdhPWWKzMS
        nP
X-Google-Smtp-Source: ABdhPJzMCGtl/U78KiOh+n5hL85TfmD48JC9kQKfXbwuXPKAlbgA94nyZ0eshDFsY/4HO7UOoEsRQFzKJ3DJ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:c7cd:: with SMTP id
 w196mr25006698ybe.265.1600139068585; Mon, 14 Sep 2020 20:04:28 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:04:19 +0800
Message-Id: <20200915110347.Bluez.v3.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH v3] device: don't wait for timeout if RemoveDevice is called
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

RemoveDevice on adapter interface used to remove a device, even when
the device is connected. However, since the introduction of the new
30 seconds timeout when setting a device as temporary, RemoveDevice
doesn't immediately remove a connected device, but only disconnects
it and waits for the timer to expire before effectively removes it.

This patch removes the device as soon as it gets disconnected,
provided the disconnection is triggered by a call to RemoveDevice.
The regular timeout still applies for other cases.

Tested manually by calling RemoveDevice on a connected device,
and with ChromeOS autotest setup.

Reviewed-by: Daniel Winkler <danielwinkler@google.com>
---

Changes in v3:
* Rebasing again

Changes in v2:
* Rebasing to HEAD

 src/adapter.c |  2 --
 src/adapter.h |  2 ++
 src/device.c  | 11 +++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index df628a7fd..4e27bd74b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -80,8 +80,6 @@
 #include "adv_monitor.h"
 #include "eir.h"
 
-#define ADAPTER_INTERFACE	"org.bluez.Adapter1"
-
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
 #define MODE_DISCOVERABLE	0x02
diff --git a/src/adapter.h b/src/adapter.h
index c70a7b0da..2f1e4b737 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -29,6 +29,8 @@
 #include <lib/bluetooth.h>
 #include <lib/sdp.h>
 
+#define ADAPTER_INTERFACE	"org.bluez.Adapter1"
+
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
diff --git a/src/device.c b/src/device.c
index 8f73ce4d3..3e7784034 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3007,6 +3007,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
 	DBusMessage *reply;
+	bool remove_device = false;
 
 	if (!state->connected)
 		return;
@@ -3036,6 +3037,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	while (device->disconnects) {
 		DBusMessage *msg = device->disconnects->data;
 
+		if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
+								"RemoveDevice"))
+			remove_device = true;
+
 		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 		device->disconnects = g_slist_remove(device->disconnects, msg);
 		dbus_message_unref(msg);
@@ -3061,6 +3066,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
+
+	if (remove_device)
+		btd_adapter_remove_device(device->adapter, device);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -4482,6 +4490,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 		disconnect_all(device);
 	}
 
+	if (device->temporary_timer > 0)
+		g_source_remove(device->temporary_timer);
+
 	if (device->store_id > 0) {
 		g_source_remove(device->store_id);
 		device->store_id = 0;
-- 
2.28.0.618.gf4bc123cb7-goog

