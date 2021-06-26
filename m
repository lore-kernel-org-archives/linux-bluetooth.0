Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976EC49EA6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C28C61939
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFZFYz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 01:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFZFYy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 01:24:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D85C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:22:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g21so7459673pfc.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JALfJhM0xDO0CbsrahAY20YPj1yX4vBjDB/WwM2pRTI=;
        b=kUMG9xOLwMh/1BGJGxcPzQDqllHV3e+YvNwYRi7dnYWnPyczXd4hWF38CHPDcifxZt
         DvYE14cgNsMa2sD/Q6jdalIfo0hzhPUGxv1MD9iA4L57KJVEqMC+vZiqhmUNejktQsGV
         6xz+GWgKv2f6RZXPTHbX33xa/xf3J9JUvjNO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JALfJhM0xDO0CbsrahAY20YPj1yX4vBjDB/WwM2pRTI=;
        b=pvKlIiKCiscgfGH0gHHhUNuQ7JuPZPKr//RUtdS/k/ESvG+Vh/K2zcySnad01zZmDo
         FC+kzdhFsgi3mp6+1DOWyyKqR+ZV3q27S66hwXukKZInIh9MwrCKOxwLvei2DOhVh60I
         aqxeS0pnxlALnLFPw2ZlN1OsWrE9gKZYFlNMxd8MruUgz99UB8YfoZJZisc6Eo1NWbQ+
         vJzzj8UUTGSOA85Vw+uNLRGYD9L08O36z/1oN4RAUHgfvxXYCgfLzAI6oeFkj3P2Xr45
         x+l1IPSZhO8jRQK/YMgdeUtT/QV/cPHPUFnqn0dZ/+BKScdHVTDugu+PC0Jl3sNX/QwY
         7KWQ==
X-Gm-Message-State: AOAM531BT1TvjevRHwpwjc7b/umhP04lEC7vgNn/8G7dL4spya4Bo//P
        rooW2bqqJREjdUl3xbVnOpl67OGuzqbfZA==
X-Google-Smtp-Source: ABdhPJzNkbkAUPl85bmbnjudV0KS5iVoR6PHl0jTq04r25KeaqzQPr2HsJWS+x0RPaBbNN96MlzYyA==
X-Received: by 2002:a63:e114:: with SMTP id z20mr12684430pgh.207.1624684947127;
        Fri, 25 Jun 2021 22:22:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:be2:cfe5:893:108f])
        by smtp.gmail.com with UTF8SMTPSA id u14sm7198956pfk.10.2021.06.25.22.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 22:22:26 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 1/3] error: BR/EDR and LE connection failure reasons
Date:   Fri, 25 Jun 2021 22:21:51 -0700
Message-Id: <20210625222111.BlueZ.v2.1.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210626052152.2543526-1-mcchou@chromium.org>
References: <20210626052152.2543526-1-mcchou@chromium.org>
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

This also added error-code.txt to describe these error codes.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

Changes in v2:
- Add error-code.txt
- Remove BtdError from return string

 doc/error-code.txt | 266 +++++++++++++++++++++++++++++++++++++++++++++
 src/error.c        | 111 +++++++++++++++++++
 src/error.h        |  52 +++++++++
 3 files changed, 429 insertions(+)
 create mode 100644 doc/error-code.txt

diff --git a/doc/error-code.txt b/doc/error-code.txt
new file mode 100644
index 000000000..e91324855
--- /dev/null
+++ b/doc/error-code.txt
@@ -0,0 +1,266 @@
+D-Bus Method Return Error Codes
+===============================
+
+The motivation of having detailed error codes is to provide context-based
+failure reasons along with D-Bus method return so that D-Bus clients can
+build metrics and optimize their application based on these failure reasons.
+For instance, a client can build retry mechanism for a connection failure or
+improve the bottleneck of use scenario based on actionable metrics.
+
+These error codes are context-based but not necessarily tied to interface or
+method calls. For instance, if a pairing request failed due to connection
+failure, connection error would be attached to the method return of Pair().
+
+BR/EDR connection already connected
+===================================
+	code:	0x0001
+	errno:	EALREADY, EISCONN
+
+Either the profile is already connected or ACL connection is in place.
+
+BR/EDR connection page timeout
+==============================
+	code:	0x0002
+	errno:	EHOSTDOWN
+
+Failed due to page timeout.
+
+BR/EDR connection profile unavailable 
+=====================================
+	code:	0x0003
+	errno:	ENOPROTOOPT
+
+Failed to find connectable services or the target service.
+
+BR/EDR connection SDP search
+============================
+	code:	0x0004
+	errno:	none
+
+Failed to complete the SDP search.
+
+BR/EDR connection create socket
+===============================
+	code:	0x0005
+	errno:	EIO
+
+Failed to create or connect to BT IO socket. This can also indicate hardware
+failure in the controller.
+
+BR/EDR connection invalid arguments
+===================================
+	code:	0x0006
+	errno:	EHOSTUNREACH
+
+Failed due to invalid arguments.
+
+BR/EDR connection not powered
+=============================
+	code:	0x0007
+	errno:	EHOSTUNREACH
+
+Failed due to adapter not powered.
+
+BR/EDR connection not supported
+===============================
+	code:	0x0008
+	errno:	EOPNOTSUPP, EPROTONOSUPPORT
+
+Failed due to unsupported state transition of L2CAP channel or other features
+either by the local host or the remote.
+
+BR/EDR connection bad socket
+============================
+	code:	0x0009
+	errno:	EBADFD
+
+Failed due to the socket is in bad state.
+
+BR/EDR connection memory allocation
+===================================
+	code:	0x000A
+	errno:	EBADFD
+
+Failed to allocate memory in either host stack or controller.
+
+BR/EDR connection busy
+======================
+	code:	0x000B
+	errno:	EBUSY
+
+Failed due to other ongoing operations, such as pairing, busy L2CAP channel or
+the operation disallowed by the controller.
+
+BR/EDR connection concurrent connection limit
+=============================================
+	code:	0x000C
+	errno:	EMLINK
+
+Failed due to reaching the concurrent connection limit to a device.
+
+BR/EDR connection timeout
+=========================
+	code:	0x000D
+	errno:	ETIMEDOUT
+
+Failed due to connection timeout
+
+BR/EDR connection refused
+=========================
+	code:	0x000E
+	errno:	ECONNREFUSED
+
+Refused by the remote device due to limited resource, security reason or
+unacceptable address type.
+
+BR/EDR connection aborted by remote
+===================================
+	code:	0x000F
+	errno:	ECONNRESET
+
+Terminated by the remote device due to limited resource or power off.
+
+BR/EDR connection aborted by local
+==================================
+	code:	0x0010
+	errno:	ECONNABORTED
+
+Aborted by the local host.
+
+BR/EDR connection protocol error
+================================
+	code:	0x0011
+	errno:	EPROTO
+
+Failed due to LMP protocol error.
+
+BR/EDR connection canceled
+==========================
+	code:	0x0012
+	errno:	none
+
+Failed due to cancellation caused by adapter drop, unexpected device drop, or
+incoming disconnection request before connection request is completed.
+
+BR/EDR connection unknown error
+===============================
+	code:	0x0013
+	errno:	ENOSYS
+
+Failed due to unknown reason.
+
+LE connection invalid arguments
+===============================
+	code:	0x0101
+	errno:	EINVAL
+
+Failed due to invalid arguments.
+
+LE connection not powered
+=========================
+	code:	0x0102
+	errno:	EHOSTUNREACH
+
+Failed due to adapter not powered.
+
+LE connection not supported
+===========================
+	code:	0x0103
+	errno:	EOPNOTSUPP, EPROTONOSUPPORT
+
+Failed due to unsupported state transition of L2CAP channel or other features
+(e.g. LE features) either by the local host or the remote.
+
+LE connection already connected
+===============================
+	code:	0x0104
+	errno: EALREADY, EISCONN
+
+Either the BT IO is already connected or LE link connection in place.
+
+LE connection bad socket
+========================
+	code:	0x0105
+	errno: EBADFD
+
+Failed due to the socket is in bad state.
+
+LE connection memory allocation
+===============================
+	code:	0x0106
+	errno: ENOMEM
+
+Failed to allocate memory in either host stack or controller.
+
+LE connection busy
+==================
+	code:	0x0107
+	errno:	EBUSY
+
+Failed due to other ongoing operations, such as pairing, connecting, busy
+L2CAP channel or the operation disallowed by the controller.
+
+LE connection refused
+=====================
+	code:	0x0108
+	errno:	ECONNREFUSED
+
+Failed due to that LE is not enabled or the attempt is refused by the remote
+device due to limited resource, security reason or unacceptable address type.
+
+LE connection create socket
+===========================
+	code:	0x0109
+	errno:	EIO
+
+Failed to create or connect to BT IO socket. This can also indicate hardware
+failure in the controller.
+
+LE connection timeout
+=====================
+	code:	0x010A
+	errno:	ETIMEDOUT
+
+Failed due to connection timeout
+
+LE connection concurrent connection limit
+=========================================
+	code:	0x010B
+	errno:	EMLINK
+
+Failed due to reaching the synchronous connection limit to a device.
+
+LE connection abort by remote
+=============================
+	code:	0x010C
+	errno:	ECONNRESET
+
+Aborted by the remote device due to limited resource or power off.
+
+LE connection abort by local
+============================
+	code:	0x010D
+	errno:	ECONNABORTED
+
+Aborted by the local host.
+
+LE connection link layer protocol error 
+=======================================
+	code:	0x010E
+	errno:	EPROTO
+
+Failed due to link layer protocol error.
+
+LE connection GATT browsing
+===========================
+	code:	0x010F
+	errno:	none
+
+Failed to complete the GATT browsing.
+
+LE connection unknown error
+===========================
+	code:	0x0110
+	errno:	ENOSYS
+
+ Failed due to unknown reason.
diff --git a/src/error.c b/src/error.c
index 89517075e..73602c4bf 100644
--- a/src/error.c
+++ b/src/error.c
@@ -27,6 +27,7 @@
 #include <config.h>
 #endif
 
+#include <stdio.h>
 #include "gdbus/gdbus.h"
 
 #include "error.h"
@@ -43,6 +44,12 @@ DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str)
 					"%s", str);
 }
 
+DBusMessage *btd_error_invalid_args_err(DBusMessage *msg, uint16_t err)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
+					"0x%04X", err);
+}
+
 DBusMessage *btd_error_busy(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
@@ -79,12 +86,24 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg)
 					"In Progress");
 }
 
+DBusMessage *btd_error_in_progress_err(DBusMessage *msg, uint16_t err)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress", "0x%04X",
+					err);
+}
+
 DBusMessage *btd_error_not_available(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
 					"Operation currently not available");
 }
 
+DBusMessage *btd_error_not_available_err(DBusMessage *msg, uint16_t err)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
+					"0x%04X", err);
+}
+
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
@@ -121,8 +140,100 @@ DBusMessage *btd_error_not_ready(DBusMessage *msg)
 					"Resource Not Ready");
 }
 
+DBusMessage *btd_error_not_ready_err(DBusMessage *msg, uint16_t err)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady", "0x%04X",
+					err);
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
 					".Failed", "%s", str);
 }
+
+DBusMessage *btd_error_failed_err(DBusMessage *msg, uint16_t err)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "0x%04X",
+					err);
+}
+
+uint16_t btd_error_bredr_conn_from_errno(int errno_code)
+{
+	switch (-errno_code) {
+	case EALREADY:
+	case EISCONN: // Fall through
+		return BTD_ERR_BREDR_CONN_ALREADY_CONNECTED;
+	case EHOSTDOWN:
+		return BTD_ERR_BREDR_CONN_PAGE_TIMEOUT;
+	case ENOPROTOOPT:
+		return BTD_ERR_BREDR_CONN_PROFILE_UNAVAILABLE;
+	case EIO:
+		return BTD_ERR_BREDR_CONN_CREATE_SOCKET;
+	case EINVAL:
+		return BTD_ERR_BREDR_CONN_INVALID_ARGUMENTS;
+	case EHOSTUNREACH:
+		return BTD_ERR_BREDR_CONN_ADAPTER_NOT_POWERED;
+	case EOPNOTSUPP:
+	case EPROTONOSUPPORT: // Fall through
+		return BTD_ERR_BREDR_CONN_NOT_SUPPORTED;
+	case EBADFD:
+		return BTD_ERR_BREDR_CONN_BAD_SOCKET;
+	case ENOMEM:
+		return BTD_ERR_BREDR_CONN_MEMORY_ALLOC;
+	case EBUSY:
+		return BTD_ERR_BREDR_CONN_BUSY;
+	case EMLINK:
+		return BTD_ERR_BREDR_CONN_CNCR_CONNECT_LIMIT;
+	case ETIMEDOUT:
+		return BTD_ERR_BREDR_CONN_TIMEOUT;
+	case ECONNREFUSED:
+		return BTD_ERR_BREDR_CONN_REFUSED;
+	case ECONNRESET:
+		return BTD_ERR_BREDR_CONN_ABORT_BY_REMOTE;
+	case ECONNABORTED:
+		return BTD_ERR_BREDR_CONN_ABORT_BY_LOCAL;
+	case EPROTO:
+		return BTD_ERR_BREDR_CONN_PROTO_ERROR;
+	default:
+		return BTD_ERR_BREDR_CONN_UNKNOWN;
+	}
+}
+
+uint16_t btd_error_le_conn_from_errno(int errno_code)
+{
+	switch (-errno_code) {
+	case EINVAL:
+		return BTD_ERR_LE_CONN_INVALID_ARGUMENTS;
+	case EHOSTUNREACH:
+		return BTD_ERR_LE_CONN_ADAPTER_NOT_POWERED;
+	case EOPNOTSUPP:
+	case EPROTONOSUPPORT: // Fall through
+		return BTD_ERR_LE_CONN_NOT_SUPPORTED;
+	case EALREADY:
+	case EISCONN: // Fall through
+		return BTD_ERR_LE_CONN_ALREADY_CONNECTED;
+	case EBADFD:
+		return BTD_ERR_LE_CONN_BAD_SOCKET;
+	case ENOMEM:
+		return BTD_ERR_LE_CONN_MEMORY_ALLOC;
+	case EBUSY:
+		return BTD_ERR_LE_CONN_BUSY;
+	case ECONNREFUSED:
+		return BTD_ERR_LE_CONN_REFUSED;
+	case EIO:
+		return BTD_ERR_LE_CONN_CREATE_SOCKET;
+	case ETIMEDOUT:
+		return BTD_ERR_LE_CONN_TIMEOUT;
+	case EMLINK:
+		return BTD_ERR_LE_CONN_SYNC_CONNECT_LIMIT;
+	case ECONNRESET:
+		return BTD_ERR_LE_CONN_ABORT_BY_REMOTE;
+	case ECONNABORTED:
+		return BTD_ERR_LE_CONN_ABORT_BY_LOCAL;
+	case EPROTO:
+		return BTD_ERR_LE_CONN_PROTO_ERROR;
+	default:
+		return BTD_ERR_LE_CONN_UNKNOWN;
+	}
+}
diff --git a/src/error.h b/src/error.h
index 7c8cad066..74d433aca 100644
--- a/src/error.h
+++ b/src/error.h
@@ -24,22 +24,74 @@
  */
 
 #include <dbus/dbus.h>
+#include <stdint.h>
 
 #define ERROR_INTERFACE "org.bluez.Error"
 
+/* BR/EDR connection failure reasons
+ * BT_ERR_* should be used as one of the parameters to btd_error_*_err().
+ */
+#define BTD_ERR_BREDR_CONN_ALREADY_CONNECTED	0x0001
+#define BTD_ERR_BREDR_CONN_PAGE_TIMEOUT		0x0002
+#define BTD_ERR_BREDR_CONN_PROFILE_UNAVAILABLE	0x0003
+#define BTD_ERR_BREDR_CONN_SDP_SEARCH		0x0004
+#define BTD_ERR_BREDR_CONN_CREATE_SOCKET	0x0005
+#define BTD_ERR_BREDR_CONN_INVALID_ARGUMENTS	0x0006
+#define BTD_ERR_BREDR_CONN_ADAPTER_NOT_POWERED	0x0007
+#define BTD_ERR_BREDR_CONN_NOT_SUPPORTED	0x0008
+#define BTD_ERR_BREDR_CONN_BAD_SOCKET		0x0009
+#define BTD_ERR_BREDR_CONN_MEMORY_ALLOC		0x000A
+#define BTD_ERR_BREDR_CONN_BUSY			0x000B
+#define BTD_ERR_BREDR_CONN_CNCR_CONNECT_LIMIT	0x000C
+#define BTD_ERR_BREDR_CONN_TIMEOUT		0x000D
+#define BTD_ERR_BREDR_CONN_REFUSED		0x000E
+#define BTD_ERR_BREDR_CONN_ABORT_BY_REMOTE	0x000F
+#define BTD_ERR_BREDR_CONN_ABORT_BY_LOCAL	0x0010
+#define BTD_ERR_BREDR_CONN_PROTO_ERROR		0x0011
+#define BTD_ERR_BREDR_CONN_CANCELED		0x0012
+#define BTD_ERR_BREDR_CONN_UNKNOWN		0x0013
+
+/* LE connection failure reasons
+ * BT_ERR_* should be used as one of the parameters to btd_error_*_err().
+ */
+#define BTD_ERR_LE_CONN_INVALID_ARGUMENTS	0x0101
+#define BTD_ERR_LE_CONN_ADAPTER_NOT_POWERED	0x0102
+#define BTD_ERR_LE_CONN_NOT_SUPPORTED		0x0103
+#define BTD_ERR_LE_CONN_ALREADY_CONNECTED	0x0104
+#define BTD_ERR_LE_CONN_BAD_SOCKET		0x0105
+#define BTD_ERR_LE_CONN_MEMORY_ALLOC		0x0106
+#define BTD_ERR_LE_CONN_BUSY			0x0107
+#define BTD_ERR_LE_CONN_REFUSED			0x0108
+#define BTD_ERR_LE_CONN_CREATE_SOCKET		0x0109
+#define BTD_ERR_LE_CONN_TIMEOUT			0x010A
+#define BTD_ERR_LE_CONN_SYNC_CONNECT_LIMIT	0x010B
+#define BTD_ERR_LE_CONN_ABORT_BY_REMOTE		0x010C
+#define BTD_ERR_LE_CONN_ABORT_BY_LOCAL		0x010D
+#define BTD_ERR_LE_CONN_PROTO_ERROR		0x010E
+#define BTD_ERR_LE_CONN_GATT_BROWSE		0x010F
+#define BTD_ERR_LE_CONN_UNKNOWN			0x0110
+
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str);
+DBusMessage *btd_error_invalid_args_err(DBusMessage *msg, uint16_t err);
 DBusMessage *btd_error_busy(DBusMessage *msg);
 DBusMessage *btd_error_already_exists(DBusMessage *msg);
 DBusMessage *btd_error_not_supported(DBusMessage *msg);
 DBusMessage *btd_error_not_connected(DBusMessage *msg);
 DBusMessage *btd_error_already_connected(DBusMessage *msg);
 DBusMessage *btd_error_not_available(DBusMessage *msg);
+DBusMessage *btd_error_not_available_err(DBusMessage *msg, uint16_t err);
 DBusMessage *btd_error_in_progress(DBusMessage *msg);
+DBusMessage *btd_error_in_progress_err(DBusMessage *msg, uint16_t err);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
 DBusMessage *btd_error_not_authorized(DBusMessage *msg);
 DBusMessage *btd_error_not_permitted(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
 DBusMessage *btd_error_agent_not_available(DBusMessage *msg);
 DBusMessage *btd_error_not_ready(DBusMessage *msg);
+DBusMessage *btd_error_not_ready_err(DBusMessage *msg, uint16_t err);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
+DBusMessage *btd_error_failed_err(DBusMessage *msg, uint16_t err);
+
+uint16_t btd_error_bredr_conn_from_errno(int errno_code);
+uint16_t btd_error_le_conn_from_errno(int errno_code);
-- 
2.32.0.93.g670b81a890-goog

