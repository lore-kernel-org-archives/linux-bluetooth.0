Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E551C43462
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7E61369
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 08:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347138AbhDGIiQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245372AbhDGIiP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 04:38:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6013DC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 01:38:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i6so23228508ybk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=z5xITeATKBgmYLo/GqpbsuwzH79+EZP5gqcHP+s9QWw=;
        b=km+NboSPEyhVeEb458vBzHP7v70lRWfO1iaSRKBhotrmy34BT/uqkimR+9Z17WW6YX
         gLkP1LPn55mzIN0kVMfnjEBivYY1Zv7FemIW+ZAS4JU0Gx7ks9ttgJnrPpMAV/KYgpOT
         PJ2pF7WJg+RNQ8oiqVlnDDfc9wm5UihB+r3SdpvEAKKG913AsWrxIWMlDjdOd9A/roD0
         bN8i4tkMdS+1d03be7uTlyrX3HNvrUXI/rYzXRGoplQXkXJ+wjHdkbpArPlkMIlmP7A9
         szmXU9MwP0z1AKl9q5auRXcMbn4ObHo9bKzAF5LOZCEuOVXtV36U6H9e/XVGC54UBDaU
         Rupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=z5xITeATKBgmYLo/GqpbsuwzH79+EZP5gqcHP+s9QWw=;
        b=rMkLa3ha5DwE2GIHPG55KDkbSQO/tx2ehmSX0SILkbS3KFNzl9NSPMjcqPzMdZxXnY
         iot/FxBPBnD1SWPxbPZQXajcTQrk4mo0ZD+5hlB8uxbF1AGeTw75d0+TJMN5xfdYERdx
         MtllgswiDPWN8UBr3BKjX30gIqK5PaOMymfU+Hi+yXs4rQaAfwWuXIuuqjmEeuSRz/OJ
         DjAxDNLKC1lc0mBcpTtHWJzQKYT4sdPfirYTRR6ToYw/lsxfrh2tEzjIOIxL3Q5QMh1k
         fm4X9vnKZbLPd7Z7PkXpiwGlCIgq8ET1B8ywVpv88R2e7tH4RgwO4Y6mBpPMAEEHQS39
         MwHg==
X-Gm-Message-State: AOAM532yeYG+G8UKP4RHl27OBRaQ+zAREPoPSuV5HoIGdkr0ZZdCkVxg
        UiKtfBGapQ6vyYCc3N9l933MqNF5NIWDfY+LCGUaoNjjdXZpGZzPSFaCgNm8qKAlMR0yMvAINpL
        uDBFkcwm73+U9PItt8Z3wk85K5l9u1MdMoIOiHYfXFBjtLR+7QD+Rq+fyu1jaWTYDY243cBnyx1
        ID
X-Google-Smtp-Source: ABdhPJyCYfEoGYDpD2a7WmMmm5H/fykzDlJEIYEg1nrhKXIMJPXt9eZeSyyFjL6Tbw3GAq2dNAOeDcfuB/R+
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:7515:f813:8ede:d08c])
 (user=apusaka job=sendgmr) by 2002:a25:df81:: with SMTP id
 w123mr2954751ybg.436.1617784684582; Wed, 07 Apr 2021 01:38:04 -0700 (PDT)
Date:   Wed,  7 Apr 2021 16:37:45 +0800
Message-Id: <20210407163723.Bluez.v2.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [Bluez PATCH v2] input/hog: support multiple variable length notification
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Processing Multiple Variable Length Notification is mandatory if EATT
is enabled (Core Spec Vol 3 Part G Sec 4.2).

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v2:
* fix compilation error

 attrib/att.h             |   1 +
 profiles/input/hog-lib.c | 109 ++++++++++++++++++++++++++++-----------
 src/attrib-server.c      |   1 +
 3 files changed, 81 insertions(+), 30 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 13a0c3a31f..0dbfb14b83 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -42,6 +42,7 @@
 #define ATT_OP_HANDLE_NOTIFY		0x1B
 #define ATT_OP_HANDLE_IND		0x1D
 #define ATT_OP_HANDLE_CNF		0x1E
+#define ATT_OP_HANDLE_NOTIFY_MULTI	0x23
 #define ATT_OP_SIGNED_WRITE_CMD		0xD2
 
 /* Error codes for Error response PDU */
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index e5e3d3e7f5..aa6c64a3f2 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -65,7 +65,6 @@
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
-#define ATT_NOTIFICATION_HEADER_SIZE	3
 
 struct bt_hog {
 	int			ref_count;
@@ -112,7 +111,8 @@ struct report {
 	uint16_t		value_handle;
 	uint8_t			properties;
 	uint16_t		ccc_handle;
-	guint			notifyid;
+	guint			notify_id;
+	guint			notify_multi_id;
 	uint16_t		len;
 	uint8_t			*value;
 };
@@ -283,22 +283,14 @@ static void find_included(struct bt_hog *hog, GAttrib *attrib,
 	free(req);
 }
 
-static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
+static void process_notification(struct report *report, guint16 len,
+							const uint8_t *data)
 {
-	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
 	struct uhid_event ev;
 	uint8_t *buf;
 	int err;
 
-	if (len < ATT_NOTIFICATION_HEADER_SIZE) {
-		error("Malformed ATT notification");
-		return;
-	}
-
-	pdu += ATT_NOTIFICATION_HEADER_SIZE;
-	len -= ATT_NOTIFICATION_HEADER_SIZE;
-
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_INPUT;
 	buf = ev.u.input.data;
@@ -306,19 +298,78 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	if (hog->has_report_id) {
 		buf[0] = report->id;
 		len = MIN(len, sizeof(ev.u.input.data) - 1);
-		memcpy(buf + 1, pdu, len);
-		ev.u.input.size = ++len;
+		memcpy(buf + 1, data, len);
+		ev.u.input.size = len + 1;
 	} else {
 		len = MIN(len, sizeof(ev.u.input.data));
-		memcpy(buf, pdu, len);
+		memcpy(buf, data, len);
 		ev.u.input.size = len;
 	}
 
 	err = bt_uhid_send(hog->uhid, &ev);
-	if (err < 0) {
+	if (err < 0)
 		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
-		return;
+}
+
+static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
+{
+	struct report *report = user_data;
+	uint8_t opcode = pdu[0];
+	guint16 report_len;
+	guint16 header_len;
+
+	/* Skip opcode field */
+	pdu += 1;
+	len -= 1;
+
+	if (opcode == ATT_OP_HANDLE_NOTIFY_MULTI)
+		header_len = 4;
+	else
+		header_len = 2;
+
+	if (len < header_len)
+		goto fail;
+
+	while (len >= header_len) {
+		/* Skip first 2 bytes (handle) */
+		pdu += 2;
+		len -= 2;
+
+		if (opcode == ATT_OP_HANDLE_NOTIFY_MULTI) {
+			report_len = get_le16(pdu);
+			pdu += 2;
+			len -= 2;
+
+			if (report_len > len)
+				goto fail;
+		} else {
+			report_len = len;
+		}
+
+		process_notification(report, report_len, pdu);
+
+		pdu += report_len;
+		len -= report_len;
 	}
+
+	if (len == 0)
+		return;
+
+fail:
+	error("Malformed ATT notification");
+}
+
+static void register_notify_handler(struct bt_hog *hog, struct report *report)
+{
+	report->notify_id = g_attrib_register(hog->attrib,
+					ATT_OP_HANDLE_NOTIFY,
+					report->value_handle,
+					report_value_cb, report, NULL);
+
+	report->notify_multi_id = g_attrib_register(hog->attrib,
+					ATT_OP_HANDLE_NOTIFY_MULTI,
+					report->value_handle,
+					report_value_cb, report, NULL);
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -336,13 +387,10 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	if (report->notifyid)
+	if (report->notify_id)
 		return;
 
-	report->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					report->value_handle,
-					report_value_cb, report, NULL);
+	register_notify_handler(hog, report);
 
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
@@ -1711,13 +1759,10 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-		if (r->notifyid)
+		if (r->notify_id)
 			continue;
 
-		r->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					r->value_handle,
-					report_value_cb, r, NULL);
+		register_notify_handler(hog, r);
 	}
 
 	return true;
@@ -1764,9 +1809,13 @@ void bt_hog_detach(struct bt_hog *hog)
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-		if (r->notifyid > 0) {
-			g_attrib_unregister(hog->attrib, r->notifyid);
-			r->notifyid = 0;
+		if (r->notify_id > 0) {
+			g_attrib_unregister(hog->attrib, r->notify_id);
+			r->notify_id = 0;
+		}
+		if (r->notify_multi_id > 0) {
+			g_attrib_unregister(hog->attrib, r->notify_multi_id);
+			r->notify_multi_id = 0;
 		}
 	}
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5a178f95ea..fb11d3db2d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1085,6 +1085,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		return;
 	case ATT_OP_HANDLE_IND:
 	case ATT_OP_HANDLE_NOTIFY:
+	case ATT_OP_HANDLE_NOTIFY_MULTI:
 		/* The attribute client is already handling these */
 		return;
 	case ATT_OP_READ_MULTI_REQ:
-- 
2.31.0.208.g409f899ff0-goog

