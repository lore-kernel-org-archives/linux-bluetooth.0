Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82486C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 01:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCKBMY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 20:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCKBMX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 20:12:23 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56F14ACF5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 17:12:22 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3EFC43F5C0;
        Sat, 11 Mar 2023 02:12:19 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH BlueZ] audio/transport: Propagate errors from avrcp_set_volume to DBus
Date:   Sat, 11 Mar 2023 02:12:02 +0100
Message-Id: <20230311011202.486271-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Any error while setting absolute volume on the peer, or notifying the
peer of changes was previously going completely unnoticed.  Propagate it
to the logs and back to the DBus "Volume" property setter so that they
aren't misled into thinking that the AVRCP command succeeded.

Note that an error is mostly harmless when the setter of the property is
an audio sink and the peer the audio source: in this case we're only
_notifying_ the peer of the change when it has already been applied on
the sink.

Also improve the other two error messages to more closely describe what
was "invalid" about the argument.
---
 profiles/audio/transport.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 457590746..2f5be8e32 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -734,15 +734,22 @@ static void set_volume(const GDBusPropertyTable *property,
 	uint16_t arg;
 	int8_t volume;
 	bool notify;
+	int err;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
-		goto error;
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected UINT16");
+		return;
+	}
 
 	dbus_message_iter_get_basic(iter, &arg);
-	if (arg > INT8_MAX)
-		goto error;
-
-	g_dbus_pending_property_success(id);
+	if (arg > INT8_MAX) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Volume must not be larger than 127");
+		return;
+	}
 
 	volume = (int8_t)arg;
 	if (a2dp->volume == volume)
@@ -757,12 +764,17 @@ static void set_volume(const GDBusPropertyTable *property,
 						"Volume");
 	}
 
-	avrcp_set_volume(transport->device, volume, notify);
-	return;
+	err = avrcp_set_volume(transport->device, volume, notify);
+	if (err) {
+		error("avrcp_set_volume returned %s (%d)", strerror(-err), err);
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".Failed",
+				"Internal error %s (%d)",
+				strerror(-err), err);
+		return;
+	}
 
-error:
-	g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
+	g_dbus_pending_property_success(id);
 }
 
 static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
-- 
2.39.2

