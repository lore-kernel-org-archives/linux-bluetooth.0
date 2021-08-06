Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2BDC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F156113B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhHFXto (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 19:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhHFXto (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 19:49:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A45C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 16:49:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z3so9180370plg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAgDoDmNzfA4A8Ci/GzHIJWsO3tfeeOX/9c+QEbEDbg=;
        b=jeHbK0nyHCw84WdIqWOEe0VppbLvy0d3nl58wWkhObVGOq6jcyll6F8NASsaVNtxVH
         W/ae1UUL0PTrn8V+7bUpyhd7FMVMil4E5mr8KCOafDTd1m2IADb8S7QCklJETogybxOT
         BCz69w69XLZQyto75ddxAfCw/f/9PJO89RgPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAgDoDmNzfA4A8Ci/GzHIJWsO3tfeeOX/9c+QEbEDbg=;
        b=JQ4a6cpHzCwwFApwHbxxZ6du5hUPm1OwFL+6Ajg1wB5G3upiy4O3o1mRWejKG3iMoR
         DcDEMjYZh/kx0DHaax2hSHCC8us8AuMgkHiAn3MUxdtm6nQPDSYXWp6HNnXP03jE3qUm
         /KWZ80zn55ztailmz0CsTVBT6O/f72Uveg7FW6ZCiQj8rOg7xixXRoHKUADadia3dbub
         vnpsidLklIqDmEuoPjB8D650yGJGEtAcqxhnMj2C2qzwj/a29XU8UdtpoCbR809alFVX
         7e2ChFrFKBbCE8fyNFw2rXb3JuaqDYxWlBWz+ip+1ulJG0yOqQxlN8WW2NtQJQQXVZpm
         03NQ==
X-Gm-Message-State: AOAM533SVSrUXE9QquH3cFfX8IPp1vCrcjpoU0CDsqNWkfjhkjgjO288
        oxg1lO547sFGhH8kNo+f/OjWhK7hV2ZmlQ==
X-Google-Smtp-Source: ABdhPJxwAygqG4KY3XvpSXGvTaBv+zGpPcZsnBI1QVXRUzIBlHrQ7UBArDHopp26MG3mDO9L7QpYAQ==
X-Received: by 2002:a62:164f:0:b029:3a9:d265:e413 with SMTP id 76-20020a62164f0000b02903a9d265e413mr7318791pfw.8.1628293766953;
        Fri, 06 Aug 2021 16:49:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:48a2:9887:4da1:32a4])
        by smtp.gmail.com with UTF8SMTPSA id nm19sm13908710pjb.27.2021.08.06.16.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 16:49:26 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 3/4] device: Include detailed error string in Connect() return
Date:   Fri,  6 Aug 2021 16:47:24 -0700
Message-Id: <20210806164624.BlueZ.v5.3.Idd761b9b9f4620480db8889e7885a17952c2c13a@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806234720.286157-1-mcchou@chromium.org>
References: <20210806234720.286157-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This replaces generic strerror message with context detailed error
string to better indicate the detailed failure reason so that the D-Bus
clients can optimize their application to work better with BlueZ, e.g.
introducing retry mechanism or building metrics.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

Changes in v5:
- Address the changes from error code to string

 src/device.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/src/device.c b/src/device.c
index df440ce09..d4795dd6a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1608,7 +1608,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 
 	if (device->connect) {
 		DBusMessage *reply = btd_error_failed(device->connect,
-								"Cancelled");
+						ERR_BREDR_CONN_CANCELED);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
@@ -1802,7 +1802,8 @@ done:
 		}
 
 		g_dbus_send_message(dbus_conn,
-				btd_error_failed(dev->connect, strerror(-err)));
+			btd_error_failed(dev->connect,
+					btd_error_bredr_conn_from_errno(err)));
 	} else {
 		/* Start passive SDP discovery to update known services */
 		if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
@@ -2003,10 +2004,12 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 						dbus_message_get_sender(msg));
 
 	if (dev->pending || dev->connect || dev->browse)
-		return btd_error_in_progress(msg);
+		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
 
-	if (!btd_adapter_get_powered(dev->adapter))
-		return btd_error_not_ready(msg);
+	if (!btd_adapter_get_powered(dev->adapter)) {
+		return btd_error_not_ready_str(msg,
+					ERR_BREDR_CONN_ADAPTER_NOT_POWERED);
+	}
 
 	btd_device_set_temporary(dev, false);
 
@@ -2019,10 +2022,12 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 			if (dbus_message_is_method_call(msg, DEVICE_INTERFACE,
 							"Connect") &&
 				find_service_with_state(dev->services,
-						BTD_SERVICE_STATE_CONNECTED))
+						BTD_SERVICE_STATE_CONNECTED)) {
 				return dbus_message_new_method_return(msg);
-			else
-				return btd_error_not_available(msg);
+			} else {
+				return btd_error_not_available_str(msg,
+					ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
+			}
 		}
 
 		goto resolve_services;
@@ -2032,7 +2037,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	if (err < 0) {
 		if (err == -EALREADY)
 			return dbus_message_new_method_return(msg);
-		return btd_error_failed(msg, strerror(-err));
+		return btd_error_failed(msg,
+					btd_error_bredr_conn_from_errno(err));
 	}
 
 	dev->connect = dbus_message_ref(msg);
@@ -2046,8 +2052,10 @@ resolve_services:
 		err = device_browse_sdp(dev, msg);
 	else
 		err = device_browse_gatt(dev, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+	if (err < 0) {
+		return btd_error_failed(msg, bdaddr_type == BDADDR_BREDR ?
+			ERR_BREDR_CONN_SDP_SEARCH : ERR_LE_CONN_GATT_BROWSE);
+	}
 
 	return NULL;
 }
@@ -2157,8 +2165,10 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
 	DBusMessage *reply;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
-							DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
+							DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args_str(msg,
+					ERR_BREDR_CONN_INVALID_ARGUMENTS);
+	}
 
 	uuid = bt_name2string(pattern);
 	reply = connect_profiles(dev, BDADDR_BREDR, msg, uuid);
@@ -2541,7 +2551,10 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 			if (err == 0)
 				goto done;
 		}
-		reply = btd_error_failed(req->msg, strerror(-err));
+		reply = btd_error_failed(req->msg,
+				bdaddr_type == BDADDR_BREDR ?
+				btd_error_bredr_conn_from_errno(err) :
+				btd_error_le_conn_from_errno(err));
 		goto done;
 	}
 
@@ -3027,7 +3040,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	 */
 	if (device->connect) {
 		DBG("connection removed while Connect() is waiting reply");
-		reply = btd_error_failed(device->connect, "Disconnected early");
+		reply = btd_error_failed(device->connect,
+						ERR_BREDR_CONN_CANCELED);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
@@ -5414,7 +5428,7 @@ done:
 	if (device->connect) {
 		if (err < 0)
 			reply = btd_error_failed(device->connect,
-							strerror(-err));
+					btd_error_le_conn_from_errno(err));
 		else
 			reply = dbus_message_new_method_return(device->connect);
 
-- 
2.32.0.605.g8dce9f2422-goog

