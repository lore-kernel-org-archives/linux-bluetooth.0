Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064F8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 00:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiCWAI0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbiCWAIZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 20:08:25 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1791A5DE7F
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c2so13748720pga.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lMeVwZRc+kCFv6ywPENuuniweobbSTLYVjAmAjxzwIE=;
        b=C8mcyl3j3WaP25KR/Vc8jrR+A7k5VEF6+DF3AuzoxWRU/87dfMC2hbZsENmTL3Of7A
         oB2Ur7tOp1wOclI8gnQNLXvjVHj5GUZ/lCxBZJpojvXEiN3x5zkBgnkUP3ZCOxaLCRl5
         z3nDXWTF0z6FtftFCwgsEIxmHvVoLkG9JMzxEebrGwA15fhbhB7ZTWthOyiP4NI5CA+L
         EAUKhqtAbquQSHgKOr6ZNlxw/YjKzQBhZ8AGWm31SHhmnrcB/ayPDLzty+d1pDeGjJiW
         jjsUnfoW0Ky4GCExp/zlSzt5T4Kkgar3MEWFt4yUeIYkduTdSBtGaLXPRw5tcGqxI8HD
         d5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMeVwZRc+kCFv6ywPENuuniweobbSTLYVjAmAjxzwIE=;
        b=J5evYvWBl1DG4mp3/E4EBENKVnHcWqYiW6PFwvIsczXz7UL11u4bsPpcKMjzFdjFLt
         LWwuo47Byyp2Q4aHyXXfRlW1yFac4yD8yJKsUGnck1HwBr8woZh7/nlfWG7t3w5mnGyj
         ksTTGgJK74Z/VzCLE6olmejGzM7ZmddBLJhYppPXbJ76pPe+Bfcm8Tulw3a2auDTo33A
         e9tAyGI33Sc94NSLLA65n5vJk3JNf5Hbp8mliHM1OJldhlfjEg+gpCNze85NoRBsZ4i0
         wQ5UxJYmKuXELNXjtgLKNfShrNhUXfOc0Jteo6ap7nRz2pRf9KpiM8G0R0IXY++S87uB
         +dxA==
X-Gm-Message-State: AOAM530+ecXFkSLYh3Zgj0tC5MS46yhjiTowa+DihsPIYTsfzWtzgXlm
        XheH0IoxFtJjy5Ji3iw4Z/1m1tZhCSo=
X-Google-Smtp-Source: ABdhPJyIevS5o+52IYgKdOZVr3H527FjsPm4eD22VY7YMusdMF5A8C+7/1H3MYEOA/TfyqYdoQ+jfg==
X-Received: by 2002:a63:f966:0:b0:380:5d50:ba72 with SMTP id q38-20020a63f966000000b003805d50ba72mr8954848pgk.403.1647994016237;
        Tue, 22 Mar 2022 17:06:56 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm10098423pfb.196.2022.03.22.17.06.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 17:06:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/9] mgmt: Add DBG macro
Date:   Tue, 22 Mar 2022 17:06:47 -0700
Message-Id: <20220323000654.3157833-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323000654.3157833-1-luiz.dentz@gmail.com>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds mgmt_log wrapper for util_debug and DBG so file and function
names are printed with the logs.
---
 src/shared/mgmt.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 95229c248..c7e6a6c1d 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -27,6 +27,9 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/timeout.h"
 
+#define DBG(_mgmt, _format, arg...) \
+	mgmt_log(_mgmt, "%s:%s() " _format, __FILE__, __func__, ## arg)
+
 struct mgmt {
 	int ref_count;
 	int fd;
@@ -177,6 +180,18 @@ static bool request_timeout(void *data)
 	return false;
 }
 
+static void mgmt_log(struct mgmt *mgmt, const char *format, ...)
+{
+	va_list ap;
+
+	if (!mgmt || !format || !mgmt->debug_callback)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(mgmt->debug_callback, mgmt->debug_data, format, ap);
+	va_end(ap);
+}
+
 static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 {
 	struct iovec iov;
@@ -187,8 +202,8 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 
 	ret = io_send(mgmt->io, &iov, 1);
 	if (ret < 0) {
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"write failed: %s", strerror(-ret));
+		DBG(mgmt, "write failed: %s", strerror(-ret));
+
 		if (request->callback)
 			request->callback(MGMT_STATUS_FAILED, 0, NULL,
 							request->user_data);
@@ -202,9 +217,7 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 							request,
 							NULL);
 
-	util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] command 0x%04x",
-				request->index, request->opcode);
+	DBG(mgmt, "[0x%04x] command 0x%04x", request->index, request->opcode);
 
 	util_hexdump('<', request->buf, ret, mgmt->debug_callback,
 							mgmt->debug_data);
@@ -283,9 +296,7 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
 	request = queue_remove_if(mgmt->pending_list,
 					match_request_opcode_index, &match);
 	if (!request) {
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"Unable to find request for opcode 0x%04x",
-				opcode);
+		DBG(mgmt, "Unable to find request for opcode 0x%04x", opcode);
 
 		/* Attempt to remove with no opcode */
 		request = queue_remove_if(mgmt->pending_list,
@@ -383,8 +394,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		cc = mgmt->buf + MGMT_HDR_SIZE;
 		opcode = btohs(cc->opcode);
 
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] command 0x%04x complete: 0x%02x",
+		DBG(mgmt, "[0x%04x] command 0x%04x complete: 0x%02x",
 						index, opcode, cc->status);
 
 		request_complete(mgmt, cc->status, opcode, index, length - 3,
@@ -394,15 +404,13 @@ static bool can_read_data(struct io *io, void *user_data)
 		cs = mgmt->buf + MGMT_HDR_SIZE;
 		opcode = btohs(cs->opcode);
 
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] command 0x%02x status: 0x%02x",
+		DBG(mgmt, "[0x%04x] command 0x%02x status: 0x%02x",
 						index, opcode, cs->status);
 
 		request_complete(mgmt, cs->status, opcode, index, 0, NULL);
 		break;
 	default:
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] event 0x%04x", index, event);
+		DBG(mgmt, "[0x%04x] event 0x%04x", index, event);
 
 		process_notify(mgmt, event, index, length,
 						mgmt->buf + MGMT_HDR_SIZE);
-- 
2.35.1

