Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D921C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67590207E8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lo97V4tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgG2Ouf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2Oue (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jul 2020 10:50:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73116C061794
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2020 07:50:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d1so962946qvs.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2020 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YvbErX2MFgIDhjr2U06aFl5vOTCHhwTRMvY1z+vdWBk=;
        b=lo97V4tDZzdQqQgY9yByqEp0gIw+uqRJ55+2wtH2yhcQVeNgXC/E8RenWTPdQWOt+t
         cBmSfmaWT8O+HK5xyHYoOp4gQ1gX9mWLIb2gq53LRF/MVnRrbXzHzoFurj662gBZdHeY
         +dKkBcj0u5Jq3eXTtOOggxcwxL3k3vANKD4A37MU967JEmRqOkvDl3g6ZNhp+BveJ4WI
         g1WXLIG9WjvvINe8oJFKUJWtChiWo0U1p1Ip87QKu4GRrtL8ibT3Sno9CM7rNjX8q5eo
         dbzyO250RBWW2o8KqPciz4GJDTaVpHdIt1bMc988YF+rxodYRiNKVkHykIirkDRS9+9W
         ktVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YvbErX2MFgIDhjr2U06aFl5vOTCHhwTRMvY1z+vdWBk=;
        b=Y1lnxxEAlcEOskDQcfYNBrGm1O/wmUZqPxLt+tw0VJd2fxf7Rclqh0zqZ3UIKcPPvp
         sZJ/HVv7VYf1E5CZbKgblXyND8Cv93ugyYMhgQ+7/51MMPQr5U0Nu+OLhz/H9Nnb9F7V
         HegW1uGIs0tMhqZ8hX1oneC5EbjknyUGXev90h3zgbCCwZ2kgx9eqTAYz6x7Gogg8h5+
         pkafymHgdt73tDD5arenTaMaS2PmbZhfBU08UvQVQHuuVSplLVSNrshtKy8KuXhjD51E
         npV0w9ULnv9EoOY5Fe+7+NfRSByJ+OfwUoR4AhTajEOaiFW+ODajbgytNobZXFQP+IUV
         hQ5g==
X-Gm-Message-State: AOAM532X+VeXCvEpRnk8RScaolvYWXzHUitIucjNAZr58C7uvqLosQoB
        ERrf5hrzUthCQSf9ywEKKtd48GNeVCNPnXXAYKXOQ5GPWh3/jVy0WQIEeLE0QnUoh32ZQs4MH4B
        cCQuCyimdIrT7C1DWnROhPMRBCnxrdCXcAdVAV2qRv6GWdA0z7iO+m98JZmh7JRCM7aG2uVe0A0
        Hb
X-Google-Smtp-Source: ABdhPJzou/VuEvRxdQfWa6US/i+gDJFXnlkOifi2cAHQ53qug3a3K8J8u+OoAYBIb3zVDruWqmrAKTRMKisx
X-Received: by 2002:a0c:e5cc:: with SMTP id u12mr32971585qvm.54.1596034232862;
 Wed, 29 Jul 2020 07:50:32 -0700 (PDT)
Date:   Wed, 29 Jul 2020 22:50:19 +0800
Message-Id: <20200729224945.Bluez.v1.1.If7e0a0d17cf6c6508f68f1505fa5864af624a4b7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [Bluez PATCH v1] input/device: Implement handle for UHID_SET_REPORT
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

This patch listens to UHID_SET_REPORT event and forwards this
message to the hid device. Upon reply, we also send a report back
to the kernel as UHID_SET_REPORT_REPLY.

Furthermore, this patch also send UHID_DESTROY upon disconnection,
and replaces the obsolete UHID_FEATURE with the compatible
UHID_GET_REPORT.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 profiles/input/device.c    | 166 +++++++++++++++++++++++++++----------
 profiles/input/hidp_defs.h |   2 +-
 2 files changed, 124 insertions(+), 44 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ee0b2404a..8fc04be37 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -117,6 +117,7 @@ bool input_get_classic_bonded_only(void)
 
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
+static int uhid_disconnect(struct input_device *idev);
 
 static bool input_device_bonded(struct input_device *idev)
 {
@@ -220,7 +221,7 @@ static bool hidp_send_intr_message(struct input_device *idev, uint8_t hdr,
 	return hidp_send_message(idev->intr_io, hdr, data, size);
 }
 
-static bool uhid_send_feature_answer(struct input_device *idev,
+static bool uhid_send_get_report_reply(struct input_device *idev,
 					const uint8_t *data, size_t size,
 					uint32_t id, uint16_t err)
 {
@@ -230,8 +231,8 @@ static bool uhid_send_feature_answer(struct input_device *idev,
 	if (data == NULL)
 		size = 0;
 
-	if (size > sizeof(ev.u.feature_answer.data))
-		size = sizeof(ev.u.feature_answer.data);
+	if (size > sizeof(ev.u.get_report_reply.data))
+		size = sizeof(ev.u.get_report_reply.data);
 
 	if (!idev->uhid_created) {
 		DBG("HID report (%zu bytes) dropped", size);
@@ -239,13 +240,13 @@ static bool uhid_send_feature_answer(struct input_device *idev,
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
@@ -258,6 +259,29 @@ static bool uhid_send_feature_answer(struct input_device *idev,
 	return true;
 }
 
+static bool uhid_send_set_report_reply(struct input_device *idev,
+					uint32_t id, uint16_t err)
+{
+	struct uhid_event ev;
+	int ret;
+
+	if (!idev->uhid_created)
+		return false;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_SET_REPORT_REPLY;
+	ev.u.set_report_reply.id = id;
+	ev.u.set_report_reply.err = err;
+
+	ret = bt_uhid_send(idev->uhid, &ev);
+	if (ret < 0) {
+		error("bt_uhid_send: %s (%d)", strerror(-ret), -ret);
+		return false;
+	}
+
+	return true;
+}
+
 static bool uhid_send_input_report(struct input_device *idev,
 					const uint8_t *data, size_t size)
 {
@@ -370,6 +394,10 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if (!idev->ctrl_io && idev->virtual_cable_unplug)
 		virtual_cable_unplug(idev);
 
+	/* If connection abruptly ended, uhid might be not yet disconnected */
+	if (idev->uhid_created)
+		uhid_disconnect(idev);
+
 	return FALSE;
 }
 
@@ -399,11 +427,13 @@ static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_t param)
 	case HIDP_HSHK_ERR_FATAL:
 		if (pending_req_type == HIDP_TRANS_GET_REPORT) {
 			DBG("GET_REPORT failed (%u)", param);
-			uhid_send_feature_answer(idev, NULL, 0,
+			uhid_send_get_report_reply(idev, NULL, 0,
 						idev->report_rsp_id, EIO);
 			pending_req_complete = true;
 		} else if (pending_req_type == HIDP_TRANS_SET_REPORT) {
 			DBG("SET_REPORT failed (%u)", param);
+			uhid_send_set_report_reply(idev, idev->report_rsp_id,
+							EIO);
 			pending_req_complete = true;
 		} else
 			DBG("Spurious HIDP_HSHK_ERR");
@@ -446,7 +476,8 @@ static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
 	DBG("");
 
 	pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
-	if (pending_req_type != HIDP_TRANS_GET_REPORT) {
+	if (pending_req_type != HIDP_TRANS_GET_REPORT &&
+				pending_req_type != HIDP_TRANS_SET_REPORT) {
 		DBG("Spurious DATA on control channel");
 		return;
 	}
@@ -460,9 +491,13 @@ static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
 	switch (param) {
 	case HIDP_DATA_RTYPE_FEATURE:
 	case HIDP_DATA_RTYPE_INPUT:
-	case HIDP_DATA_RTYPE_OUPUT:
-		uhid_send_feature_answer(idev, data + 1, size - 1,
+	case HIDP_DATA_RTYPE_OUTPUT:
+		if (pending_req_type == HIDP_TRANS_GET_REPORT)
+			uhid_send_get_report_reply(idev, data + 1, size - 1,
 							idev->report_rsp_id, 0);
+		else
+			uhid_send_set_report_reply(idev, idev->report_rsp_id,
+							0);
 		break;
 
 	case HIDP_DATA_RTYPE_OTHER:
@@ -579,9 +614,13 @@ static gboolean hidp_report_req_timeout(gpointer data)
 	switch (pending_req_type) {
 	case HIDP_TRANS_GET_REPORT:
 		req_type_str = "GET_REPORT";
+		uhid_send_get_report_reply(idev, NULL, 0, idev->report_rsp_id,
+								ETIMEDOUT);
 		break;
 	case HIDP_TRANS_SET_REPORT:
 		req_type_str = "SET_REPORT";
+		uhid_send_set_report_reply(idev, idev->report_rsp_id,
+								ETIMEDOUT);
 		break;
 	default:
 		/* Should never happen */
@@ -598,6 +637,17 @@ static gboolean hidp_report_req_timeout(gpointer data)
 	return FALSE;
 }
 
+static void hidp_send_output(struct uhid_event *ev, void *user_data)
+{
+	struct input_device *idev = user_data;
+	uint8_t hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUTPUT;
+
+	DBG("");
+
+	hidp_send_intr_message(idev, hdr, ev->u.output.data,
+						ev->u.output.size);
+}
+
 static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
 {
 	struct input_device *idev = user_data;
@@ -606,34 +656,37 @@ static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
 
 	DBG("");
 
-	switch (ev->u.output.rtype) {
+	switch (ev->u.set_report.rtype) {
 	case UHID_FEATURE_REPORT:
-		/* Send SET_REPORT on control channel */
-		if (idev->report_req_pending) {
-			DBG("Old GET_REPORT or SET_REPORT still pending");
-			return;
-		}
-
 		hdr = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
-		sent = hidp_send_ctrl_message(idev, hdr, ev->u.output.data,
-							ev->u.output.size);
-		if (sent) {
-			idev->report_req_pending = hdr;
-			idev->report_req_timer =
-				g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
-						hidp_report_req_timeout, idev);
-		}
+		break;
+	case UHID_INPUT_REPORT:
+		hdr = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_INPUT;
 		break;
 	case UHID_OUTPUT_REPORT:
-		/* Send DATA on interrupt channel */
-		hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
-		hidp_send_intr_message(idev, hdr, ev->u.output.data,
-							ev->u.output.size);
+		hdr = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUTPUT;
 		break;
 	default:
-		DBG("Unsupported HID report type %u", ev->u.output.rtype);
+		DBG("Unsupported HID report type %u", ev->u.set_report.rtype);
 		return;
 	}
+
+	if (idev->report_req_pending) {
+		DBG("Old GET_REPORT or SET_REPORT still pending");
+		uhid_send_set_report_reply(idev, ev->u.set_report.id, EBUSY);
+		return;
+	}
+
+	sent = hidp_send_ctrl_message(idev, hdr, ev->u.set_report.data,
+						ev->u.set_report.size);
+	if (sent) {
+		idev->report_req_pending = hdr;
+		idev->report_req_timer =
+			g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
+					hidp_report_req_timeout, idev);
+		idev->report_rsp_id = ev->u.set_report.id;
+	} else
+		uhid_send_set_report_reply(idev, ev->u.set_report.id, EIO);
 }
 
 static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
@@ -646,13 +699,13 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
 
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
@@ -660,22 +713,24 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
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
-	}
+		idev->report_rsp_id = ev->u.get_report.id;
+	} else
+		uhid_send_get_report_reply(idev, NULL, 0, ev->u.get_report.id,
+									EIO);
 }
 
 static void epox_endian_quirk(unsigned char *data, int size)
@@ -908,14 +963,39 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 		return err;
 	}
 
-	bt_uhid_register(idev->uhid, UHID_OUTPUT, hidp_send_set_report, idev);
-	bt_uhid_register(idev->uhid, UHID_FEATURE, hidp_send_get_report, idev);
+	bt_uhid_register(idev->uhid, UHID_OUTPUT, hidp_send_output, idev);
+	bt_uhid_register(idev->uhid, UHID_GET_REPORT, hidp_send_get_report,
+									idev);
+	bt_uhid_register(idev->uhid, UHID_SET_REPORT, hidp_send_set_report,
+									idev);
 
 	idev->uhid_created = true;
 
 	return err;
 }
 
+static int uhid_disconnect(struct input_device *idev)
+{
+	int err;
+	struct uhid_event ev;
+
+	if (!idev->uhid_created)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	err = bt_uhid_send(idev->uhid, &ev);
+	if (err < 0) {
+		error("bt_uhid_send: %s", strerror(-err));
+		return err;
+	}
+
+	idev->uhid_created = false;
+
+	return err;
+}
+
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
@@ -1074,7 +1154,7 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 		idev->virtual_cable_unplug = true;
 
 	if (idev->uhid)
-		return 0;
+		return uhid_disconnect(idev);
 	else
 		return ioctl_disconnect(idev, flags);
 }
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
2.28.0.rc0.142.g3c755180ce-goog

