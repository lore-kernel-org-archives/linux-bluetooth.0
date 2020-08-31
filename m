Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D65C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7AB20BED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 08:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TddfAqZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHaIMs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaIMo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 04:12:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA30C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 01:12:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a14so8412722ybm.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jttsDn9iolcivEGMZxCfWYyrBybAzZ7cJMXs3BjjCw0=;
        b=TddfAqZS24wLeYRdxoRHzTL1sz3nmpQz2cQ7Sq0arJ8iX6lnHAyt6mNlusW43yhtKd
         CtQQCWtxHFGlzliCDMSBTMGX1gmnGH+NTwXH0bbZd9/vUoTy2t0xDj3KNsi4yK/CQ8ad
         I+aY7W2M12QjRbbrzDwyxqQ5qSan2PmKYvH+HOMdpfNbyVJJfoqMrJAhlAanER2c+fl3
         o/52JUy6mpy1jaVvGgf4Z5Kt1ip4SUtBsitApKFv5xwzPF5ZRvH4v8leidRx44Bm6b3Z
         R97l/4x0NxCW/IhuybO9WL/LCrzuR2m39vspEgNaFaYDhTHNNQDmLIl27nbGhxATgcOM
         cANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jttsDn9iolcivEGMZxCfWYyrBybAzZ7cJMXs3BjjCw0=;
        b=ai7eUGVz0jJ/XRFUYWSg2ybyGE3GDslKVXLL1/HwHSUfquv0l6LXuqduxD2JL79NjC
         Lf1z9s+AiqvpYEYQ79800Q89qUUC80Hs9vzjC2gHKNV+Cr4Sx6wFe9IhE9WZOSzUrdrv
         +DlrF75Nr2fjIG7DKhKuWfe2PH/vfOpGXnISJ19CJzT1fqr3RgaHTdQ76Fs19nbPZl/E
         G/bRiFUmrabuha+ldx7FsWClVA7YMImrILE/2rwOr2fMAMl1eBpeCcaqcPXtrtfSqYu6
         IBIPCt5CRY7y0hkO8jI7PGTPo6ZVnlDXiG3OwUFkKgxqpq23stNSq4GOw8zaUlsu74j3
         zp+g==
X-Gm-Message-State: AOAM531o81kjkta6dSrjTVv4C4/NwIef/38WDw9f6Y52aZV/xKnhfESR
        dDrXrdAvBJxUGHsz5O0lFG5IoFth5K7YCnACc1VZEHZFHd6HxHkBgDlhfR1HN5YoGKi7oOBXFlM
        I11vk76l414m/94G5PXrSxX4UC0nWOZUvMYf1DcR+4hSUyM9aBYS7sMXm9p0m/t6U0m7OaE5t47
        uv
X-Google-Smtp-Source: ABdhPJzxqXE7NTI0SgpDqGuHsvQmWH5j9T7SQYU0P7OBzwXjMadPshFHGrrnD/s+R2rYq1RSgYS6qvMa+TvE
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:af05:: with SMTP id
 a5mr611200ybh.411.1598861561527; Mon, 31 Aug 2020 01:12:41 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:12:28 +0800
Message-Id: <20200831161140.Bluez.v1.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v1] device: don't wait for timeout if RemoveDevice is called
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

 src/adapter.c |  2 --
 src/adapter.h |  2 ++
 src/device.c  | 11 +++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..d6c65ff69 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -79,8 +79,6 @@
 #include "advertising.h"
 #include "eir.h"
 
-#define ADAPTER_INTERFACE	"org.bluez.Adapter1"
-
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
 #define MODE_DISCOVERABLE	0x02
diff --git a/src/adapter.h b/src/adapter.h
index f8ac20261..f835c984f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -26,6 +26,8 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 
+#define ADAPTER_INTERFACE	"org.bluez.Adapter1"
+
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
diff --git a/src/device.c b/src/device.c
index bb8e07e8f..cee0ddfd2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3001,6 +3001,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	bool remove_device = false;
 
 	if (!state->connected)
 		return;
@@ -3018,6 +3019,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	while (device->disconnects) {
 		DBusMessage *msg = device->disconnects->data;
 
+		if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
+								"RemoveDevice"))
+			remove_device = true;
+
 		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 		device->disconnects = g_slist_remove(device->disconnects, msg);
 		dbus_message_unref(msg);
@@ -3043,6 +3048,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
+
+	if (remove_device)
+		btd_adapter_remove_device(device->adapter, device);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -4457,6 +4465,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 		disconnect_all(device);
 	}
 
+	if (device->temporary_timer > 0)
+		g_source_remove(device->temporary_timer);
+
 	if (device->store_id > 0) {
 		g_source_remove(device->store_id);
 		device->store_id = 0;
-- 
2.28.0.402.g5ffc5be6b7-goog

