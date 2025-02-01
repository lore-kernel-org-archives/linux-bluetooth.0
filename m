Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED81BD014
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738422743; cv=pass; b=In+ZmNXS06n6hG03dEgsexzMMWqu+yKcfiwclvpRyFwtWD9FOpOkJkqgg8f1K7+ArJIeKG34cWv0hsT4rgLLVNEh1xbUoql545+WhH1TJ0SB+kX5tNP9v9l8bfr5U89/p6+4Nosj1USiQfm+CPzyyXW8ZtyiGT6DAuuC+YIfzcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738422743; c=relaxed/simple;
	bh=X4JXgt+6NSnIJCbjp8izFSAisMuo+mB619Uze2vJlz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdRPnGGCz9OOqpnuevZLXsU3IzOGQ9uw+gRzylC8yP7fts6E5TSXFuIA5POLtoHWoz2NO/hgvy1KIIfGE8a6KAndFQJFTACy9f9ohGcFw3n5xbHs9wIiXh6wgsIaLFCIT+dbUEOLgBUmvDa3bIE5ecmnafUbEOH8ghqD56AbUNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KSdqSVeC; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KSdqSVeC"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YlbpM6j6Yz49PvR;
	Sat,  1 Feb 2025 17:12:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1738422732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t+JoFc0TG/4p4Xl84B4gLEdEDxILKWi1pZADH7q7gpU=;
	b=KSdqSVeC2SmixEE1KWgfNZdL/13GlfvHIZzH/ApPt+fhpbvYfka2ScRE3RGlgp+hrMOI1P
	jNu3n48p7hEPocZUc2vUPIDfeqWHwY25rv3lb/3xJJiwFjLKhNDRvlxb0StVrao2Hb4+iZ
	VbvSyJ+h8UtqHVKF36ukkT1QqgdTMbpNhvQH277Qcu7Vy47vdlTwXDwKwDzu7z3Ur1If6b
	nRg0FaSA421xx31SSTLoFOpPGczOeXX8qvIfmHik0QM50RmZ1Nwe2vz8qy7rf/K6i7U5oE
	228SIiTQ5Ewwh3a3fKAYUEWfLdu8qUjxjjS3ZLeeuTahr7L8sMgfCG57ft0Iqg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1738422732; a=rsa-sha256;
	cv=none;
	b=mMkVwJ6Wq2vbQL0GgoEQXNg+MJVKlyr6O/plxsHNazx53y5QFznaPkfPM6c+SSA19KcAS9
	zjJR/FNyR7Kpa41Tjz/vCqTk0C8CxB73lXyErx/KUdXU6YDVmIviJ/PMT8zjGjWXfGQOYi
	Nhmy4xuT1/ap80qwxd8wgMxgpmo0d+hCM+rfNcMj2x/h5iujQpXWH1wOl1c6hvDJLAdwLa
	+wd5oYw2OP4SQcJClevOtai6z8kmtDjJk+KRc11Ury+yaNxoKeXMJStbrobKO3cTiLEBPG
	uyMdD9BzZJ306iYl5YChLUTTNSHpdBCOnYFPYZcd55aZWYRpels42oslqRtKPQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1738422732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t+JoFc0TG/4p4Xl84B4gLEdEDxILKWi1pZADH7q7gpU=;
	b=B2YR4iwEALE2W/lkGFYiyg0dYC0AuNGWgpRxHmLk5T0TALiqTOFR+7LWyjgvI3WsIbIB9c
	FBEHWeygJJvDB3v9hG1zKR60pMspmkRJpt/UjGwAeCTlIQFqMTdtAxXecLzQkmK7ieakwm
	7gY4XjzIRON0O6GIOUi2NSfxMaSqI1wjdDz7PPQNgBBW8t5zhGwCXxYebqJNwDLuCGisGC
	9Hm8H+oXu/nyTqE62aY/2FNMFRSsso8XrUsblSmxlViDiCr8WgGRE65MXBDgsgDM+OOZ26
	nWGtCqc+hTlUOra3abdrq2KSGCklnYeTXVCK0scCFis2HeEu1/OTd18GOjwE1Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3] shared/vcp: have only one volume change in flight at a time
Date: Sat,  1 Feb 2025 17:12:09 +0200
Message-ID: <06e82df8d3cdd52cdaf4417059638382d7443efd.1738422702.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bt_vcp_set_volume() is called again before the previous operation has
completed, the requests get the same change counter, and all except the
first one fail.

Fix by waiting until the current request completes, and if volume was
set again during waiting, send a new request with the latest pending
volume value. In this definition, bt_vcp_set_volume() will skip over
intermediate volume updates if they are done too rapidly.

Send only volume requests that change the value to a different one than
last notification we have seen: in this case the request either fails,
or succeeds and generates a new notification.  In theory this guarantees
we always exit waiting, but safeguard it with a timeout.
---

Notes:
    v3: add timeout, wait separately for reply and notify
    
        In theory from VCS v1.0.1 3.2.2.5 + 3.2.2 you expect that request
        that is setting volume to different value than that of the current
        change counter, can only either fail, or succeed and produce
        notification. But it's probably safer to have a timeout regardless,
        so that we're guaranteed to stop waiting.
    
        I also changed it to keep track of which of write response & volume
        notify have arrived, to avoid a race condition where notify from
        another client's volume change caused us to send another request
        before previous completed.
    
    v2: reset pending_ops when attaching, needs to be cleared on reconnect

 src/shared/vcp.c | 86 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 6b0f2f9db..f0887ad62 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -32,6 +32,8 @@
 
 #define VCP_STEP_SIZE 1
 
+#define VCP_CLIENT_OP_TIMEOUT		2000
+
 #define VOCS_VOL_OFFSET_UPPER_LIMIT	 255
 #define VOCS_VOL_OFFSET_LOWER_LIMIT	-255
 
@@ -176,6 +178,14 @@ struct bt_vcp_notify {
 	void *user_data;
 };
 
+struct bt_vcp_client_op {
+	uint8_t volume;
+	bool resend;
+	bool wait_reply;
+	bool wait_notify;
+	unsigned int timeout_id;
+};
+
 struct bt_vcp {
 	int ref_count;
 	struct bt_vcp_db *ldb;
@@ -203,6 +213,8 @@ struct bt_vcp {
 	uint8_t volume;
 	uint8_t volume_counter;
 
+	struct bt_vcp_client_op pending_op;
+
 	void *debug_data;
 	void *user_data;
 };
@@ -395,6 +407,14 @@ static void vcp_remote_client_detached(void *data, void *user_data)
 	cb->detached(vcp, cb->user_data);
 }
 
+static void vcp_client_op_clear(struct bt_vcp_client_op *op)
+{
+	if (op->timeout_id)
+		timeout_remove(op->timeout_id);
+
+	memset(op, 0, sizeof(*op));
+}
+
 void bt_vcp_detach(struct bt_vcp *vcp)
 {
 	if (!queue_remove(sessions, vcp))
@@ -404,6 +424,8 @@ void bt_vcp_detach(struct bt_vcp *vcp)
 		bt_gatt_client_unref(vcp->client);
 		vcp->client = NULL;
 	}
+
+	vcp_client_op_clear(&vcp->pending_op);
 }
 
 static void vcp_db_free(void *data)
@@ -2003,6 +2025,22 @@ done:
 	return vcp;
 }
 
+static void vcp_set_volume_complete(struct bt_vcp *vcp)
+{
+	bool resend = vcp->pending_op.resend;
+	uint8_t volume = vcp->pending_op.volume;
+
+	vcp_client_op_clear(&vcp->pending_op);
+
+	/* If there were more volume set ops while waiting for the one that
+	 * completes, send request to set volume to the latest pending value.
+	 */
+	if (resend) {
+		DBG(vcp, "set pending volume 0x%x", volume);
+		bt_vcp_set_volume(vcp, volume);
+	}
+}
+
 static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -2020,6 +2058,10 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 
 	if (vcp->volume_changed)
 		vcp->volume_changed(vcp, vcp->volume);
+
+	vcp->pending_op.wait_notify = false;
+	if (!vcp->pending_op.wait_reply)
+		vcp_set_volume_complete(vcp);
 }
 
 static void vcp_volume_cp_sent(bool success, uint8_t err, void *user_data)
@@ -2031,12 +2073,23 @@ static void vcp_volume_cp_sent(bool success, uint8_t err, void *user_data)
 			DBG(vcp, "setting volume failed: invalid counter");
 		else
 			DBG(vcp, "setting volume failed: error 0x%x", err);
+
+		vcp_set_volume_complete(vcp);
+	} else {
+		vcp->pending_op.wait_reply = false;
+		if (!vcp->pending_op.wait_notify)
+			vcp_set_volume_complete(vcp);
 	}
 }
 
-uint8_t bt_vcp_get_volume(struct bt_vcp *vcp)
+static bool vcp_set_volume_timeout(void *data)
 {
-	return vcp->volume;
+	struct bt_vcp *vcp = data;
+
+	DBG(vcp, "setting volume: timeout");
+	vcp->pending_op.timeout_id = 0;
+	vcp_set_volume_complete(vcp);
+	return false;
 }
 
 static bool vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
@@ -2061,9 +2114,24 @@ static bool vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
 		return false;
 	}
 
-	vcp->volume = volume;
+	/* If there is another set volume op in flight, just update the wanted
+	 * pending volume value. Req with the latest volume value is sent after
+	 * the current one completes. This may skip over some volume changes,
+	 * as it only sends a request for the final value.
+	 */
+	if (vcp->volume == volume) {
+		/* Do not set to current value, as that doesn't generate
+		 * a notification
+		 */
+		return true;
+	} else if (vcp->pending_op.timeout_id) {
+		vcp->pending_op.volume = volume;
+		vcp->pending_op.resend = true;
+		return true;
+	}
+
 	req.op = BT_VCS_SET_ABSOLUTE_VOL;
-	req.vol_set = vcp->volume;
+	req.vol_set = volume;
 	req.change_counter = vcp->volume_counter;
 
 	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *)&req,
@@ -2072,6 +2140,11 @@ static bool vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
 		DBG(vcp, "error writing volume");
 		return false;
 	}
+
+	vcp->pending_op.timeout_id = timeout_add(VCP_CLIENT_OP_TIMEOUT,
+					vcp_set_volume_timeout, vcp, NULL);
+	vcp->pending_op.wait_notify = true;
+	vcp->pending_op.wait_reply = true;
 	return true;
 }
 
@@ -2108,6 +2181,11 @@ bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume)
 		return vcp_set_volume_server(vcp, volume);
 }
 
+uint8_t bt_vcp_get_volume(struct bt_vcp *vcp)
+{
+	return vcp->volume;
+}
+
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
-- 
2.48.1

