Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30853C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 03:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A3F206FA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 03:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="S34esk/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIADhy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIADhy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 23:37:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D5C0612FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 20:37:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e1so11647764ybk.14
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 20:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LNBYe2bPyaTncbo6rNP7apjWhIf3bf+Cen1nymRRMqE=;
        b=S34esk/XXEqYkNMO5Z8LKXgKO+IfTlyQbdTO18FGw38ofniNtAH/uDm/HDMPzOQreh
         /fDUjeTWeQcx+y4UQf7Ap51cm0fOqG47FjMhj+eykdHNMMzP+u1WM2cmosEFcNNLC79B
         f+lEglZ8H4/WFK1np6AYLITIeaMQ60ZUx+WzsLe7/8XqygDJpKOreBX57Pq2jb/1olL6
         CysBrI8Lb5274TGrFrk8otq8Ibrd9k74EKM28pPJtkhVtPC5hykdB5w1hj1Zl5/hhNOh
         IE9LMBTlm5TRZHvCO1djigo46c0/iQy1jINUEeQed2URJl9N29P1u+ItMJG4TSnFJU80
         f/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LNBYe2bPyaTncbo6rNP7apjWhIf3bf+Cen1nymRRMqE=;
        b=DAn7xw26OaGR4/i05ipQmfqNEAc0e5yY4fYGzllOq5mTbwO5HxuapET4eyO/QuoDjj
         27exc4L9w251h7xRJS2lMkmAbPK6T+eCjrfkAEUpogd7Op4dKYXs02h0k+mz5MKr6Qf7
         eJkxFsJrElcE2i0y+6xJBcCP4/KYr3GmcxkoGkeyuNpTZrs+ypgTz9ozxDiB2tRsBB8i
         +/VakrQxJKlGYf+fwd1h8h2FDWYbGJUjpxxIkfktClMpIgpSuh6lrj7j2zbRJtpCNy8I
         Ehr9BOGW+1XUSynfQWdqt4xUHN+oVtLHXKKl40Fx7qggVpXYt0xl40kO77EPQGFUz6op
         pBHg==
X-Gm-Message-State: AOAM532iicwj77s4MZqyzBdH3Bv4bTSgV3MM3vNk8EnT2DWK7xAmaus9
        Y5Zyf17731t0nbIsBurfoSOe8zw2ZeRQZrkTeiFZROfvxC8SXZzw2JHEio2if9oee6Vb1RhdWto
        U3ZswPHHxkC+40HJRXdZiWjwZg/RRONym7sAvu7UYO2hwWaQ3ygnGZ87RB1zJxh95cowdj/XI/Q
        y4
X-Google-Smtp-Source: ABdhPJxG/BTV1qfGQR/fDv0zawJgXU71zmZqzm9s2P3vzwO195rqeP0d3PsrDB+ZS97wu+/59mlxibpLdC7u
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a05:6902:1026:: with SMTP id
 x6mr7708269ybt.349.1598931473141; Mon, 31 Aug 2020 20:37:53 -0700 (PDT)
Date:   Tue,  1 Sep 2020 11:37:46 +0800
Message-Id: <20200901113736.Bluez.v2.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v2] device: don't wait for timeout if RemoveDevice is called
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

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v2:
* Rebasing to HEAD

 src/adapter.c |  2 --
 src/adapter.h |  2 ++
 src/device.c  | 11 +++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1435e2bd7..ffd05aa0b 100644
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
index df440ce09..f20270017 100644
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
@@ -4477,6 +4485,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
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

