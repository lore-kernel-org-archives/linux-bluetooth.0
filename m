Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5F56B87
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182705; cv=none; b=S/VY5eU0RHm27/4XOpnUZqyPGDmJ+bKoIKBXkcraLixLs6Mj1uAXGu+pNRppzgtIu36Nuu5QzcxVD4/7b6aPmuNAidb6YxbROspEDZGgSMHvyBwHHp3H59a/wbRCLPXvkCHttbHZQBlfPkE/B96k33d8Txid2LpG4iB0CwZ4i1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182705; c=relaxed/simple;
	bh=FfPCppVcSYknsnxqBvS2qzmqpvVcEFIsGs6Ce+q58A4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD61zo3D0LvyIy8biZMe95B+pTPultDhtl3Mr0D6Bk3RGjs2ue8cUsCW8N0zbuZ8UJ//93wbNCk8eS0mVAfnsAxY8CdDkZPbzTAp+bKV2CpYtx2VXLvMKg9KpXBVnoNwFGkojDLuo8yjEv4DstEzCXcJED3gyipF0rMXaoh2Juk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1G574+n; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1G574+n"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d35ab44ba9so798119e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182701; x=1710787501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZM1XkQj7ah1htGxaEUTQI7nRzsS9xzGuWx9zjMLiUg=;
        b=T1G574+nqzy1gXzZO0KKdTG8/A017sFipLBUu4gn4df+RkkiyOKBjcUk6AJBKh40x0
         AE4+ZIdg6WTfjMof/hysqULYhR3smLtknc/D+sG8i08HGgrK5cbDmwU8mZTVyrb9+89o
         cBGR/Q6T17XhSX4hGrd965w3kytXvAgLdwOw3+qmlaoq7Yy+EbAdU1V/VxVdQ6t89prv
         NE9gA3PBeJe8C+8s8CYQvAjXz3cT4zm6dEIOvn96btXJNNrbngzi+apVbnF5Fe+duMiC
         HXbB33EIjXPFGMQKXsfR93Ld5g48a/lIpSDtoZagXe7qenDPyRbG358k/zSV8ml9jMg9
         PQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182701; x=1710787501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZM1XkQj7ah1htGxaEUTQI7nRzsS9xzGuWx9zjMLiUg=;
        b=tL4UDy6SI+OWo+gP1MClnEVK1a8NmRLmg2o+GnETQxuS95EDy6Ps+dlbddmqQfUfct
         vJ3my5WDt2SM3lsv2M0En33mDIBJaCXD0TNkatxPr7zY+l2lb1O4hOr89ZOniaElSYwS
         oc7PW/Q9wqHdxPVjdfrpN8dY3CusOyVyBdermDMcoZvcBzTio2BdzLvsNy+FhbQoV6kV
         JjqY76Cq8/AH2+VWtW/G7GDLNmLwo6GN3VQhVJ8dgavMtzAINvbarM9QAiAMTpOC+x01
         RgOn//AyB44xHENTnz3Dk4fwkd5gCB2b5E6VGz54QgfsFfN2tsavJw6Bj70UtyMkwybu
         pVXQ==
X-Gm-Message-State: AOJu0Yzxc2g2OlcrIA9LQodPVGhoHn7WyaD9RpwWTDMK2jiHXlfJE5Kc
	O6ImrodZQNP9y9nvRgPEt5Z+p+d3VhT60RCboTi3GfIVIpT2RkYV3m+wpcnw
X-Google-Smtp-Source: AGHT+IExLA+S8zSgmqIBol42tthtgpqnkdYoKY8NwYmMHwof51TSLMyzpNdWxKogeGmlaJwjCavvJw==
X-Received: by 2002:a05:6122:2222:b0:4c9:2540:8520 with SMTP id bb34-20020a056122222200b004c925408520mr1413429vkb.1.1710182701081;
        Mon, 11 Mar 2024 11:45:01 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056122128f00b004c003cf5e14sm672510vkp.28.2024.03.11.11.44.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:44:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] hog-lib: Use bt_uhid functions
Date: Mon, 11 Mar 2024 14:44:54 -0400
Message-ID: <20240311184456.890351-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311184456.890351-1-luiz.dentz@gmail.com>
References: <20240311184456.890351-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid function instead of directly submitting
events directly using bt_uhid_send.
---
 profiles/input/hog-lib.c | 168 ++++++---------------------------------
 1 file changed, 25 insertions(+), 143 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 67492a63eca3..8071e1364b10 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -79,8 +79,6 @@ struct bt_hog {
 	GSList			*reports;
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
-	bool			uhid_created;
-	bool			uhid_start;
 	uint64_t		uhid_flags;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
@@ -99,7 +97,6 @@ struct bt_hog {
 	struct queue		*gatt_op;
 	struct gatt_db		*gatt_db;
 	struct gatt_db_attribute	*report_map_attr;
-	struct queue		*input;
 };
 
 struct report {
@@ -326,8 +323,6 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
-	struct uhid_event ev;
-	uint8_t *buf;
 	int err;
 
 	if (len < ATT_NOTIFICATION_HEADER_SIZE) {
@@ -338,40 +333,10 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	pdu += ATT_NOTIFICATION_HEADER_SIZE;
 	len -= ATT_NOTIFICATION_HEADER_SIZE;
 
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_INPUT;
-	buf = ev.u.input.data;
-
-	/* BLUETOOTH SPECIFICATION Page 16 of 26
-	 * HID Service Specification
-	 *
-	 * Report ID shall be nonzero in a Report Reference characteristic
-	 * descriptor where there is more than one instance of the Report
-	 * characteristic for any given Report Type.
-	 */
-	if (report->numbered && report->id) {
-		buf[0] = report->id;
-		len = MIN(len, sizeof(ev.u.input.data) - 1);
-		memcpy(buf + 1, pdu, len);
-		ev.u.input.size = ++len;
-	} else {
-		len = MIN(len, sizeof(ev.u.input.data));
-		memcpy(buf, pdu, len);
-		ev.u.input.size = len;
-	}
-
-	/* If uhid had not sent UHID_START yet queue up the input */
-	if (!hog->uhid_created || !hog->uhid_start) {
-		if (!hog->input)
-			hog->input = queue_new();
-
-		queue_push_tail(hog->input, util_memdup(&ev, sizeof(ev)));
-		return;
-	}
-
-	err = bt_uhid_send(hog->uhid, &ev);
+	err = bt_uhid_input(hog->uhid, report->numbered ? report->id : 0, pdu,
+				len);
 	if (err < 0)
-		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
+		error("bt_uhid_input: %s (%d)", strerror(-err), -err);
 }
 
 static void report_notify_destroy(void *user_data)
@@ -832,56 +797,32 @@ static void set_numbered(void *data, void *user_data)
 	}
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
 static void start_flags(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 
-	hog->uhid_start = true;
 	hog->uhid_flags = ev->u.start.dev_flags;
 
 	DBG("uHID device flags: 0x%16" PRIx64, hog->uhid_flags);
 
 	if (hog->uhid_flags)
 		g_slist_foreach(hog->reports, set_numbered, hog);
-
-	queue_remove_all(hog->input, input_dequeue, hog, free);
 }
 
 static void set_report_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
 	struct bt_hog *hog = user_data;
-	struct uhid_event rsp;
 	int err;
 
 	hog->setrep_att = 0;
 
-	memset(&rsp, 0, sizeof(rsp));
-	rsp.type = UHID_SET_REPORT_REPLY;
-	rsp.u.set_report_reply.id = hog->setrep_id;
-	rsp.u.set_report_reply.err = status;
-
 	if (status != 0)
 		error("Error setting Report value: %s", att_ecode2str(status));
 
-	err = bt_uhid_send(hog->uhid, &rsp);
+	err = bt_uhid_set_report_reply(hog->uhid, hog->setrep_id, status);
 	if (err < 0)
-		error("bt_uhid_send: %s", strerror(-err));
+		error("bt_uhid_set_report_reply: %s", strerror(-err));
 }
 
 static void set_report(struct uhid_event *ev, void *user_data)
@@ -937,34 +878,16 @@ fail:
 }
 
 static void report_reply(struct bt_hog *hog, uint8_t status, uint8_t id,
-			bool numbered, uint16_t len, const uint8_t *data)
+			uint16_t len, const uint8_t *data)
 {
-	struct uhid_event rsp;
 	int err;
 
 	hog->getrep_att = 0;
 
-	memset(&rsp, 0, sizeof(rsp));
-	rsp.type = UHID_GET_REPORT_REPLY;
-	rsp.u.get_report_reply.id = hog->getrep_id;
-
-	if (status)
-		goto done;
-
-	if (numbered && len > 0) {
-		rsp.u.get_report_reply.size = len + 1;
-		rsp.u.get_report_reply.data[0] = id;
-		memcpy(&rsp.u.get_report_reply.data[1], data, len);
-	} else {
-		rsp.u.get_report_reply.size = len;
-		memcpy(rsp.u.get_report_reply.data, data, len);
-	}
-
-done:
-	rsp.u.get_report_reply.err = status;
-	err = bt_uhid_send(hog->uhid, &rsp);
+	err = bt_uhid_get_report_reply(hog->uhid, hog->getrep_id, status, id,
+					data, len);
 	if (err < 0)
-		error("bt_uhid_send: %s", strerror(-err));
+		error("bt_uhid_get_report_reply: %s", strerror(-err));
 }
 
 static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
@@ -994,7 +917,7 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 	++pdu;
 
 exit:
-	report_reply(hog, status, report->id, report->numbered, len, pdu);
+	report_reply(hog, status, report->numbered ? report->id : 0, len, pdu);
 }
 
 static void get_report(struct uhid_event *ev, void *user_data)
@@ -1030,61 +953,33 @@ static void get_report(struct uhid_event *ev, void *user_data)
 
 fail:
 	/* reply with an error on failure */
-	report_reply(hog, err, 0, false, 0, NULL);
+	report_reply(hog, err, 0, 0, NULL);
 }
 
 static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 							size_t report_map_len)
 {
 	uint8_t *value = report_map;
-	struct uhid_event ev;
 	size_t vlen = report_map_len;
-	int i, err;
+	int err;
 	GError *gerr = NULL;
-
-	if (vlen > sizeof(ev.u.create2.rd_data)) {
-		error("Report MAP too big: %zu > %zu", vlen,
-					sizeof(ev.u.create2.rd_data));
-		return;
-	}
-
-	/* create uHID device */
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_CREATE2;
+	bdaddr_t src, dst;
 
 	bt_io_get(g_attrib_get_channel(hog->attrib), &gerr,
-			BT_IO_OPT_SOURCE, ev.u.create2.phys,
-			BT_IO_OPT_DEST, ev.u.create2.uniq,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_INVALID);
-
 	if (gerr) {
 		error("Failed to connection details: %s", gerr->message);
 		g_error_free(gerr);
 		return;
 	}
 
-	/* Phys + uniq are the same size (hw address type) */
-	for (i = 0;
-	    i < (int)sizeof(ev.u.create2.phys) && ev.u.create2.phys[i] != 0;
-	    ++i) {
-		ev.u.create2.phys[i] = tolower(ev.u.create2.phys[i]);
-		ev.u.create2.uniq[i] = tolower(ev.u.create2.uniq[i]);
-	}
-
-	strncpy((char *) ev.u.create2.name, hog->name,
-						sizeof(ev.u.create2.name) - 1);
-	ev.u.create2.vendor = hog->vendor;
-	ev.u.create2.product = hog->product;
-	ev.u.create2.version = hog->version;
-	ev.u.create2.country = hog->bcountrycode;
-	ev.u.create2.bus = BUS_BLUETOOTH;
-	ev.u.create2.rd_size = vlen;
-
-	memcpy(ev.u.create2.rd_data, value, vlen);
-
-	err = bt_uhid_send(hog->uhid, &ev);
+	err = bt_uhid_create(hog->uhid, hog->name, &src, &dst,
+				hog->vendor, hog->product, hog->version,
+				hog->bcountrycode, value, vlen);
 	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
+		error("bt_uhid_create: %s", strerror(-err));
 		return;
 	}
 
@@ -1093,9 +988,6 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
 	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
 
-	hog->uhid_created = true;
-	hog->uhid_start = false;
-
 	DBG("HoG created uHID device");
 }
 
@@ -1146,7 +1038,8 @@ static void read_report_map(struct bt_hog *hog)
 {
 	uint16_t handle;
 
-	if (!hog->report_map_attr || hog->uhid_created || hog->report_map_id)
+	if (!hog->report_map_attr || bt_uhid_created(hog->uhid) ||
+			hog->report_map_id)
 		return;
 
 	handle = gatt_db_attribute_get_handle(hog->report_map_attr);
@@ -1312,24 +1205,14 @@ static bool cancel_gatt_req(const void *data, const void *user_data)
 static void uhid_destroy(struct bt_hog *hog)
 {
 	int err;
-	struct uhid_event ev;
-
-	if (!hog->uhid_created)
-		return;
 
 	bt_uhid_unregister_all(hog->uhid);
 
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-
-	err = bt_uhid_send(hog->uhid, &ev);
-
+	err = bt_uhid_destroy(hog->uhid);
 	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
+		error("bt_uhid_destroy: %s", strerror(-err));
 		return;
 	}
-
-	hog->uhid_created = false;
 }
 
 static void hog_free(void *data)
@@ -1339,7 +1222,6 @@ static void hog_free(void *data)
 	bt_hog_detach(hog);
 	uhid_destroy(hog);
 
-	queue_destroy(hog->input, free);
 	queue_destroy(hog->bas, (void *) bt_bas_unref);
 	g_slist_free_full(hog->instances, hog_free);
 
@@ -1810,7 +1692,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 		bt_hog_attach(instance, gatt);
 	}
 
-	if (!hog->uhid_created) {
+	if (!bt_uhid_created(hog->uhid)) {
 		DBG("HoG discovering characteristics");
 		if (hog->attr)
 			gatt_db_service_foreach_char(hog->attr,
@@ -1822,7 +1704,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 					char_discovered_cb, hog);
 	}
 
-	if (!hog->uhid_created)
+	if (!bt_uhid_created(hog->uhid))
 		return true;
 
 	/* If UHID is already created, set up the report value handlers to
-- 
2.43.0

