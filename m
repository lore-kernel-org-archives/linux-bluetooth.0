Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DA189906
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418362; cv=pass; b=D1TRdugDL+g+bEF/qwFVAkzJT9llJ/wYReFmwwXEUyhoO8TU5jpc9ypCAM8Zy0hxE9zIZTCB88hAz+f4yoJmzPXZrsYTFt57beU8wqpxWx+ffKno0wocarct5c6UfxzvxcV2CqGNtsuS4YtfJz2RW083Ho+2udYPEhJgo8rmB7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418362; c=relaxed/simple;
	bh=P+5PeKN8tH0/0ix0HjNgMp+3/me2+70+DoKe7K1JtV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7+z6Gi+nMUCrnYwmNwFLwSD2o4p+seL+qKtjh+YHhReRJUOdI1e/BqYq6MmwQlQbi6J/LSvUSsrovnC9NQZz2CfqJ6m2yBqmbFBEA3/BDpWp1H0NoaA0DanXtN2r9DIjkh7cXEQjxsU5qTLbKjhTTuyq6zKIy11RP7t2u0vFEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RzYW6fhK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RzYW6fhK"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDc2ycHz49Q4w;
	Mon,  9 Jun 2025 00:32:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9rqxJKGNEqTO8iTOKbbdtNkY5ka0mH+mr87AXnXX9o=;
	b=RzYW6fhKIB/IzUe9MEN6oOH5V58JS1qqren3GRuQTBw3k/W6eJIugN8vbLQVha9S32bmlr
	Ltz74MMMrF+ZnUDOjDraf+SDxWKhYJK2JEWR/YMwa/Ea76vt7ejLLie6xXyrxTK8sZTeCQ
	DCf5jBeaBusucFNTx4BkZmKBsj4J1lfhBn4T39jU1O3oS32UFl9Nmo13lPS2Gje4yB0si/
	WJpDjwKAUh5azhWQZsl5fJU4MvlHhkntBReWXE3oW7Z5FgGngu6IXzwxfzDXcvWPc0orOx
	7apoX0quqY30YdN/jWBQVq2REfx51wxTZTGLOY7wBTcSN+zdftmMgYHLLy11tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9rqxJKGNEqTO8iTOKbbdtNkY5ka0mH+mr87AXnXX9o=;
	b=NaSvAQaDT7H1ETDwE8O6V8MJnmILyXMGXd8ut/XBQsUDU8q4XZ3JRPY5AnUDh0DK2Sxl2p
	n4d27YDodpTzIhdqQ+HJOWxfJBSBW5MRJms0xmXnqFWmXksAU408kbfcwEfyvFiUEskOL5
	cSTWYhJ4tWdRGlEwi5d/cFQ+bhiNBQvHILzqe97rhjsK4Y9pGqbmjCcQGycPhk6KM14Jq2
	WegSCDZ42EuUaBNTpBGQETOz4JBE3KtP7LLqRY59ueZt/NIHoe1qB2Di7eASOWDTIHQyuT
	S2qEHt/dQKM5wypcL04xKYdtNSf+bRNnIck77G+UiN1SBu/Cpx1ntn7+lCMDFg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418352; a=rsa-sha256;
	cv=none;
	b=hulg+pT9Ds1AD+PoDulmXA6kkHqGYViuwm9hCTMr1xukVZ8eEeV4rq/G+7vDL6jMjp/p36
	58++sIrbs47EB0UA8IjO9WJDymhIB5JC71c5BKZ5mwKUNwIs/l8kN8lT1Kn9Ud1N1cqgfc
	U2lGDAA1Bap5m6XJ94Ays64rHaqgkCB/obYlygUxTbU6x8h0tatDLj7HSPnXjaPXTd8asR
	CI+nUhUfAIvv2LrcOE12/3SqH5lDkqXobtUQ4GLzDIwhS/h6xEqQznyfTGTcjmDhw62oif
	n1+z1C1G3YV66XXdVSv1J0X4UTfg6civepbybtHlVu6L9WGlJ+jR5ksTa9V8eg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 01/10] bap: do not try QoS before links are updated & io created
Date: Mon,  9 Jun 2025 00:32:13 +0300
Message-ID: <2256956d28dcf399854f542e03ed35e265a5c860.1749418319.git.pav@iki.fi>
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

In setup config, QoS must be done after corresponding bap_state
callback, because stream links are updated only at that point.  If the
ASE was in CONFIG state before reconfiguration, this gets done in wrong
order.

Track explicitly that bap_state() is done after bt_bap_stream_config(),
before proceeding to QoS.
---
 profiles/audio/bap.c | 82 ++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee7c8bc49..b420354cd 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -75,6 +75,7 @@ struct bap_setup {
 	bool recreate;
 	bool cig_active;
 	uint8_t sid;
+	bool config_pending;
 	struct iovec *caps;
 	struct iovec *metadata;
 	unsigned int id;
@@ -720,6 +721,46 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 	setup->msg = NULL;
 }
 
+static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
+				struct bt_bap_stream *stream, int defer);
+
+static int setup_qos(struct bap_setup *setup)
+{
+	struct bap_data *data = setup->ep->data;
+	struct bt_bap_stream *stream = setup->stream;
+
+	if (!stream)
+		return -EINVAL;
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_CONFIG)
+		goto error;
+	if (setup->id)
+		goto error;
+
+	setup_create_io(data, setup, stream, true);
+	if (!setup->io) {
+		error("Unable to create io");
+		goto error;
+	}
+
+	/* Wait QoS response to respond */
+	setup->id = bt_bap_stream_qos(stream, &setup->qos, qos_cb, setup);
+	if (!setup->id) {
+		error("Failed to Configure QoS");
+		goto error;
+	}
+
+	/* Bcast does not call the callback */
+	if (bt_bap_stream_get_type(setup->stream) == BT_BAP_STREAM_TYPE_BCAST)
+		setup->id = 0;
+
+	return 0;
+
+error:
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_RELEASING)
+		bt_bap_stream_release(stream, NULL, NULL);
+	return -EIO;
+}
+
 static void config_cb(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
@@ -732,17 +773,8 @@ static void config_cb(struct bt_bap_stream *stream,
 	setup->id = 0;
 
 	if (!code) {
-		/* Check state is already set to config then proceed to qos */
-		if (bt_bap_stream_get_state(stream) ==
-					BT_BAP_STREAM_STATE_CONFIG) {
-			setup->id = bt_bap_stream_qos(stream, &setup->qos,
-							qos_cb, setup);
-			if (!setup->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream, NULL, NULL);
-			}
-		}
-
+		if (!setup->config_pending)
+			setup_qos(setup);
 		return;
 	}
 
@@ -984,6 +1016,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
+	setup->config_pending = true;
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 						setup->caps, config_cb, setup);
 	if (!setup->id) {
@@ -1003,6 +1036,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
 		setup->id = 0;
+		setup->config_pending = false;
 
 		if (ep->data->service)
 			service_set_connecting(ep->data->service);
@@ -1401,6 +1435,7 @@ static void setup_config(void *data, void *user_data)
 						ep->rpac, &setup->qos,
 						setup->caps);
 
+	setup->config_pending = true;
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 						setup->caps, config_cb, setup);
 	if (!setup->id) {
@@ -1805,9 +1840,6 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 	return queue_find(sessions, cig_busy_session, &info);
 }
 
-static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
-				struct bt_bap_stream *stream, int defer);
-
 static gboolean setup_io_recreate(void *user_data)
 {
 	struct bap_setup *setup = user_data;
@@ -2187,25 +2219,9 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->server_streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
-			if (!setup->io) {
-				error("Unable to create io");
-				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
-					bt_bap_stream_release(stream, NULL,
-								NULL);
-				return;
-			}
-
-			/* Wait QoS response to respond */
-			setup->id = bt_bap_stream_qos(stream,
-							&setup->qos,
-							qos_cb,	setup);
-			if (!setup->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream,
-							NULL, NULL);
-			}
+		if (setup) {
+			setup->config_pending = false;
+			setup_qos(setup);
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-- 
2.49.0

