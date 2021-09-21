Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212EA61184
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhIUQu5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhIUQuz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 12:50:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA700C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:49:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so13786910pls.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjCujCNv75N9S8hy4VUHJ8ZotgSGTx6b7LLzgwfR3hg=;
        b=GG80hgn0KydrEtZDr4UWAvaZDMmsPS70yMPrHH4QpJrb27w4JiGBXhSzGfQHi89sMk
         WBLhHXDsHHiAzRymputcObC+w+p5YX4Ely3U4CHZ0jWbXqXKSrliW0Ew3y5+a8JG2Ix6
         4fRAH3QxE0/hbg4HqFp/RukMdWbx9hHyaCoQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjCujCNv75N9S8hy4VUHJ8ZotgSGTx6b7LLzgwfR3hg=;
        b=tIJGek2HAZ/QkZY5ZOCmx2AZaT7RlEcgEp2FeFEsqVKGIGPRfSnsO7H2VIBp/TWA08
         +7YiiOUBZWekgiy2z8yrQdsozH3kcItiAGxvN77JOR23otej2VBtZ82XIuNpjz3ON4E3
         mQGPrJpX/eCxX1o1cbgFL/bjq7DsJ/kJu49IamidLo9jzUtgln2HsGxdLwRvuvat36Ep
         OnHGDZtjaE1+YJC7+Qq+sk+Bvx/W00yFFLP/R/hXLe7aJNGWRTDVDXb66izR6TpCgeSq
         cJx8YmheGZo/gQK2iDbya822tAwsm9EUSSMhvK0Y5YEbKQi30EPg5kh4XyxjNPu5Ce+v
         UoMg==
X-Gm-Message-State: AOAM530xeQOpoI7zbAy/WalPqKCVZ4p7vb0FODQt2LLuljoiFVk/oMXT
        EGxu1tr9EEIn7ZjpdLB4zvQ6l8ht4pi7Gg==
X-Google-Smtp-Source: ABdhPJzUikYv7l2INW9A2vHjV53PU2Yqiy1BcrtZQv4zy8Zy/oaeR++eC7siip/yC3sCKLZH568+tA==
X-Received: by 2002:a17:90a:19d8:: with SMTP id 24mr6278170pjj.129.1632242965986;
        Tue, 21 Sep 2021 09:49:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:db3:f19e:7f67:74f])
        by smtp.gmail.com with UTF8SMTPSA id w9sm2824126pjl.56.2021.09.21.09.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 09:49:25 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 2/4] error: BR/EDR and LE connection failure reasons
Date:   Tue, 21 Sep 2021 09:47:07 -0700
Message-Id: <20210921094400.BlueZ.v6.2.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
In-Reply-To: <20210921164708.1497029-1-mcchou@chromium.org>
References: <20210921164708.1497029-1-mcchou@chromium.org>
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
index dd85cd288..caeee1cc7 100644
--- a/src/error.c
+++ b/src/error.c
@@ -14,6 +14,8 @@
 #include <config.h>
 #endif
 
+#include <error.h>
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
index 7fcddaf4a..d0552bef1 100644
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
+const char* btd_error_bredr_conn_from_errno(int errno_code);
+const char* btd_error_le_conn_from_errno(int errno_code);
-- 
2.33.0.464.g1972c5931b-goog

