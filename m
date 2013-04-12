Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] obexd: Add getattribute to obc_transport
Date: Fri, 12 Apr 2013 11:29:02 +0200
Message-Id: <1365758946-8682-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds a getattribute function pointer to obc_transport, which allows
transports to provide the session specific service attributes.
---
 obexd/client/transport.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/transport.h b/obexd/client/transport.h
index 5140840..b035cfc 100644
--- a/obexd/client/transport.h
+++ b/obexd/client/transport.h
@@ -31,6 +31,7 @@ struct obc_transport {
 				obc_transport_func func, void *user_data);
 	int (*getpacketopt) (GIOChannel *io, int *tx_mtu, int *rx_mtu);
 	void (*disconnect) (guint id);
+	const void *(*getattribute) (guint id, int attribute_id);
 };
 
 int obc_transport_register(struct obc_transport *transport);
-- 
1.8.2.1

