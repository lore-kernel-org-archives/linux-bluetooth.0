Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107D2AD22
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737922149; cv=pass; b=FnscJ9OU7zzS5LSpDcKMC0sItX/wb/McrMJo/UAmW7FGzV2JhmN9Mdex1VdFmhMb+SM2GHK7ZD5JREc2l2YmGmQFkDS8FFjbCBN4Mujl2pK4uuQd2kptimMwRUaNkSBjWu/vWzaNSRd90fmr54zkWE+n3p9QSSAIfQz6HO3zVSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737922149; c=relaxed/simple;
	bh=rAHxPyKvXdE90/C/+XEmCIMYHVpBfKBUJQT9MFf16iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUwkeGKO7VpZO2/3s7fR6W//65PqCvjxIH1pDA0NsXaUJ625+8SPHaB+n/SzWqAOfEJYhFTttOOuwbvj6y+ci8bOhwXwDrwf336c1cytgkO/BYGhNQOX0aaFhBIMHMqkq2Q2RmdwaLO6eZwYuDJcYlg9T9uPNlgZ+GZkvjZ26W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dvXXHwtY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dvXXHwtY"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Yh2gZ1mkBzyQx;
	Sun, 26 Jan 2025 22:08:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1737922138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NBrauUgkMRZa9Yd2m3DRZGSVkTgzhfv1Fatbt4xVvc8=;
	b=dvXXHwtYP6aECUCCkgCdtoJ9HXjRtY26nU1hIKx5dU8rkOUyPOi3zFzIWyZaS8G2J8bUJg
	em3otZUTBIrAOJw3rnByQYII766Tj/+6IRQ89+p1o/Kggl0fm8fF9NvHNhC5MyTVc7OyF1
	b0fvrb+kpKahxGjZHsi+Bok2oqUQIyw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1737922138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NBrauUgkMRZa9Yd2m3DRZGSVkTgzhfv1Fatbt4xVvc8=;
	b=F61nyQdEa3za61serwoJHqRUEKE15hJff0zfis6MFwRt03M4COaiPP96SYENB5357Ql2RD
	gxSE+VVtuGs+UscA0bB2LIgZTkV/uxomy0rE6gvA6fLY+3LovkpafPW0Q2ozbg88y5Vdg0
	pLrEjK9V69yJwn0O9wQ7HY0bBBjJf7c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1737922138; a=rsa-sha256; cv=none;
	b=AsQQdocWUpCwTJRERiqSm6e9ajj+uStztRjdBK+i4b9Cu9Og1jrcm1yS9aWmPnSBFPyt1T
	Gdn5kjKg2kd1XmjdCWztyExeLFrwLQq47Qs2WwZMP/WraoTId+Nc1XGz0v2Aha7iENn+HC
	eVel0Ui1/0y/Cph+z5VJ5RoSi5l5LBI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] shared/vcp: have only one volume change in flight at a time
Date: Sun, 26 Jan 2025 22:08:54 +0200
Message-ID: <06f0a1ed2fc2726b8dd46eef113e07ad742048c1.1737921917.git.pav@iki.fi>
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

Fix by sending another volume set request only after the previous has
either failed or generated a volume notification.

Send only volume requests that change the value to a different one than
last notification we have seen: in this case the request either fails,
or succeeds and generates a new notification.  In all these cases, we
exit the wait state correctly.
---

Notes:
    v2: reset pending_ops when attaching, needs to be cleared on reconnect

 src/shared/vcp.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 6b0f2f9db..2b5d186b8 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -203,6 +203,9 @@ struct bt_vcp {
 	uint8_t volume;
 	uint8_t volume_counter;
 
+	uint8_t pending_volume;
+	unsigned int pending_ops;
+
 	void *debug_data;
 	void *user_data;
 };
@@ -2003,6 +2006,19 @@ done:
 	return vcp;
 }
 
+static void vcp_set_pending_volume(struct bt_vcp *vcp)
+{
+	/* Send pending request if any */
+	if (vcp->pending_ops <= 1) {
+		vcp->pending_ops = 0;
+		return;
+	}
+	vcp->pending_ops = 0;
+
+	DBG(vcp, "set pending volume 0x%x", vcp->pending_volume);
+	bt_vcp_set_volume(vcp, vcp->pending_volume);
+}
+
 static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -2020,6 +2036,8 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 
 	if (vcp->volume_changed)
 		vcp->volume_changed(vcp, vcp->volume);
+
+	vcp_set_pending_volume(vcp);
 }
 
 static void vcp_volume_cp_sent(bool success, uint8_t err, void *user_data)
@@ -2031,6 +2049,8 @@ static void vcp_volume_cp_sent(bool success, uint8_t err, void *user_data)
 			DBG(vcp, "setting volume failed: invalid counter");
 		else
 			DBG(vcp, "setting volume failed: error 0x%x", err);
+
+		vcp_set_pending_volume(vcp);
 	}
 }
 
@@ -2061,9 +2081,20 @@ static bool vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
 		return false;
 	}
 
-	vcp->volume = volume;
+	vcp->pending_volume = volume;
+	if (vcp->pending_ops) {
+		/* Wait for current operation to complete */
+		vcp->pending_ops++;
+		return true;
+	} else if (vcp->volume == vcp->pending_volume) {
+		/* Do not set to current value, as that doesn't generate
+		 * a notification
+		 */
+		return true;
+	}
+
 	req.op = BT_VCS_SET_ABSOLUTE_VOL;
-	req.vol_set = vcp->volume;
+	req.vol_set = vcp->pending_volume;
 	req.change_counter = vcp->volume_counter;
 
 	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *)&req,
@@ -2072,6 +2103,8 @@ static bool vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
 		DBG(vcp, "error writing volume");
 		return false;
 	}
+
+	vcp->pending_ops++;
 	return true;
 }
 
@@ -2896,6 +2929,8 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	if (!vcp->client)
 		return false;
 
+	vcp->pending_ops = 0;
+
 	bt_uuid16_create(&uuid, VCS_UUID);
 	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vcs_service, vcp);
 
-- 
2.48.1

