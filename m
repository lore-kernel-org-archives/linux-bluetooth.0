Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626137;
	b=P1PQ74KcC6BnDtm2J9qiTw8NI0XzB8amRlG4xtheafuoSmO6MNNBvIfH/qKBmqtimQtY
	 G9+0ao0iEBOiKcEdtJcmMsmCZgc2Of+v9w2QxXl9cC4UIMx4YJI9wM2HRNehYqDF5bocq
	 Ta8z48jb1MRpCEn/zi/KMjj4WQtxvnAA1eMHQcdb2D9Pis3pVL9CiFwvDimbrLFd05Vws
	 6C+SEIWzU+kXtGWdWSxXb2sffsEY7ITVx9GieIUSkj2Y6/ZYXSfAoNOugMv5OyrBjnpPB
	 NTcpouywp7mybN58PcfeQ3EedHJ56rUrY5BPvGgFjckM38qNcyL8FefIlUHH6GCc1gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EsDpInEyj4vRykbXuJSxUPc5yVmhq0adXW0d8rEHeXc=;
	b=thbfzFCKGuaEXOYU+rYYNcNVP0MKKTwddhUpGI0o9rmorssFwncj50xP+sesfhcfWLKk
	 Vg35xlh7X+8je5U7HD1w66tNXuOldwrW+peWeUQWSSe01+VjEnJvJ5A8e61mpAb3M4nMm
	 khSnQtMLk3rQ4a/LDy3FfIlgOL9FrZuU6TUo0LZgIzZyH/CLcPMKvqjcC8xHFnv/UzyF5
	 QGRtwr5otuPqzQQ72elPTUv9eY64W/pqwz9pj2ofW/mJvqYnyCGPjxtIiCMZ5F7Ny/6RZ
	 IeqXs7JYOKzbouWWir6XCHUUZvUhUC5yArSDYV6kjucEE0WRyhJYUOhGj6g5bYcN1cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Dv9Ywq8p;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7076606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7076606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Dv9Ywq8p
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so28775175e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626135; x=1796230935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsDpInEyj4vRykbXuJSxUPc5yVmhq0adXW0d8rEHeXc=;
        b=Dv9Ywq8pybwMuGFVjrtFS3xzoXamJjidcjeACTzzLoV7UQdK+GCSIzmApYtZzsDfzO
         p57CvHXzXhJAJOr9kxdiXamsKj0mk5ox3W1hTBHyoKVDx+5un1fB/MsCGuq5sxat9GGz
         8HNuGIbUDYDbnqCxlmuaAB3sCjUnQQOje10fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626135; x=1796230935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EsDpInEyj4vRykbXuJSxUPc5yVmhq0adXW0d8rEHeXc=;
        b=t1eh18cjCShecv0YJtNir7L4rNItjPntd25lqLX4H2tMLAOKW98D+bOZEh1GFZLNPd
         uBxw4SG+p952bBKKU7KM0j4cq8WIIVVtznIVPTppUTr318UljzfSmGSQ1rFYaABtju3n
         rWEycrOF5WXueHRGHfbHu4YmRWfSB+kR2AvFZXJIEOcwf0EU0oXuLgHkPOOR78tY06eL
         bgDVaYr3c24CCDcFh6u7AED4pVb9krj8bvT8aMAVSlArNlTJ/ADGIBUirK4g7Ko/Oz/f
         68nrh7AMLz/CLPebyowR51rUcCor2M4WsUdDrfydAsRj7xQ7Em/hSwa49UOORWFM+ZXV
         yCXw==
X-Gm-Message-State: APuU4Z+tX6nKN7Pp2ZAGYwdmZ7hQsV9nI+/fNxAdCrxtQhzN3NzZK/Dj
	mhMHzFPp//i0zHYKA8pRoBKS7+vc4nN2e2IYAfnxdt0iRm+SiIZLKjSvKeCazzttXC0LMTaekX4
	awlfp
X-Gm-Gg: AZFdTZf2DnF1cemiWWq2PBJ/hL9xFclnkKN/Q+z19XMnhMJgUrsH6rKumok73UvxQs6
	Y/+Ik9WtHe1Sq3FG/6cObDx1O9FXdQtnPiJg/LTUUV4ilD/RGlgQMICXH2zUTafFRtjNz3GBIG6
	ueHkhF1zaNIvP3j4lfbCSk258Ch0fU5e3tvqCHzFKQxQ4qSEV/nfIshAPuHoBuyizRYnlWCjvv9
	6zMUQcNV7oEyczteBTkqR26ijwJPqNcpsGER7wrjUjQweqj0JakuoyRIhZR2+o0PCb7BJSmfODy
	B5b122lrw3iMy6NBLy0G491mVoRKINgJrvpzK2iDme29QmOg+aFaKADALqB9DqM3CxfmSGOq4X3
	Ka8Ysj8cdAsRexKs+nK3CfnjVL0wz+e9WVlLRj8HRNKHWG/S2qZDdFYTZtdrzLrhFoHWJJJXLoN
	7jkE5+UB47UVtWW3Jp3iuSSPDlJTAOU/6EQd631cjBTpRaPMY+o45/uj4rA0FogEaQMHZQZSoh0
	mg+LzMM1v1zC0RwbNDAPTcEtev2JMTBzn7H9mnhRhi6mhkKpvpGa3khSxfolSENHu46HRTQ0mS2
	MrysC/Yks5KOuclfKj27azhwTkeDu2SvPgfwmK6R9eSen/IgAQ==
X-Received: by 2002:a05:600c:4ecd:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb8881e81cmr390604895e9.29.1795626134924;
        Wed, 25 Nov 2026 09:02:14 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba3d3679bsm40475725e9.2.2026.11.25.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:14 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/4] shared/vcp: Add bt_vcp_get_mute and bt_vcp_set_mute
Date: Wed, 25 Nov 2026 18:02:05 +0100
Message-ID: <20261125170207.1648671-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
References: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the Mute field of Volume State next to the volume. As a client,
setting it writes Mute or Unmute to the remote Volume Control Point. As
a server, it updates the local Volume State and notifies it.

The volume callback now also runs when only the mute state changes, so
its user sees a remote client muting or unmuting the server.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/vcp.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/vcp.h |   3 ++
 2 files changed, 116 insertions(+)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index c7f74956e..1dae20d46 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -181,6 +181,8 @@ struct bt_vcp_notify {
 struct bt_vcp_client_op {
 	uint8_t volume;
 	bool resend;
+	uint8_t mute;
+	bool resend_mute;
 	bool wait_reply;
 	bool wait_notify;
 	unsigned int timeout_id;
@@ -216,6 +218,7 @@ struct bt_vcp {
 
 	uint8_t volume;
 	uint8_t volume_counter;
+	uint8_t mute;
 
 	struct bt_vcp_client_op pending_op;
 
@@ -977,6 +980,18 @@ struct vocs_op_handler {
 	{}
 };
 
+static void vcp_mute_changed(struct bt_vcp *vcp, uint8_t mute)
+{
+	if (vcp->mute == mute)
+		return;
+
+	vcp->mute = mute;
+
+	/* The volume callback reports any Volume State change */
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
+}
+
 static void vcs_cp_write(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				const uint8_t *value, size_t len,
@@ -991,6 +1006,7 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
 	};
 	uint8_t	*vcp_op;
 	struct vcs_op_handler *handler;
+	struct vol_state *vstate;
 	uint8_t ret = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
 
 	DBG(vcp, "VCP Control Point Write");
@@ -1032,6 +1048,10 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
 		DBG(vcp, "%s", handler->str);
 
 		ret = handler->func(vcs, vcp, &iov);
+
+		vstate = vdb_get_vstate(vcs->vdb);
+		if (!ret && vstate)
+			vcp_mute_changed(vcp, vstate->mute);
 	} else {
 		DBG(vcp, "Unknown opcode 0x%02x", *vcp_op);
 		ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
@@ -2045,6 +2065,8 @@ static void vcp_set_volume_complete(struct bt_vcp *vcp)
 {
 	bool resend = vcp->pending_op.resend;
 	uint8_t volume = vcp->pending_op.volume;
+	bool resend_mute = vcp->pending_op.resend_mute;
+	uint8_t mute = vcp->pending_op.mute;
 
 	vcp_client_op_clear(&vcp->pending_op);
 
@@ -2055,6 +2077,12 @@ static void vcp_set_volume_complete(struct bt_vcp *vcp)
 		DBG(vcp, "set pending volume 0x%x", volume);
 		bt_vcp_set_volume(vcp, volume);
 	}
+
+	/* If the volume request above is in flight, this one waits for it */
+	if (resend_mute) {
+		DBG(vcp, "set pending mute 0x%x", mute);
+		bt_vcp_set_mute(vcp, mute);
+	}
 }
 
 static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
@@ -2076,6 +2104,7 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 
 	vcp->volume = vstate->vol_set;
 	vcp->volume_counter = vstate->counter;
+	vcp->mute = vstate->mute;
 
 	if (vcp->volume_changed)
 		vcp->volume_changed(vcp, vcp->volume);
@@ -2207,6 +2236,89 @@ uint8_t bt_vcp_get_volume(struct bt_vcp *vcp)
 	return vcp->volume;
 }
 
+static bool vcp_set_mute_client(struct bt_vcp *vcp, uint8_t mute)
+{
+	struct bt_vcs_param req;
+	uint16_t value_handle;
+	struct bt_vcs *vcs = vcp_get_vcs(vcp);
+
+	if (!vcs || !vcs->vol_cp) {
+		DBG(vcp, "error: vol_cp characteristic not available");
+		return false;
+	}
+
+	if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL, &value_handle,
+							NULL, NULL, NULL)) {
+		DBG(vcp, "error: vol_cp characteristic not available");
+		return false;
+	}
+
+	/* Like volume, wait for the op in flight: it changes the counter */
+	if (vcp->pending_op.timeout_id) {
+		vcp->pending_op.mute = mute;
+		vcp->pending_op.resend_mute = true;
+		return true;
+	} else if (vcp->mute == mute) {
+		return true;
+	}
+
+	req.op = mute ? BT_VCS_MUTE : BT_VCS_UNMUTE;
+	req.change_counter = vcp->volume_counter;
+
+	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *)&req,
+					sizeof(req), vcp_volume_cp_sent, vcp,
+					NULL)) {
+		DBG(vcp, "error writing mute");
+		return false;
+	}
+
+	vcp->pending_op.timeout_id = timeout_add(VCP_CLIENT_OP_TIMEOUT,
+					vcp_set_volume_timeout, vcp, NULL);
+	vcp->pending_op.wait_notify = true;
+	vcp->pending_op.wait_reply = true;
+	return true;
+}
+
+static bool vcp_set_mute_server(struct bt_vcp *vcp, uint8_t mute)
+{
+	struct bt_vcp_db *vdb = vcp_get_vdb(vcp);
+	struct vol_state *vstate;
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
+	if (vstate->mute == mute)
+		return true;
+
+	vstate->mute = mute;
+	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *) vstate,
+			sizeof(struct vol_state), bt_vcp_get_att(vcp));
+	vcp_mute_changed(vcp, mute);
+	return true;
+}
+
+bool bt_vcp_set_mute(struct bt_vcp *vcp, uint8_t mute)
+{
+	if (vcp->client)
+		return vcp_set_mute_client(vcp, mute);
+	else
+		return vcp_set_mute_server(vcp, mute);
+}
+
+uint8_t bt_vcp_get_mute(struct bt_vcp *vcp)
+{
+	return vcp->mute;
+}
+
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -2320,6 +2432,7 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 
 	vcp->volume = vs->vol_set;
 	vcp->volume_counter = vs->counter;
+	vcp->mute = vs->mute;
 }
 
 static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index e031beafd..807d2bdbe 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -42,6 +42,9 @@ void bt_vcp_detach(struct bt_vcp *vcp);
 uint8_t bt_vcp_get_volume(struct bt_vcp *vcp);
 bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume);
 
+uint8_t bt_vcp_get_mute(struct bt_vcp *vcp);
+bool bt_vcp_set_mute(struct bt_vcp *vcp, uint8_t mute);
+
 bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t cb,
 			void *user_data, bt_vcp_destroy_func_t destroy);
 
-- 
2.43.0

