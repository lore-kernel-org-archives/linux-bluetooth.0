Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C8222577
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679059; cv=pass; b=nqB+EYpMEZlsnIfezPDMgGWfBmAMDTEKeKGFcYR71LZjTu+wSbhnpfPxHYlg6vA4ZJOz5D46vKv4T63BTtHaA9GJx40Ow2e6W2Dnw6M4TaWjkUQxAXl6MxaIKc16TAih65g+Y8c/qVSmDA+mg49/9mWm6WltImRD79VMK9xpuGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679059; c=relaxed/simple;
	bh=B3KNKAb5TxXPpdgI5rOXztrTXauzfH57wpWAWoleuKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je5ovpZzgsxK9fQ/TAG12qB9GaBBbY9rMvt86esxRIM3b2GNNX7HNK31ehrNXw/AAfY1FLtxOO8JapxlJVCm2aIGv+HC1QLczAeyGmP1Xp1uG8kK5YSAAi5f8U2zP4JwHPPydIQexGLf9NX62C+WXistk/Orq4xrSwoIY4Oqz4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=bl1fAB4F; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="bl1fAB4F"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzCly0nHNz49Q76;
	Fri,  8 Aug 2025 21:50:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdLqRkXYYZEKmuAjlI0d7q7GmasvCSeL3RZ+bA2XOLA=;
	b=bl1fAB4FCcoDMQ2hqclaf75B85CyzE2sXqi8q7pld4M74XvT76C5lZ75Bh3YhqRrTRuVT1
	2zHRa/CN/KnmQcVC64GenPmuySZwdACjMQTB1RtZY2vNLDNwYSLbzJXAtp5/mIYdS8o/zN
	RuleYA/8dmM/ZPkk/p+nlnVFWkyVLQ4vfAiArSCRROT71PhAleuj5j2EF1CxxxH3nWXknS
	ztnQZdqnolXkKfKoL6oJYJCL6eB4T/tQe058Lwi/ALmo8Jsmh4b8p973ABbHpZYwotcGIt
	r/B2gqgIf587rsMibD3OKeBz7m+ZueBvkLNGkx0+7vKqvdnOQ0JRywg5t9zVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdLqRkXYYZEKmuAjlI0d7q7GmasvCSeL3RZ+bA2XOLA=;
	b=XoESjbwfQI2D7DJVu2Ki+wGNYbRTHGgw6f5nGMV/xLCsZtTILSHknwe00dcqaeGQVGLT+3
	RM2AgMAoBURDAHp27ubVRFVYGlpAfJSNZxm68btwWM4vLZUhIVbzYYadNiaEevtnJXSVuO
	saEagICzhKe5Lqxwf4vz0MkpI/oAhfK3Ry1vmnAzv+lqS/Fha4qvUVRExLpaokHg+lBuE9
	vkTEBxDFErxg8jEQu+9wtg4rY40zOl9meXLolGZJ/yBwKfVdT3jd75JF4xDzS6qz+WYuDZ
	62P2bJ0gqDhvlCX3ruaC+y8vy8bBYLa1nE78fl5nt4hVzC7AQ0mT8gnWUoVk5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679054; a=rsa-sha256;
	cv=none;
	b=MMMLiauzpA4gravQAcPNRPB75wuKFLLuduFZhQQx/az44SsHcTSEFBDRmkfUT6/E7yTLPG
	5YUOHRN9Xt5M+zod59UrRHo7hfMuyZ3SMWfMGNnt86ZCluHkn9izjPCaozmH2kXc2e96+n
	CYsI7KrzN7McoP9oAtrl2vuUHX6RmRls3rRKQFXaAPgfC8fIvb7lcJqEGjivWobZ2US0BO
	L8Mj9+bqKI8HI5n1nsEplZlOVw557oRsntUw9QGZqTg/uBGRJJNTYuHkpc9uid6nfRyeIb
	4sE3elcnYaQQ2x6WxhjrmQXjnmA5wF2fpqb96BDPjkX/PGiqCNrD+cWZ+/WofQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/7] media: fix pac_select(), pac_config() return values
Date: Fri,  8 Aug 2025 21:50:36 +0300
Message-ID: <136ad7f6e6e7928f3c245469cc95016c02caa80a.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
References: <cover.1754678883.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These return 0 on success, < 0 on error, not TRUE/FALSE.
---
 profiles/audio/media.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 8e62dca17..a723b311c 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1063,8 +1063,11 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	dbus_message_iter_close_container(&iter, &dict);
 
-	return media_endpoint_async_call(msg, endpoint, NULL, pac_select_cb,
-								data, free);
+	if (!media_endpoint_async_call(msg, endpoint, NULL, pac_select_cb,
+								data, free))
+		return -EIO;
+
+	return 0;
 }
 
 static void pac_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t cb,
@@ -1228,7 +1231,7 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	if (msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		endpoint_remove_transport(endpoint, transport);
-		return FALSE;
+		return -ENOMEM;
 	}
 
 	data = new0(struct pac_config_data, 1);
@@ -1243,8 +1246,11 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 
 	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
 
-	return media_endpoint_async_call(msg, endpoint, transport,
-					pac_config_cb, data, free);
+	if (!media_endpoint_async_call(msg, endpoint, transport,
+						pac_config_cb, data, free))
+		return -EIO;
+
+	return 0;
 }
 
 static void pac_clear(struct bt_bap_stream *stream, void *user_data)
-- 
2.50.1

