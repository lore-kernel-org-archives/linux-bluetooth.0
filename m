Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8037EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiBYWjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiBYWjk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 17:39:40 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428E31BAF2A
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 14:39:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c9so5998761pll.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzQm9qesz3ol51WyVnV6vxTJSNvdD9oLymgjxOEZYrM=;
        b=lZUFFGA2GXGbMJ+N/Auv12lGxRZxHT30Ih39ZKAyyxrdKt13UmCaE/febDIvAg/3sn
         HXt50ipkf8FZtv2Dw+fn7Txd0VeaptFBvruYRUNUF01+phRd/hc0s3yWBf0uhgiGEw6f
         +UDZj5E/xI4W7Q7Jg6R8z90iJ5WlW3s9nJFcPtJmYCY96+Xly90wBo2PmZiUYDWtTAQx
         /JbohRDBSrM2TIMuRHTZSjDSBubPXGpXXQjMUKJHP8GlStKrYQ4zw2AtLUeQB6r+0pJp
         +sNN35fIEXfw5URzC5kzHOpBAqhjUQHiUCQKVDI3r+ddiATK8zFA8eV9Y2/w4l/M4DVP
         RZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzQm9qesz3ol51WyVnV6vxTJSNvdD9oLymgjxOEZYrM=;
        b=WDK7DmYuNwJN+4QVnoFS7uCm3qkkjV11RFypdOqANqiO8nFD3dRdKdXRTvdJdVf39f
         v1nHLoZ7SDrwBDBiqHnWXIISIbU9FZttEzSmLYE1PU9ZfuQqRiwtcM66K3/Ro1pw6Jew
         wg7yzBF+9QdjScT292k+FnDedAqy/EC3adzUtFV+v+Pd5U3J8kpLynsV7XLfFUvmLUvg
         PKEzIom3zuFmPRTRa6cORiLLmJ7gw7/1uUk4O22VJkYdMJJMeDIeKQUlNd5Kjz1z5wg8
         dydyKztSY9hHyVIoV1zMV/nQlN25UF3AM7OyaiuCLkINFe7TITFqvOmp8zJOOY/0rqZ9
         6gBQ==
X-Gm-Message-State: AOAM532fvzXO2kQjWGrkVzGyvCXb8Xm0ZcCuuAGLwwD8F0atKIGz7c++
        h6vFp7ovEBpfYuvP2ZDIGm8O5ORsce0=
X-Google-Smtp-Source: ABdhPJyVoHeV/Q/kvIgDKZfrZa9QUCXRAwxEryXAEwO/5nas3DxcDNnD5P0Wen65KatqOREsE4PHfg==
X-Received: by 2002:a17:90a:8b82:b0:1b8:9624:2bab with SMTP id z2-20020a17090a8b8200b001b896242babmr5310770pjn.177.1645828746464;
        Fri, 25 Feb 2022 14:39:06 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm4671549pfv.49.2022.02.25.14.39.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:39:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] hog-lib: Fix not waiting for UHID_START
Date:   Fri, 25 Feb 2022 14:39:05 -0800
Message-Id: <20220225223905.571204-1-luiz.dentz@gmail.com>
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
 profiles/input/hog-lib.c | 41 +++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 5af99fcda..b611f6b4a 100644
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
+	if (!hog->uhid_created || !hog->uhid_start) {
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
@@ -1068,10 +1072,9 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
 
 	hog->uhid_created = true;
+	hog->uhid_start = false;
 
 	DBG("HoG created uHID device");
-
-	queue_remove_all(hog->input, input_dequeue, hog, free);
 }
 
 static void db_report_map_write_value_cb(struct gatt_db_attribute *attr,
-- 
2.35.1

