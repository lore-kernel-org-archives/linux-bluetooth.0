Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628B1EF0AF
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463666; cv=none; b=Ox03wcoR8KSx/m2C+08QBtyuxK161ETDqUgFjzD9idgSgajUAWFGfxAj5C4g+dgLXqRYK6NMNW//Bry8Qpq7WV1GO8NRYbLXo6T2r1RXLgl3ooD5v/fuAewmO06h4sTgaNbD/qQiLdeZ5Yjq0dcWf9KEmTNjye4HPRChkYGeD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463666; c=relaxed/simple;
	bh=us7BX9z3JbNUm1iwU4gbVF2qCYXv2kzA2cq2Zi/POMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZd6tStGfaw4bdEIwWJ0uF2eLcYu8ESlnGove8tC1/ywBooOwv39bIqDhrpaNyO2f51uaduOiRQGhPv4oXx5vNFz8D0tqx1Dv5SBQEmPDjpgVXA1nYJ0C+fIP2feTC8mkaxxlIGfAipmNbKAfwApK7uzKAPIwEAxL+Ez1X6OFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=Rmw83k0c; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Rmw83k0c"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so8987240a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737463662; x=1738068462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EBgcxkfUJPQfZObbMHq5EhfZB/o0AHpwA81k4Z0yUo=;
        b=Rmw83k0cI81/yruSQjPxShv83MQLJmZCOciLyRkZYPrMb4dnWaa+bp7EcyIvNfGR7Z
         AaOi85Wt0HbAaM2u46yjjdWFEuAQJguZozsIXXjwRkiP4XclPFd+9vbOoqnIYm5oN2dH
         sdE7U6XCw5DjPrGUgrQLz/Qdm5tOmEMYkUg/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737463662; x=1738068462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EBgcxkfUJPQfZObbMHq5EhfZB/o0AHpwA81k4Z0yUo=;
        b=nupJaYEhpm8wkYHBMpm0wqzTdjHHFyyfzs3tLcvkjXGSqXVDyIgdxHJMD+kUt1iXcH
         dmpuEvokH13W+pzBSVQsO/LH3aLtPjLgc32WWFuqRWc0WnrmijwBGpdPz+F2CxazOdzf
         PPvKbHz6WEt/W/oMNyUlgYi46PypPt4Z/kPrbuEYo3+geRgLwJdRB5a+aQzTkahJf3ef
         cbn1HbuPij5U9wffiVymPC1SIlGJ/6YeOalJI5YNX9lAthgrRHUC9CwAi354FyYg77Jm
         OcGH5bINC6xl1iXh4fwn8lEgrDizDK+dvu+4BfomORmaoxt/HFj1y/SBjDzZ7q+GZyke
         FElQ==
X-Gm-Message-State: AOJu0YyoS2JqC63FAOVS0bZSB+U7mSzYa5HVkSvn4Ls7WYwrbVQD+MM2
	+MHseyxwm6v3cnJSW7aj6o2giBrl6u9mwT0dgPscn83yih/7tURw5YFHbDjuhFgDLZftNGasZYg
	=
X-Gm-Gg: ASbGncv6Ku7UVSQy1CMXAuN2hNcoJGMT8hgIQ2GaMh/r7/0zPMCHPKVWCIF8ikS+dOX
	p9pj6fU/smFN+jwdPHvhc3bJC0/31yvURY7tFlrm9oZttLjS/vnjb8dnn2iTObXLmeaYkeDoG+d
	6mKauXQHO5YfRjG7xbSfe2OeyfjLNuvg6kgCCxIp2r2azfXKml84QgmYJpq6Ch1ACN3W9Y2Pu8K
	qaO6PDODFLiFPQvbIV89C3UK3AjZeA7ON+VsLyWMcPscHCVLULYctAI2Qzsj0AN4kLMlbl/Zwof
	t5il7C5JztzKftVDW9YHR80/1OXUxQ5D26TPZM0H3niJ
X-Google-Smtp-Source: AGHT+IG8wPa2N92av6SDmNSCWM6TqStZMdnUEcO9sWp2HuU7/ym25JUm88P51r+Wc8egDUTbE3EvAw==
X-Received: by 2002:a05:6402:278f:b0:5d2:7346:3ecb with SMTP id 4fb4d7f45d1cf-5db7d2f8066mr16803487a12.12.1737463662150;
        Tue, 21 Jan 2025 04:47:42 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm7153591a12.19.2025.01.21.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 04:47:41 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 5/5] shared/vcp: control volume when acting as a server
Date: Tue, 21 Jan 2025 13:47:18 +0100
Message-Id: <20250121124718.3995904-6-michal.dzik@streamunlimited.com>
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

Local VCP chatacteristics are now connected to transport properties.
---
 src/shared/vcp.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 683650f31..7ce6d576a 100644
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
+bool bt_vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
 {
 	struct bt_vcs_client_ab_vol req;
 	uint16_t value_handle;
@@ -2044,6 +2075,39 @@ bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume)
 	return true;
 }
 
+bool bt_vcp_set_volume_server(struct bt_vcp *vcp, uint8_t volume)
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
+		return bt_vcp_set_volume_client(vcp, volume);
+	else
+		return bt_vcp_set_volume_server(vcp, volume);
+}
+
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
-- 
2.34.1

