Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76538AC88
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920359; cv=none; b=X+tV98Yq6ciMiKWLmX97gJfvASAK96SG5auk6xYFM116K2NJL3S4SbggicyVan6KT4BCJZcQhl1iyhwi6vnns5121aiDj/FugCIDWVfksZOkkf+SLcX0I0jj5GGVrTkstVzJm4iyMNEqFE0qKJ+HCqRXaMnzGIxnbEb6hQcECUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920359; c=relaxed/simple;
	bh=8arYTOG08D7fxxHVJHDL1/W/JHhpSVXNAqwxat/+k04=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSs+Ycx0P6uzKG2+JCXn8qZ0EiXnLODK/H7SoxOa5qgtGrc3qtS3d5WfPGIqKsIm3+KxcFnsM2iLMg8gh2rIdb7xKnCsHWq5mH/+8FOVmv8WmhJYIJVLRV7lFylYrsA7wcfp+y5sYK6bCBy9Z51sz2sJslg1Ko6CPETyqOPP+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQUkziCz; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQUkziCz"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9771d9759d4so270245241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920357; x=1785525157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QXzG5OMLeGIR+r5lhnLfx7pEiMDgqM6t2rmsoQmq6aA=;
        b=jQUkziCzb8EWmgafsBqNhHagZ0isq+fYXBptON/n83cMefhL4wE8MlK1Y4nM3G+uZR
         u3YU28o+JQJuY4KTBGDahlLB1vkPv9P4XPEU67EBThOUmbJgIivQwQdveSqH/YHB84I1
         4nIcfSGQbaThFsKO2N/QTcK52xAv1WM8qREQMLjLm01Lju1BAzu8arz35kR8AmEPFuJD
         /LSQ2LU00xQVF7KiuaPVgY2yDIThu8S34lKLa+BZjanHS82i3vnm+eJQhb1Ne2mYzUAp
         B9bhhQDYPvnueInN5h73NAsXWSzUPlGCpIQvXFrfdxzBj7C8SEByR9b+qOaiKZ/ZXmRT
         5EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920357; x=1785525157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QXzG5OMLeGIR+r5lhnLfx7pEiMDgqM6t2rmsoQmq6aA=;
        b=C2DPPZUg+U3x9Bg8AkmD4ZtyrZRXPItGYwXe/UE2NZgY+P5ZUE5ShRbOj6S9zWu6U2
         +gQ40A6pbFyEclbudzVkKDtG7Y+QTb4eufSiFSolG6qr55DcXrJvuUkmXywjSUO8c8Ah
         1YlAsAKzQJgrCn9L0D1FYUVpXl/8bXpo38L9SLLz9U76wO6KZLd5S1F8OvhVwtDgoZ7x
         8c/oVrfynId3tCND11nTbvwLsHh6AenFUP38eLO08kN+EzLHNAm2TeNAlBdTE+zlrAog
         HwblrE5bPQEhsnp/MXlwNCMzwjbzuC/cuQxL3pJd1EPE5mzeQuoCBkRZps0KmI6srGbU
         HA3w==
X-Gm-Message-State: AOJu0YzmaSFgdu6mrP8swAuJQ348zNRmUsR9/zWtEYdHgno1oAlAradj
	QnhVmK4DMj2y2+ruGoq8ibGNe3bs8doIzOjQeuhepUG41Tfe6dnymgW0r3eU9geI
X-Gm-Gg: AR+sD11GUseOz7SzBawFU1xXIMI1vqvMkgIOK4grrHvvU5rKv0IkMRbGmoCmjfFd+9H
	W17ZypcgP3Brf15Ec61lJ98YNI1My6INqeIcVRB9FzNHj9tx9Fib1LvNGoYYI15tTgCDX2dHemu
	L2WAyELli/LiHGPioLDuFKv/tR7tMpXKku9/HUpoK94ht3xFPYL1UFAEBnSvooUyh/K+VNMKLSd
	IwY6CFPC7deBGqbuV2zgxUZYA+7VaIov9Eoue/PG2mFAbcmqICd7XapeEFseUcq3YdP78Qb34oJ
	piZ6KH60El6imLq+/AnS7dDUz0VVtsRLQApQh8ihc7Ep5zDCVgyJie/t4mok2s1wHWuKd4/sqaZ
	y2N8S+XP4hhJ+8Rw1NPm9pPMXiEa51jghBxehaFh0Coz5jIl8lmvuNvvnF+vyQssRO/Mbo2l/l0
	Hj+fRtvqTamRJmEsZg1KaYBNBIIjsaNU09w9NrDnNcVVCG2tH7EKlMw/urXvgM3irehdHd1vIm
X-Received: by 2002:a05:6102:f98:b0:73a:2195:4386 with SMTP id ada2fe7eead31-74d6060a001mr4420579137.24.1784920356640;
        Fri, 24 Jul 2026 12:12:36 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/12] input/hog-lib: Add discovery support for HIDS 1.1 SCI attributes
Date: Fri, 24 Jul 2026 15:12:14 -0400
Message-ID: <20260724191225.1815634-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for discovering and reading HIDS 1.1 SCI (Subrated
Connection Interval) characteristics:

 - HID SCI Mode (0x2c39)
 - HID SCI Information (0x2c3a)

When the HID Information flags indicate SCI is supported (bit 2),
the SCI Mode and SCI Information characteristics are read after
the HID Information is obtained.
---
 profiles/input/hog-lib.c | 106 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 70a1bdcbf4df..054356371ea7 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -56,6 +56,8 @@
 #define HOG_REPORT_UUID		0x2A4D
 #define HOG_PROTO_MODE_UUID	0x2A4E
 #define HOG_CONTROL_POINT_UUID	0x2A4C
+#define HOG_SCI_MODE_UUID	0x2C39
+#define HOG_SCI_INFO_UUID	0x2C3A
 
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
@@ -64,6 +66,8 @@
 #define HOG_PROTO_MODE_BOOT    0
 #define HOG_PROTO_MODE_REPORT  1
 
+#define HOG_INFO_FLAG_SCI_SUPPORTED	0x04
+
 #define HID_INFO_SIZE			4
 #define ATT_NOTIFICATION_HEADER_SIZE	3
 
@@ -98,6 +102,8 @@ struct bt_hog {
 	struct queue		*gatt_op;
 	struct gatt_db		*gatt_db;
 	struct gatt_db_attribute	*report_map_attr;
+	uint16_t		sci_mode_handle;
+	uint16_t		sci_info_handle;
 };
 
 struct report {
@@ -152,6 +158,10 @@ static void destroy_gatt_req(void *data)
 }
 
 static void read_report_map(struct bt_hog *hog);
+static void sci_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data);
+static void sci_info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data);
 
 static void remove_gatt_req(struct gatt_request *req, uint8_t status)
 {
@@ -1105,6 +1115,85 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	DBG("bcdHID: 0x%04X bCountryCode: 0x%02X Flags: 0x%02X",
 			hog->bcdhid, hog->bcountrycode, hog->flags);
 
+	/* Read SCI attributes if SCI is supported */
+	if (hog->flags & HOG_INFO_FLAG_SCI_SUPPORTED) {
+		if (hog->sci_mode_handle)
+			read_char(hog, hog->attrib, hog->sci_mode_handle,
+						sci_mode_read_cb, hog);
+		if (hog->sci_info_handle)
+			read_char(hog, hog->attrib, hog->sci_info_handle,
+						sci_info_read_cb, hog);
+	}
+
+remove:
+	remove_gatt_req(req, status);
+}
+
+static void sci_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_request *req = user_data;
+	uint8_t value;
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("HID SCI Mode read failed: %s", att_ecode2str(status));
+		goto remove;
+	}
+
+	vlen = dec_read_resp(pdu, plen, &value, sizeof(value));
+	if (vlen != 1) {
+		error("ATT protocol error");
+		goto remove;
+	}
+
+	DBG("SCI Mode: 0x%02X", value);
+
+remove:
+	remove_gatt_req(req, status);
+}
+
+static void sci_info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_request *req = user_data;
+	uint8_t value[14];
+	ssize_t vlen;
+	uint8_t min_conn_interval;
+	uint8_t num_grps;
+	uint8_t i;
+
+	if (status != 0) {
+		error("HID SCI Information read failed: %s",
+						att_ecode2str(status));
+		goto remove;
+	}
+
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 2) {
+		error("ATT protocol error");
+		goto remove;
+	}
+
+	min_conn_interval = value[0];
+	num_grps = value[1];
+
+	DBG("SCI Info: Minimum Supported Connection Interval: %.3f ms "
+		"(0x%02x) Number of Supported Subgroups: %d",
+		min_conn_interval * 0.125, min_conn_interval, num_grps);
+
+	for (i = 0; i < num_grps && (2 + i * 6 + 5) < vlen; i++) {
+		uint16_t min, max, stride;
+		size_t off = 2 + i * 6;
+
+		min = get_le16(&value[off]);
+		max = get_le16(&value[off + 2]);
+		stride = get_le16(&value[off + 4]);
+
+		DBG("  Subgroup[%u]: Min %.3f ms Max %.3f ms Stride %.3f ms",
+			i, min * 0.125, max * 0.125, stride * 0.125);
+	}
+
 remove:
 	remove_gatt_req(req, status);
 }
@@ -1150,6 +1239,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	struct gatt_primary *primary = hog->primary;
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
 	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
+	bt_uuid_t sci_mode_uuid, sci_info_uuid;
 	struct report *report;
 	GSList *l;
 	uint16_t info_handle = 0, proto_mode_handle = 0;
@@ -1167,6 +1257,8 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
 	bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
 	bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
+	bt_uuid16_create(&sci_mode_uuid, HOG_SCI_MODE_UUID);
+	bt_uuid16_create(&sci_info_uuid, HOG_SCI_INFO_UUID);
 
 	for (l = chars; l; l = g_slist_next(l)) {
 		struct gatt_char *chr, *next;
@@ -1201,6 +1293,10 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			proto_mode_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &ctrlpt_uuid) == 0)
 			hog->ctrlpt_handle = chr->value_handle;
+		else if (bt_uuid_cmp(&uuid, &sci_mode_uuid) == 0)
+			hog->sci_mode_handle = chr->value_handle;
+		else if (bt_uuid_cmp(&uuid, &sci_info_uuid) == 0)
+			hog->sci_info_handle = chr->value_handle;
 	}
 
 	if (proto_mode_handle) {
@@ -1360,7 +1456,7 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
-	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
+	bt_uuid_t proto_mode_uuid, ctrlpt_uuid, sci_mode_uuid, sci_info_uuid;
 	uint16_t handle, value_handle;
 	struct iovec map = {};
 
@@ -1414,6 +1510,14 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 	bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
 	if (!bt_uuid_cmp(&ctrlpt_uuid, &uuid))
 		hog->ctrlpt_handle = value_handle;
+
+	bt_uuid16_create(&sci_mode_uuid, HOG_SCI_MODE_UUID);
+	if (!bt_uuid_cmp(&sci_mode_uuid, &uuid))
+		hog->sci_mode_handle = value_handle;
+
+	bt_uuid16_create(&sci_info_uuid, HOG_SCI_INFO_UUID);
+	if (!bt_uuid_cmp(&sci_info_uuid, &uuid))
+		hog->sci_info_handle = value_handle;
 }
 
 static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
-- 
2.54.0

