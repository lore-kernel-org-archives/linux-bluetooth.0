Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48F376BE1
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974108; cv=none; b=AFYmqv9f5bBNu5pRD6qUKFufBw8b1q1YTcUwqH50cWgSiwpYUPedvcb3ZsUBpzK9NB9yezEdtKESZ1q5spUOcrgS2nE8sTQCXAxK0f331ZgPZal6tLuhujyBuB9Glu3JVmmr9kN9cb4oTy9s36Z6lF2mo58mGJjYPDHR45axgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974108; c=relaxed/simple;
	bh=JJotgogY7xc2up7yUeFBAIuoE0BybgIdEwWCeQvzINw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCFFIF5bf7/2ZxCgS+d1I+LOpnbqK23QYxEcRXGxZ8tAMU5Ttrd9+5jcntRaqHmq7wMsiG4n3YY3LZOmUezJj/V4X6f2mhPA3eLuQAnAnLl+ZfVXKhRw0N0dyry1/vAye8ATzdoeV2NLSMiXG+m9HYKkKfR6Yph9k7zdIV0OEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=h9ygbnRS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="h9ygbnRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772974102; x=1773578902; i=martinbts@gmx.net;
	bh=jn68mZVLVQAdVBrSiDl1lsbH7EkHfqtft+WObZSDVnA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h9ygbnRSEyfaJh793AC32fUgde6vWrZLqblrzzr2JwLaNJNN/3oldnGQoSR9XAy1
	 BJqdAwWOrqBrPVY0D/Mv/2J+zRG/6gCIOtzPn2AsFjYyAj7USSBvD//32Ka+t6+U/
	 Df3tBg7sJqMXKQPgvpMrBWdUzUvsfJ/2+5+plu6F+17K9yLJJo+M2IF2AhCKvoqGC
	 kCFTMjkJQBKSFbxLM2wsy8GwvnYDl1B3uAqHg6EJre53naKR+zoNZNu6DUz9IVLbu
	 nTtN3CTecD85eqDhvEwtgIgxohLtlt8ygDbTH7jPIAIj+DEI7BVKnRX9CN7AhWy8u
	 gjar4u6f/E2eOWPbtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1vZ8IY3tL9-00ugnO; Sun, 08
 Mar 2026 13:48:22 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v2 1/6] shared/gatt: make secondary discovery optional
Date: Sun,  8 Mar 2026 13:47:38 +0100
Message-ID: <20260308124745.19248-2-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260308124745.19248-1-martinbts@gmx.net>
References: <20260308124745.19248-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gRggcDJJ80NwR6Yn3aUZ/6UPsYgin5DIAuJnOyMdXkY9++bKIMn
 s7lf/C5C/SBITzIHXgNPFhx5xwixJHilT7J4DT1sewg5WEuoRfJ5SYP/flea95YbT6dZNIT
 liMEJhNFrA6ykUvUB4ftOiyzsXwVWsn/+Q56O4L4naahLw4AhNNKFQBGmKl/7KJM3ZT2/bs
 QRJJn1canNPIUYYHDKcMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2h9LGhpCpew=;inOaf+jORfrn0W+Z9eZRPyGZSpD
 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

BREAKING CHANGE!

* Remove gatt_client_init from bt_gatt_client_new. Consumers must now
  call gatt_client_init themselves!
* Remove mtu paramter from bt_gatt_client_new
* Rename gatt_client_init to bt_gatt_client_init and make it public
* Introduce a new bt_gatt_client field "skip_secondary", default false
* Introduce public skip_secondary setter
* If true, skip_secondary makes discover_primary_cb goto done
  (instead of discoverying secondary services)
=2D--
 src/shared/gatt-client.c | 22 ++++++++++++++--------
 src/shared/gatt-client.h |  4 +++-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index df1541b88..7896ed329 100644
=2D-- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -93,6 +93,7 @@ struct bt_gatt_client {
 	struct queue *notify_chrcs;
 	int next_reg_id;
 	unsigned int disc_id, nfy_id, nfy_mult_id, ind_id;
+	bool skip_secondary;
=20
 	/*
 	 * Handles of the GATT Service and the Service Changed characteristic
@@ -1344,7 +1345,7 @@ secondary:
 	 * functionality of a device and is referenced from at least one
 	 * primary service on the device.
 	 */
-	if (queue_isempty(op->pending_svcs))
+	if (queue_isempty(op->pending_svcs) || client->skip_secondary)
 		goto done;
=20
 	/* Discover secondary services */
@@ -2106,7 +2107,7 @@ done:
 	notify_client_ready(client, success, att_ecode);
 }
=20
-static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
+bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 {
 	struct discovery_op *op;
=20
@@ -2549,7 +2550,6 @@ fail:
=20
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
-							uint16_t mtu,
 							uint8_t features)
 {
 	struct bt_gatt_client *client;
@@ -2561,11 +2561,6 @@ struct bt_gatt_client *bt_gatt_client_new(struct ga=
tt_db *db,
 	if (!client)
 		return NULL;
=20
-	if (!gatt_client_init(client, mtu)) {
-		bt_gatt_client_free(client);
-		return NULL;
-	}
-
 	return bt_gatt_client_ref(client);
 }
=20
@@ -2592,6 +2587,17 @@ struct bt_gatt_client *bt_gatt_client_clone(struct =
bt_gatt_client *client)
 	return bt_gatt_client_ref(clone);
 }
=20
+bool bt_gatt_client_set_skip_secondary(struct bt_gatt_client *client,
+								bool skip)
+{
+	if (!client)
+		return false;
+
+	client->skip_secondary =3D skip;
+
+	return true;
+}
+
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
 {
 	if (!client)
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 63cf99500..e510ad455 100644
=2D-- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -18,9 +18,11 @@ struct bt_gatt_client;
=20
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
-							uint16_t mtu,
 							uint8_t features);
 struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client=
);
+bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu);
+bool bt_gatt_client_set_skip_secondary(struct bt_gatt_client *client,
+								bool skip);
=20
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
 void bt_gatt_client_unref(struct bt_gatt_client *client);
=2D-=20
2.47.3

