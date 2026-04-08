Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809E17A300
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679210; cv=none; b=Jh2opqEhz1rJv4qeUsUntbs8PQJPw4As3TGizuBRTODlhnuv97zEr2ORT3Waw5VFi0gOS9FjVGdiquJOGxaI1e9TwDARU655jdAKyVnyyEQyIhlCjXOPB4iq/BzQNTp6MRhR37Lb9ReiNa4RmVp0P7xDi9W4R7OPteENDPf8ciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679210; c=relaxed/simple;
	bh=cLueYuXPRXrEtmcsRJp5N8hbm8RBUvkyXmbTAgpTJ4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HAZ8yPZMyF+NWRj5oY1JeASYuSWrNUAdhHNXdwpTTp0KLpRVtce2fltlgKeXQEE4iXb0tTBwJEFOj7S//+JVo/ASQCVsw9aXY8HtM450IMSa7Y48zpBvCxNOC5bLDshX+pxWyIFcBPfuZyASTT+4HVUZ2EV7au8AuIlMf/FF9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T24i3yx+; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T24i3yx+"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56daad0fdbaso40550e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679208; x=1776284008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAAT29BiVvyrPoVuH3xD+9nhk6leM/U8wh7yovvVAAw=;
        b=T24i3yx+VuFW0TdaSe0p9DSfjUO7k4lbIIkwgdfn1/NIRXPFFgGBCQ0kwbR29PUT3H
         fubnV8opcF6w8GszJQGpFsYa/VASx9Ap5nBdemKJMPN+L571pUyNgD5Oorb8AwKCrsMq
         CrRM4GWRAl0rAuE/NzibjIb11KZA68EjerOnG/VFuOY2AU920jVvCXub6D2L4Cr6YQNE
         f7NajTJpS/XzgbfATcye9uahe6E1vqEH54fqjoMbDJre+Ttp7pWRza6CRoAG3aaq7iM/
         ZKkscyadmEevJrju/mGMTKbUgaU10Ct12CTuAGxwxj3MZ6Pmbl1+zK2f4yrNh4FTFenO
         hSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679208; x=1776284008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAAT29BiVvyrPoVuH3xD+9nhk6leM/U8wh7yovvVAAw=;
        b=r5kphfwA9U8OB+ZhtvZQP/1C4U8dYLJvZyM1kVrKC4/C5BMHlGen0gXQhFmuIOLlow
         pzcKvlpSYC/OiMDfJHbhnyuhOb+5C4oJLoxB8zcVFpKvhLZQTFNiI9lM01JS4vvj8XBd
         rxpoUUNzn3TapQWjv+c2p7xcg9xr8ShA3KSGr0iTvLbXpg/8COJyjBofaF2sbpCV9O7A
         GLEA9dPkMG4yTza6iDGKJ5lBEQYsMZqlvFxxjs4UCi6LtlgjFAskshEwXP2MqA/Bcnpd
         v+FGai135IlcD1hDfQrBrh90ercgGp+s9Y4LFm5H6SIOsNqsq/2OS+MrsFFjnJLVgaDJ
         1/4Q==
X-Gm-Message-State: AOJu0YydsqIWl7SVgIItRK+7RQOAjAgUz1ZaNtwLs+6DIBMDNXfkHvPS
	RpL477NNj30CdmA5cPSq4CkAgn28L6pFMkEaSn2PrtKGg4z7eKkEVAyM7oHqyI0fFkw=
X-Gm-Gg: AeBDiev/vKgddF2XfnbORR3srQVigWlDZYTQ2d+xEUF8UBzLl4SBHHNp0x36iEVxNAs
	sPB/Ksb54WHpApnvFAbbedERd4tea8sNo9r2z8pJLwgFvYUTesUaIBgI5R+Tzt6PnCmSSNAfNUS
	owMu1Gx7NjHfsLWCNfItjsDPFNmAyqw45RKo2c97ev0CMGY5fX4LmCAjlz0/uWRo3kSpKedK+bV
	V5hv1r0YhUSk0XZYBUZelHl9YHQ2XjeUQLCpa9G9U0575f+G/RpUe60NT5S6DCDgmw4KbnXVWDF
	KunJtrvbu0hQxWeuNsDq5QtpDrhIDv5HkXlxNI0H8+MHRl8c7KKAVbeq1LP1ZrgB/vD88Zy2czL
	IoIVrCwKSUq2TLQ7cPTxhhkX9wyrh2Y60yhWLwseje0E8xV148GmCREKR+qsmZsMCwRmyctqylQ
	7iM0ZMnTYqxB+C1+6iZbN2us9Uzkp0DvVhukblG/D57V7ZjV0cWS75eqmNTrD6z7KyqvnmXpjn2
	R1c8YXXsegl2zPSfA==
X-Received: by 2002:a05:6122:3b83:b0:56e:e68e:9fae with SMTP id 71dfb90a1353d-56ee68eb83bmr6500910e0c.10.1775679207805;
        Wed, 08 Apr 2026 13:13:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bd2106csm20823096e0c.18.2026.04.08.13.13.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:13:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/gatt-server: Add bt_gatt_server_set_permissions
Date: Wed,  8 Apr 2026 16:13:17 -0400
Message-ID: <20260408201318.483799-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_gatt_server_set_permissions which can be used to
enabled/disable permission checking before operations which can be
useful on testing only environment where encryption/pairing is not
desirable/needed.
---
 src/shared/gatt-server.c | 13 +++++++++++++
 src/shared/gatt-server.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 27ae7e79ed3d..6273899965c0 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -93,6 +93,7 @@ struct bt_gatt_server {
 	struct bt_att *att;
 	int ref_count;
 	uint16_t mtu;
+	bool perms;
 
 	unsigned int mtu_id;
 	unsigned int read_by_grp_type_id;
@@ -414,6 +415,9 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 	uint32_t perm;
 	int security;
 
+	if (!server->perms)
+		return 0;
+
 	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (perm && mask & BT_ATT_PERM_READ && !(perm & BT_ATT_PERM_READ))
@@ -1652,6 +1656,7 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 	server->db = gatt_db_ref(db);
 	server->att = bt_att_ref(att);
 	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
+	server->perms = true;
 	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
 	server->prep_queue = queue_new();
 	server->min_enc_size = min_enc_size;
@@ -1680,6 +1685,14 @@ struct bt_att *bt_gatt_server_get_att(struct bt_gatt_server *server)
 	return server->att;
 }
 
+void bt_gatt_server_set_permissions(struct bt_gatt_server *server, bool value)
+{
+	if (!server)
+		return;
+
+	server->perms = value;
+}
+
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)
 {
 	if (!server)
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index de98a0d04747..ea49f2960d71 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -17,6 +17,8 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 					uint8_t min_enc_size);
 uint16_t bt_gatt_server_get_mtu(struct bt_gatt_server *server);
 struct bt_att *bt_gatt_server_get_att(struct bt_gatt_server *server);
+void bt_gatt_server_set_permissions(struct bt_gatt_server *server,
+					bool value);
 
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server);
 void bt_gatt_server_unref(struct bt_gatt_server *server);
-- 
2.53.0

