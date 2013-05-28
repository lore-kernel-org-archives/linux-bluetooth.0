Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/6] obex: add obex_getsockname()
Date: Tue, 28 May 2013 14:45:20 -0300
Message-Id: <1369763123-17949-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
References: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Allow obex users to get the source device address.
---
 obexd/src/obex.c | 10 ++++++++++
 obexd/src/obex.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index a3e7b0e..7a1d612 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -1226,6 +1226,16 @@ int obex_getpeername(struct obex_session *os, char **name)
 	return transport->getpeername(os->io, name);
 }
 
+int obex_getsockname(struct obex_session *os, char **name)
+{
+	struct obex_transport_driver *transport = os->server->transport;
+
+	if (transport == NULL || transport->getsockname == NULL)
+		return -ENOTSUP;
+
+	return transport->getsockname(os->io, name);
+}
+
 int memncmp0(const void *a, size_t na, const void *b, size_t nb)
 {
 	if (na != nb)
diff --git a/obexd/src/obex.h b/obexd/src/obex.h
index 443a748..fc16747 100644
--- a/obexd/src/obex.h
+++ b/obexd/src/obex.h
@@ -46,6 +46,7 @@ ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer);
 ssize_t obex_get_non_header_data(struct obex_session *os,
 							const uint8_t **data);
 int obex_getpeername(struct obex_session *os, char **name);
+int obex_getsockname(struct obex_session *os, char **name);
 
 /* Just a thin wrapper around memcmp to deal with NULL values */
 int memncmp0(const void *a, size_t na, const void *b, size_t nb);
-- 
1.8.1.4

