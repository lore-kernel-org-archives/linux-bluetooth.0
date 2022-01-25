Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5994DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 02:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378664AbiAYCeN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3418586AbiAYCOU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 21:14:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78478C055A8D
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 17:05:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so1001025pjb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 17:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzbjHWMiM3b6phRpAyFjxuE5+li5uZJOjLZ45cpT4Ag=;
        b=I3AFk6QSc70TjhQglpOF1AwPjHhJ5SSmP1GLq56gx4qJPquKaJ67HZtzPP6aQiCAJa
         iTR7iQsRh4cuou/Hy8aEAuAKyGaA4VsgDRF5hLIyO3UNiQ3gZwBS1Yw6fSnozbIsEe4I
         vnRBDoOmaDFBqJvVsndDc+VlYHBe/corlqC7a5HXZkGXNxVooXp0e3/iu9oGFgOZnyBe
         N8VIto1puPR6iBQsDN1MAU8EcB6fgEH/0NwIdw+h3+QrGXGZa9u2NM2wI8f4CBUYdsD2
         Md/8vJGCFE9cUsdU6BFMy5OIaFtwxv9aL5lSIPbA98BNNqF0CMCGzsjdG1TnUbhC0zpZ
         6Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzbjHWMiM3b6phRpAyFjxuE5+li5uZJOjLZ45cpT4Ag=;
        b=UfIEXp9PsAMhuqHjH2R+yVqwCSkQkHn3VJ3FWcIj9ALW1vYk4ov9RwO5OclOgVnV/p
         sJbU2ximVGGr7IpOuA2rIeeIz4fbWWZXGECIZlDwk0OtXT9Kxd4r9A1s2gdQWW95l+71
         Y2EacXOOUExFOIMTkBSVYK4TyggmV/OeQXr7RRKDYWSjyH/FyzCcJlM43HUrTvaep6yE
         2Ciwls67S/TXjqtbEBKwgxo6n8/j6UBJI7bJV/3FWU9y/eV9HkqHw6Fvr/ZHaosVG2/I
         KBF+RTVvqX1Fl4Tx44ZglP5CJrGJNc7jmueVmoLAsk+zrYLmOWS5YGlc/2/PZuWm8blR
         KofA==
X-Gm-Message-State: AOAM533YEDdU4aBGzbPD5/Z4Xtn49I6JCr9ailQWrEVyKgRXI8wY+WJu
        JpAEJL7FYkbJdIn2kdPrsIkP6CpGa6RL0w==
X-Google-Smtp-Source: ABdhPJyTX5HBw4btjymm1+QDMWBXsdyOMN/NMzWepjM1V2Dl2OpuKQsWvYbu1TvJ/L4GIa2nS5jb0Q==
X-Received: by 2002:a17:90b:384e:: with SMTP id nl14mr994585pjb.150.1643072699709;
        Mon, 24 Jan 2022 17:04:59 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id oo9sm498037pjb.15.2022.01.24.17.04.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 17:04:59 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] shared/mgmt: Add request timeout handling
Date:   Mon, 24 Jan 2022 17:04:57 -0800
Message-Id: <20220125010458.2326473-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds request timeout handling, by default the timeout is set to 2
seconds but in case the user want a different timeout it can use
mgmt_send_timeout to set a different value.
---
 src/shared/mgmt.c | 70 +++++++++++++++++++++++++++++++++++++++++------
 src/shared/mgmt.h |  5 ++++
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 41457b430..291a2c636 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -25,6 +25,9 @@
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/timeout.h"
+
+#define MGMT_TIMEOUT 2
 
 struct mgmt {
 	int ref_count;
@@ -49,6 +52,7 @@ struct mgmt {
 };
 
 struct mgmt_request {
+	struct mgmt *mgmt;
 	unsigned int id;
 	uint16_t opcode;
 	uint16_t index;
@@ -57,6 +61,8 @@ struct mgmt_request {
 	mgmt_request_func_t callback;
 	mgmt_destroy_func_t destroy;
 	void *user_data;
+	int timeout;
+	unsigned int timeout_id;
 };
 
 struct mgmt_notify {
@@ -81,6 +87,9 @@ static void destroy_request(void *data)
 	if (request->destroy)
 		request->destroy(request->user_data);
 
+	if (request->timeout_id)
+		timeout_remove(request->timeout_id);
+
 	free(request->buf);
 	free(request);
 }
@@ -150,6 +159,26 @@ static void write_watch_destroy(void *user_data)
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
@@ -169,6 +198,12 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
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
@@ -566,7 +601,8 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
 static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
 				uint16_t index, uint16_t length,
 				const void *param, mgmt_request_func_t callback,
-				void *user_data, mgmt_destroy_func_t destroy)
+				void *user_data, mgmt_destroy_func_t destroy,
+				int timeout)
 {
 	struct mgmt_request *request;
 	struct mgmt_hdr *hdr;
@@ -598,12 +634,18 @@ static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
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
@@ -735,10 +777,11 @@ unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
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
 
@@ -746,7 +789,7 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 		return 0;
 
 	request = create_request(mgmt, opcode, index, length, param,
-					callback, user_data, destroy);
+					callback, user_data, destroy, timeout);
 	if (!request)
 		return 0;
 
@@ -766,6 +809,15 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 	return request->id;
 }
 
+unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_send_timeout(mgmt, opcode, index, length, param, callback,
+					user_data, destroy, MGMT_TIMEOUT);
+}
+
 unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
@@ -777,7 +829,8 @@ unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index
 		return 0;
 
 	request = create_request(mgmt, opcode, index, length, param,
-					callback, user_data, destroy);
+					callback, user_data, destroy,
+					MGMT_TIMEOUT);
 	if (!request)
 		return 0;
 
@@ -803,7 +856,8 @@ unsigned int mgmt_reply(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 		return 0;
 
 	request = create_request(mgmt, opcode, index, length, param,
-					callback, user_data, destroy);
+					callback, user_data, destroy,
+					MGMT_TIMEOUT);
 	if (!request)
 		return 0;
 
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 56add613d..e4f1a7934 100644
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
-- 
2.34.1

