Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FC061994
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 20:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhCVUQT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 16:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhCVUQS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 16:16:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F935C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 13:16:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so11178218pjh.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2BglIFbcf2BYrYGph2xO1jzurwYUlKCOgvHw+A6UXg=;
        b=CrnO7B3gS5LmpDLxOwj5qizRTUzYnauRSd9X0U5Rra0dXoSAIRhI+1cygbRLCyTzhp
         B//NASjQjlrXz3XKPN0Vno7w/RqEzIJjsrTtHZy7bXJW4qviP0Kv1eaiilq5u5BIwrQR
         S9rSIXe6cg386uJIPlOcAj417vCO1Uds1cpNO9BV20DfWGqytEDhNtahI3TDD1/hjCa5
         fPtboU+xL5FixEwNwWtI/3mkbZWYUzzejwIKLR/Fpo8/6vR12bTDQT74KT2ldU60EpdB
         xJilQA6hY1iycM4YWjCxmhjZD45uvQcogZycY2Aim93U8SJK7MzfSw9mec7qfzTqKNNk
         JqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2BglIFbcf2BYrYGph2xO1jzurwYUlKCOgvHw+A6UXg=;
        b=NV0cwFwmgiyt97ReRbqmXcMCWFflBkuhtcImkP3+7ENEq+U1ZNcWYhmZYi9YOIia6b
         8sbcOIJnD6JxLXSXbZY7AO4U3xmH0cGM3VFueyzECInVqSBnPEjmCg+Ca55chfirJEV+
         ES7IwfQs3u8Ej6vuTzogn39Wv7a9+KSxJp8jRsPGckzeWlQa8aZ+zVql5EAD2uLxNBIH
         R/iAQ/gPg93sz1VIr8ONLIMWR+Q1qBSoPCTrFuk68gtij34fT1o1VOd6r72tUDAIxURn
         VBiNv1fidJp4P8aMhfS0z91PT7BTLX7w26NGDoP6RXAQmzLBqkphv9s5zSZS4w1AKkhW
         gnlw==
X-Gm-Message-State: AOAM533+7yrTaf3TPttuWjEBN9vFFZX3TKPUQOePWGBhYjoLcd3qbSf8
        MWg+FOOYiJV2tps9OsCMgRdyQUrN0NGt/w==
X-Google-Smtp-Source: ABdhPJyo/C38mM+4pLVqVs7M5c72CAI0zzpWPvoCBQzEN6FAF3I4X0RANnwqefWIsNPERO3YNGiPsA==
X-Received: by 2002:a17:90a:b293:: with SMTP id c19mr769610pjr.193.1616444177269;
        Mon, 22 Mar 2021 13:16:17 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y19sm15756003pfo.0.2021.03.22.13.16.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:16:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog-lib: Fix crash when receiving UHID_GET_REPORT
Date:   Mon, 22 Mar 2021 13:16:16 -0700
Message-Id: <20210322201616.3118617-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If UHID_GET_REPORT is received but a report cannot be found, etc, the
would pass bt_hog as user_data instead of report to get_report_cb
leading to a crash.

Fixes https://github.com/bluez/bluez/issues/112
---
 profiles/input/hog-lib.c | 49 ++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 6ac14e401..e5e3d3e7f 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -786,11 +786,9 @@ fail:
 	set_report_cb(err, NULL, 0, hog);
 }
 
-static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void report_reply(struct bt_hog *hog, uint8_t status, uint8_t id,
+				 uint16_t len, const uint8_t *data)
 {
-	struct report *report = user_data;
-	struct bt_hog *hog = report->hog;
 	struct uhid_event rsp;
 	int err;
 
@@ -800,6 +798,31 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 	rsp.type = UHID_GET_REPORT_REPLY;
 	rsp.u.get_report_reply.id = hog->getrep_id;
 
+	if (status)
+		goto done;
+
+	if (hog->has_report_id && len > 0) {
+		rsp.u.get_report_reply.size = len + 1;
+		rsp.u.get_report_reply.data[0] = id;
+		memcpy(&rsp.u.get_report_reply.data[1], data, len);
+	} else {
+		rsp.u.get_report_reply.size = len;
+		memcpy(rsp.u.get_report_reply.data, data, len);
+	}
+
+done:
+	rsp.u.get_report_reply.err = status;
+	err = bt_uhid_send(hog->uhid, &rsp);
+	if (err < 0)
+		error("bt_uhid_send: %s", strerror(-err));
+}
+
+static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct report *report = user_data;
+	struct bt_hog *hog = report->hog;
+
 	if (status != 0) {
 		error("Error reading Report value: %s", att_ecode2str(status));
 		goto exit;
@@ -820,20 +843,8 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 	--len;
 	++pdu;
 
-	if (hog->has_report_id && len > 0) {
-		rsp.u.get_report_reply.size = len + 1;
-		rsp.u.get_report_reply.data[0] = report->id;
-		memcpy(&rsp.u.get_report_reply.data[1], pdu, len);
-	} else {
-		rsp.u.get_report_reply.size = len;
-		memcpy(rsp.u.get_report_reply.data, pdu, len);
-	}
-
 exit:
-	rsp.u.get_report_reply.err = status;
-	err = bt_uhid_send(hog->uhid, &rsp);
-	if (err < 0)
-		error("bt_uhid_send: %s", strerror(-err));
+	report_reply(hog, status, report->id, len, pdu);
 }
 
 static void get_report(struct uhid_event *ev, void *user_data)
@@ -868,8 +879,8 @@ static void get_report(struct uhid_event *ev, void *user_data)
 	return;
 
 fail:
-	/* cancel the request on failure */
-	get_report_cb(err, NULL, 0, hog);
+	/* reply with an error on failure */
+	report_reply(hog, err, 0, 0, NULL);
 }
 
 static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
-- 
2.30.2

