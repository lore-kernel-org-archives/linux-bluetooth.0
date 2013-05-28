Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/6] transport: add getsockname to transport driver
Date: Tue, 28 May 2013 14:45:18 -0300
Message-Id: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Enable other pieces of obex to get the source Bluetooth address.
---
 obexd/src/transport.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/src/transport.h b/obexd/src/transport.h
index b81615b..97e10d0 100644
--- a/obexd/src/transport.h
+++ b/obexd/src/transport.h
@@ -26,6 +26,7 @@ struct obex_transport_driver {
 	uint16_t service;
 	void *(*start) (struct obex_server *server, int *err);
 	int (*getpeername) (GIOChannel *io, char **name);
+	int (*getsockname) (GIOChannel *io, char **name);
 	void (*stop) (void *data);
 };
 
-- 
1.8.1.4

