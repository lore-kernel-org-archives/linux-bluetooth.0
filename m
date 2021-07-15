Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B011C12002
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02827613CC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhGOBOl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGOBOl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 21:14:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59378C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:11:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cu14so2754124pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEDW9GgxcjnKM5DbyQ4gCDEWGpAfaZad24mH40e9GQ8=;
        b=DFgmUbaDtpkvebz5Tes9m7oQG3f/JOGCpOZ5SOrrTkAKR0QE3tCNoMYfITzL8JicPm
         VJXuTYuBY0r8r+0RkoodIvlF657Eq7k949bvuBC2zHzkOKqBH8AURdjdnR6ceGv5m67t
         9Lej4Q24x67Nz46IW2APo8Kuc+Z4dFeS+T77w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEDW9GgxcjnKM5DbyQ4gCDEWGpAfaZad24mH40e9GQ8=;
        b=UpAEZ9J+6vI4pX2UMF0njgFi9pwUzpW5E0p+a1uomLlnBl5GE8M4KlSDKexM/mtmaT
         5+R6fmec5iYBYWHFZritqF23U3LJvLhsYEgmvjts8IffGyAlXflNP8DhpxvJ+zxDA1Eq
         JZxxz1LtdLIYEYPas0xXrU17AFTlhuBJ+X6DwraBFdsww7ulcrhvDDJps4leSqoCrGl5
         jbponb35Ceznid5a0MbLKLozE19DgP8YYByFbzTTMA4fweSjBmi0qAahpAFjtLX6SX/e
         mjdTzXBdmFSeNnaP2S4goLh/6hSdYSZnlnQfbpVhwSsEJGHovQWnUBbpjUzGWmMuIYMY
         V04Q==
X-Gm-Message-State: AOAM533zIWN+H4YdNiULeO+2FXX1jhI7NeQXByoHqY7MpU0Ma4/Ra7WV
        Ahr3L6lOcvfdwI/yEDW39Y4Ve/XvLHnCpQ==
X-Google-Smtp-Source: ABdhPJwbOTfKLzNPzKT4I08ICuCmqm7U4w4shyfBjnv2kGpbCWoo0rznSZ+D9VURprNKs8qrH0ryOA==
X-Received: by 2002:a17:902:7d83:b029:11d:75c2:79a6 with SMTP id a3-20020a1709027d83b029011d75c279a6mr703374plm.62.1626311507597;
        Wed, 14 Jul 2021 18:11:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:20b7:5dcc:d530:a8df])
        by smtp.gmail.com with UTF8SMTPSA id e16sm4680341pgl.54.2021.07.14.18.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 18:11:47 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 3/4] device: Include BtdError code in Connect() return
Date:   Wed, 14 Jul 2021 18:09:54 -0700
Message-Id: <20210714180917.BlueZ.v3.3.Idd761b9b9f4620480db8889e7885a17952c2c13a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210715010951.963176-1-mcchou@chromium.org>
References: <20210715010951.963176-1-mcchou@chromium.org>
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

