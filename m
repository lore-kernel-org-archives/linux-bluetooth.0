Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984621147B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520643; cv=none; b=PFXnyVc0PCkG6vcgOIBpcKstiUvGqmGIDFr/avgMZ18ffm/PFOLISX787cGeJkielBq6aoJR5tj4qOQIEpVm9HEHaZUO358kljj14y/8Xxuxa/iEthLSqkxURsuvZDAR7/+fhDvwieURirjcxTornf7V9kmrr3uoZHPeGNRvUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520643; c=relaxed/simple;
	bh=+m0B/8KYSY0fnXhc+Jrsc0hgcKHIlZxdj1VZ4taXH0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJa6UHQC6OXrC5GE9r4u2j2VsC252QjRIMpGOx+cHln42hLK7NyIWtfM2VaZ5F5yJXdI1A9LyMle0kY7m15kS/T6B8wgUBoO7kTL0VZMMtBhqe/r21vqdOAV1B15kxi5ErSueDdRuMhFLuIryfNTzhI5oN7dSZrdk0UzMEMBToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=IJwvMa5f; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="IJwvMa5f"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so3076934a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1736520640; x=1737125440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqhsVbPzlcE+fQgneHQmPEYJr9f/YkgczuSoAu9Cj+0=;
        b=IJwvMa5fbGWfuuASD36CeWUQyf7Czsco+iI9/OZe2QWi16JMm709FbDGkV5ukbl9Dm
         tsMe9zZD1drHJZCCuqDzhfvP+YaK77S02fwcWYm8PDIXf9167Zdc11Wwn1Fs7+6qrKjh
         MG+a5FyJ603KPKKGIfg5FpbVwFUHmFrA+Oy88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520640; x=1737125440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqhsVbPzlcE+fQgneHQmPEYJr9f/YkgczuSoAu9Cj+0=;
        b=v24H6vFYIT2asUcG7eXx0mpA38SoN3Kv/fqxyVLHguCt/8Wboq8ZsdSlbr+n4WZpqk
         HGxE+unHYczG4TgJb84bBZ9tNLL/eM+sLPOWkjj6XTlqARhhi/YqSUpE9eR6okJN/ehW
         iKJbUd8vhS4h0Ea+1i5L/zGWYRB0RAMQv9Vb6WXKRtzExZbPPN2thHpu1BavYUwf5Q06
         gSh0t7PVC6wh4QomTGjyKQl7+7eb+OrWHsgMBUfLLNbh5Mx1XMScDgKxPrNCAGJT6Drl
         p2vbOJY/sWIwOOeDX8MN6a5ti7XWlWo2Lrmu7HE0hW8IF0l2F3Urv0HeqNBNQDjOvKrr
         AEMA==
X-Gm-Message-State: AOJu0YwNJdUvsTnsbf0AeMM5eB3ZN8/RwhSCFyv5Y6V5s+hUHHCrUbqi
	axV7mJNctMERH0IvNF1WUFUYZHRMLAARnGzfryO4oDqzFvqnhOaHIFLXKFlCExwWEI57GZjG5Hg
	=
X-Gm-Gg: ASbGncth44brj9pZX2wJLN5Y8neCybWmqsT7ltZtHBodZ6WSZrBB0eMiVxHrhEtCIJO
	kVMcleug2NMf+x2aDBCHNrwOlvxI0YWM+vKXXq9/nJPBUUWOAiqu+hGyijMWJpo+mXJOPYnJd9F
	2YYZp2kGrIZ3tE1vxOVXke//JBmzyMoF/br6JZXykWK0/sQaP833x2rvZhyH2rmn336GXWYjskB
	ASEaAS3Cfp4jwWqsI5irHk7ASPYGXhXbcL1FL4xK39eyRqGFZ96Um4y/63Ok+SJvkm7vU2e9XNn
	o6rl6eAhn2yjMPQ72n7iURM8BCJvUG4=
X-Google-Smtp-Source: AGHT+IHLZIB1D4GWFieZyuxtLSITc38NV5h5pYqKbyO/pzZlURjB/hmpkdcIlwTOtkCRfi8QApDQrA==
X-Received: by 2002:a05:6402:4403:b0:5d0:9974:7da2 with SMTP id 4fb4d7f45d1cf-5d972e178a9mr9906019a12.19.1736520639760;
        Fri, 10 Jan 2025 06:50:39 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c3fccsm1679331a12.21.2025.01.10.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:50:39 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 3/3] vcp: allow volume control when acting as a server
Date: Fri, 10 Jan 2025 15:50:19 +0100
Message-Id: <20250110145019.2380299-4-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
References: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Local VCP chatacteristics are now connected to transport properties.
---
 profiles/audio/vcp.c |   7 +--
 src/shared/vcp.c     | 109 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 30 deletions(-)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 0203673bf..07b227107 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -186,7 +186,7 @@ bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume)
 	return FALSE;
 }
 
-static void vcp_detached(struct bt_vcp *vcp, void *user_data)
+static void vcp_remote_client_detached(struct bt_vcp *vcp, void *user_data)
 {
 	struct vcp_data *data;
 
@@ -201,7 +201,7 @@ static void vcp_detached(struct bt_vcp *vcp, void *user_data)
 	vcp_data_remove(data);
 }
 
-static void vcp_attached(struct bt_vcp *vcp, void *user_data)
+static void vcp_remote_client_attached(struct bt_vcp *vcp, void *user_data)
 {
 	struct vcp_data *data;
 	struct bt_att *att;
@@ -352,7 +352,8 @@ static int vcp_init(void)
 	if (err)
 		return err;
 
-	vcp_id = bt_vcp_register(vcp_attached, vcp_detached, NULL);
+	vcp_id = bt_vcp_register(vcp_remote_client_attached,
+					    vcp_remote_client_detached, NULL);
 
 	return 0;
 }
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index c92eb00d4..45d0f4485 100644
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
@@ -389,7 +397,6 @@ static void vcp_detached(void *data, void *user_data)
 
 void bt_vcp_detach(struct bt_vcp *vcp)
 {
-	struct bt_vcs *vcs;
 	if (!queue_remove(sessions, vcp))
 		return;
 
@@ -399,7 +406,7 @@ void bt_vcp_detach(struct bt_vcp *vcp)
 	}
 
 	if (vcp->rdb) {
-		vcs = vcp_get_vcs(vcp);
+		struct bt_vcs *vcs = vcp_get_vcs(vcp);
 		vcs->service = NULL;
 		vcs->vs = NULL;
 		vcs->vs_ccc = NULL;
@@ -506,6 +513,7 @@ static void vcp_disconnected(int err, void *user_data)
 	DBG(vcp, "vcp %p disconnected err %d", vcp, err);
 
 	bt_vcp_detach(vcp);
+	queue_foreach(vcp_cbs, vcp_remote_client_detached, vcp);
 }
 
 static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db *db)
@@ -524,6 +532,8 @@ static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db *db)
 	vcp = bt_vcp_new(db, NULL);
 	vcp->att = att;
 
+	queue_foreach(vcp_cbs, vcp_remote_client_attached, vcp);
+
 	bt_att_register_disconnect(att, vcp_disconnected, vcp, NULL);
 
 	if (!sessions)
@@ -566,6 +576,10 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 
 	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume / 2);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -605,6 +619,10 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 
 	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume / 2);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -645,6 +663,10 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x00;
 	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume / 2);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -685,6 +707,10 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x00;
 	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume / 2);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -724,6 +750,10 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
 
 	vstate->vol_set = req->vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	vcp->volume = vstate->vol_set;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume / 2);
 
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
@@ -2023,34 +2053,59 @@ bool bt_vcp_set_volume(struct bt_vcp *vcp, int8_t volume)
 {
 	struct bt_vcs_client_ab_vol req;
 	uint16_t value_handle;
-	struct bt_vcs *vcs = vcp_get_vcs(vcp);
 
-	if (!vcs) {
-		DBG(vcp, "error: vcs not available");
-		return false;
-	}
+	vcp->volume = volume * 2;
 
-	if (!vcs->vol_cp) {
-		DBG(vcp, "error: vol_cp characteristics not available");
-		return false;
-	}
+	if (vcp->rdb) {
+		/* local gatt client */
+		struct bt_vcs *vcs = vcp_get_vcs(vcp);
 
-	if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL, &value_handle,
-							NULL, NULL, NULL)) {
-		DBG(vcp, "error: vol_cp characteristics not available");
-		return false;
-	}
+		if (!vcs) {
+			DBG(vcp, "error: vcs not available");
+			return false;
+		}
 
-	vcp->volume = volume * 2;
-	req.op = BT_VCS_SET_ABSOLUTE_VOL;
-	req.vol_set = vcp->volume;
-	req.change_counter = vcp->volume_counter;
-
-	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *) &req,
-		sizeof(struct bt_vcs_client_ab_vol), vcp_volume_cp_sent, vcp,
-									NULL)) {
-		DBG(vcp, "error writing volume");
-		return false;
+		if (!vcs->vol_cp) {
+			DBG(vcp, "error: vol_cp characteristics not available");
+			return false;
+		}
+
+		if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL,
+					&value_handle, NULL, NULL, NULL)) {
+			DBG(vcp, "error: vol_cp characteristics not available");
+			return false;
+		}
+
+		req.op = BT_VCS_SET_ABSOLUTE_VOL;
+		req.vol_set = vcp->volume;
+		req.change_counter = vcp->volume_counter;
+
+		if (!bt_gatt_client_write_value(vcp->client, value_handle,
+			(void *) &req, sizeof(struct bt_vcs_client_ab_vol),
+					vcp_volume_cp_sent, vcp, NULL)) {
+			DBG(vcp, "error writing volume");
+			return false;
+		}
+	} else {
+		// local gatt server
+		struct bt_vcp_db *vdb = vcp_get_vdb(vcp);
+		struct vol_state *vstate;
+
+		if (!vdb) {
+			DBG(vcp, "error: VDB not available");
+			return false;
+		}
+
+		vstate = vdb_get_vstate(vdb);
+		if (!vstate) {
+			DBG(vcp, "error: VSTATE not available");
+			return false;
+		}
+
+		vstate->vol_set = vcp->volume;
+		vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+		gatt_db_attribute_notify(vdb->vcs->vs, (void *) vstate,
+				sizeof(struct vol_state), bt_vcp_get_att(vcp));
 	}
 	return true;
 }
-- 
2.34.1

