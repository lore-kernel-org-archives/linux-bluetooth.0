Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0C9476
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737913662; cv=pass; b=f5wF1tP8nPonBEY3mPJsyVJu9iAAVotfY9KGB0S2nCOpmJIWPc+gkDIL9BaXxhdQ9mSIGEg2Kh14cjm+T/CDC8MaXLzOh9x4Fp4CnZVuCoijbGpNrz+EpvIEdr6wpwX74W/AdOsuSEdVn8XoXiNzbg+TJNm2rWLCqBq/FGy11zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737913662; c=relaxed/simple;
	bh=ErLrVbqJfud247PspLKOC5lSuqFndWToFzyF3mG0dps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFLh32R4hZRZZrEntJPsGA/YQh31CHjhMUEVfRxCJOlrFzjbCdU4Dawh5elpbdNqrkCc7JLma/wTJudmdc1HrnV4b288JpDSi2xqzX3AzKg2v4g1SePfPrRbTCwiANlPeK2RykrXK75iiQMMubAaLSiGoMnMR4CmsCpesCleAVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=GOspFOt9; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="GOspFOt9"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YgzXR3NtLz49Q47;
	Sun, 26 Jan 2025 19:47:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1737913656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iZKtgyBqgaiNFYCQsKpe9ne2jVCyTj4wxB5qgIY//NY=;
	b=GOspFOt9q7+MnCHkQhqt+YVB0+703m0pW8RHPLUqrrBQHHm5sl9iM8LVoikUsMhCE2qLk+
	GfuZ6SEnCBveszNjoDbI/KnLn2GD4XcoW244BP9pSOwrHgsmUnn1UQR7i9exAy88s1jZAx
	UI+M2c6KGAj02BLJYnA/iU2zWjDUkJYyS+c9dJFVQ77EP+vYfacbIQE+b0/v9DxeJP2Uau
	lGKQUVeFWPg3jsI/Nq8pi6flpvnfSxZRYVY6DWVEjvrJw18lcyRLHjoMDHoXcmsbZDOQkl
	x79njkPE2mjot3Gg18+K3Sd6LyDbpGWOqJj5YLfytpKY6P5QfaVCU3l+06Omsg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1737913656; a=rsa-sha256;
	cv=none;
	b=oJC3DwuBa8w++Tsuy3z7WuWBQQlhAkHxvzaVitFwCjzjnAWZnAGcaJe+qTfnbUKprnIxTA
	nKMJxSnqxelaR7a3K0d4nt1p40dSCEuUbxP4KXoJMxfzmKeM04aW15L3Byg4ILiVNNulam
	fNRhtkoIzkLY2hRZU+86Fv/JSbWiGpgSJ/8yhrHkOuU02/cKxiTRJ2s/ATlv4aNNSafY+3
	+EdwoTwj0fvwsGd0cige5/BM7nDH4CwC7bgz1tzcfiTL/mNi1LhHh2wuxIB7BYY0Y7b8Sq
	nBtnn4lZzaGrE4PulxrgNYp2NCOmjn7wVG25j0Nl0bRWWe1xKjdOvigRNCrIRQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1737913656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iZKtgyBqgaiNFYCQsKpe9ne2jVCyTj4wxB5qgIY//NY=;
	b=aT+TVQfPvcxhSfaWGE+xywIJi6rBC0ihyz/ZRaAHHAAzpcB2dRXRpxSX8Fr2L08qFSxODL
	khngdBWbQo+dkcNmSsi4Y5iYgFbCXoXcPgvYL2+BgJxXIM4k1QrjIXma3U/7FWA3zbDcC6
	MzuD9M6jtReNZDi48ho/31vAZknQPTqu8OrW+40lGtDiKi1/pjO4IozKLg4zaUAV8ikwMs
	ggcfHVWr9qFbz9XRUJ2D7zMd+X3T0fMmlybO2r1uTibLf8ER23xSKOYMGuEns3rmGig5jO
	XstiqxE/U8ivn7GvwPL66orqtYdHC4K2opP9AUc/2nOQAiftanIXV6Ai3rA9Sw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/vcp: have only one volume change in flight at a time
Date: Sun, 26 Jan 2025 19:47:30 +0200
Message-ID: <5b7315d16822f8ec8b21ec124f82a1b90ab66ae8.1737913576.git.pav@iki.fi>
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
 src/shared/vcp.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 6b0f2f9db..f781b7b2b 100644
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
 
-- 
2.48.1

