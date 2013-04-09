Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] obexd: Add the possibility for drivers to force a service lookup
Date: Tue,  9 Apr 2013 13:54:07 +0200
Message-Id: <1365508448-13171-8-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This change adds a force_service_lookup flag to obc_drivers, that allows
drivers to force a service lookup when connecting.

The Bluetooth transport will not do a service lookup if the port number
to connect to is specified directly. Drivers like MAP, that require
information from the service record, would therefore not necessarily have
all data available that they need to function properly. Those drivers can
set the force_service_lookup flag to force querying the available service
records on the remote device.
---
 obexd/client/bluetooth.c | 5 ++++-
 obexd/client/driver.h    | 1 +
 obexd/client/session.c   | 5 +++--
 obexd/client/transport.h | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index 20b4164..ada3a31 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -51,6 +51,7 @@ struct bluetooth_session {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint16_t port;
+	gboolean force_service_lookup;
 	sdp_session_t *sdp;
 	sdp_record_t *sdp_record;
 	GIOChannel *io;
@@ -382,7 +383,7 @@ static int session_connect(struct bluetooth_session *session)
 
 	DBG("session %p", session);
 
-	if (session->port > 0) {
+	if (session->port > 0 && !session->force_service_lookup) {
 		session->io = transport_connect(&session->src, &session->dst,
 							session->port,
 							transport_callback,
@@ -399,6 +400,7 @@ static int session_connect(struct bluetooth_session *session)
 
 static guint bluetooth_connect(const char *source, const char *destination,
 				const char *service, uint16_t port,
+				gboolean force_service_lookup,
 				obc_transport_func func, void *user_data)
 {
 	struct bluetooth_session *session;
@@ -418,6 +420,7 @@ static guint bluetooth_connect(const char *source, const char *destination,
 	session->func = func;
 	session->port = port;
 	session->user_data = user_data;
+	session->force_service_lookup = force_service_lookup;
 
 	session->service = g_strdup(service);
 	str2ba(destination, &session->dst);
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
index 7f4a192..3cf3864 100644
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
1.8.2.1

