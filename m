Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2107C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 00:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiCWAI0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbiCWAIZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 20:08:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B625E143
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c23so93753plo.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oA2b2MSFZ5xMIcZQftlPk/BJnbKEpfSvA/B3B3AZtBo=;
        b=S+ACimeHKf47x+75YpDn69/Ldbv0OJymFBKcQqFOdIPso+b8VZ+YN01psvbsnJizhM
         zhiW/8rm0kbwUwZPoP0zFEyW2O5uTxTEzBe3YCtq75NXY3GkruZ5yj9NUxnujG8I9+b2
         6Yj1JpX6Y3pOetnrDBkjVgdyFGoNgRs6eCSagp63hUpDHvgS4YI1CUpqnLG/4kQ7yuxx
         TcHjnRKxFrY5n5S4te62FXawSP7BjNTZWJFh2l/x0G7V+T65ZF322E/GFYvKxHoZtJyE
         xDT1GJQfwwn/OeqMTsz2/vu5v19/t4QiR6JcychiVFLAmqkpb3g46jJqCyRBPNeaIpwG
         Haeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oA2b2MSFZ5xMIcZQftlPk/BJnbKEpfSvA/B3B3AZtBo=;
        b=N6cR/yMAMy9np6wyVMW5TZ0DhttKRiHoIGn/wd5U3lXReGcNBs+uwu4NZ7LkQXboiM
         FMzvDRM968ZAQaBVsQNTyoemolUdxpuWadj8xKqMUPs4hLr5i104ZjwoP3Jx5Ppg/3PN
         f2pxdgHLOBcp5bUpxpgSZtTcBk5EbzlRc4elJSDTtuAKTKJdpOeGLM5JA49iMN3qIRI1
         Z9pWGjeJrLzX1POp0XQWsvbdHBlTAw0QB2sSREn8mowDCbACKu/cTxNfex544TSbeRyJ
         w+Y4sLXcThs+LpUCxs3/WFWkSf204jDGE2VNUlzmWHp/XxoWF5F/SOGaHLOCzAUU6UYZ
         UpXw==
X-Gm-Message-State: AOAM531ID2ShBZc3psYIX3ku6BZPn3woY5ZJbI7vY9aq2Q9tIfQZYSic
        rNAoz4/6JjwjZp4l+XKHclY6Bvi1bBk=
X-Google-Smtp-Source: ABdhPJx3gzXoOPQfoQY5i9y0jNOekjrbGNXTGeqz178v+rkSw5WDfX3xSbC9tiRD4Ztrhc1LRzsSGg==
X-Received: by 2002:a17:903:1209:b0:14e:e31c:b8c4 with SMTP id l9-20020a170903120900b0014ee31cb8c4mr20951542plh.153.1647994016832;
        Tue, 22 Mar 2022 17:06:56 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm10098423pfb.196.2022.03.22.17.06.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 17:06:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/9] mgmt: Introduce mgmt_set_verbose
Date:   Tue, 22 Mar 2022 17:06:48 -0700
Message-Id: <20220323000654.3157833-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323000654.3157833-1-luiz.dentz@gmail.com>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces mgmt_set_verbose which can be used to enable printing
the the likes hexdump of packets, by default it is disabled since in
most cases the hexdump is not very useful and there are better tools
to collect the hexdumo like btmon.
---
 src/shared/mgmt.c | 24 ++++++++++++++++++++----
 src/shared/mgmt.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index c7e6a6c1d..cf518cc2b 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -50,6 +50,7 @@ struct mgmt {
 	mgmt_debug_func_t debug_callback;
 	mgmt_destroy_func_t debug_destroy;
 	void *debug_data;
+	bool verbose;
 };
 
 struct mgmt_request {
@@ -192,6 +193,15 @@ static void mgmt_log(struct mgmt *mgmt, const char *format, ...)
 	va_end(ap);
 }
 
+static void mgmt_hexdump(struct mgmt *mgmt, char dir, const void *data,
+							size_t len)
+{
+	if (!mgmt->verbose)
+		return;
+
+	util_hexdump(dir, data, len, mgmt->debug_callback, mgmt->debug_data);
+}
+
 static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 {
 	struct iovec iov;
@@ -219,8 +229,7 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 
 	DBG(mgmt, "[0x%04x] command 0x%04x", request->index, request->opcode);
 
-	util_hexdump('<', request->buf, ret, mgmt->debug_callback,
-							mgmt->debug_data);
+	mgmt_hexdump(mgmt, '<', request->buf, ret);
 
 	queue_push_tail(mgmt->pending_list, request);
 
@@ -373,8 +382,7 @@ static bool can_read_data(struct io *io, void *user_data)
 	if (bytes_read < 0)
 		return false;
 
-	util_hexdump('>', mgmt->buf, bytes_read,
-				mgmt->debug_callback, mgmt->debug_data);
+	mgmt_hexdump(mgmt, '>', mgmt->buf, bytes_read);
 
 	if (bytes_read < MGMT_HDR_SIZE)
 		return true;
@@ -594,6 +602,14 @@ bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
 	return true;
 }
 
+void mgmt_set_verbose(struct mgmt *mgmt, bool value)
+{
+	if (!mgmt)
+		return;
+
+	mgmt->verbose = value;
+}
+
 bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
 {
 	if (!mgmt)
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index b413cea78..0f3e54c16 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -28,6 +28,7 @@ typedef void (*mgmt_debug_func_t)(const char *str, void *user_data);
 
 bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
 				void *user_data, mgmt_destroy_func_t destroy);
+void mgmt_set_verbose(struct mgmt *mgmt, bool value);
 
 bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
 
-- 
2.35.1

