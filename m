Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082AEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E474161166
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhIUQv0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhIUQv0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 12:51:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6B3C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:49:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so2429565pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRXvFilc8lwgq6QPf0tPcFU77zb4bdVFTnUqWSbeJ/k=;
        b=eAkS+AA3FXQk0p2eG0TzIB41ILq71Wl2GYDmLaBWySwjSZIE97D7qSiwiPpS/nabNz
         Kb2Z9n1iGpiftS8mrNpJnzAbKyfXKeY6p7yd50Ox/qvOIl3VQoYV1WwcSfirtC6fZFc7
         G0uWtsTjoUjeN0njpcXBI66ERlezJ6TxdZT/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRXvFilc8lwgq6QPf0tPcFU77zb4bdVFTnUqWSbeJ/k=;
        b=J09ncgt1617KveHwYGURVe3z3mD0spfMSsVg/tkQ760Lg5EVugK0MNWb00je3ytTwM
         JTFnNoxveGiQjM71awMKRY8kwz2Cq46oTJSLtQnjDLub7pYd8grP9UHCer5ITNUJU1Mi
         QVnN6iWvLfaTRMC0VqDlZHskmuIPJr+1QXfxCSL6m1CAM0pKNvglbbhM+yP8LdWfUsfL
         K0WpfKGA8ZAZIKA0tepneg4jFoF/YSXO2nfYZ6xEXv+xp80HJl79dCvTmu2NrNI72/aW
         CMSlc8eh5jCx2zaGSTbGBwsXH0yEp6GIPLupdG8eLBTWJoikmiPzDFeFwBxD8m3utb94
         XqnQ==
X-Gm-Message-State: AOAM532CZTO9MgIQZwjaWe7+J4sjLmnoGl1EtSy5YKNe+Dj+6vJZd7yX
        JsMsgExhBRx3/VnSfO1YtVhIcq247vUWNg==
X-Google-Smtp-Source: ABdhPJwttFn/AP1H8EwZbfLwjln01/M6RBwWfzdLv/pvbWeBiza678L6feg9sUiYSkQLIwWlmzBQbQ==
X-Received: by 2002:a17:90a:1b2a:: with SMTP id q39mr6369224pjq.219.1632242996925;
        Tue, 21 Sep 2021 09:49:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:db3:f19e:7f67:74f])
        by smtp.gmail.com with UTF8SMTPSA id u16sm18021056pfn.68.2021.09.21.09.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 09:49:56 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 3/4] device: Include detailed error string in Connect() return
Date:   Tue, 21 Sep 2021 09:47:09 -0700
Message-Id: <20210921094400.BlueZ.v6.3.Idd761b9b9f4620480db8889e7885a17952c2c13a@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
In-Reply-To: <20210921164708.1497029-1-mcchou@chromium.org>
References: <20210921164708.1497029-1-mcchou@chromium.org>
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
2.33.0.464.g1972c5931b-goog

