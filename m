Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D93C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097FC6186A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFZFZH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 01:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFZFZF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 01:25:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF0EC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:22:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u14so3549349pga.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEDW9GgxcjnKM5DbyQ4gCDEWGpAfaZad24mH40e9GQ8=;
        b=KwOliyLK8Ci+rOawaF+eYzZ18cmD1P6/m0KC86Qo5n7BXi95ZhtLJZr1yQhUkITGq/
         JsTVU3SNz7P0vjN0ZiX8dBZGCBiK3P7vl9FLTcJ64SIlToJ8nOnrX1GhPMdOWodNzaO5
         +VSc5MtXpTdEGEz5wHuvCBYuYGt1M3PInOkts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEDW9GgxcjnKM5DbyQ4gCDEWGpAfaZad24mH40e9GQ8=;
        b=bJqiP185OV0ZhJ1umAcW4mc48Jp66I+diIxd/Mtz943fPLvRKjwFkxUfGFtu9H10E3
         Nb3ElI4iOZN6LGD4XEG5Sci4acoc8MJ82W/mkcdPucnwfX/xv87GZwWrd8nZeE59LHlu
         gIQCkpDV5YsT5sYIDONnfuiLDa7Og0oB4IyZdo1LHZ6JdDkRqX3qOf4R78cqDh4V+UKH
         F11JWa9ZYIuVpWoNnwVIF8rxjuva2zoFSqnjsPUQcpDiTDYInB+Q80y27YiBT0fFGXAY
         vo0ABcCe8MCZMjnY/Beh8oYmGDA6ynTVLI6cRW4WOoRjiD8whQI2I7r/MsEmA1EwsctE
         4ltg==
X-Gm-Message-State: AOAM533mySr7hLEb7xllrm7VN/3ejpTYeCxcw06EziJlPjoVcBIGVcUN
        Q+MpgGc3Hk+3S0+UPODm+eKwZ4ZNgsRmSA==
X-Google-Smtp-Source: ABdhPJxHkkCJjwMRHAylry482rB7QzMwtykuOoQ03krrXDn5TqVM2vQxadYuHpLgl3zcNx42V/A3aw==
X-Received: by 2002:aa7:9695:0:b029:304:95f8:8f6b with SMTP id f21-20020aa796950000b029030495f88f6bmr14258637pfk.28.1624684962605;
        Fri, 25 Jun 2021 22:22:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:be2:cfe5:893:108f])
        by smtp.gmail.com with UTF8SMTPSA id m13sm1517539pfc.119.2021.06.25.22.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 22:22:42 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 2/3] device: Include BtdError code in Connect() return
Date:   Fri, 25 Jun 2021 22:21:53 -0700
Message-Id: <20210625222111.BlueZ.v2.2.Idd761b9b9f4620480db8889e7885a17952c2c13a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210626052152.2543526-1-mcchou@chromium.org>
References: <20210626052152.2543526-1-mcchou@chromium.org>
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

(no changes since v1)

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
2.32.0.93.g670b81a890-goog

