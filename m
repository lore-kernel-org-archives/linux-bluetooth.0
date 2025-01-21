Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87AF1F1508
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470668; cv=none; b=LAOwNAvSiMzm956wpd2/Uf3Mlqep8xx7sVRvwU0eRCsMp2BiSTlLi4yUSb7sNZkffvpAOuI/iC0GXO0UtXfBW5dYbGXj1MjAdVqzuKIMF9RXO+O4edPndq6HuyPm7BCBbc5COnw5My707x2BFvtQmIxFnTGxlsTPUv5ntu7S0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470668; c=relaxed/simple;
	bh=sO+dboodXBdmqOHqDW2Ro0yGw2C8mpljwEwLlBSPMNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MiSDqJvdUicpZZmLH/b4OvUa6CAFMaPoHrkqtB0uQBx2VDBb87UzIT9/IPhjx9DgSfrJi2MAKJu+IC29sWHpOAdjMBrT6YL+TZbVwTRWAwktrpua+7AwMqZA9Wu7hcvLj2ES/i2UMp/I1FJzTZ4hqX2wSwCXNKsvmW8RPlKuTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=IBAHoBm4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="IBAHoBm4"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df80eeeedso5702819e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 06:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737470663; x=1738075463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRLQplTHJGkAWlkArhYviFfIPTshswlkLWRCkvQRO/g=;
        b=IBAHoBm4xuWlJVpHzXBfW7ZGLIlnnSGLet/+fU91F3CtiFMZNbZnbgAJgtE0WbYwZH
         bWZHcGpy+hs54VZK2JQsgpLdG21xqsAkf6MaDd8nXO1y/jcjSmTkR9HlAI0jltfmvP5j
         A/RFJBC4bUfbrsuL2TX3dmEc5E13mdhkb6vLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470663; x=1738075463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRLQplTHJGkAWlkArhYviFfIPTshswlkLWRCkvQRO/g=;
        b=aRrDFhJdb4w4dqMRHk4MaPdNyS1q9jGRUZe4t89NIqsvf7v+MhaB1hpJ6j4fpUUSCY
         4E1d2HTJgDABczSXuNCRefk0JUPEf+MkxjkP0ZAb4mGxOVXKhbQ4I7+KBydfe2Qmqb7i
         OcZWRE6KeJ5KNuehCJ1jXEMunQt3vjmnxgubZfy8PzId1m1ZzlGbhPkITA5wMhIV0QRo
         6Q0KYxSEWc224SRHd0YALaN4JOtIpTq7I8n/aCSvtHdjhSc2EOFr1bvVlnF5BeLAK/FS
         w5ZcXTpxxK6kuSOLFGZh3R7ZPWTDHzcUH+vWoEyqQgdKRmuhOJKDRIqBe3GV8EnRks4i
         B5hg==
X-Gm-Message-State: AOJu0YyZLnjR2lvh9NfJAtDu7kHJoWjNryDViu2WkRKO7l33SzAmhZns
	+Jyefa8NhgPNoVjJh4jkdORqSL1eIHTHt/xIBV1ga6zY29aKme8NWRDrLJJOV0XC2zrtMzUzQmo
	=
X-Gm-Gg: ASbGnctNEu+373cnxO6tHSmj3zaCGj26mvnZ1L6NzOawHuJxcPCovD76Qw+f3IuwpaV
	T7E1yWguozhhQIrvybB9oxefweKw16RbD8OkAFZ9RNJbkKwPDTLcx30laJ0pV9hlFXc6TLnR47+
	ayBKH34mIwOjCCYM0KmcTbH+6QGS7gYdFMGf5lmCVIb7IK+uU2PHV6EKZvPWdtDktumn113Wwnb
	e4fFFqUq9oAZdCxTXZCLXToOCfbSAQNDUQywMxaj4DpDXXUM7NgiOvX5P/Ai9ke/R/0RGG2iheW
	TEyVh8AuQfl3OWiUPUwEJV13AO+vwByZBw3w4qLcmpNo
X-Google-Smtp-Source: AGHT+IGixtvvYJTXX28Vaeb6aFbJ3zY3cFLSYujqyVjEImM/mVIm7j5mRXIF1rEgXZq9RJx9Wy53qw==
X-Received: by 2002:ac2:5230:0:b0:541:1c48:8c0d with SMTP id 2adb3069b0e04-5439c285a31mr5438349e87.49.1737470663166;
        Tue, 21 Jan 2025 06:44:23 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af733fdsm1866237e87.174.2025.01.21.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:22 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v3 1/5] shared/vcp: add API to control volume on VCP client
Date: Tue, 21 Jan 2025 15:44:00 +0100
Message-Id: <20250121144404.4087658-2-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
References: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
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

