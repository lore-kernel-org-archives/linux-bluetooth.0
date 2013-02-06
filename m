Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/8] obexd: Add get_service_record to obc_transport
Date: Wed,  6 Feb 2013 15:45:15 +0100
Message-Id: <1360161922-6585-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds a get_service_record function pointer to obc_transport,
which allows transports to provide the session specific service record.
This record can be queried using obc_session_get_service_record.
---
 obexd/client/session.c   | 6 ++++++
 obexd/client/session.h   | 2 ++
 obexd/client/transport.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index db37a86..32f58c3 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -827,6 +827,12 @@ fail:
 	return NULL;
 }
 
+const void *obc_session_get_service_record(struct obc_session *session)
+{
+	if (session->id > 0 && session->transport != NULL)
+		return session->transport->get_service_record(session->id);
+}
+
 const char *obc_session_get_owner(struct obc_session *session)
 {
 	if (session == NULL)
diff --git a/obexd/client/session.h b/obexd/client/session.h
index 402c042..8a3d629 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -54,6 +54,8 @@ const char *obc_session_get_target(struct obc_session *session);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
 
+const void *obc_session_get_service_record(struct obc_session *session);
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
diff --git a/obexd/client/transport.h b/obexd/client/transport.h
index 5140840..eb29bf3 100644
--- a/obexd/client/transport.h
+++ b/obexd/client/transport.h
@@ -31,6 +31,7 @@ struct obc_transport {
 				obc_transport_func func, void *user_data);
 	int (*getpacketopt) (GIOChannel *io, int *tx_mtu, int *rx_mtu);
 	void (*disconnect) (guint id);
+	const void *(*get_service_record)(guint id);
 };
 
 int obc_transport_register(struct obc_transport *transport);
-- 
1.8.1.2

