Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6C249E5
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935816; cv=none; b=FLaPXVE8UoeiCnunv+qxXjPWxqOmzU0SbqZJ90zAHr5Pj/FnB2LY3vCUteCks9wevVWI2YSNlm/8c1wzdjA9y2TN7Fuo+EqJ9cy594TCq3pC0GBnn6wuDv+3vHZSCrf4JXxyZnAb4zSqfuCZTy9FFhXo1vCCqbpkFBJBZ8YmgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935816; c=relaxed/simple;
	bh=edNdKBZ5plA0LT/YHTfTHpHqn0wn8LFQAWcVbM873n0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEOuKwJclHLhHP7JTwGpDOYdil3GbKasxFeyofztnMdpFl2jtDRprIsV2Cpwv+s9q2jzRiJfKcUSzXdcU3/jK9+rZyG5iSfNJeyrr+u/rIwbJcDBv7zyzHD7pYfQBq1H+oSI6mkyAt+ZT8VlfjxRHzjQmPus1/IsK5XvqRsZgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtujbaid; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtujbaid"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so1639918241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709935812; x=1710540612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55wsVvcdOoB8HNtBp2fr9/iQJweKQFrRz4cdmpf3cwg=;
        b=mtujbaidncX5CMBc7eYebVUKLw6cInw+fh/4lIkUNd+daottg28TpTXJdl5KiV4MHI
         GJLtWoqtU29sC1OoupXmrEn5J2EDt3etlZxUvkAAj6N+RZBtuhv/Fh8+c/h4Gj46VfH7
         FUnglWpd4WIAHHURCP5mMg1y5QChdU7UcPY4FoHGLySu8SNMXD+s0AmkTB8/kvDty0gu
         fqWcWhZehor0uYzKobF6Dy2Ez9bocqv20K1kSahX4C0ZFSbJva85G9LyOHyXSKwLBL4k
         GABJjZ/+rtS13mGz7PtqctlKEQvhk/7mpWaniAxPtgDaVUE++7Dc/sTogrTKb/Z1rZah
         8a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935812; x=1710540612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55wsVvcdOoB8HNtBp2fr9/iQJweKQFrRz4cdmpf3cwg=;
        b=DgqyH7/IrGCxbiXYSVoCsjXyPKoezPwZeohrBoZE1wuPBXNhGAOorq58R833J8Mz1f
         f0bTG22cTZSstM0hUS4Iu4B2eY1kqH/7WfXBIH5ZYL8LPLGsVeR2Dl2RwhrlYvpV5bt0
         5/2Hz+bC6SGsPdw94ctwgZUR/eqspO2UW1xyw1ZAWSgeRzY6uvewJK1RBHeBk/9OtWJ4
         1+Bod3mC9RAmITN7rC/4vnC/4BBagX+JlxFPbGQbuTTiS865gcdLyukoXue8lmZlXOay
         gCPhG0vAjVzywaueNAK78zpF7VFgKXAMVt6kGlup5BONeqM/7wwT2n8JawxDt591fjmK
         ZA6Q==
X-Gm-Message-State: AOJu0YxXlnBYByA2j4vaNY30PcU2p5JGvQgYXoZjv7lkZTeD1OKmBW8B
	5AScoCQQxZjzSNpOCqOl9+KIRm/QF18ZL620W+TshKQ194gFA9A6Cw+xjt1+
X-Google-Smtp-Source: AGHT+IHiGQb2fXCVK6QF4O4ICdtcSW+7IhTmuWK94G7KwgUpNYCGCkVHae9icmCeFNIF/teLvM6DlQ==
X-Received: by 2002:a05:6122:905:b0:4c9:2540:8520 with SMTP id j5-20020a056122090500b004c925408520mr812623vka.1.1709935812356;
        Fri, 08 Mar 2024 14:10:12 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id el15-20020a056122278f00b004d33d93758asm29039vkb.23.2024.03.08.14.10.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:10:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] hog-lib: Use bt_uhid_create instead of UHID_CREATE2
Date: Fri,  8 Mar 2024 17:10:05 -0500
Message-ID: <20240308221007.250681-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308221007.250681-1-luiz.dentz@gmail.com>
References: <20240308221007.250681-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid_create instead of directly submitting
UHID_CREATE2 since it can track UHID_START by itself.
---
 profiles/input/hog-lib.c | 78 +++++++---------------------------------
 1 file changed, 13 insertions(+), 65 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 67492a63eca3..ef3d6aa1b1eb 100644
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
@@ -360,15 +358,6 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 		ev.u.input.size = len;
 	}
 
-	/* If uhid had not sent UHID_START yet queue up the input */
-	if (!hog->uhid_created || !hog->uhid_start) {
-		if (!hog->input)
-			hog->input = queue_new();
-
-		queue_push_tail(hog->input, util_memdup(&ev, sizeof(ev)));
-		return;
-	}
-
 	err = bt_uhid_send(hog->uhid, &ev);
 	if (err < 0)
 		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
@@ -851,7 +840,6 @@ static void start_flags(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 
-	hog->uhid_start = true;
 	hog->uhid_flags = ev->u.start.dev_flags;
 
 	DBG("uHID device flags: 0x%16" PRIx64, hog->uhid_flags);
@@ -1037,54 +1025,26 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
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
 
@@ -1093,9 +1053,6 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
 	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
 
-	hog->uhid_created = true;
-	hog->uhid_start = false;
-
 	DBG("HoG created uHID device");
 }
 
@@ -1146,7 +1103,8 @@ static void read_report_map(struct bt_hog *hog)
 {
 	uint16_t handle;
 
-	if (!hog->report_map_attr || hog->uhid_created || hog->report_map_id)
+	if (!hog->report_map_attr || bt_uhid_created(hog->uhid) ||
+			hog->report_map_id)
 		return;
 
 	handle = gatt_db_attribute_get_handle(hog->report_map_attr);
@@ -1312,24 +1270,14 @@ static bool cancel_gatt_req(const void *data, const void *user_data)
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
 		error("bt_uhid_send: %s", strerror(-err));
 		return;
 	}
-
-	hog->uhid_created = false;
 }
 
 static void hog_free(void *data)
@@ -1810,7 +1758,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 		bt_hog_attach(instance, gatt);
 	}
 
-	if (!hog->uhid_created) {
+	if (!bt_uhid_created(hog->uhid)) {
 		DBG("HoG discovering characteristics");
 		if (hog->attr)
 			gatt_db_service_foreach_char(hog->attr,
@@ -1822,7 +1770,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 					char_discovered_cb, hog);
 	}
 
-	if (!hog->uhid_created)
+	if (!bt_uhid_created(hog->uhid))
 		return true;
 
 	/* If UHID is already created, set up the report value handlers to
-- 
2.43.0

