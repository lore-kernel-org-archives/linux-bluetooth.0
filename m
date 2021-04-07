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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D60C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 07:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE6C613A0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 07:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbhDGHRZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbhDGHRY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 03:17:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27838C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 00:17:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k15so16604617ybh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q8b+vp+Kos0XCcWOwLv4FkdpawEhpj36zdSruePcwx0=;
        b=IY4r7OiO09fjKOCPRoml8PY4t4WdK/4qABZFQ7oJKNPeLJZJ011ckzvq3FjItACY7P
         DlmHeF90rwBTCHtf+YMZDZqCiMzfiOy/egQLQFoew1d8e4xoH0eQCqFO2z2wRoIgf5qD
         g8S38uWfQJpZ7tAlls/NpWCrg3qAFCCXVAvx2Uj5snAgJL2XlJYYdvgrDIKCgYFzVHQA
         0QD0Oh37UyQSEclLYuX6/gCvQHbzLyAtB9z38XMTNjtki/CWo1pRrD5JqhDlUYNYJ1k7
         p2qncTSnU/u6XpGM4HBvAO7AqrQx+kpnvYXxMFFVrhgpYmZ/5T6YZvg88OprlHwLRX/M
         5ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q8b+vp+Kos0XCcWOwLv4FkdpawEhpj36zdSruePcwx0=;
        b=D3tGzktbbx6ohpo7PRDvptT9/V/sMt9E963Jd+ipTRKLObE6G3NfXOLvYmIffYPHTQ
         4aQWcLpT8s2bJo9PZra024ie9usmGNQ4HVcVRtLgoxEOI5Rp0HKx1qR6x/qM98pyBc5L
         //a3SB4ANAVm/SwAkVuGWiMJ+XPNYy9ndknYfM8Sd2WXplPvnQ9nyEFgYo3oo4VQ5GGv
         +0pOWJGFn3i/04xzpT1mQfdSLd+/DgESBgPHVc0AjgGHxuSoDNrIJAonpTFFvACFSxOG
         39mIiL5o/kdnGRrQqmTDr0kbs6EZu3sVhhiqrinCxiJcIbbwFIfg0NGhxaGVYIIRH1JI
         bk0A==
X-Gm-Message-State: AOAM5304RgzjAXjA7BoJokXhegamg4L/+55Qta62yjAY4W4ytofQgJGD
        LJ2E6tNJ6UDUMtvFeFvUoEuHrfi5L0hIlNEzoz2Idj3XISyaJ5q1VH7YZA41lcPeJ/1Irw6DrlY
        NT+21fMraY0FQ6iPtaSAM+NXs9Mek+lAUDB2Uk4l+Ddq68QqT3l8TZXyS7PDIebKoSfROxZxP9z
        AC
X-Google-Smtp-Source: ABdhPJy1igfU/WoiQ3OIHn1pfO7E62SSiPhvmDpsev+HomwK8SrlWd1yYSAp7VaxpExbeaDxKjHimyutJN8R
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:7515:f813:8ede:d08c])
 (user=apusaka job=sendgmr) by 2002:a25:d914:: with SMTP id
 q20mr2562987ybg.397.1617779834352; Wed, 07 Apr 2021 00:17:14 -0700 (PDT)
Date:   Wed,  7 Apr 2021 15:17:08 +0800
Message-Id: <20210407151649.Bluez.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [Bluez PATCH] input/hog: support multiple variable length notification
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

 attrib/att.h             |   1 +
 profiles/input/hog-lib.c | 105 ++++++++++++++++++++++++++++-----------
 src/attrib-server.c      |   1 +
 3 files changed, 79 insertions(+), 28 deletions(-)

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
index e5e3d3e7f5..2b81ee5b28 100644
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
@@ -339,10 +390,7 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	if (report->notifyid)
 		return;
 
-	report->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					report->value_handle,
-					report_value_cb, report, NULL);
+	register_notify_handler(hog, report);
 
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
@@ -1714,10 +1762,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 		if (r->notifyid)
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

