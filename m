Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E47C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4E820732
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jYElMMjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHUHWD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgHUHWB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 03:22:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670FC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:21:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o5so602208pgb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPRYxgB2XxX7Z1aiBzTSI/wL9Ebvg2gjReZiaambCFo=;
        b=jYElMMjXdG1bg9pmnmr1kINJzz5f4CH+FPxvNf9UX2zqLwkhT3cuaFuPu3ggVeS8NV
         PctT9lbrnRfAMQXYDY22gsdCYJ9+NnM550iPXKGw5T0U+EgBdV+kUmmEsUTYS2DEZQ7x
         LIiqMSE5Skpt9IktZ+RLq+zE/wU2V7r8sOp70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPRYxgB2XxX7Z1aiBzTSI/wL9Ebvg2gjReZiaambCFo=;
        b=H+1hx4Dy3v4UXyr2X/GeEHQKO53ESGSMlRYjNv6MWXZpZkcw9iRVVG7PBbdMjQHlS3
         MiCLmlhz3yaua3+7f/4+YkiLBYGhToFB4q0o4jxxWhw4aO7fZpIAepTNyeTsyOlCkKI7
         u06aJFLIjVsCPUBhyJCOWhz0X3bYi5gY8V1jmBUTDE7Pd+ZcaAKcSSHRZ1Q70YLmC1Qm
         BT1vys3Sxs4pdUyAIIpUQI0RMQaf0cMHjf3Tt7n5r9mH68JOgdehj1urJwKxK9r75pE4
         TUdwWLH7R6VL/xe1YO+WtqW/eMSfbYfjFrBJ3YpzMbZvzTk15/hM756BTfXm4yne1Hd5
         ctlA==
X-Gm-Message-State: AOAM530Kq1SI43EaP8WheM+F28edaj6XsJ2bVEhnrwVnpQLa8Jl33GO5
        Kd6AQAB7HL9SZoZ0F7lFuXXPsDWhfBhXGg==
X-Google-Smtp-Source: ABdhPJyhI0Q+WhRibjLdrsdfzsSfVkR8i/RRC8A7VoUnkhthbnIh3rF1irjC8iEcvWysQtBTJGsTaw==
X-Received: by 2002:a63:3fcf:: with SMTP id m198mr1291656pga.400.1597994518826;
        Fri, 21 Aug 2020 00:21:58 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id d127sm1371218pfc.175.2020.08.21.00.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:21:58 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] shared/mgmt: Provide timeout in mgmt_send()
Date:   Fri, 21 Aug 2020 00:21:55 -0700
Message-Id: <20200821072155.18834-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds mgmt_send_with_timeout() to help callers who want to use
mgmt_send with timeout handling. Ideally, all mgmt_send() caller should
use timeout, but in this patch only UNPAIR_DEVICE mgmt command is known
to have no-reply problem in the kernel.

This prevents bluetoothd from getting stuck in a state of waiting for
kernel MGMT reply forever. We still need to fix the kernel side for the
missing reply.

---
 src/adapter.c     |  8 +++---
 src/shared/mgmt.c | 62 ++++++++++++++++++++++++++++++++++++++++++++---
 src/shared/mgmt.h |  6 +++++
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..787d1bbb6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -114,6 +114,8 @@ static const struct mgmt_blocked_key_info blocked_keys[] = {
 		 0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
 };
 
+#define DEFAULT_MGMT_TIMEOUT	2	/* Timeout for MGMT commands (secs) */
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
@@ -7217,9 +7219,9 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter,
 	cp.addr.type = bdaddr_type;
 	cp.disconnect = 1;
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
-				adapter->dev_id, sizeof(cp), &cp,
-				NULL, NULL, NULL) > 0)
+	if (mgmt_send_with_timeout(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
+					adapter->dev_id, sizeof(cp), &cp, NULL,
+					NULL, NULL, DEFAULT_MGMT_TIMEOUT) > 0)
 		return 0;
 
 	return -EIO;
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 277e361a6..7e70aba43 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -38,6 +38,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/timeout.h"
 
 struct mgmt {
 	int ref_count;
@@ -60,6 +61,11 @@ struct mgmt {
 	void *debug_data;
 };
 
+struct mgmt_pending_request {
+	unsigned int request_id;
+	struct mgmt *mgmt;
+};
+
 struct mgmt_request {
 	unsigned int id;
 	uint16_t opcode;
@@ -69,6 +75,8 @@ struct mgmt_request {
 	mgmt_request_func_t callback;
 	mgmt_destroy_func_t destroy;
 	void *user_data;
+	/* Timeout for the request if > zero, otherwise timer is not used. */
+	int timeout_seconds;
 };
 
 struct mgmt_notify {
@@ -157,6 +165,8 @@ static void write_watch_destroy(void *user_data)
 	mgmt->writer_active = false;
 }
 
+bool mgmt_pending_timeout(void *user_data);
+
 static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 {
 	struct iovec iov;
@@ -184,6 +194,14 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 							mgmt->debug_data);
 
 	queue_push_tail(mgmt->pending_list, request);
+	if (request->timeout_seconds > 0) {
+		struct mgmt_pending_request *pending_request =
+			malloc(sizeof(struct mgmt_pending_request));
+		pending_request->request_id = request->id;
+		pending_request->mgmt = mgmt;
+		timeout_add(request->timeout_seconds * 1000,
+				mgmt_pending_timeout, pending_request, NULL);
+	}
 
 	return true;
 }
@@ -267,6 +285,29 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
 	wakeup_writer(mgmt);
 }
 
+bool mgmt_pending_timeout(void *user_data)
+{
+	struct mgmt_pending_request *pending_request = user_data;
+	struct mgmt *mgmt = pending_request->mgmt;
+	const struct mgmt_request *request =
+			queue_find(mgmt->pending_list,
+					match_request_id,
+					UINT_TO_PTR(
+						pending_request->request_id));
+
+	free(pending_request);
+
+	if (!request)
+		return false;
+
+	/* Pretend that kernel has replied with TIMEOUT status. */
+	request_complete(mgmt, MGMT_STATUS_TIMEOUT, request->opcode,
+				request->index, /* length */ 0,
+				/* param */ NULL);
+
+	return false;
+}
+
 struct event_index {
 	uint16_t event;
 	uint16_t index;
@@ -571,10 +612,12 @@ static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
 	return request;
 }
 
-unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
-				uint16_t length, const void *param,
-				mgmt_request_func_t callback,
-				void *user_data, mgmt_destroy_func_t destroy)
+unsigned int mgmt_send_with_timeout(
+			struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+			uint16_t length, const void *param,
+			mgmt_request_func_t callback,
+			void *user_data, mgmt_destroy_func_t destroy,
+			int timeout_seconds)
 {
 	struct mgmt_request *request;
 
@@ -590,6 +633,7 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 		mgmt->next_request_id = 1;
 
 	request->id = mgmt->next_request_id++;
+	request->timeout_seconds = timeout_seconds;
 
 	if (!queue_push_tail(mgmt->request_queue, request)) {
 		free(request->buf);
@@ -602,6 +646,16 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 	return request->id;
 }
 
+unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_send_with_timeout(
+			mgmt, opcode, index, length, param, callback, user_data,
+			destroy, /* timeout_seconds */ 0);
+}
+
 unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 7caeb3844..9aea64010 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -46,6 +46,12 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
 typedef void (*mgmt_request_func_t)(uint8_t status, uint16_t length,
 					const void *param, void *user_data);
 
+unsigned int mgmt_send_with_timeout(
+			struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+			uint16_t length, const void *param,
+			mgmt_request_func_t callback,
+			void *user_data, mgmt_destroy_func_t destroy,
+			int timeout_seconds);
 unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
-- 
2.26.2

