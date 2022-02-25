Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39721C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 22:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiBYWVy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBYWVx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 17:21:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E61A6FBE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 14:21:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z2so5927890plg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEN/dCUpS+UrJze4tcYBCH3t9ePSjmcjsOenxAlYHV8=;
        b=Lr1tchV38447lptCdCXaBn8UKvdZZCEf0kPwvk2Q3FsjE6JYfGTUar62npSHd4Z6vu
         X96cRIOYld0hinVxiCkghYZ68jgV1RfDMHAo99i/c2mN+NlhL7h9eQyWX5UBp1W48R6U
         L3YA4BMkEXCcaCnyy8MWPXj/E41DDSNhE+WHtcvweAeDMCHUgURawQzwjZ4xYZLYOc8u
         lexjvq4JJybEosmlK4Y6WCKD63UG/GnqBKzwsWA0H8LAZA7C+zXGl37lJGdWOT7bT5uj
         8Zzz2Al5kztKAqYjbDjQrEGZP9HZi5YT2w7UnLe0tHBSCKZP2UFPxObxmWYIIhGLsgcq
         aNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEN/dCUpS+UrJze4tcYBCH3t9ePSjmcjsOenxAlYHV8=;
        b=wMLUj1Zi1ewJk6EEZi1En6y5H/5QMp/7iR7rUN4afCNRiHxU6r76OAHmLKz8cJzZmk
         mcMlLa7Jwfg/ZwSYqMHwkRAKqA7Or8pFIMHXbzjSuLR+bf2N8MSQoxkk/qYnhsjFjEoC
         3ktbB8m4ZiKuqiWfz8g3Q6HjpEfNstC1InYkYjyy2i/75vScqVf82DiSXKK9UnTsXoti
         dr2raRA0EpaTvbPVjlJM1eWN0/5msjNpAuq6DQgrOpOQMoxHAMw9hSCEOSvUy8GwXRxP
         u8PkysnEO/TkyzycOJod9z7klCkjLx1jjLF4F0EG5m7Io3Adp0t7rTezgR2BOsmxx/H5
         2r+w==
X-Gm-Message-State: AOAM533OCbHuCcPfy2Ubw6h/KesIyUotNndrgLZN9aQD7hzyrR01ODe+
        B6mo31JyBWyUub2TYQzZ59doX646yfw=
X-Google-Smtp-Source: ABdhPJxuGD2r8MizboUZibzhKoQd48yKp4omj7zM9TSdBnWrmB5fpNpK5f0jwO+7xHVYnYfDp7l6Ew==
X-Received: by 2002:a17:902:a98b:b0:14f:ae28:c660 with SMTP id bh11-20020a170902a98b00b0014fae28c660mr9620107plb.94.1645827680347;
        Fri, 25 Feb 2022 14:21:20 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ep5-20020a17090ae64500b001bc56af507dsm10187736pjb.47.2022.02.25.14.21.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:21:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog-lib: Fix not waiting for UHID_START
Date:   Fri, 25 Feb 2022 14:21:19 -0800
Message-Id: <20220225222119.567035-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With use of UHID_CREATE2 the code needs to wait for UHID_START in order
to know if the reports are numbered or not.

Fixes: https://github.com/bluez/bluez/issues/298
---
 profiles/input/hog-lib.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 5af99fcda..e3f3f8f91 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -81,6 +81,7 @@ struct bt_hog {
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
 	bool			uhid_created;
+	bool			uhid_start;
 	uint64_t		uhid_flags;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
@@ -358,8 +359,8 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 		ev.u.input.size = len;
 	}
 
-	/* If uhid had not been created yet queue up the input */
-	if (!hog->uhid_created) {
+	/* If uhid had not sent UHID_START yet queue up the input */
+	if (!hog->uhid_start) {
 		if (!hog->input)
 			hog->input = queue_new();
 
@@ -809,16 +810,34 @@ static void set_numbered(void *data, void *user_data)
 	}
 }
 
+static bool input_dequeue(const void *data, const void *match_data)
+{
+	const struct uhid_event *ev = data;
+	const struct bt_hog *hog = match_data;
+	int err;
+
+	err = bt_uhid_send(hog->uhid, ev);
+	if (err < 0) {
+		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
+		return false;
+	}
+
+	return true;
+}
+
 static void start_flags(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 
+	hog->uhid_start = true;
 	hog->uhid_flags = ev->u.start.dev_flags;
 
 	DBG("uHID device flags: 0x%16" PRIx64, hog->uhid_flags);
 
 	if (hog->uhid_flags)
 		g_slist_foreach(hog->reports, set_numbered, hog);
+
+	queue_remove_all(hog->input, input_dequeue, hog, free);
 }
 
 static void set_report_cb(guint8 status, const guint8 *pdu,
@@ -992,21 +1011,6 @@ fail:
 	report_reply(hog, err, 0, false, 0, NULL);
 }
 
-static bool input_dequeue(const void *data, const void *match_data)
-{
-	const struct uhid_event *ev = data;
-	const struct bt_hog *hog = match_data;
-	int err;
-
-	err = bt_uhid_send(hog->uhid, ev);
-	if (err < 0) {
-		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
-		return false;
-	}
-
-	return true;
-}
-
 static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 							size_t report_map_len)
 {
@@ -1070,8 +1074,6 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 	hog->uhid_created = true;
 
 	DBG("HoG created uHID device");
-
-	queue_remove_all(hog->input, input_dequeue, hog, free);
 }
 
 static void db_report_map_write_value_cb(struct gatt_db_attribute *attr,
-- 
2.35.1

