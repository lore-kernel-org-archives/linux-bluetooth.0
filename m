Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5011DF96A
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463659; cv=none; b=PobcwyMm18YcQP3a0a772hLoQ+qeQfor89tR6a4qqDZdtZ6J5NbYkCxbdmm0LMvWs3VkOZiFd5ILpzcoz75eJXUR/5iFnRifJeFiqOLl1/MCOZjRtE07xYOx2fI/qhiauvFC/r40oKcT9Bnb+YIWxFIBrLxyssp+yos0qiuExjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463659; c=relaxed/simple;
	bh=sO+dboodXBdmqOHqDW2Ro0yGw2C8mpljwEwLlBSPMNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6Wj5fvpkRlAbxd3sly90XWi2EcrDJWCkMbaOA2X9QKQauBNZzUjneTbK3K1nTDh817yHaHEZEfNaAvxv24XYGguO3ndNs3ipFfiowlWk4jAzrfzvS7u0rvAXTHcEH3/wkv9KnTQJb8o3CgJLuHKio4U3pLfnrENDI9IA/AKd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=pxwPwlja; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="pxwPwlja"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so8987031a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737463655; x=1738068455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRLQplTHJGkAWlkArhYviFfIPTshswlkLWRCkvQRO/g=;
        b=pxwPwljaj+HtEspxFM/vP7LzTPbhZwInscJ7DydmpxwzSrkzu2UBThOjylYVkhaqyg
         TyLRcPWORb1pk0+ju8HIYSeWZWfcPoiBH4mQIHg6L9RXI4+6NnCGBC37Db9RpqgypZtm
         Al6JZi+2o5gAx4SHfxHPuns6pQMJ3cga2IN4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737463655; x=1738068455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRLQplTHJGkAWlkArhYviFfIPTshswlkLWRCkvQRO/g=;
        b=XBDO7uVZJ4QewNemBl13CZx9F48G0YUowhqd3XZqiyL6PkczuEA3uPtraBAavNJmru
         on4BrsSoL17onwGmZRu/nfpSXgfYax5Js6vN6V/3l8/w8VsKTg0FEFnYrIICGPMorccq
         0oNaiq4SV/F+Z6qlg1g68V/lDaly3Odm6omgsIVWHDU6ChSIxVB1zLjo3darZlbOnqsE
         TP+MqY8QpcRkvhrWYsx75W76+36gP5IL5Pc+XyYWnn9N0/BKyZfMbL4pkVW8vpC+kRB3
         XoEF6ZPE1KuUalJoE7fNHxzH4YVDOEdwX9whETRYAAliqB7lRmiGETkqKJJ36CtqVWg3
         RR9g==
X-Gm-Message-State: AOJu0Yx0Qs51B7w4ItXMEJM7A9vBzxYvHi5qRcY/kvXpVjs7NjMsRei8
	11mkWSBeWWQiRc3SIGgIQCqpPt9NbesGG4f1umJqmf1HIL8Vea8uDb2tCWkrXWTHFCcTOYT4YQw
	=
X-Gm-Gg: ASbGncuGoKq2KIrk4CypGoxDxAxDN+ajcqrP54ClA33hbJVI2KYKBxfSmiKgDs/7y2P
	npDII+iY8QgdLi/PiZ0vYR3ztZKMN8ytNuv3eREbmcOu9Ui+Xi9CpQm2BjjbB6UsPZMNff49JLa
	jWisA3UpFzEaccOx6Hgay1cZMdQ9omwS91BViDlFFDtJMu+VGvmAJaZ4BQIrueHpuCpT1jJfEcB
	lAdol9YolR3h0e11fSCupQxaayw+Zc3rqjUXR+uJqHm3QsTHFl6tXmwtyKSS6Hw30h711587QeT
	rh+S2P1refgKmTWvKnY3z/rJVhC9SYlNngEyH9v/V6AS
X-Google-Smtp-Source: AGHT+IEIofdoUTZNJ/DKIOGpK8JqSZkfg3cGhiKPHCv3Mq8AKY1oYEvv2LUQk1HjRWGWLDesBy+eQw==
X-Received: by 2002:a05:6402:524b:b0:5da:ba6:3a3e with SMTP id 4fb4d7f45d1cf-5db7d2e2824mr16403429a12.7.1737463654824;
        Tue, 21 Jan 2025 04:47:34 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm7153591a12.19.2025.01.21.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 04:47:34 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/5] shared/vcp: add API to control volume on VCP client
Date: Tue, 21 Jan 2025 13:47:14 +0100
Message-Id: <20250121124718.3995904-2-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121124718.3995904-1-michal.dzik@streamunlimited.com>
References: <20250121124718.3995904-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/shared/vcp.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/vcp.h |  7 ++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index cfc426624..abc5a35a3 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -147,6 +147,12 @@ struct bt_vcs_ab_vol {
 	uint8_t	vol_set;
 } __packed;
 
+struct bt_vcs_client_ab_vol {
+	uint8_t	op;
+	uint8_t	change_counter;
+	uint8_t	vol_set;
+} __packed;
+
 struct bt_vocs_set_vol_off {
 	uint8_t	change_counter;
 	int16_t set_vol_offset;
@@ -192,6 +198,11 @@ struct bt_vcp {
 
 	bt_vcp_debug_func_t debug_func;
 	bt_vcp_destroy_func_t debug_destroy;
+	bt_vcp_volume_func_t volume_changed;
+
+	uint8_t volume;
+	uint8_t volume_counter;
+
 	void *debug_data;
 	void *user_data;
 };
@@ -1874,6 +1885,15 @@ bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t func,
 	return true;
 }
 
+bool bt_vcp_set_volume_callback(struct bt_vcp *vcp,
+				bt_vcp_volume_func_t volume_changed)
+{
+	if (!vcp)
+		return false;
+
+	vcp->volume_changed = volume_changed;
+	return true;
+}
 unsigned int bt_vcp_register(bt_vcp_func_t attached, bt_vcp_func_t detached,
 							void *user_data)
 {
@@ -1959,6 +1979,65 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 	DBG(vcp, "Vol Settings 0x%x", vstate.vol_set);
 	DBG(vcp, "Mute Status 0x%x", vstate.mute);
 	DBG(vcp, "Vol Counter 0x%x", vstate.counter);
+
+	vcp->volume = vstate.vol_set;
+	vcp->volume_counter = vstate.counter;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
+}
+
+static void vcp_volume_cp_sent(bool success, uint8_t err, void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+
+	if (!success) {
+		if (err == BT_ATT_ERROR_INVALID_CHANGE_COUNTER)
+			DBG(vcp, "setting volume failed: invalid counter");
+		else
+			DBG(vcp, "setting volume failed: error 0x%x", err);
+	}
+}
+
+uint8_t bt_vcp_get_volume(struct bt_vcp *vcp)
+{
+	return vcp->volume;
+}
+
+bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume)
+{
+	struct bt_vcs_client_ab_vol req;
+	uint16_t value_handle;
+	struct bt_vcs *vcs = vcp_get_vcs(vcp);
+
+	if (!vcs) {
+		DBG(vcp, "error: vcs not available");
+		return false;
+	}
+
+	if (!vcs->vol_cp) {
+		DBG(vcp, "error: vol_cp characteristics not available");
+		return false;
+	}
+
+	if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL, &value_handle,
+							NULL, NULL, NULL)) {
+		DBG(vcp, "error: vol_cp characteristics not available");
+		return false;
+	}
+
+	vcp->volume = volume;
+	req.op = BT_VCS_SET_ABSOLUTE_VOL;
+	req.vol_set = vcp->volume;
+	req.change_counter = vcp->volume_counter;
+
+	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *) &req,
+		sizeof(struct bt_vcs_client_ab_vol), vcp_volume_cp_sent, vcp,
+									NULL)) {
+		DBG(vcp, "error writing volume");
+		return false;
+	}
+	return true;
 }
 
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
@@ -2061,6 +2140,9 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 	DBG(vcp, "Vol Set:%x", vs->vol_set);
 	DBG(vcp, "Vol Mute:%x", vs->mute);
 	DBG(vcp, "Vol Counter:%x", vs->counter);
+
+	vcp->volume = vs->vol_set;
+	vcp->volume_counter = vs->counter;
 }
 
 static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
@@ -2757,4 +2839,3 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 
 	return true;
 }
-
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index 26db5732d..705b6f301 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -36,6 +36,7 @@ struct bt_vcp;
 typedef void (*bt_vcp_destroy_func_t)(void *user_data);
 typedef void (*bt_vcp_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_vcp_func_t)(struct bt_vcp *vcp, void *user_data);
+typedef void (*bt_vcp_volume_func_t)(struct bt_vcp *vcp, uint8_t volume);
 
 struct bt_vcp *bt_vcp_ref(struct bt_vcp *vcp);
 void bt_vcp_unref(struct bt_vcp *vcp);
@@ -45,9 +46,15 @@ void bt_vcp_add_db(struct gatt_db *db);
 bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client);
 void bt_vcp_detach(struct bt_vcp *vcp);
 
+uint8_t bt_vcp_get_volume(struct bt_vcp *vcp);
+bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume);
+
 bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t cb,
 			void *user_data, bt_vcp_destroy_func_t destroy);
 
+bool bt_vcp_set_volume_callback(struct bt_vcp *vcp,
+				bt_vcp_volume_func_t volume_changed);
+
 struct bt_att *bt_vcp_get_att(struct bt_vcp *vcp);
 
 bool bt_vcp_set_user_data(struct bt_vcp *vcp, void *user_data);
-- 
2.34.1

