Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F20FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8458461881
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbhI3Wlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbhI3Wlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 18:41:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC2C06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:40:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so7645162pgr.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VyUR7d30EIw3pm2R8uPCDjdAE0eBCZ4IJjyqGZIsN0=;
        b=HAtAMPFgkXHBcrKDLR6e8FaKH/DssOme/MEIm+RE3IpAVTDSAHc5sfd5f5pJB1jaHg
         vPucixhijbL9LqFikIVkxq5TyS9ivDNnVB6m9e5h+ywbPxzq1XqXXOO7ydnMy/fuHx0v
         M0MVnDauL66cARrz2BOw+BHy0cT/9A7p6hCRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VyUR7d30EIw3pm2R8uPCDjdAE0eBCZ4IJjyqGZIsN0=;
        b=BVffoR0rpZQiHEv9zHbdiqIaEgrdVUxr9At4A8skw27iAaFQdVgGARWPLkjqexsZeA
         ThyypAAwk0++1SmGBLF3wLlMB02J9LLCHGy95sxIeZjlCtZMf9UrZXjjDegTZKhWWPid
         WoDQJLa6ujsqiOUam9zYTVxOXBbiOEOxkinPygH3DCWWCK2WVmCoFiqifBCyyrUWf/Bd
         qeCxhC393fQFKsStLZ7KrvE290BfxOWMy9OtAGLwgcQAO85h2buDeUTbPtexbMb9iEW/
         E9rVwkAJQ/wduFL3YHY/r6AscvORlJRkOGqoTosU1wiEWjg+VXtqhTIgLjjEBcW/LPj/
         mxww==
X-Gm-Message-State: AOAM531OoRxySueTY/A508rMHm+yOtQLQhAQ3bK1NcdWVNhPh4/8sjOD
        fdbuarydYmiK2ZG2y4nCdcdBNu5DUyaPvg==
X-Google-Smtp-Source: ABdhPJw8rA+QU83NWK4qm0DC8cpTgZFQ+soHu55gwxAYFyxbRGftGgAurLcxvcUOCq7RhXhIrtPn5Q==
X-Received: by 2002:aa7:92d2:0:b0:44b:566e:ec5 with SMTP id k18-20020aa792d2000000b0044b566e0ec5mr6653017pfa.30.1633041601238;
        Thu, 30 Sep 2021 15:40:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb71:bb5c:56a6:693f])
        by smtp.gmail.com with UTF8SMTPSA id g22sm4999328pfj.15.2021.09.30.15.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 15:40:00 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 3/4] device: Include detailed error string in Connect() return
Date:   Thu, 30 Sep 2021 15:37:28 -0700
Message-Id: <20210930153703.BlueZ.v7.3.Idd761b9b9f4620480db8889e7885a17952c2c13a@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930223726.2886139-1-mcchou@chromium.org>
References: <20210930223726.2886139-1-mcchou@chromium.org>
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

(no changes since v5)

Changes in v5:
- Address the changes from error code to string

 src/device.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/src/device.c b/src/device.c
index b29aa195d..230274ee1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1605,7 +1605,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 
 	if (device->connect) {
 		DBusMessage *reply = btd_error_failed(device->connect,
-								"Cancelled");
+						ERR_BREDR_CONN_CANCELED);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
@@ -1799,7 +1799,8 @@ done:
 		}
 
 		g_dbus_send_message(dbus_conn,
-				btd_error_failed(dev->connect, strerror(-err)));
+			btd_error_failed(dev->connect,
+					btd_error_bredr_conn_from_errno(err)));
 	} else {
 		/* Start passive SDP discovery to update known services */
 		if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
@@ -2000,10 +2001,12 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
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
 
@@ -2016,10 +2019,12 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
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
@@ -2029,7 +2034,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	if (err < 0) {
 		if (err == -EALREADY)
 			return dbus_message_new_method_return(msg);
-		return btd_error_failed(msg, strerror(-err));
+		return btd_error_failed(msg,
+					btd_error_bredr_conn_from_errno(err));
 	}
 
 	dev->connect = dbus_message_ref(msg);
@@ -2043,8 +2049,10 @@ resolve_services:
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
@@ -2154,8 +2162,10 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
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
@@ -2538,7 +2548,10 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
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
 
@@ -3030,7 +3043,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	 */
 	if (device->connect) {
 		DBG("connection removed while Connect() is waiting reply");
-		reply = btd_error_failed(device->connect, "Disconnected early");
+		reply = btd_error_failed(device->connect,
+						ERR_BREDR_CONN_CANCELED);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
@@ -5454,7 +5468,7 @@ done:
 	if (device->connect) {
 		if (err < 0)
 			reply = btd_error_failed(device->connect,
-							strerror(-err));
+					btd_error_le_conn_from_errno(err));
 		else
 			reply = dbus_message_new_method_return(device->connect);
 
-- 
2.33.0.800.g4c38ced690-goog

