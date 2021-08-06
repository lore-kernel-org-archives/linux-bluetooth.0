Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDFDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C5A6113B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhHFXtX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhHFXtX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 19:49:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4416AC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 16:49:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a20so9253947plm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WOqVoAfj34+t/vHFiodLU5+26NK5uCE6eUgJpHFD/s=;
        b=oBvnF0HxiGdkmjeqU/dwTV0OKtceXaehXuaBw+WjDLtroF6Us53O5cxseSx//9B7kc
         M814mbZMPnUxyF6OoOn/f3ePdYCp4yVZyxl3db7QbRQllCnl2rt0SGECisX+IBA7/z1R
         HoYkA9G2bbhHeHpC628c00jnP1fnSHdU4kmWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WOqVoAfj34+t/vHFiodLU5+26NK5uCE6eUgJpHFD/s=;
        b=XqsdSGYVzq9S2BSvL/C7V3tT105KWS7JtftAkxXvCwPrx5S5YuQTMM/3q20nL0XKjW
         NtOrPZLHiqA2+1OdspUSTLYxd99HtPF5R7hOoOLU0n5bYVZHVQsHLLc5CesPGKfFgaJI
         D8PWAMuUg4JqqoXx99VUzqShAFS60C0tgEKj3EacFjxMWMV11OM3WqOUL5Ozn4KLE/Om
         OLwOTTCaoeOICSboXR3OjaHLKgbyclWlEdtWM1IDkO8nvy0RxYSQJg7NIbfeUavu3jSg
         Iz7GJkscqs1i8SAkXney8U/PSlYwG6vGEWRL3yP6g2bi8YF8wYiwi+cSegZq9sLgdzhb
         JEVA==
X-Gm-Message-State: AOAM532LCr+UE5zTgr0GPSMYorX/GzA4T3geO6s8xIHaokGRWBL54xju
        WwElYOdSPURf6pgYIgA3WujBUrMIt0HFlg==
X-Google-Smtp-Source: ABdhPJyi3v+W3nZz86TIphLsyJan1kVznH/cxcce70m/fBN7VW3HQcEAZT9pm64k7Q8QWg9vv3CGgw==
X-Received: by 2002:a17:902:930b:b029:12c:a7f4:afb2 with SMTP id bc11-20020a170902930bb029012ca7f4afb2mr10989664plb.24.1628293745535;
        Fri, 06 Aug 2021 16:49:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:48a2:9887:4da1:32a4])
        by smtp.gmail.com with UTF8SMTPSA id q21sm2069245pjg.55.2021.08.06.16.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 16:49:05 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 2/4] error: BR/EDR and LE connection failure reasons
Date:   Fri,  6 Aug 2021 16:47:22 -0700
Message-Id: <20210806164624.BlueZ.v5.2.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806234720.286157-1-mcchou@chromium.org>
References: <20210806234720.286157-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The source of Connect() failures can be divided into the following
three.
- bluetoothd's device interface state transition and profile state
  transition
- Kernel's L2CAP layer state transition
- Potential HCI error codes returned by the remote device

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

Changes in v5:
- Replace uint16_t error code with string

Changes in v4:
- Address make errors

Changes in v3:
- Separate error-code.txt into its own commit

Changes in v2:
- Add error-code.txt
- Remove BtdError from return string

 src/error.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/error.h |  59 +++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/src/error.c b/src/error.c
index 89517075e..411f36fcb 100644
--- a/src/error.c
+++ b/src/error.c
@@ -27,6 +27,8 @@
 #include <config.h>
 #endif
 
+#include <error.h>
+#include <stdio.h>
 #include "gdbus/gdbus.h"
 
 #include "error.h"
@@ -79,12 +81,24 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg)
 					"In Progress");
 }
 
+DBusMessage *btd_error_in_progress_str(DBusMessage *msg, const char *str)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
+					"%s", str);
+}
+
 DBusMessage *btd_error_not_available(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
 					"Operation currently not available");
 }
 
+DBusMessage *btd_error_not_available_str(DBusMessage *msg, const char *str)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
+					"%s", str);
+}
+
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
@@ -121,8 +135,94 @@ DBusMessage *btd_error_not_ready(DBusMessage *msg)
 					"Resource Not Ready");
 }
 
+DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady",
+					"%s", str);
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
 					".Failed", "%s", str);
 }
+
+const char* btd_error_bredr_conn_from_errno(int errno_code)
+{
+	switch (-errno_code) {
+	case EALREADY:
+	case EISCONN:
+		return ERR_BREDR_CONN_ALREADY_CONNECTED;
+	case EHOSTDOWN:
+		return ERR_BREDR_CONN_PAGE_TIMEOUT;
+	case ENOPROTOOPT:
+		return ERR_BREDR_CONN_PROFILE_UNAVAILABLE;
+	case EIO:
+		return ERR_BREDR_CONN_CREATE_SOCKET;
+	case EINVAL:
+		return ERR_BREDR_CONN_INVALID_ARGUMENTS;
+	case EHOSTUNREACH:
+		return ERR_BREDR_CONN_ADAPTER_NOT_POWERED;
+	case EOPNOTSUPP:
+	case EPROTONOSUPPORT:
+		return ERR_BREDR_CONN_NOT_SUPPORTED;
+	case EBADFD:
+		return ERR_BREDR_CONN_BAD_SOCKET;
+	case ENOMEM:
+		return ERR_BREDR_CONN_MEMORY_ALLOC;
+	case EBUSY:
+		return ERR_BREDR_CONN_BUSY;
+	case EMLINK:
+		return ERR_BREDR_CONN_CNCR_CONNECT_LIMIT;
+	case ETIMEDOUT:
+		return ERR_BREDR_CONN_TIMEOUT;
+	case ECONNREFUSED:
+		return ERR_BREDR_CONN_REFUSED;
+	case ECONNRESET:
+		return ERR_BREDR_CONN_ABORT_BY_REMOTE;
+	case ECONNABORTED:
+		return ERR_BREDR_CONN_ABORT_BY_LOCAL;
+	case EPROTO:
+		return ERR_BREDR_CONN_LMP_PROTO_ERROR;
+	default:
+		return ERR_BREDR_CONN_UNKNOWN;
+	}
+}
+
+const char* btd_error_le_conn_from_errno(int errno_code)
+{
+	switch (-errno_code) {
+	case EINVAL:
+		return ERR_LE_CONN_INVALID_ARGUMENTS;
+	case EHOSTUNREACH:
+		return ERR_LE_CONN_ADAPTER_NOT_POWERED;
+	case EOPNOTSUPP:
+	case EPROTONOSUPPORT:
+		return ERR_LE_CONN_NOT_SUPPORTED;
+	case EALREADY:
+	case EISCONN:
+		return ERR_LE_CONN_ALREADY_CONNECTED;
+	case EBADFD:
+		return ERR_LE_CONN_BAD_SOCKET;
+	case ENOMEM:
+		return ERR_LE_CONN_MEMORY_ALLOC;
+	case EBUSY:
+		return ERR_LE_CONN_BUSY;
+	case ECONNREFUSED:
+		return ERR_LE_CONN_REFUSED;
+	case EIO:
+		return ERR_LE_CONN_CREATE_SOCKET;
+	case ETIMEDOUT:
+		return ERR_LE_CONN_TIMEOUT;
+	case EMLINK:
+		return ERR_LE_CONN_SYNC_CONNECT_LIMIT;
+	case ECONNRESET:
+		return ERR_LE_CONN_ABORT_BY_REMOTE;
+	case ECONNABORTED:
+		return ERR_LE_CONN_ABORT_BY_LOCAL;
+	case EPROTO:
+		return ERR_LE_CONN_LL_PROTO_ERROR;
+	default:
+		return ERR_LE_CONN_UNKNOWN;
+	}
+}
diff --git a/src/error.h b/src/error.h
index 7c8cad066..91a02654a 100644
--- a/src/error.h
+++ b/src/error.h
@@ -24,9 +24,62 @@
  */
 
 #include <dbus/dbus.h>
+#include <stdint.h>
 
 #define ERROR_INTERFACE "org.bluez.Error"
 
+/* BR/EDR connection failure reasons */
+#define ERR_BREDR_CONN_ALREADY_CONNECTED	"BR/EDR connection already "\
+						"connected"
+#define ERR_BREDR_CONN_PAGE_TIMEOUT		"BR/EDR connection page timeout"
+#define ERR_BREDR_CONN_PROFILE_UNAVAILABLE	"BR/EDR connection profile "\
+						"unavailable"
+#define ERR_BREDR_CONN_SDP_SEARCH		"BR/EDR connection SDP search"
+#define ERR_BREDR_CONN_CREATE_SOCKET		"BR/EDR connection create "\
+						"socket"
+#define ERR_BREDR_CONN_INVALID_ARGUMENTS	"BR/EDR connection invalid "\
+						"argument"
+#define ERR_BREDR_CONN_ADAPTER_NOT_POWERED	"BR/EDR connection adapter "\
+						"not powered"
+#define ERR_BREDR_CONN_NOT_SUPPORTED		"BR/EDR connection not "\
+						"suuported"
+#define ERR_BREDR_CONN_BAD_SOCKET		"BR/EDR connection bad socket"
+#define ERR_BREDR_CONN_MEMORY_ALLOC		"BR/EDR connection memory "\
+						"allocation"
+#define ERR_BREDR_CONN_BUSY			"BR/EDR connection busy"
+#define ERR_BREDR_CONN_CNCR_CONNECT_LIMIT	"BR/EDR connection concurrent "\
+						"connection limit"
+#define ERR_BREDR_CONN_TIMEOUT			"BR/EDR connection timeout"
+#define ERR_BREDR_CONN_REFUSED			"BR/EDR connection refused"
+#define ERR_BREDR_CONN_ABORT_BY_REMOTE		"BR/EDR connection aborted by "\
+						"remote"
+#define ERR_BREDR_CONN_ABORT_BY_LOCAL		"BR/EDR connection aborted by "\
+						"local"
+#define ERR_BREDR_CONN_LMP_PROTO_ERROR		"BR/EDR connection LMP "\
+						"protocol error"
+#define ERR_BREDR_CONN_CANCELED			"BR/EDR connection canceled"
+#define ERR_BREDR_CONN_UNKNOWN			"BR/EDR connection unknown"
+
+/* LE connection failure reasons */
+#define ERR_LE_CONN_INVALID_ARGUMENTS	"LE connection invalid arguments"
+#define ERR_LE_CONN_ADAPTER_NOT_POWERED	"LE connection adapter not powered"
+#define ERR_LE_CONN_NOT_SUPPORTED	"LE connection not supported"
+#define ERR_LE_CONN_ALREADY_CONNECTED	"LE connection already connected"
+#define ERR_LE_CONN_BAD_SOCKET		"LE connection bad socket"
+#define ERR_LE_CONN_MEMORY_ALLOC	"LE connection memory allocation"
+#define ERR_LE_CONN_BUSY		"LE connection busy"
+#define ERR_LE_CONN_REFUSED		"LE connection refused"
+#define ERR_LE_CONN_CREATE_SOCKET	"LE connection create socket"
+#define ERR_LE_CONN_TIMEOUT		"LE connection timeout"
+#define ERR_LE_CONN_SYNC_CONNECT_LIMIT	"LE connection concurrent connection "\
+					"limit"
+#define ERR_LE_CONN_ABORT_BY_REMOTE	"LE connection abort by remote"
+#define ERR_LE_CONN_ABORT_BY_LOCAL	"LE connection abort by local"
+#define ERR_LE_CONN_LL_PROTO_ERROR	"LE connection link layer protocol "\
+					"error"
+#define ERR_LE_CONN_GATT_BROWSE		"LE connection GATT browsing"
+#define ERR_LE_CONN_UNKNOWN		"LE connection unknown"
+
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_busy(DBusMessage *msg);
@@ -35,11 +88,17 @@ DBusMessage *btd_error_not_supported(DBusMessage *msg);
 DBusMessage *btd_error_not_connected(DBusMessage *msg);
 DBusMessage *btd_error_already_connected(DBusMessage *msg);
 DBusMessage *btd_error_not_available(DBusMessage *msg);
+DBusMessage *btd_error_not_available_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_in_progress(DBusMessage *msg);
+DBusMessage *btd_error_in_progress_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
 DBusMessage *btd_error_not_authorized(DBusMessage *msg);
 DBusMessage *btd_error_not_permitted(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
 DBusMessage *btd_error_agent_not_available(DBusMessage *msg);
 DBusMessage *btd_error_not_ready(DBusMessage *msg);
+DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
+
+const char* btd_error_bredr_conn_from_errno(int errno_code);
+const char* btd_error_le_conn_from_errno(int errno_code);
-- 
2.32.0.605.g8dce9f2422-goog

