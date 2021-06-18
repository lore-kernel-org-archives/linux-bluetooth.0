Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3668EC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19056613B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 00:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhFRATa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhFRATa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 20:19:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 17:17:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 69so3792227plc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 17:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiJR3YjCUSEUCdAl6YeU1HOIiffi0akjmAu9i2hhBpQ=;
        b=B7PUk4tmmAl++V8G2hbvji6U2vLguU4rjJPEWkUA8Yci6pe00eUfsIIoyD08o8mNhO
         uUY0gyDTkkbmjqmJIApCEsG33rJr249tZqHLX64fzzYze10SNjLmx7ucR3YS1an8Hxqs
         z1zR+GJGOClr8/GKdLWFsAs0lOKJeJWlsWLWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiJR3YjCUSEUCdAl6YeU1HOIiffi0akjmAu9i2hhBpQ=;
        b=ShNzYsHjGWE4Pg5YvdXeazWHnS7bqlENZ0WQOlSFLdtHUXgGZ23otX57rUznWrzc0s
         kTkgZjYnqYn2IleE3tJEqMvkUNeVa5TecUntKYcd0U6WGS9ZtiWo0WSQveGKyTWpU+vP
         kEgfdxrZvFzeuBkdE8XpVDMC563zYLOj6eLkhf5I/neOHVJYwglPcJyxkLQJHynNm7ts
         gyc0ep6ld6/YAX23bf1l8o9y5/rClyTwsKBvwm/SvgNR81Jry4z6YRZ7I2QGGGgrsbB+
         dOJidxChYTL7ewCk+PS1HRrwpsaJ0NIhbRQNLdnbxbSwbzKkMw/RGYDeVAMjffDCBqQn
         fOdA==
X-Gm-Message-State: AOAM530v0B48PcnWCHpoD63As82gekQeqI9O+gmk+pmcJMuxmXalwD8e
        PP6LhkTBrzTmx/xllj4TFAEc0HrCjdeuyA==
X-Google-Smtp-Source: ABdhPJwTbBO1z1cZbGji3RaZoSKc3lm0w5K49xUBqCVvCJ8AqCupUcCykHJYAiMHTIzLvSj+TKlgfA==
X-Received: by 2002:a17:902:6b82:b029:120:3404:ce99 with SMTP id p2-20020a1709026b82b02901203404ce99mr2286390plk.49.1623975441397;
        Thu, 17 Jun 2021 17:17:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d75:da94:7930:935d])
        by smtp.gmail.com with UTF8SMTPSA id z9sm6256096pfc.101.2021.06.17.17.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 17:17:20 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1 2/3] device: Include BtdError code in Connect() return
Date:   Thu, 17 Jun 2021 17:16:00 -0700
Message-Id: <20210617170013.BlueZ.v1.2.Idd761b9b9f4620480db8889e7885a17952c2c13a@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618001559.1284204-1-mcchou@chromium.org>
References: <20210618001559.1284204-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This replaces generic strerror message with context specific BtdError
code to better indicate the detailed failure reason so that the D-Bus
clients can optimize their application to work better with BlueZ, e.g.
introducing retry mechanism or building metrics.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

 src/device.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/src/device.c b/src/device.c
index df440ce09..c9dc616a2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1607,8 +1607,8 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	}
 
 	if (device->connect) {
-		DBusMessage *reply = btd_error_failed(device->connect,
-								"Cancelled");
+		DBusMessage *reply = btd_error_failed_err(device->connect,
+						BTD_ERR_BREDR_CONN_CANCELED);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
@@ -1802,7 +1802,8 @@ done:
 		}
 
 		g_dbus_send_message(dbus_conn,
-				btd_error_failed(dev->connect, strerror(-err)));
+			btd_error_failed_err(dev->connect,
+					btd_error_bredr_conn_from_errno(err)));
 	} else {
 		/* Start passive SDP discovery to update known services */
 		if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
@@ -2003,10 +2004,12 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 						dbus_message_get_sender(msg));
 
 	if (dev->pending || dev->connect || dev->browse)
-		return btd_error_in_progress(msg);
+		return btd_error_in_progress_err(msg, BTD_ERR_BREDR_CONN_BUSY);
 
-	if (!btd_adapter_get_powered(dev->adapter))
-		return btd_error_not_ready(msg);
+	if (!btd_adapter_get_powered(dev->adapter)) {
+		return btd_error_not_ready_err(msg,
+					BTD_ERR_BREDR_CONN_ADAPTER_NOT_POWERED);
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
+				return btd_error_not_available_err(msg,
+					BTD_ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
+			}
 		}
 
 		goto resolve_services;
@@ -2032,7 +2037,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	if (err < 0) {
 		if (err == -EALREADY)
 			return dbus_message_new_method_return(msg);
-		return btd_error_failed(msg, strerror(-err));
+		return btd_error_failed_err(msg,
+					btd_error_bredr_conn_from_errno(err));
 	}
 
 	dev->connect = dbus_message_ref(msg);
@@ -2046,8 +2052,11 @@ resolve_services:
 		err = device_browse_sdp(dev, msg);
 	else
 		err = device_browse_gatt(dev, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+	if (err < 0) {
+		return btd_error_failed_err(msg, bdaddr_type == BDADDR_BREDR ?
+			BTD_ERR_BREDR_CONN_SDP_SEARCH :
+			BTD_ERR_LE_CONN_GATT_BROWSE);
+	}
 
 	return NULL;
 }
@@ -2157,8 +2166,10 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
 	DBusMessage *reply;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
-							DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
+							DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args_err(msg,
+					BTD_ERR_BREDR_CONN_INVALID_ARGUMENTS);
+	}
 
 	uuid = bt_name2string(pattern);
 	reply = connect_profiles(dev, BDADDR_BREDR, msg, uuid);
@@ -2541,7 +2552,11 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 			if (err == 0)
 				goto done;
 		}
-		reply = btd_error_failed(req->msg, strerror(-err));
+		reply = (bdaddr_type == BDADDR_BREDR ?
+				btd_error_failed_err(req->msg,
+					btd_error_bredr_conn_from_errno(err)) :
+				btd_error_failed_err(req->msg,
+					btd_error_le_conn_from_errno(err)));
 		goto done;
 	}
 
@@ -3027,7 +3042,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	 */
 	if (device->connect) {
 		DBG("connection removed while Connect() is waiting reply");
-		reply = btd_error_failed(device->connect, "Disconnected early");
+		reply = btd_error_failed_err(device->connect,
+						BTD_ERR_BREDR_CONN_CANCELED);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
@@ -5413,8 +5429,8 @@ done:
 
 	if (device->connect) {
 		if (err < 0)
-			reply = btd_error_failed(device->connect,
-							strerror(-err));
+			reply = btd_error_failed_err(device->connect,
+					btd_error_le_conn_from_errno(err));
 		else
 			reply = dbus_message_new_method_return(device->connect);
 
-- 
2.32.0.288.g62a8d224e6-goog

