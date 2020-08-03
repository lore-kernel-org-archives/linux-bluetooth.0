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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA42206E9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXOTl8OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHCGwh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHCGwg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 02:52:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9007C06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2020 23:52:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e22so25714828pgl.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2020 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NvpgW09Qx9kcQUivEiNanw9jEQfujYcYKP6nVpJ353A=;
        b=XXOTl8OVI1+ObfPXab+XUFupwBKbeDdy/48x+KRGrapuXx49C5vJr5CDfL05I6bHk0
         e/W1fgQi2BMTskBTfTw6xY2NsLMAb0To14p/KgVEca76B3xuzRtVYUnFyOXDcwwhRii5
         wAr7CUcfxW7v4i6GbkC+HL/RYMbUY/ZRuo1GQUMh/vTO6e2AUfSEmzH5PCJFRQ23kJGR
         1f4NRv5nubH1wHAV0eoLRedY/JSX9GMQi68SXYaVerKshrUsOKkB98TLG+x2LXWcvS6D
         ECw4v36Lfvw9Z8HF+QZ46yLZLdTW/cNBzx5HzhU5qdJDb2lp42dNMREOY1+u4KpspN52
         hUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NvpgW09Qx9kcQUivEiNanw9jEQfujYcYKP6nVpJ353A=;
        b=HvtkGHeXjMim2OABrpdtp5sxmHPE7dB4VNY8N5FpYf6W2ht4cNDBYMkNVVwDtbwK1J
         bZHQaDLTgjx+VsivHwwvtAOVRN57eW2PKtu8X0WgrhKO62sUz3lda6fW7FeEw31oKogn
         UOWetuxycUl7iX94cmL2MvOZ1/rNWzVv1lbNfFQcsRwJP5yrcM54933Z3YmhzOugRQ6L
         9IbzWIdaAt1Fy2DNhjP6BxIdsvgbG/3DvowneV9NhWME9F78xxSVIk664ZM/zV2XQ+UO
         LPz/eD50P+8g8aZWHd407+ibRswkunMrRKAqz6IPM2PA0zuxIcphtX/kTzGa5ozCMLvi
         UFJA==
X-Gm-Message-State: AOAM530hUIMzS3VKCSRkZS6n/cMEhRtrJbCP842PoIwZGWYo6jyKkdPL
        H0XBaIFBdECIgcLqPk/WMuJgWx6aqzCZ9plYz5c7T//WcsTpZ+raFPWcqdLhg9cJMBLQLFbDL3z
        PhBxd+WulwxwhOLEYsWoYwnTg05+PU0xQRcDC6I0dI54KXs6tmJlTsSLA6bhJSd2yoWv0OhgBWK
        HA
X-Google-Smtp-Source: ABdhPJy+4K+dCNl8KB2HvqPEDgKNvPvKLUg1+IPvOn4PFUBGMEAS6V6claMBvCva82c1+OBu+OxRAKxn+Odh
X-Received: by 2002:a62:3741:: with SMTP id e62mr14062269pfa.127.1596437555981;
 Sun, 02 Aug 2020 23:52:35 -0700 (PDT)
Date:   Mon,  3 Aug 2020 14:52:23 +0800
In-Reply-To: <20200803145200.Bluez.v2.1.Ibf5508171632eebb66a6cd0ed2fa87bfac078f74@changeid>
Message-Id: <20200803145200.Bluez.v2.2.I90a7cdf110044e880cf5610972e93a0f47d6c9fd@changeid>
Mime-Version: 1.0
References: <20200803145200.Bluez.v2.1.Ibf5508171632eebb66a6cd0ed2fa87bfac078f74@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [Bluez PATCH v2 2/3] input/device: Implement handle for UHID_SET_REPORT
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

hidp_send_set_report no longer listen UHID_OUTPUT events, that is
handled by hidp_send_output instead.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
-Split into three patches, now this only handles UHID_SET_REPORT

 profiles/input/device.c | 100 ++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 24 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ac4487f63..757290080 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -258,6 +258,29 @@ static bool uhid_send_get_report_reply(struct input_device *idev,
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
@@ -404,6 +427,8 @@ static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_t param)
 			pending_req_complete = true;
 		} else if (pending_req_type == HIDP_TRANS_SET_REPORT) {
 			DBG("SET_REPORT failed (%u)", param);
+			uhid_send_set_report_reply(idev, idev->report_rsp_id,
+							EIO);
 			pending_req_complete = true;
 		} else
 			DBG("Spurious HIDP_HSHK_ERR");
@@ -446,7 +471,8 @@ static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
 	DBG("");
 
 	pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
-	if (pending_req_type != HIDP_TRANS_GET_REPORT) {
+	if (pending_req_type != HIDP_TRANS_GET_REPORT &&
+				pending_req_type != HIDP_TRANS_SET_REPORT) {
 		DBG("Spurious DATA on control channel");
 		return;
 	}
@@ -461,8 +487,12 @@ static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
 	case HIDP_DATA_RTYPE_FEATURE:
 	case HIDP_DATA_RTYPE_INPUT:
 	case HIDP_DATA_RTYPE_OUTPUT:
-		uhid_send_get_report_reply(idev, data + 1, size - 1,
+		if (pending_req_type == HIDP_TRANS_GET_REPORT)
+			uhid_send_get_report_reply(idev, data + 1, size - 1,
 							idev->report_rsp_id, 0);
+		else
+			uhid_send_set_report_reply(idev, idev->report_rsp_id,
+							0);
 		break;
 
 	case HIDP_DATA_RTYPE_OTHER:
@@ -579,9 +609,13 @@ static gboolean hidp_report_req_timeout(gpointer data)
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
@@ -598,6 +632,17 @@ static gboolean hidp_report_req_timeout(gpointer data)
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
@@ -606,34 +651,37 @@ static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
 
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
-		hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUTPUT;
-		hidp_send_intr_message(idev, hdr, ev->u.output.data,
-							ev->u.output.size);
+		hdr = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUTPUT;
 		break;
 	default:
-		DBG("Unsupported HID report type %u", ev->u.output.rtype);
+		DBG("Unsupported HID report type %u", ev->u.set_report.rtype);
+		return;
+	}
+
+	if (idev->report_req_pending) {
+		DBG("Old GET_REPORT or SET_REPORT still pending");
+		uhid_send_set_report_reply(idev, ev->u.set_report.id, EBUSY);
 		return;
 	}
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
@@ -675,7 +723,9 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
 			g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
 						hidp_report_req_timeout, idev);
 		idev->report_rsp_id = ev->u.get_report.id;
-	}
+	} else
+		uhid_send_get_report_reply(idev, NULL, 0, ev->u.get_report.id,
+									EIO);
 }
 
 static void epox_endian_quirk(unsigned char *data, int size)
@@ -908,9 +958,11 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 		return err;
 	}
 
-	bt_uhid_register(idev->uhid, UHID_OUTPUT, hidp_send_set_report, idev);
+	bt_uhid_register(idev->uhid, UHID_OUTPUT, hidp_send_output, idev);
 	bt_uhid_register(idev->uhid, UHID_GET_REPORT, hidp_send_get_report,
 									idev);
+	bt_uhid_register(idev->uhid, UHID_SET_REPORT, hidp_send_set_report,
+									idev);
 
 	idev->uhid_created = true;
 
-- 
2.28.0.163.g6104cc2f0b6-goog

