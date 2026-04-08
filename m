Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84D37754C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679268; cv=none; b=dRU2CqL+QUQ3N9QrvDzRlaKUlgj/fvc4MKIWu6LzYeX5Is5uP6UmyaPph9HcVmKe6Vj7CLUd1XIvqBQyJMmxhtvAG2WQ+DeF5APUYRzLrpp4QtdGN8wrD/9UcXqCE4DEvuWqPNiMf7RBsNzD7Ux1cAt10CNO6z3P3kSCA9PBgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679268; c=relaxed/simple;
	bh=cLueYuXPRXrEtmcsRJp5N8hbm8RBUvkyXmbTAgpTJ4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q83YVcrnycd6neYnR7t9BYRMrV6OL9Lz1DOiVX/f/hX130jYvtIe684xWYQxtWcpfnMWpVcI4kTe2F0pZPsSlwx/l6XZScAEkUjCj4UA8K//TcUpqCLOKX/YxX4+utXYN5AM5vVQIBdcJeLgKBwcaoYcaAHOZwcSE4PbkYKmZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFxsOyBg; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFxsOyBg"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56db1b3626bso74492e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679266; x=1776284066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAAT29BiVvyrPoVuH3xD+9nhk6leM/U8wh7yovvVAAw=;
        b=jFxsOyBgKGZvSxJFadmEFQM8hRcRMifZVqQ9p0VnPsl94z4bxSceB0Uk5SJO1GoTyS
         y2GfStO7cvUIRRo14cpz2YS+lgAathEddwKSMLTFa3kAuh5QP/qHB6qlPnhvtNA8g+mL
         qjI9B3dKM9k46JQLQ5FgI2SW2Esbg/d/YBaqFNq9O7ShdnDgrAIhNLvU3otdBD8jL1b+
         18Rex8Y0+2PDIDxXp85Wiui3lsO7/MNKxOJpe+vpwr7k/Ms6gaHLygP5extnBNnFXtFz
         l0fHMaaQUs2UDnri3QymwHsEnfNK/Pzbslv0ytStSsPOyhUcDYYMmWtXWmcVJTluioOQ
         j8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679266; x=1776284066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAAT29BiVvyrPoVuH3xD+9nhk6leM/U8wh7yovvVAAw=;
        b=l+OAbWLDzz3/sVgnJgJeFK6F2IrV4Of7+bRkhQdwM7TMJY+aM0IHjHVYHALMeWayoY
         yAsL8BRiEwL67IF4zeOkXNqhAn+q6aLmkC10FQETlm+SG8JucqFH97tK0VRsJBufoujA
         Ow5ZNTGnJbV9rp5UX6ltoHK9dohHREsk3kEGWbhQO6tejuZNSMP1xZlOTa89PKW3Y8oI
         0N/6dQxhvgG7YBswtQXqBiKpTvl547K49rata0PnITbnnlMx1BfZ3wWtNC/xYU9fNNTc
         sYygMeLsWEAY5CPIyB/yn8cy9MHEMv1vSgFUFjsmjKf23bKTyM1m0CtswrYqgltQVlDr
         aJLg==
X-Gm-Message-State: AOJu0YyotxiDKn5V8OnuZAODEBWjvYQkgr8VrsokO3KsU5maCOzDA58B
	BSdO8e3daB3bha8u6z/XHu8LgzaOlYGw5GmFf0iWptKyPTxzqzKy1zuF4gNqSzd3x5w=
X-Gm-Gg: AeBDievn7+qhg24rkymNwz4Kx408VpRFZMYVWmGNDhplTfCHtxEok+869r7dEE4yJ08
	uQX2rUfl/kJqrMiftfsjayjwLBpTJzxkOA5CsTa/R5Rn/8bcOiBIMhK29pm4/yu+fthAPAZYRo5
	Y8CoJVErs16cM7L93hC5blL7rp/Mrnsf0KgjrJfQUTAFKrVKSUmYJZ5aVI1FxYdLX1ja8sse492
	O0du9DK2OGh4vTYk/YJ1Caf2681BUJwmwckI1MFk3Ygbt8ah/lH/r6vcJn9r0IrrvCZ6thhNWGv
	waF6MabpwZtj/7PF9ofzMaGFIsxDOOxKxxxcK0D4E9vvnT5DKa+07/p4veu9DfhNX/EK6UpbqF3
	TlYFwFNM3Agk0d9N4caTo7tAzJ2si+aKca/Yl5Yn9T2xpMvkH8kBIpj4HAHcWauKgQtEqZ1/7n4
	Sk/SE/4FrGXiFQG1VU6olQR+Vd7EugYKnlcBDZwsA58aI/CkLtd71UdvbeecPjL03UqyT7ZfJIY
	St2J+C/ys489TZX5wxOUwxR8Qr+
X-Received: by 2002:a05:6102:6443:b0:608:9f39:fe90 with SMTP id ada2fe7eead31-6089f3a122bmr122404137.24.1775679265851;
        Wed, 08 Apr 2026 13:14:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60583098fa7sm21071024137.10.2026.04.08.13.14.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:14:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/gatt-server: Add bt_gatt_server_set_permissions
Date: Wed,  8 Apr 2026 16:14:14 -0400
Message-ID: <20260408201415.488511-1-luiz.dentz@gmail.com>
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

