Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35838DE2
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jan 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868849; cv=pass; b=LlCgYoB72dCHc71tl1AEDIWvMDt0z+w9o9aDN1hMnTZqQjA4Qv3Pb65yJsFSmnozH0CVt3/+J0hrJPSakBV6ndd/ET1mHH0cDqPyMGkPf+sN2YXQjxtaxq+kS7LFJ4gPaBOudh5+Ov+J3ivdVFdapVpK+xOahJ2wfeWN326zZAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868849; c=relaxed/simple;
	bh=4fWVwnWG/4Tavpeco9/zAQJAzLZpa6iP5Sn2kHmw4m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3L1AsoWcOmmsBMJq1BAQdiVqkzD6nrjWdHISL1t2vGG0S7WAAfHM2FgNMXcwDjpUpZZqCtI6sHysoVIqp0U6tCjbzWQCmDEPjpeClyJ899I98YrsceuU97CzeI8sBbKjMgMCf7akFO3KKw9bVstd+3S0f85L1bIDTLIOFunGq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=fail (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=lnr+rKWH reason="signature verification failed"; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="lnr+rKWH"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TJ4dt3gcRzyNX;
	Sun, 21 Jan 2024 22:27:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1705868835; h=from:from:from:from:from:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i1c5Zrs0aoB4BTBRuJnjGsTLsmWcJnKOcaUe7WoUgUM=;
	b=lnr+rKWHrOgy4uh24RdR31PCHivYRc+7MuP919dzy6IJRVPqOJ0qiwRe0YjoIE79/LBkmI
	9YWaVP4quB7bDgqeZNLbxmTPCs2eQ+jKFD6xdo4d3qRTW3weH9C2fSGMGmInIAu48GSash
	dQ+oM6Ba3O+w+iI/nX/u2DfISJ5dMCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1705868835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i1c5Zrs0aoB4BTBRuJnjGsTLsmWcJnKOcaUe7WoUgUM=;
	b=Nlx6wHzH48wopBt4QmE7tDT5cLOpm3qCeD3fmNn7dK91kzfoRBkLL+6pEOEKbJvQceh4z7
	loJ2bPjQ9utqJwLcbxT8HIJNhBxkCmQ8EpgZQ3L4U/owUMR72X3sHOOjA23zXiisGk8lCq
	/NqTxreloivNwX/+SoRbUXhnLhQbGZ4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1705868835; a=rsa-sha256; cv=none;
	b=hSwtq7gXmck8xu3w9t9/gW8WYMn8M74xC3tWeeD2FmQtwue6f32EM0zC3SQcSfymjjUxN7
	DMKxA+iZFRau9VxcRkaX88qdncRCHHXAC5WKsXlKZWUUvv3Dc7XWmW9ZkNIpjBIAjNNWX0
	dq9+aQdo93WdJHrWXEtsuuT0IOyekEs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: register all endpoints before starting config select
Date: Sun, 21 Jan 2024 22:27:06 +0200
Message-ID: <447a1b2f472b1c0c83de357e1c8094eec73308f0.1705868192.git.pav@iki.fi>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register all BAP endpoints first, so that they all become visible in
DBus before we start calling SelectProperties() on them.

This allows sound servers to know ahead of time what capabilities the
device has, and plan the configuration.

For example, a sound server might select different configuration for
sink+source configurations as opposed to sink or source only, due to
bandwidth etc. concerns.
---
 profiles/audio/bap.c | 48 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 69e982832..8d44e48fe 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1285,7 +1285,7 @@ done:
 	queue_foreach(ep->data->bcast, bap_config, NULL);
 }
 
-static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							void *user_data)
 {
 	struct btd_service *service = user_data;
@@ -1294,8 +1294,35 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	DBG("lpac %p rpac %p", lpac, rpac);
 
 	ep = ep_register(service, lpac, rpac);
-	if (!ep) {
+	if (!ep)
 		error("Unable to register endpoint for pac %p", rpac);
+
+	return true;
+}
+
+static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+							void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data = btd_service_get_user_data(service);
+	struct match_ep match = { lpac, rpac };
+	struct queue *queue;
+	struct bap_ep *ep;
+
+	switch (bt_bap_pac_get_type(rpac)) {
+	case BT_BAP_SINK:
+		queue = data->snks;
+		break;
+	case BT_BAP_SOURCE:
+		queue = data->srcs;
+		break;
+	default:
+		return true;
+	}
+
+	ep = queue_find(queue, match_ep, &match);
+	if (!ep) {
+		error("Unable to find endpoint for pac %p", rpac);
 		return true;
 	}
 
@@ -1328,8 +1355,14 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 
 	DBG("bap %p", bap);
 
-	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_found, service);
-	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_found, service);
+	/* Register all ep before selecting, so that sound server
+	 * knows all.
+	 */
+	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_register, service);
+	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_register, service);
+
+	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_select, service);
+	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_select, service);
 }
 
 static bool match_setup_stream(const void *data, const void *user_data)
@@ -2044,8 +2077,11 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 
 	data = btd_service_get_user_data(service);
 
-	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_found, service);
-	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
+	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_register, service);
+	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_register, service);
+
+	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_select, service);
+	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_select, service);
 }
 
 static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
-- 
2.43.0

