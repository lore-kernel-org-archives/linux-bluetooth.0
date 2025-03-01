Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D51E51F2
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844680; cv=pass; b=njkJOxUnmP7hE2qDGp7QUWI5UDMjYRkNF5go3LUa4f59PpJjmX9DlmVwj+Nmb4PSbmyLbZCYLbVy3Mz6m/wgw98xAAZjeY8Y847RKe6ADuLAX0sJJtTuw4qjAhh6b3TMkyTR2wze3TwOPesK5/pweZXVuPrudbJtos4z3EymkJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844680; c=relaxed/simple;
	bh=R1uajWOdVZM/GSJq0D17DD+g2Pz/nKy3XLpFoajFEc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stK2svwK0cse3uJPlb8SpnPlc0YsucfnVqHcaRzaRy3sWmn0M4chhhngazs1FVeerffAzC3lsEpADMnoF3hekmXGDwowXTfGNldmSV2rGcEDcB6HvGFJ3hfhYs4gw4kQSlOyqEVv8fRuX9tf8sdP7oEmBn5hfm3uq4w35WkJs6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=IWsOE10O; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IWsOE10O"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV66rmzz4BKHR;
	Sat,  1 Mar 2025 17:57:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYqibg+YY66EQe/1Ffp2wAtCIp4QaM0Yk4Frj1UsDQc=;
	b=IWsOE10OsL3QE7fuR/yrXSH5WyXFV7OCqV56//E7o2OnKEFWUfAL+cJLp97xufJ55Bi01h
	FfJnyEKfAhUYDOZBeyN7sVJ0Cg1b4CdnpXDY/m0HOfgJq3T3nkbjBWHgZKh2HfNQfTL5bn
	Fc1Ij7y1bdhDJWI6R9OrCBVqDDbANbZrqYxFcCoIwRlUER+YikeVVp3bt3K0p6uMC2JgD9
	ES/iD5SnXeC57j3oklrRkpE7MOZQPK6t0WRK0AzugwmYtBIfxGQQwDiy2z05+yOY+9ajFW
	PSNwv6JWKVxnLesF/ckzzhtjktUHb1R5vUTA8y4PjwEcUSrdFSbrDJq/TuSrvg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844671; a=rsa-sha256;
	cv=none;
	b=tLw8HUDpDwNzegYtpYiLMuSe02Abk+zFCH2vZ11KC5yFnYNeusgHOB1WQ8/7YybvzvdoSh
	u8NclwxVV11IDIi1Rx/UvyhAaRujNKbQRa8rWCXlhTgH1tlSkiaM/gbVsjDKaNkbPkdshy
	8QormxDA6bsE2YwsdJnAKv0/WxULRLplAgrHD+EtFTPkMUtuc2nF25q7+UbMy86UukJ45N
	Jwcqu4AXdO7PfYaOJfFo0114TApvVBMcswBTzF1gFq8sjVnopAPhEokTaIUltzTtA8gJ6Q
	qEXtb/7Hk1tdZH8JC6IestEz1RJ7TvHJBTETL7muzMWUud8UMQ1/aNQGIrKhNg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYqibg+YY66EQe/1Ffp2wAtCIp4QaM0Yk4Frj1UsDQc=;
	b=ON/tg9xWf0hPI23MXHBLH2nj0xrWqxhrAfYtHdEQ9ycg2qrQm9ZllJbComRrc+6MP5U1oY
	ge3yU9HvE3cqLmcPY+ko/zMyXXLiDFLNZ+KJYSCXN++NYFzvIYwH/DZ2lq8yc89QuVTMOr
	uLjhjDueYY4GTtwLWDcGjzH69PRf9FrkwhjttKEPfbQj04YcX1XF21xlMF1rvnID9csFmS
	2GAetM2n1nhvssw7p5liCRUMbVQF59o55pMulhkaDQ5UdTtDK9HwM1+wjJDanT0f16md2b
	gAqonzQQevaPPD7tgyJqGrZPDMIM7dPY7EQXx73wZLN0UEKH9SOf/Z0gZeK10Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 7/9] bap: support removing streams with ClearConfiguration()
Date: Sat,  1 Mar 2025 17:57:38 +0200
Message-ID: <1fba5476695ae5ff96f3d80d6f2cf19367cb4d70.1740844617.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement removing streams via ClearConfiguration().
---
 profiles/audio/bap.c       | 87 ++++++++++++++++++++++++++++++++++++--
 profiles/audio/transport.c | 17 ++++++++
 profiles/audio/transport.h |  1 +
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 39484c74a..46512a7f3 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -58,6 +58,7 @@
 
 #include "bap.h"
 #include "bass.h"
+#include "transport.h"
 
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
@@ -81,6 +82,7 @@ struct bap_setup {
 	unsigned int id;
 	struct iovec *base;
 	struct future *qos_done;
+	struct future *close_done;
 	void (*destroy)(struct bap_setup *setup);
 };
 
@@ -903,12 +905,30 @@ static void setup_io_close(void *data, void *user_data)
 	bt_bap_stream_io_connecting(setup->stream, -1);
 }
 
-static void ep_close(struct bap_ep *ep)
+static void setup_close(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct future *close_done = user_data;
+	struct bt_bap_stream *stream = setup->stream;
+
+	DBG("%p", setup);
+
+	future_init_chain(&setup->close_done, close_done);
+
+	setup_io_close(setup, NULL);
+
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_RELEASING)
+		bt_bap_stream_release(stream, NULL, NULL);
+	else
+		setup_free(setup);
+}
+
+static void ep_close(struct bap_ep *ep, struct future *close_done)
 {
 	if (!ep)
 		return;
 
-	queue_foreach(ep->setups, setup_io_close, NULL);
+	queue_foreach(ep->setups, setup_close, close_done);
 }
 
 static struct bap_setup *setup_new(struct bap_ep *ep)
@@ -962,6 +982,7 @@ static void setup_free(void *data)
 	}
 
 	future_clear(&setup->qos_done, ECANCELED, NULL);
+	future_clear(&setup->close_done, 0, NULL);
 
 	if (setup->ep)
 		queue_remove(setup->ep->setups, setup);
@@ -1077,7 +1098,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	 * TO DO reconfiguration of a BIS.
 	 */
 	if (bt_bap_pac_get_type(ep->lpac) != BT_BAP_BCAST_SOURCE)
-		ep_close(ep);
+		ep_close(ep, NULL);
 
 	setup = setup_new(ep);
 
@@ -1129,6 +1150,63 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+struct close_stream_data {
+	const char *path;
+	struct future *close_done;
+	unsigned int count;
+};
+
+static void close_stream(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct close_stream_data *info = user_data;
+	struct bt_bap_stream *stream = setup->stream;
+	const char *path = media_transport_stream_path(stream);
+
+	if (info->path && (!path || strcmp(info->path, path)))
+		return;
+
+	setup_close(setup, info->close_done);
+	info->count++;
+}
+
+static unsigned int ep_close_stream(struct bap_ep *ep,
+						struct future *close_done,
+						const char *transport_path)
+{
+	struct close_stream_data info = { transport_path, close_done, 0 };
+
+	queue_foreach(ep->setups, close_stream, &info);
+	return info.count;
+}
+
+
+static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct bap_ep *ep = data;
+	const char *path;
+	DBusMessageIter args;
+	struct future *done = NULL;
+
+	dbus_message_iter_init(msg, &args);
+	dbus_message_iter_get_basic(&args, &path);
+
+	DBG("%s: %s", ep->path, path ? path : "NULL");
+
+	future_init_dbus_reply(&done, "clear_configuration", msg);
+
+	if (strcmp(path, ep->path) == 0)
+		path = NULL;
+
+	if (ep_close_stream(ep, done, path))
+		future_clear(&done, 0, NULL);
+	else
+		future_clear(&done, path ? EINVAL : 0, NULL);
+
+	return NULL;
+}
+
 static bool stream_io_unset(const void *data, const void *user_data)
 {
 	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
@@ -1350,6 +1428,9 @@ static const GDBusMethodTable ep_methods[] = {
 					GDBUS_ARGS({ "endpoint", "o" },
 						{ "Configuration", "a{sv}" } ),
 					NULL, set_configuration) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ClearConfiguration",
+					GDBUS_ARGS({ "transport", "o" }),
+					NULL, clear_configuration) },
 	{ },
 };
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f3ac1a251..e81ef6e9a 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2671,3 +2671,20 @@ void media_transport_update_device_volume(struct btd_device *dev,
 
 	btd_device_set_volume(dev, volume);
 }
+
+const char *media_transport_stream_path(void *stream)
+{
+	GSList *l;
+
+	if (!stream)
+		return NULL;
+
+	for (l = transports; l; l = l->next) {
+		struct media_transport *transport = l->data;
+
+		if (media_transport_get_stream(transport) == stream)
+			return transport->path;
+	}
+
+	return NULL;
+}
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 808e1a193..7c107281a 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -33,3 +33,4 @@ void transport_get_properties(struct media_transport *transport,
 int media_transport_get_device_volume(struct btd_device *dev);
 void media_transport_update_device_volume(struct btd_device *dev,
 								int volume);
+const char *media_transport_stream_path(void *stream);
-- 
2.48.1

