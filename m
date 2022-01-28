Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37162C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 02:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbiA1CHi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 21:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbiA1CHi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 21:07:38 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11F0C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:07:37 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n17so6049282iod.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hXZSR+xjTlB3Rf89jHBUZOSbxSBKhgoR5CbeOozYl8s=;
        b=EhgieR9l1DH2aZJPL+KjOffI0/Czt0S+QESaz5U1qTYmgac6O3EGHSpBK/+iNbf6ZG
         uv97k3xoTIGQmdafpKpqm6AhHRGFCg8Mq/UfSf0/aqjA88fbBXO0R3en1g2F6WXWe5a9
         bxXGIvMgOglDigDvvmdWIVskdyDWTblQx1Gz1NxPIRQ4DAKzeqREBhTRVjrSg4d2Z364
         TjewKs3ps1LWNMzOP9MOMYE/QeuChXFJOb4gyQVCVeCA92icSI1TobEj/nj+r1RkMgDs
         aSc7htLv0nUsRc0ivFu6QxcJ0PehiwjUL7gYoSjyrdICg2Uh8VmJM/LWEpt5roLA++mt
         b4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hXZSR+xjTlB3Rf89jHBUZOSbxSBKhgoR5CbeOozYl8s=;
        b=VYiDWEqHwUZgt/GhBTISXIesgufRJgaCQK2XmI/R94xlY9d8lDbCUDulHFcyom1Qqu
         kXbE+cbO0d7k0qzBSJoVV+CnrVT/+GR69wf9jAsqDdq4ec1cyGTgGCvBZahf/1zdMfYd
         m/PhQrULetFgYpReYv07OOHxs8Ax5Ldyx5nC3/tZYX22vutmFualX6VHHGObvkWQIYoz
         /fZNtdztELckwd/LUmtyXk/FAxYpSauGEBq4i2trjua1BnO2yWqEanj2tX0RiPcb+72R
         SNRkglpaeA+2dU8aWA7uJl6syct5YOCTsVKnVkr3DPd2OzCemMvmMXiNECq++OMbX+HN
         TvXA==
X-Gm-Message-State: AOAM5331uWVfYloftF46IzdwVXJ+vEIR4xlytSHDCsglkQIY6CzjcNvM
        nF8XCwSmRXGJI2K0BmQIEBtstvcIxpxraw==
X-Google-Smtp-Source: ABdhPJx5F9U2eiuCCKF+I3eus0UQmIpSVmQ+nf/XvJ740TCA2BSJnt70HmCBF0Vgq6Y/Mv9JT7sMgA==
X-Received: by 2002:a05:6638:309:: with SMTP id w9mr3567736jap.241.1643335657005;
        Thu, 27 Jan 2022 18:07:37 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p5sm12306763iof.50.2022.01.27.18.07.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:07:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] shared/mgmt: Add request timeout handling
Date:   Thu, 27 Jan 2022 18:07:34 -0800
Message-Id: <20220128020735.3779202-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds request timeout handling when using mgmt_send_timeout and
mgmt_reply_timeout, the timeout is applied to the request only when it
is actually transmitted and not while queued.
---
v2: Remove default timeout so the likes of mgmt_send/mgmt_reply use 0
instead which disables the timeout handling.

 src/shared/mgmt.c | 85 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/mgmt.h | 10 ++++++
 2 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 41457b430..95229c248 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -25,6 +25,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/timeout.h"
 
 struct mgmt {
 	int ref_count;
@@ -49,6 +50,7 @@ struct mgmt {
 };
 
 struct mgmt_request {
+	struct mgmt *mgmt;
 	unsigned int id;
 	uint16_t opcode;
 	uint16_t index;
@@ -57,6 +59,8 @@ struct mgmt_request {
 	mgmt_request_func_t callback;
 	mgmt_destroy_func_t destroy;
 	void *user_data;
+	int timeout;
+	unsigned int timeout_id;
 };
 
 struct mgmt_notify {
@@ -81,6 +85,9 @@ static void destroy_request(void *data)
 	if (request->destroy)
 		request->destroy(request->user_data);
 
+	if (request->timeout_id)
+		timeout_remove(request->timeout_id);
+
 	free(request->buf);
 	free(request);
 }
@@ -150,6 +157,26 @@ static void write_watch_destroy(void *user_data)
 	mgmt->writer_active = false;
 }
 
+static bool request_timeout(void *data)
+{
+	struct mgmt_request *request = data;
+
+	if (!request)
+		return false;
+
+	request->timeout_id = 0;
+
+	queue_remove_if(request->mgmt->pending_list, NULL, request);
+
+	if (request->callback)
+		request->callback(MGMT_STATUS_TIMEOUT, 0, NULL,
+						request->user_data);
+
+	destroy_request(request);
+
+	return false;
+}
+
 static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 {
 	struct iovec iov;
@@ -169,6 +196,12 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 		return false;
 	}
 
+	if (request->timeout)
+		request->timeout_id = timeout_add_seconds(request->timeout,
+							request_timeout,
+							request,
+							NULL);
+
 	util_debug(mgmt->debug_callback, mgmt->debug_data,
 				"[0x%04x] command 0x%04x",
 				request->index, request->opcode);
@@ -566,7 +599,8 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
 static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
 				uint16_t index, uint16_t length,
 				const void *param, mgmt_request_func_t callback,
-				void *user_data, mgmt_destroy_func_t destroy)
+				void *user_data, mgmt_destroy_func_t destroy,
+				int timeout)
 {
 	struct mgmt_request *request;
 	struct mgmt_hdr *hdr;
@@ -598,12 +632,18 @@ static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
 	hdr->index = htobs(index);
 	hdr->len = htobs(length);
 
+	/* Use a weak reference so requests don't prevent mgmt_unref to
+	 * cancel requests and free in case of the last reference is dropped by
+	 * the user.
+	 */
+	request->mgmt = mgmt;
 	request->opcode = opcode;
 	request->index = index;
 
 	request->callback = callback;
 	request->destroy = destroy;
 	request->user_data = user_data;
+	request->timeout = timeout;
 
 	return request;
 }
@@ -735,10 +775,11 @@ unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 	return ret;
 }
 
-unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
-				uint16_t length, const void *param,
-				mgmt_request_func_t callback,
-				void *user_data, mgmt_destroy_func_t destroy)
+unsigned int mgmt_send_timeout(struct mgmt *mgmt, uint16_t opcode,
+				uint16_t index, uint16_t length,
+				const void *param, mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy,
+				int timeout)
 {
 	struct mgmt_request *request;
 
@@ -746,7 +787,7 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 		return 0;
 
 	request = create_request(mgmt, opcode, index, length, param,
-					callback, user_data, destroy);
+					callback, user_data, destroy, timeout);
 	if (!request)
 		return 0;
 
@@ -766,6 +807,15 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 	return request->id;
 }
 
+unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_send_timeout(mgmt, opcode, index, length, param, callback,
+					user_data, destroy, 0);
+}
+
 unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
@@ -777,7 +827,8 @@ unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index
 		return 0;
 
 	request = create_request(mgmt, opcode, index, length, param,
-					callback, user_data, destroy);
+					callback, user_data, destroy,
+					0);
 	if (!request)
 		return 0;
 
@@ -792,10 +843,11 @@ unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index
 	return request->id;
 }
 
-unsigned int mgmt_reply(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
-				uint16_t length, const void *param,
-				mgmt_request_func_t callback,
-				void *user_data, mgmt_destroy_func_t destroy)
+unsigned int mgmt_reply_timeout(struct mgmt *mgmt, uint16_t opcode,
+				uint16_t index, uint16_t length,
+				const void *param, mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy,
+				int timeout)
 {
 	struct mgmt_request *request;
 
@@ -803,7 +855,7 @@ unsigned int mgmt_reply(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 		return 0;
 
 	request = create_request(mgmt, opcode, index, length, param,
-					callback, user_data, destroy);
+					callback, user_data, destroy, timeout);
 	if (!request)
 		return 0;
 
@@ -823,6 +875,15 @@ unsigned int mgmt_reply(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 	return request->id;
 }
 
+unsigned int mgmt_reply(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_reply_timeout(mgmt, opcode, index, length, param, callback,
+						user_data, destroy, 0);
+}
+
 bool mgmt_cancel(struct mgmt *mgmt, unsigned int id)
 {
 	struct mgmt_request *request;
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 56add613d..b413cea78 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -55,6 +55,11 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
 				void *user_data, mgmt_destroy_func_t destroy);
+unsigned int mgmt_send_timeout(struct mgmt *mgmt, uint16_t opcode,
+				uint16_t index, uint16_t length,
+				const void *param, mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy,
+				int timeout);
 unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
@@ -63,6 +68,11 @@ unsigned int mgmt_reply(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
 				void *user_data, mgmt_destroy_func_t destroy);
+unsigned int mgmt_reply_timeout(struct mgmt *mgmt, uint16_t opcode,
+				uint16_t index, uint16_t length,
+				const void *param, mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy,
+				int timeout);
 bool mgmt_cancel(struct mgmt *mgmt, unsigned int id);
 bool mgmt_cancel_index(struct mgmt *mgmt, uint16_t index);
 bool mgmt_cancel_all(struct mgmt *mgmt);
-- 
2.34.1

