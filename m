Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2008AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0433D61881
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhI3WlM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhI3WlL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 18:41:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1CC06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:39:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 133so7680504pgb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c7sAOsooiNrbffPynCXP0BPJZ3H+m+UWlU/LC7Z3WkU=;
        b=ijSF2nYTezF5fK07PLnZxyzKT+C5DIZUSE3Lxqa4rMgQZH0Dqtnicm5QZXAQ9Mv9fw
         V/PaQ9CQqt9kcRqYf5l+B/XXbbC9OcBUzM2A3XOQtBXIfe2LQZ7H/qLp/i4u9Olv9cCY
         VPk43D1Esmb3DzK4fVe/u5Mx5+j0ESOdZl2To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7sAOsooiNrbffPynCXP0BPJZ3H+m+UWlU/LC7Z3WkU=;
        b=LpXeZIheu7VXdewVbgDyqHuiHzTwpuc7c6ZJ4cog4bP47hkg8Xxz3kB/ae0KCXQeFL
         wcLjwBV15doORG2hDjZiFdlTA0SyaWc1wtDH4kfRFVMHTbj7olZ+ja8JPrTN6hijxucR
         OU64jU40euK9CO+QT6mu4q9ztaMKrtJbbP77X3ncCsgx0I9LrhTofM/RLXqa1PQPxkSp
         jE6E0OgDfwJ38DFtuomV4VnyHJb/XYQWp41wmISJcWRgPrncbP/3VJ8Wxqyhg89jZ4C9
         jQxQe+f/mHFjic6mWmO2q8cOQ64TQa0pfVba5b7PVUqz88ZHwt0uDpXOObe4oyWd1rv8
         K0Vg==
X-Gm-Message-State: AOAM530HdpV5VJ2QtKXQUwH9NoaEII4gs2nXlespWpXI/K0AF2ATqjCF
        O2PppHHFNLVOeOmFxJAeL26vzY3E2yQdHA==
X-Google-Smtp-Source: ABdhPJwZS6egLzb0wT6u4+ASf/7piSQLSJ0o4I78IapBifVBgRcFCChrN4XJI2CZjJnUT8htDP2DeQ==
X-Received: by 2002:a05:6a00:130c:b0:444:f9d4:d800 with SMTP id j12-20020a056a00130c00b00444f9d4d800mr8062707pfu.38.1633041567733;
        Thu, 30 Sep 2021 15:39:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb71:bb5c:56a6:693f])
        by smtp.gmail.com with UTF8SMTPSA id 18sm3996860pfi.60.2021.09.30.15.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 15:39:27 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 2/4] error: BR/EDR and LE connection failure reasons
Date:   Thu, 30 Sep 2021 15:37:26 -0700
Message-Id: <20210930153703.BlueZ.v7.2.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930223726.2886139-1-mcchou@chromium.org>
References: <20210930223726.2886139-1-mcchou@chromium.org>
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

Changes in v7:
- Fix nits.

Changes in v6:
- Rephrase error strings.

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
 src/error.h |  57 ++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/src/error.c b/src/error.c
index dd85cd288..29c071067 100644
--- a/src/error.c
+++ b/src/error.c
@@ -14,6 +14,8 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+#include <stdio.h>
 #include "gdbus/gdbus.h"
 
 #include "error.h"
@@ -66,12 +68,24 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg)
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
@@ -108,8 +122,94 @@ DBusMessage *btd_error_not_ready(DBusMessage *msg)
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
+const char *btd_error_bredr_conn_from_errno(int errno_code)
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
+const char *btd_error_le_conn_from_errno(int errno_code)
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
index 7fcddaf4a..dded9f93d 100644
--- a/src/error.h
+++ b/src/error.h
@@ -11,9 +11,60 @@
  */
 
 #include <dbus/dbus.h>
+#include <stdint.h>
 
 #define ERROR_INTERFACE "org.bluez.Error"
 
+/* BR/EDR connection failure reasons */
+#define ERR_BREDR_CONN_ALREADY_CONNECTED	"br-connection-already-"\
+						"connected"
+#define ERR_BREDR_CONN_PAGE_TIMEOUT		"br-connection-page-timeout"
+#define ERR_BREDR_CONN_PROFILE_UNAVAILABLE	"br-connection-profile-"\
+						"unavailable"
+#define ERR_BREDR_CONN_SDP_SEARCH		"br-connection-sdp-search"
+#define ERR_BREDR_CONN_CREATE_SOCKET		"br-connection-create-socket"
+#define ERR_BREDR_CONN_INVALID_ARGUMENTS	"br-connection-invalid-"\
+						"argument"
+#define ERR_BREDR_CONN_ADAPTER_NOT_POWERED	"br-connection-adapter-not-"\
+						"powered"
+#define ERR_BREDR_CONN_NOT_SUPPORTED		"br-connection-not-suuported"
+#define ERR_BREDR_CONN_BAD_SOCKET		"br-connection-bad-socket"
+#define ERR_BREDR_CONN_MEMORY_ALLOC		"br-connection-memory-"\
+						"allocation"
+#define ERR_BREDR_CONN_BUSY			"br-connection-busy"
+#define ERR_BREDR_CONN_CNCR_CONNECT_LIMIT	"br-connection-concurrent-"\
+						"connection-limit"
+#define ERR_BREDR_CONN_TIMEOUT			"br-connection-timeout"
+#define ERR_BREDR_CONN_REFUSED			"br-connection-refused"
+#define ERR_BREDR_CONN_ABORT_BY_REMOTE		"br-connection-aborted-by-"\
+						"remote"
+#define ERR_BREDR_CONN_ABORT_BY_LOCAL		"br-connection-aborted-by-"\
+						"local"
+#define ERR_BREDR_CONN_LMP_PROTO_ERROR		"br-connection-lmp-protocol-"\
+						"error"
+#define ERR_BREDR_CONN_CANCELED			"br-connection-canceled"
+#define ERR_BREDR_CONN_UNKNOWN			"br-connection-unknown"
+
+/* LE connection failure reasons */
+#define ERR_LE_CONN_INVALID_ARGUMENTS	"le-connection-invalid-arguments"
+#define ERR_LE_CONN_ADAPTER_NOT_POWERED	"le-connection-adapter-not-powered"
+#define ERR_LE_CONN_NOT_SUPPORTED	"le-connection-not-supported"
+#define ERR_LE_CONN_ALREADY_CONNECTED	"le-connection-already-connected"
+#define ERR_LE_CONN_BAD_SOCKET		"le-connection-bad-socket"
+#define ERR_LE_CONN_MEMORY_ALLOC	"le-connection-memory-allocation"
+#define ERR_LE_CONN_BUSY		"le-connection-busy"
+#define ERR_LE_CONN_REFUSED		"le-connection-refused"
+#define ERR_LE_CONN_CREATE_SOCKET	"le-connection-create-socket"
+#define ERR_LE_CONN_TIMEOUT		"le-connection-timeout"
+#define ERR_LE_CONN_SYNC_CONNECT_LIMIT	"le-connection-concurrent-connection-"\
+					"limit"
+#define ERR_LE_CONN_ABORT_BY_REMOTE	"le-connection-abort-by-remote"
+#define ERR_LE_CONN_ABORT_BY_LOCAL	"le-connection-abort-by-local"
+#define ERR_LE_CONN_LL_PROTO_ERROR	"le-connection-link-layer-protocol-"\
+					"error"
+#define ERR_LE_CONN_GATT_BROWSE		"le-connection-gatt-browsing"
+#define ERR_LE_CONN_UNKNOWN		"le-connection-unknown"
+
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_busy(DBusMessage *msg);
@@ -22,11 +73,17 @@ DBusMessage *btd_error_not_supported(DBusMessage *msg);
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
+const char *btd_error_bredr_conn_from_errno(int errno_code);
+const char *btd_error_le_conn_from_errno(int errno_code);
-- 
2.33.0.800.g4c38ced690-goog

