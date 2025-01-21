Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FC1F3D3B
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470672; cv=none; b=SJY/GWj642muCAc52t5z82AC3z9kqowi+33ZZSdOnf6gnhejdU0wbGKfrZbTPWD8UpjPtwRIcn8K8G4rS2I8W//lg8WsoycQepWKPpx2u8BV7QY4NG/Gh83CBBKt+LdPq+THxeweRrFMCr+dprbRxZKsvjw+NCue/yf8aJ55h7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470672; c=relaxed/simple;
	bh=wn1B9Gx/4YVsA26SoKfQOvl6b31fvWHtAVoKIIQCEWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZgmDexPfAYBhuYxknY9tv6WP9xwWvVg7EGvHvy3E1HQBdhRW+l0nJBGPFWzELnLoSTrJSI6mCZu2RpwBDA/oBW8nB8V4z7sgWM5MltGaR9ioqoPEfiOY2X5t7eQeKBue3E60nx0yb3C9EKDX/moFB08mdtJKVzf11tK7e1qRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=g0SkRuWo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="g0SkRuWo"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401c52000dso6062851e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737470668; x=1738075468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXwEOTqnAwGpLdBgRoFBLXm/lX+EzmxiYp2YjB18kHo=;
        b=g0SkRuWok9W0AHGWypZ9J1Rf7JjDZQHtgx5Gk7a7HlhHXKLqt9aQf4BXquICRBY6le
         tr/tVXPNS9Y414HgtB+QFR0eiJIqKra/Ulc/91RvaVvVCNtrUNPCzYK3zG1w3Glq8JHf
         JNe7KP697xkh68EBX6/qedoIWidpmJkYn/Mfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470668; x=1738075468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXwEOTqnAwGpLdBgRoFBLXm/lX+EzmxiYp2YjB18kHo=;
        b=nJPc78EVUqYGZ3KM832t3iDS3+NzARgzlsXxgQQEJNhn3mD7xlKUArpubRPfB49nt6
         /9Qj1FbzWvVCmr4seZWucdBgyjTaoOtg3DGeEF5VczjXEbj6sL/x652KFIGNPS37yp2z
         jxDp+O23lnQ/F/gscPk4h0NsPPgDw2wW18WXxTMtFCBULINtRIWxOfT8TJ0FEK17e8yj
         Ep0wrbj8FbIbUXg9TNSlfeQQiI6vmz5E2L94vGT+qoTftQq/WcCCn7JOuMVrNyewF7e9
         dFACfy88US9NnrxzVco3QGErRb8F6bgYyDbAyPKej+fJPaaq2ZKFssjvYAdk5xVotQMW
         VfZg==
X-Gm-Message-State: AOJu0Yy1xbMkByoons5nKtSzIzsJ8HnvS5W/QEPr3yFM6pMqxgloemBY
	ieJgF0+FpQiLXzwtaSYtoaD6EN4ePQ8Rf4O/rcpcBMysCo0wEP8f7IA5D3kieKYSikQGFnp9eC4
	=
X-Gm-Gg: ASbGncvm1UtMgGX7JJaR0BDatytkBBcTyvHWhJu4oJa7AC/tAA+Y2uB9E1hsd0qiPzL
	t4udKkZLUl9GHnwiqqNOPo4c76KpOAJEKoU4qzzAQuI+OnQ6/EpeCf4/sOMviudPGW1a+0FWk+2
	dizJp0eZnUdRb5dG7A0H7FZpYbe/hbyS2jT+K1HvDAJJCk0E1nw3wiKf/mh1qPaKg5ZLBjCecMU
	vcnxN4WFTuS0h0JPR0fBUvhUS/uQfsbc3lHH84FQlx/UiNm7HFKhdxpNiGMsv++KxfHaOYEtR3t
	4zIfU6BtmgoE+ncMBLqWL5uFCn8OJR/wuTAg4K4vPOOL
X-Google-Smtp-Source: AGHT+IGAig0CdqlDz2NwCGIVvajpDD1zM3X+IfSAU6P3qzb3QhUUUwrLjwDcArG+NzV7pSWS8YyVWQ==
X-Received: by 2002:ac2:4294:0:b0:540:1f7d:8bc4 with SMTP id 2adb3069b0e04-5439c281105mr5956838e87.48.1737470668035;
        Tue, 21 Jan 2025 06:44:28 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af733fdsm1866237e87.174.2025.01.21.06.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:27 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v3 5/5] shared/vcp: control volume when acting as a server
Date: Tue, 21 Jan 2025 15:44:04 +0100
Message-Id: <20250121144404.4087658-6-michal.dzik@streamunlimited.com>
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

Local VCP chatacteristics are now connected to transport properties.
---
 src/shared/vcp.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 683650f31..898303e05 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -379,7 +379,15 @@ static struct bt_aics *vcp_get_aics(struct bt_vcp *vcp)
 	return vcp->rdb->aics;
 }
 
-static void vcp_detached(void *data, void *user_data)
+static void vcp_remote_client_attached(void *data, void *user_data)
+{
+	struct bt_vcp_cb *cb = data;
+	struct bt_vcp *vcp = user_data;
+
+	cb->attached(vcp, cb->user_data);
+}
+
+static void vcp_remote_client_detached(void *data, void *user_data)
 {
 	struct bt_vcp_cb *cb = data;
 	struct bt_vcp *vcp = user_data;
@@ -495,6 +503,7 @@ static void vcp_disconnected(int err, void *user_data)
 	DBG(vcp, "vcp %p disconnected err %d", vcp, err);
 
 	bt_vcp_detach(vcp);
+	queue_foreach(vcp_cbs, vcp_remote_client_detached, vcp);
 }
 
 static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db *db)
@@ -513,6 +522,8 @@ static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db *db)
 	vcp = bt_vcp_new(db, NULL);
 	vcp->att = att;
 
+	queue_foreach(vcp_cbs, vcp_remote_client_attached, vcp);
+
 	bt_att_register_disconnect(att, vcp_disconnected, vcp, NULL);
 
 	if (!sessions)
@@ -555,6 +566,10 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 
 	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -594,6 +609,10 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 
 	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -634,6 +653,10 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x00;
 	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -674,6 +697,10 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x00;
 	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -713,6 +740,10 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
 
 	vstate->vol_set = req->vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -2008,7 +2039,7 @@ uint8_t bt_vcp_get_volume(struct bt_vcp *vcp)
 	return vcp->volume;
 }
 
-bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume)
+static bool vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
 {
 	struct bt_vcs_client_ab_vol req;
 	uint16_t value_handle;
@@ -2044,6 +2075,39 @@ bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume)
 	return true;
 }
 
+static bool vcp_set_volume_server(struct bt_vcp *vcp, uint8_t volume)
+{
+	struct bt_vcp_db *vdb = vcp_get_vdb(vcp);
+	struct vol_state *vstate;
+
+	vcp->volume = volume;
+
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		return false;
+	}
+
+	vstate = vdb_get_vstate(vdb);
+	if (!vstate) {
+		DBG(vcp, "error: VSTATE not available");
+		return false;
+	}
+
+	vstate->vol_set = vcp->volume;
+	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *) vstate,
+			sizeof(struct vol_state), bt_vcp_get_att(vcp));
+	return true;
+}
+
+bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume)
+{
+	if (vcp->client)
+		return vcp_set_volume_client(vcp, volume);
+	else
+		return vcp_set_volume_server(vcp, volume);
+}
+
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
-- 
2.34.1

