Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68C1DEFD6
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374544; cv=pass; b=rurNZVjPJcVWS5F59P0hNb9nxAMIugMHA4S2x+CoEspnhzVaxZtKszNh2XoMyuP6wFWiztq7ZrsXNNUmRL9V17BSVL0oUqg8EHYkhIFlCtlMXPDCXkV31jQEqcGKGlUIer5AOUmIlgEb0Y6SDmcPAXj5vwxMUxs8KJTipc4wDIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374544; c=relaxed/simple;
	bh=ORsc7z4iaM78BNUqt32yk6J23LhXcoE5vyfgd8rM2f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBxfJGDZ/M7QEfZYNb1cfZS7WG2Zv40sxU5QxQC7OIqCYaZNkueP9gIfJdCO4uLpU+7smXuUVB4ciBWvcEuNNs3rQIsIg3FhUBlIasjOM43mXFeuMnRr0BdT8k/0XNCc04/cKb/p1XNufpbdieMlSEghzEStA4vOXSa2NP3PCc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=CIpwhXof; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="CIpwhXof"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8Yf21Wczyjb;
	Sun,  4 May 2025 19:02:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/K/c98BkTGAf5Tn7q5pM4PcRGNxc1xhLqLZmL4BSeU=;
	b=CIpwhXofuIay/fLNs7OnOS805f/lqILTWyMW4RJH3x/8ErMeoW5e94+TzO4MPlSd4OkC0P
	Fflt4eGiED2gFdu/YY0YS8XDc0XzLdD/LtXPIXR9Ssykuq4eHhTECn6mXQD38vnavPfatP
	Y7YGVNDOotYFjnmcNIdJpzmmigm5gZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/K/c98BkTGAf5Tn7q5pM4PcRGNxc1xhLqLZmL4BSeU=;
	b=n+ZcAlK+LNWMsu+vLkiRIIJ8YSwCOGJHy5f6Lh4kjkR7yr0MlljnBMaOXoNMzOhwX9+gyI
	vjSc6PzxO2xJurdgakHA5+UEDvG0kOAcz1atKGeivlnrnTIpuFVvAd0X7/WvUBzYAdXO2b
	3HiawdBWHiZCwO69yzNbfXFthzJTbPY=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374534; a=rsa-sha256; cv=none;
	b=qHKRCeHXSfqWRqxk06rYnyqezzlDj6RLOZ8CXq+bT/9XZ1/7ACCfjVuCCNrEsfXvPUYq7P
	pQNty8nQ0XWsvFskm5EfXvG8dCmrXtfRdwbiZ12fjl2PAA8O3qPaP95RmnWK33ha6MPAJ+
	6HeKRjzCpSge9WYN5sKdZ3az1SWg09Y=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 08/11] bap: support removing streams with ClearConfiguration()
Date: Sun,  4 May 2025 19:02:00 +0300
Message-ID: <d0362faa8d8a9b494a6c71e726f2efb22fb15aa4.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement removing streams via ClearConfiguration().
---
 profiles/audio/bap.c       | 154 +++++++++++++++++++++++++++++++++++--
 profiles/audio/transport.c |  17 ++++
 profiles/audio/transport.h |   1 +
 3 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 64dee8f9d..c9755ad96 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -57,6 +57,8 @@
 #include "src/log.h"
 #include "src/error.h"
 
+#include "transport.h"
+
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
 #define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
@@ -67,6 +69,7 @@ struct bap_setup;
 
 typedef void (*bap_setup_ready_func_t)(struct bap_setup *setup, int code,
 						uint8_t reason, void *data);
+typedef void (*bap_setup_close_func_t)(struct bap_setup *setup, void *data);
 
 struct bap_setup {
 	struct bap_ep *ep;
@@ -81,12 +84,15 @@ struct bap_setup {
 	bool cig_active;
 	uint8_t sid;
 	bool config_pending;
+	bool closing;
 	struct iovec *caps;
 	struct iovec *metadata;
 	unsigned int id;
 	struct iovec *base;
 	bap_setup_ready_func_t ready_cb;
 	void *ready_cb_data;
+	bap_setup_close_func_t close_cb;
+	void *close_cb_data;
 	void (*destroy)(struct bap_setup *setup);
 };
 
@@ -741,6 +747,8 @@ static int setup_qos(struct bap_setup *setup)
 
 	if (!stream)
 		return -EINVAL;
+	if (setup->closing)
+		return -EINVAL;
 	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_CONFIG)
 		goto error;
 	if (setup->id)
@@ -817,12 +825,87 @@ static void setup_io_close(void *data, void *user_data)
 	bt_bap_stream_io_connecting(setup->stream, -1);
 }
 
-static void ep_close(struct bap_ep *ep)
+static int setup_close(struct bap_setup *setup, bap_setup_close_func_t cb,
+								void *user_data)
 {
-	if (!ep)
+	if (setup->closing)
+		return -EBUSY;
+
+	DBG("%p", setup);
+
+	setup->close_cb = cb;
+	setup->close_cb_data = user_data;
+	setup->closing = true;
+
+	if (!setup->stream) {
+		setup_free(setup);
+		return 0;
+	}
+
+	bt_bap_stream_discard(setup->stream);
+	return 0;
+}
+
+struct ep_close_data {
+	int remaining;
+	int count;
+	const char *path;
+	void (*cb)(int count, void *user_data);
+	void *user_data;
+};
+
+static void ep_close_setup_cb(struct bap_setup *setup, void *user_data)
+{
+	struct ep_close_data *epdata = user_data;
+
+	epdata->remaining--;
+
+	DBG("closed setup %p remain %d", setup, epdata->remaining);
+
+	if (epdata->remaining)
 		return;
 
-	queue_foreach(ep->setups, setup_io_close, NULL);
+	if (epdata->cb)
+		epdata->cb(epdata->count, epdata->user_data);
+
+	free(epdata);
+}
+
+static void ep_close_setup(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct ep_close_data *epdata = user_data;
+	struct bt_bap_stream *stream = setup->stream;
+	const char *path = media_transport_stream_path(stream);
+
+	if (epdata->path && (!path || strcmp(epdata->path, path)))
+		return;
+
+	epdata->remaining++;
+	if (setup_close(setup, ep_close_setup_cb, epdata))
+		epdata->remaining--;
+	else
+		epdata->count++;
+}
+
+static void ep_close(struct bap_ep *ep, const char *transport_path,
+			void (*cb)(int count, void *user_data), void *user_data)
+{
+	struct ep_close_data *epdata;
+
+	DBG("close ep %p path %s", ep, transport_path ? transport_path : "-");
+
+	epdata = new0(struct ep_close_data, 1);
+	epdata->cb = cb;
+	epdata->path = transport_path;
+	epdata->user_data = user_data;
+	epdata->remaining = 1;
+
+	if (ep)
+		queue_foreach(ep->setups, ep_close_setup, epdata);
+
+	epdata->path = NULL;
+	ep_close_setup_cb(NULL, epdata);
 }
 
 static struct bap_setup *setup_new(struct bap_ep *ep)
@@ -872,6 +955,9 @@ static void setup_free(void *data)
 
 	setup_ready(setup, -ECANCELED, 0);
 
+	if (setup->closing && setup->close_cb)
+		setup->close_cb(setup, setup->close_cb_data);
+
 	if (setup->stream && setup->id) {
 		bt_bap_stream_cancel(setup->stream, setup->id);
 		setup->id = 0;
@@ -1022,7 +1108,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	 * TO DO reconfiguration of a BIS.
 	 */
 	if (bt_bap_pac_get_type(ep->lpac) != BT_BAP_BCAST_SOURCE)
-		ep_close(ep);
+		ep_close(ep, NULL, NULL, NULL);
 
 	setup = setup_new(ep);
 
@@ -1062,6 +1148,51 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+struct clear_configuration_data {
+	DBusMessage *msg;
+	bool all;
+};
+
+static void clear_configuration_cb(int count, void *user_data)
+{
+	struct clear_configuration_data *data = user_data;
+	DBusMessage *reply;
+
+	DBG("%p", data);
+
+	if (!data->all && count == 0)
+		reply = btd_error_invalid_args(data->msg);
+	else
+		reply = dbus_message_new_method_return(data->msg);
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(data->msg);
+	free(data);
+}
+
+static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct bap_ep *ep = data;
+	const char *path;
+	struct clear_configuration_data *cbdata;
+	DBusMessageIter args;
+
+	dbus_message_iter_init(msg, &args);
+	dbus_message_iter_get_basic(&args, &path);
+
+	if (strcmp(path, ep->path) == 0)
+		path = NULL;
+
+	cbdata = new0(struct clear_configuration_data, 1);
+	cbdata->msg = dbus_message_ref(msg);
+	cbdata->all = (path == NULL);
+
+	DBG("%p %s %s", cbdata, ep->path, path ? path : "NULL");
+	ep_close(ep, path, clear_configuration_cb, cbdata);
+	return NULL;
+}
+
 static bool stream_io_unset(const void *data, const void *user_data)
 {
 	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
@@ -1234,6 +1365,9 @@ static const GDBusMethodTable ep_methods[] = {
 					GDBUS_ARGS({ "endpoint", "o" },
 						{ "Configuration", "a{sv}" } ),
 					NULL, set_configuration) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ClearConfiguration",
+					GDBUS_ARGS({ "transport", "o" }),
+					NULL, clear_configuration) },
 	{ },
 };
 
@@ -1244,10 +1378,9 @@ static void ep_free(void *data)
 	struct bap_ep *ep = data;
 	struct queue *setups = ep->setups;
 
-	ep_cancel_select(ep);
-
 	ep->setups = NULL;
 	queue_destroy(setups, setup_free);
+	ep_cancel_select(ep);
 	free(ep->path);
 	free(ep);
 }
@@ -1441,6 +1574,8 @@ static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 
 	if (setup->ready_cb)
 		return -EBUSY;
+	if (setup->closing)
+		return -EINVAL;
 
 	setup->ready_cb = cb;
 	setup->ready_cb_data = user_data;
@@ -2249,6 +2384,13 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 
 	setup = bap_find_setup_by_stream(data, stream);
 
+	if (setup && setup->closing) {
+		if (old_state == BT_BAP_STREAM_STATE_RELEASING) {
+			setup_free(setup);
+			return;
+		}
+	}
+
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_IDLE:
 		/* Release stream if idle */
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 3d1f55b70..b399d0f35 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2670,3 +2670,20 @@ void media_transport_update_device_volume(struct btd_device *dev,
 
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
2.49.0

