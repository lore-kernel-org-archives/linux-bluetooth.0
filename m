Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/8] obexd: Provide SDP record in get_service_record
Date: Wed,  6 Feb 2013 15:45:16 +0100
Message-Id: <1360161922-6585-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This caches the SDP record of the active session in the bluetooth transport
and makes the data available for clients in get_service_record.
The cached SDP record can be retreived using obc_session_get_service_record.

To have the SDP record also available when directly connecting by port,
the profile implementation has to specify force_service_lookup in its
obc_driver struct.

Profiles like MAP specify additional SDP attributes that are of interest
for the profile implementation.
---
 obexd/client/bluetooth.c | 51 +++++++++++++++++++++++++++++++++++++++++-------
 obexd/client/driver.h    |  1 +
 obexd/client/session.c   |  5 +++--
 obexd/client/transport.h |  1 +
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index a832a3f..07c2228 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -51,7 +51,9 @@ struct bluetooth_session {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint16_t port;
+	gboolean force_service_lookup;
 	sdp_session_t *sdp;
+	sdp_record_t *sdp_record;
 	GIOChannel *io;
 	char *service;
 	obc_transport_func func;
@@ -82,6 +84,9 @@ static void session_destroy(struct bluetooth_session *session)
 	if (session->sdp)
 		sdp_close(session->sdp);
 
+	if (session->sdp_record)
+		sdp_record_free(session->sdp_record);
+
 	g_free(session->service);
 	g_free(session);
 }
@@ -160,7 +165,7 @@ static void search_callback(uint8_t type, uint16_t status,
 		sdp_record_t *rec;
 		sdp_list_t *protos;
 		sdp_data_t *data;
-		int recsize, ch = -1;
+		int recsize, ch = -1, psm = -1;
 
 		recsize = 0;
 		rec = sdp_extract_pdu(rsp, bytesleft, &recsize);
@@ -183,15 +188,31 @@ static void search_callback(uint8_t type, uint16_t status,
 		data = sdp_data_get(rec, 0x0200);
 		/* PSM must be odd and lsb of upper byte must be 0 */
 		if (data != NULL && (data->val.uint16 & 0x0101) == 0x0001)
-			ch = data->val.uint16;
-
-		sdp_record_free(rec);
+			psm = data->val.uint16;
+
+		/* Preferably connect using L2CAP directly instead of RFCOMM.
+		 * If the session has already a port specified, use that to
+		 * connect. */
+		if (session->port == 0) {
+			if (psm > 0)
+				port = psm;
+			else if (ch > 0)
+				port = ch;
+		} else if (session->port > 0 &&
+				(session->port == ch || session->port == psm)) {
+			port = session->port;
+		}
 
-		if (ch > 0) {
-			port = ch;
+		/* Cache the sdp record associated with the service that we
+		 * attempt to connect. This allows reading it's application
+		 * specific parameters with get_service_record. */
+		if (port > 0) {
+			session->sdp_record = rec;
 			break;
 		}
 
+		sdp_record_free(rec);
+
 		scanned += recsize;
 		rsp += recsize;
 		bytesleft -= recsize;
@@ -362,7 +383,7 @@ static int session_connect(struct bluetooth_session *session)
 
 	DBG("session %p", session);
 
-	if (session->port > 0) {
+	if (session->port > 0 && !session->force_service_lookup) {
 		session->io = transport_connect(&session->src, &session->dst,
 							session->port,
 							transport_callback,
@@ -379,6 +400,7 @@ static int session_connect(struct bluetooth_session *session)
 
 static guint bluetooth_connect(const char *source, const char *destination,
 				const char *service, uint16_t port,
+				gboolean force_service_lookup,
 				obc_transport_func func, void *user_data)
 {
 	struct bluetooth_session *session;
@@ -398,6 +420,7 @@ static guint bluetooth_connect(const char *source, const char *destination,
 	session->func = func;
 	session->port = port;
 	session->user_data = user_data;
+	session->force_service_lookup = force_service_lookup;
 
 	session->service = g_strdup(service);
 	str2ba(destination, &session->dst);
@@ -459,11 +482,25 @@ static int bluetooth_getpacketopt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
 	return 0;
 }
 
+static const void *get_bluetooth_service_record(guint id)
+{
+	GSList *l;
+
+	for (l = sessions; l; l = l->next) {
+		struct bluetooth_session *session = l->data;
+
+		if (session->id == id)
+			return session->sdp_record;
+	}
+	return NULL;
+}
+
 static struct obc_transport bluetooth = {
 	.name = "Bluetooth",
 	.connect = bluetooth_connect,
 	.getpacketopt = bluetooth_getpacketopt,
 	.disconnect = bluetooth_disconnect,
+	.get_service_record = get_bluetooth_service_record,
 };
 
 int bluetooth_init(void)
diff --git a/obexd/client/driver.h b/obexd/client/driver.h
index f1c0646..08ea09b 100644
--- a/obexd/client/driver.h
+++ b/obexd/client/driver.h
@@ -26,6 +26,7 @@ struct obc_driver {
 	const char *uuid;
 	void *target;
 	gsize target_len;
+	gboolean force_service_lookup;
 	int (*probe) (struct obc_session *session);
 	void (*remove) (struct obc_session *session);
 };
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 32f58c3..dbbbc8e 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -407,8 +407,9 @@ static int session_connect(struct obc_session *session,
 	}
 
 	session->id = transport->connect(session->source, session->destination,
-					driver->uuid, session->channel,
-					transport_func, callback);
+						driver->uuid, session->channel,
+						driver->force_service_lookup,
+						transport_func, callback);
 	if (session->id == 0) {
 		obc_session_unref(callback->session);
 		g_free(callback);
diff --git a/obexd/client/transport.h b/obexd/client/transport.h
index eb29bf3..b131c50 100644
--- a/obexd/client/transport.h
+++ b/obexd/client/transport.h
@@ -28,6 +28,7 @@ struct obc_transport {
 	const char *name;
 	guint (*connect) (const char *source, const char *destination,
 				const char *service, uint16_t port,
+				gboolean force_service_lookup,
 				obc_transport_func func, void *user_data);
 	int (*getpacketopt) (GIOChannel *io, int *tx_mtu, int *rx_mtu);
 	void (*disconnect) (guint id);
-- 
1.8.1.2

