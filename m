Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92614AA4
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="R4hwEyeh"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BB2726
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 08:00:15 -0800 (PST)
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SSy242yP8z49Q1r;
	Sun, 12 Nov 2023 18:00:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699804813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ddU2F39Yz3+abifU68xlt+o74WQz6fWioDl3MPSS0w=;
	b=R4hwEyehFZWDpbTo6xGmGXy9QPkinYm0TqavYW2liNixhIdm0/exg3CeC2UzYrUqVZw5Ya
	6b7HyF+9NA16hs9GHJwp6fRp5dqz0tmSMaWH00DuEjeCfzROmckPi6g3jNigi8kRL3+lt0
	Gg/ktZi7Rs0ATCrgeSs6TSRp5vFoAehEi9rtyQ1UtTAL1BO5Zs4s6+js6/ltQvaghyhMeq
	+SmKf0jcd2JFO2xyyWvNLefloXdJnJG0ATfsXsxlCy6qb38JPc4AIXs1BQL8xcbT+szlVr
	3Bktm9fMOp6JGgkph5U/5gG8sSbaaHlRePT8HXloyx73m8xRNwtAX2aHGTX08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699804813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ddU2F39Yz3+abifU68xlt+o74WQz6fWioDl3MPSS0w=;
	b=Eh0rjBUgCOiiiRo0zZXeMGA+I9rod5Es++vZdcTiXnnCJPeU2BB7lmH+U0amUOIs5IuBm5
	mMIVJiWFy8doqvd7jRG3Ew5+XuHw65ujXQI928pq0qxLfqGZ3bP8odj3Ef+1qMc34r1u/h
	eSJiBQFOhl+fSxgFogfGPoap4DqAZSMoWeRZBMUb4OaQ1drTkiaevenigFHx5E9F4HSjSi
	aTpS74UV7f6Ufpg7fmp3gdryBWgRwVCzYKNr9+azi5G2qe9HNjQ3Keai5Hw///lDik6uDE
	Ba+ZJ+r3jAeLbD+WvQDkZQCYVr/oP2uKaIWYz0XzrEJs80gZ3K3WhB/Y9nldwA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699804813; a=rsa-sha256;
	cv=none;
	b=nWjrmhHtfEfWoMlxJGohSTFRzRjk1KQRnmvRrfKzg0mn2GKyUwpk+wzgf0JG/2WqjRCs0w
	vZ6R/dH3bmgdUSKjPb2CQolDlfPYoYPhZ98dABz3md/vSRVxKFimqeZ14ycAkL4eWM1jj2
	eDXwsm2R2saPd7VxILgCsM1iCT8PHaxsgWAW/8nvcH1j59PWT26Wm5LDFYa1AIcWl6eDfk
	XTXg96dKBwOmDHxEvqmcX4T5/TXOOLLiEzJYl9EnTbMIxLs98L+H1DAo8OVzf0V06fk3aI
	sJETk7yHQ9L2Uo2ghw9dLnuG8nOUQxp+unLJCiGKbb4HqbGMOeg4f6xGbAwPwg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] shared/bap: add bt_bap_stream_config_update for updating QoS choice
Date: Sun, 12 Nov 2023 18:00:02 +0200
Message-ID: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bt_bap_stream_config_update for updating the QoS while in Codec
Configured state.
---
 src/shared/bap.c | 18 ++++++++++++++++++
 src/shared/bap.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 13bbcf793..d90e39f7c 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4600,6 +4600,24 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 	return 0;
 }
 
+int bt_bap_stream_config_update(struct bt_bap_stream *stream,
+					struct bt_bap_qos *qos)
+{
+	if (!bap_stream_valid(stream))
+		return -EINVAL;
+
+	if (stream->ep->state != BT_BAP_STREAM_STATE_CONFIG)
+		return -EINVAL;
+
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		stream->qos = *qos;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							void *user_data)
 {
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 23edbf4c6..099c2edd0 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -255,6 +255,9 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data);
 
+int bt_bap_stream_config_update(struct bt_bap_stream *stream,
+					struct bt_bap_qos *pqos);
+
 unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					bt_bap_stream_func_t func,
-- 
2.41.0

