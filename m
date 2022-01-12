Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF3FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jan 2022 22:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiALWsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jan 2022 17:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiALWsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jan 2022 17:48:45 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E54BC061748
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 14:48:45 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id w9so5773076iol.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 14:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=p/5eE7orLsIcNXsuvHQEKwUG1gSvQ6fLVrrHDFuDJRc=;
        b=pUnh/uIuQb7hoUHUwbPDOISHNdMp5hmM4h63sXSLLVcCq5HW29BsZFmYdkyqC4gnxY
         xZrF26s88VI+w717YdOCGiIZpnDHPAquMweP5EKu503gQHpD5KfZ5T8YZ3yNIFXe2TCf
         BlB4aDKecCRXSKAMF7oDmlv4TkKJ+2a9B05ufvX8ppaBAd/sdceZpOYMbmryxysmTNQs
         HGrCCW8q40f4WKFENMOYK0+O8oTy5Y3xFK+hABcpvnFnZndrXNFUxLhteV3c0ott74jz
         KapTREUX0+ErZU0J87K9hgIiO/r4WmIhio/SsyEXwXd4ffpHG6STSVuIrGCQl3+XG7P/
         xSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/5eE7orLsIcNXsuvHQEKwUG1gSvQ6fLVrrHDFuDJRc=;
        b=pt3cc8nbdQ6xfz3B/buX2SeMV+LZcBmR9dcmWoFwQNIaqNXkDp9lwCLaIqz4swhRPk
         yXpBS1cmErYJf1wMZRudXrK9k/5PakgKZWBxoNeOjl8oTJxjUOqNWvaOj0ex2KM4SteQ
         x7IT6nMM76zb7YkFZZqxjB0XG0nmD/0KPeYAvILG3ymo+QJUyOD8tAGAZgMpRNDqBiW9
         LX4VyXMgVnMXkH83fwEKX3Yr1w1KsxErY95S2dB0gF+VltsWqYi94BNNagwhXggS9hj5
         fadyowX3VrncajjJGUsLW/iCS1Xl4651aTvTFLsqyOufxcG9psPgzcGi9O1FkHuBvwhO
         3pfQ==
X-Gm-Message-State: AOAM5316sZvOf6eEcApvuOkFJX1HDqxitZMnJQTrYw2+d69mijXBVKd3
        /qrWnC8Uu1fsadYy956HpfUksH5oq2s=
X-Google-Smtp-Source: ABdhPJzqeM9n66xkW9bVopwupHfyrkBTWau+UsYb4N4msog2w2CpNDqx/ZLO5EwZuTHEUbRjweUhBg==
X-Received: by 2002:a05:6602:ca:: with SMTP id z10mr863949ioe.117.1642027724236;
        Wed, 12 Jan 2022 14:48:44 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o12sm777209ilu.86.2022.01.12.14.48.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:48:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] hog: Add input queue while uhid device has not been created
Date:   Wed, 12 Jan 2022 14:48:42 -0800
Message-Id: <20220112224842.519814-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220112224842.519814-1-luiz.dentz@gmail.com>
References: <20220112224842.519814-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since report map is only read after all reports it is possible to start
receiving notifications before uhid has been created, so this adds a
queue to store the events while the report map is pending and once uhid
has been created dequeue the events.
---
 profiles/input/hog-lib.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index beb19af70..0b375feb8 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -98,6 +98,7 @@ struct bt_hog {
 	struct queue		*gatt_op;
 	struct gatt_db		*gatt_db;
 	struct gatt_db_attribute	*report_map_attr;
+	struct queue		*input;
 };
 
 struct report_map {
@@ -355,11 +356,18 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 		ev.u.input.size = len;
 	}
 
-	err = bt_uhid_send(hog->uhid, &ev);
-	if (err < 0) {
-		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
+	/* If uhid had not been created yet queue up the input */
+	if (!hog->uhid_created) {
+		if (!hog->input)
+			hog->input = queue_new();
+
+		queue_push_tail(hog->input, util_memdup(&ev, sizeof(ev)));
 		return;
 	}
+
+	err = bt_uhid_send(hog->uhid, &ev);
+	if (err < 0)
+		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -993,6 +1001,21 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 	return str;
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
 static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 							ssize_t report_map_len)
 {
@@ -1072,6 +1095,8 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 	hog->uhid_created = true;
 
 	DBG("HoG created uHID device");
+
+	queue_remove_all(hog->input, input_dequeue, hog, free);
 }
 
 static void db_report_map_write_value_cb(struct gatt_db_attribute *attr,
@@ -1284,6 +1309,7 @@ static void hog_free(void *data)
 
 	bt_hog_detach(hog);
 
+	queue_destroy(hog->input, free);
 	queue_destroy(hog->bas, (void *) bt_bas_unref);
 	g_slist_free_full(hog->instances, hog_free);
 
-- 
2.33.1

