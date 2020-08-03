Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BEEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BD5206E9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhAHmpe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgHCGwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHCGwd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 02:52:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF81C06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2020 23:52:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so29752123ybh.21
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2020 23:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kvGLc9MoMctHddyD48jmqsqHTMBXm6uOmxj+kdRL0nk=;
        b=rhAHmpe+hMPJWKIWqshL8K8rQAnWp6jnNbozbsIfUvk29jQojR+OHtK8wm4gXmlf3S
         aFs/ySkdSJS5Eac/O8wp3SXMb30RvKEB7N1AQS6N2+KeSrBLzofUfvN6iepL6vtkuQye
         I1dDEVgCo7MjpDmsZYN+Ct7cl36Nhwk05NDphorzWADmg4TPPMCYI2xNE7wond0UywK7
         SdWA7b4hsMMwDsQGQ43E3Z7w+Bg1yK0fVV+DZsuLsyH9zfjxf7mxTBzY05WQJwKkU86Q
         C6X5BR5VQb4UOmZTrVK6d8VP6ZnkmLkRX6nAnHP5GMDyfPUaX1ENWgqKykL9fPMvkylX
         3cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kvGLc9MoMctHddyD48jmqsqHTMBXm6uOmxj+kdRL0nk=;
        b=gZth7kMlBOTfRabtRnAW47WkOfZfxO5cdnCPVuSF9odDO0o6dcUvtr/r7S6NK5wHIX
         BRAa3upEmd2gDUbndo4edID4MmdZ8PBzoiF/v+pMZ0rA6nMuaqhrQD3RpcHxwqFw/PcG
         WaODKs7S1sr+18hukJLpNAvt7OjE4f4XovlDFLpO+YNZAUpFdtj/QFefW5UWqzJzn7Mc
         Z1kKI3MyuIk8jr4x30lR5YvGlWFFc2ZYSQIHzB7b7VIn8OyVt9xE3fMav5KjX1mkNkP4
         8JxS4yIgp7ZIg9iSUeNbZHkZqLul+g00egxLZtHxIAK8KU6SHuNZNFbDF2WkzfL5M+Yf
         j+fQ==
X-Gm-Message-State: AOAM532Z49koVIYBBSwOZRzLL7ciwS3Oyz1hRZmmP3ubrc509EJRN0mA
        3UDxtJXIUGPhpeHYB/GTNuNjr9pB8PwGWwMnTByTKSLSrKqpoxH37+cTOhifZWfIbzUFlTWYqQy
        GteqNgR5Qe9XwctxuAf+Tu0BMB+NnBjXvmYdyBE1q3zM3JzcErRCNZIPEQn6Lw2L0Vmw28JL8QF
        pW
X-Google-Smtp-Source: ABdhPJx90jasNTt6/kbdQFWPhXuloV9ACsUp3X1TiGC70uhv9sRL/Y3PpsOc/hk9C8Mb+sZFXABzdUrsHdx0
X-Received: by 2002:a25:d98f:: with SMTP id q137mr21530834ybg.480.1596437552064;
 Sun, 02 Aug 2020 23:52:32 -0700 (PDT)
Date:   Mon,  3 Aug 2020 14:52:22 +0800
Message-Id: <20200803145200.Bluez.v2.1.Ibf5508171632eebb66a6cd0ed2fa87bfac078f74@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [Bluez PATCH v2 1/3] input/device: Replace UHID_FEATURE with UHID_GET_REPORT
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to kernel's uhid.h, UHID_FEATURE is obsolete and is
replaced with UHID_GET_REPORT.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
-Split into three patches, now this only handles UHID_GET_REPORT

 profiles/input/device.c    | 41 +++++++++++++++++++-------------------
 profiles/input/hidp_defs.h |  2 +-
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ee0b2404a..ac4487f63 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -220,7 +220,7 @@ static bool hidp_send_intr_message(struct input_device *idev, uint8_t hdr,
 	return hidp_send_message(idev->intr_io, hdr, data, size);
 }
 
-static bool uhid_send_feature_answer(struct input_device *idev,
+static bool uhid_send_get_report_reply(struct input_device *idev,
 					const uint8_t *data, size_t size,
 					uint32_t id, uint16_t err)
 {
@@ -230,8 +230,8 @@ static bool uhid_send_feature_answer(struct input_device *idev,
 	if (data == NULL)
 		size = 0;
 
-	if (size > sizeof(ev.u.feature_answer.data))
-		size = sizeof(ev.u.feature_answer.data);
+	if (size > sizeof(ev.u.get_report_reply.data))
+		size = sizeof(ev.u.get_report_reply.data);
 
 	if (!idev->uhid_created) {
 		DBG("HID report (%zu bytes) dropped", size);
@@ -239,13 +239,13 @@ static bool uhid_send_feature_answer(struct input_device *idev,
 	}
 
 	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_FEATURE_ANSWER;
-	ev.u.feature_answer.id = id;
-	ev.u.feature_answer.err = err;
-	ev.u.feature_answer.size = size;
+	ev.type = UHID_GET_REPORT_REPLY;
+	ev.u.get_report_reply.id = id;
+	ev.u.get_report_reply.err = err;
+	ev.u.get_report_reply.size = size;
 
 	if (size > 0)
-		memcpy(ev.u.feature_answer.data, data, size);
+		memcpy(ev.u.get_report_reply.data, data, size);
 
 	ret = bt_uhid_send(idev->uhid, &ev);
 	if (ret < 0) {
@@ -399,7 +399,7 @@ static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_t param)
 	case HIDP_HSHK_ERR_FATAL:
 		if (pending_req_type == HIDP_TRANS_GET_REPORT) {
 			DBG("GET_REPORT failed (%u)", param);
-			uhid_send_feature_answer(idev, NULL, 0,
+			uhid_send_get_report_reply(idev, NULL, 0,
 						idev->report_rsp_id, EIO);
 			pending_req_complete = true;
 		} else if (pending_req_type == HIDP_TRANS_SET_REPORT) {
@@ -460,8 +460,8 @@ static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
 	switch (param) {
 	case HIDP_DATA_RTYPE_FEATURE:
 	case HIDP_DATA_RTYPE_INPUT:
-	case HIDP_DATA_RTYPE_OUPUT:
-		uhid_send_feature_answer(idev, data + 1, size - 1,
+	case HIDP_DATA_RTYPE_OUTPUT:
+		uhid_send_get_report_reply(idev, data + 1, size - 1,
 							idev->report_rsp_id, 0);
 		break;
 
@@ -626,7 +626,7 @@ static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
 		break;
 	case UHID_OUTPUT_REPORT:
 		/* Send DATA on interrupt channel */
-		hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
+		hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUTPUT;
 		hidp_send_intr_message(idev, hdr, ev->u.output.data,
 							ev->u.output.size);
 		break;
@@ -646,13 +646,13 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
 
 	if (idev->report_req_pending) {
 		DBG("Old GET_REPORT or SET_REPORT still pending");
-		uhid_send_feature_answer(idev, NULL, 0, ev->u.feature.id,
+		uhid_send_get_report_reply(idev, NULL, 0, ev->u.get_report.id,
 									EBUSY);
 		return;
 	}
 
 	/* Send GET_REPORT on control channel */
-	switch (ev->u.feature.rtype) {
+	switch (ev->u.get_report.rtype) {
 	case UHID_FEATURE_REPORT:
 		hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_FEATURE;
 		break;
@@ -660,21 +660,21 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
 		hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_INPUT;
 		break;
 	case UHID_OUTPUT_REPORT:
-		hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_OUPUT;
+		hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_OUTPUT;
 		break;
 	default:
-		DBG("Unsupported HID report type %u", ev->u.feature.rtype);
+		DBG("Unsupported HID report type %u", ev->u.get_report.rtype);
 		return;
 	}
 
-	sent = hidp_send_ctrl_message(idev, hdr, &ev->u.feature.rnum,
-						sizeof(ev->u.feature.rnum));
+	sent = hidp_send_ctrl_message(idev, hdr, &ev->u.get_report.rnum,
+						sizeof(ev->u.get_report.rnum));
 	if (sent) {
 		idev->report_req_pending = hdr;
 		idev->report_req_timer =
 			g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
 						hidp_report_req_timeout, idev);
-		idev->report_rsp_id = ev->u.feature.id;
+		idev->report_rsp_id = ev->u.get_report.id;
 	}
 }
 
@@ -909,7 +909,8 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 	}
 
 	bt_uhid_register(idev->uhid, UHID_OUTPUT, hidp_send_set_report, idev);
-	bt_uhid_register(idev->uhid, UHID_FEATURE, hidp_send_get_report, idev);
+	bt_uhid_register(idev->uhid, UHID_GET_REPORT, hidp_send_get_report,
+									idev);
 
 	idev->uhid_created = true;
 
diff --git a/profiles/input/hidp_defs.h b/profiles/input/hidp_defs.h
index 5dc479acf..bb9231dbb 100644
--- a/profiles/input/hidp_defs.h
+++ b/profiles/input/hidp_defs.h
@@ -63,7 +63,7 @@
 #define HIDP_DATA_RSRVD_MASK			0x0c
 #define HIDP_DATA_RTYPE_OTHER			0x00
 #define HIDP_DATA_RTYPE_INPUT			0x01
-#define HIDP_DATA_RTYPE_OUPUT			0x02
+#define HIDP_DATA_RTYPE_OUTPUT			0x02
 #define HIDP_DATA_RTYPE_FEATURE			0x03
 
 /* HIDP protocol header parameters */
-- 
2.28.0.163.g6104cc2f0b6-goog

