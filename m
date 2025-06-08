Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68325256C9F
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418361; cv=pass; b=rvJrVBvwfbZu2lZ43Hr0R3aILfLW0Wb80ff4Yg+dF4/wMZZH2N01LVF/WOaeGy+6ZYpXuEDt2X4qRT/ktAFb3UzK1Y/n8zJie/rqo4mfEjzBMa28m8G4mX1GAkFUjKLOJ3M4kqo3mteMy/vBUaphtq+PUlzEzOemO1ihv5sgRxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418361; c=relaxed/simple;
	bh=+VCzMt6KfrS0wMd8o+d2ZA6CSF1DWxP5443xC3g3N2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5rJD1mO9uIl9fZcx3wxZBOaMoKszWDEbTxwyL8ZbKE1n4/nWfcqiLuPTqmztYQYrv5F1b5BqKTwjdZ+WWCp4SDzrfFJnkp4rGzuid3YXC9wVxLDdBGje1YKQQ+VrVzg3udL1bq1fw4qpBQtQGZYSRFtHHelb5rfS3wF/QAGC/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=TizX2U9S; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="TizX2U9S"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDk4Wvyz49QDC;
	Mon,  9 Jun 2025 00:32:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUV0GcFXwF09YF6XpAfdDgSzcv31H3RTVyHIIvBGI1A=;
	b=TizX2U9SveURCTxAT0v9Ga9vn3zQwIfBxpgGIn9XzH9+kcLsSGKpfy29Sf8+6JWVhDWm4a
	+djN8hJEq9x1sHzXpMHGwAqkXsyf2VCX7j4xOukxjHPW1n7ooH0vn9OLhSuYzPhpKMf5Zb
	4YydTxs0nGGrRgEkBNCPxZB08b1sLp/aXoVdHKyxGygoZHGdaARut6NO6Mi5yNa1tkctP6
	G7f/IrWY9MQAFBCSX5sokgvs3Oj7MXGEciHyIEwc5HcVniAU5Jx31m2/LIkdyADXPEQwTp
	rPV+t6WAFRXMY9J/YND/b2lahL2+vFnI8dNlX5Tcl7QCJvQmQHjpeCxbtprohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUV0GcFXwF09YF6XpAfdDgSzcv31H3RTVyHIIvBGI1A=;
	b=ZjMlXJUp0BXws8JKYeTiYGgy1d3FlBBaNEcqRnrr+gQYGYKl4iEHWTaZJ0J4CH8UMXoKzr
	UgihgcgX6GLG+8vmaXNTwL3pqWLSpgZPZ5NnDCgQKmepLqsQrrqDQ2agNmWAYykxBYuyS5
	5y2lQP5tAeJgqb58UoqwMaReqvmjmeewBjY+4y9Sw9q3NPUqMKYMVqpaZHrFV22n47ItSH
	J2eXkK5gg3kCtjEs0NEmLVNrHJNQF7zo7/h1X4Mjyw/qj1CwCQ6/8L3KxFaryn3SGSyTkU
	SPGxXOl/UmyPYU8cmDGbsAP/9KgXDednnIAFQyy4V1PaD+/BnO0Mwu1zdZglHQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418358; a=rsa-sha256;
	cv=none;
	b=jlcslMOQIE2Yqr/3QQ7XMnX/hT6x9Ij84XzRMUmtyrVmfgzSejU4PkHCKeI3mPs6WGotCy
	AOgJ0ixgQS/7OaZi6K74SrpYA0QJXv5GELB/w/6H9tSDFYUojjikkQqcYsTNnI0Y6T0O7p
	nhzDDuwmQRo8K7xWzVVrWpw/eM7hpFjCP4/0JxET5cJGa5KOaMvmMbD1kLULOOtuQXEZFF
	LKRMlk47aOJ5D0xZRM7cHI94mZ0W6LvsMLttFZZT2MMHZNdHsnCyTzOvV7+nwilfN9S4q1
	fifnRWh2sXvEtP1U5TP3Y8Ag5ahYUZ2QovhXEpggSuFm47DAGFKSbYhF/vVk6w==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 04/10] bap: lock streams when used
Date: Mon,  9 Jun 2025 00:32:16 +0300
Message-ID: <11f5fab62c2c8054394f5295b3f0d42054066327.1749418319.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749418319.git.pav@iki.fi>
References: <cover.1749418319.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to lower layer when we are using the streams.

When setup is freed, make sure the corresponding stream is released
after unlocking.
---
 profiles/audio/bap.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b420354cd..6be6ff8fd 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -861,6 +861,17 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 	return setup;
 }
 
+static void release_stream(struct bt_bap_stream *stream)
+{
+	switch (bt_bap_stream_get_state(stream)) {
+	case BT_BAP_STREAM_STATE_IDLE:
+	case BT_BAP_STREAM_STATE_RELEASING:
+		break;
+	default:
+		bt_bap_stream_release(stream, NULL, NULL);
+	}
+}
+
 static void setup_free(void *data)
 {
 	struct bap_setup *setup = data;
@@ -892,6 +903,10 @@ static void setup_free(void *data)
 	if (setup->destroy)
 		setup->destroy(setup);
 
+	bt_bap_stream_unlock(setup->stream);
+
+	release_stream(setup->stream);
+
 	free(setup);
 }
 
@@ -1015,6 +1030,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
+	bt_bap_stream_lock(setup->stream);
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
 	setup->config_pending = true;
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
@@ -1107,6 +1123,7 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	/* Create and configure stream */
 	setup->stream = bt_bap_stream_new(bap_data->bap,
 			lpac, NULL, &setup->qos, caps);
+	bt_bap_stream_lock(setup->stream);
 
 	setup->sid = sid;
 	bt_bap_stream_set_user_data(setup->stream, path);
@@ -1430,10 +1447,12 @@ static void setup_config(void *data, void *user_data)
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
-	if (!setup->stream)
+	if (!setup->stream) {
 		setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
 						ep->rpac, &setup->qos,
 						setup->caps);
+		bt_bap_stream_lock(setup->stream);
+	}
 
 	setup->config_pending = true;
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
-- 
2.49.0

