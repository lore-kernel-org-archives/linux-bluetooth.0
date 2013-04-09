Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] obexd: Add get_bluetooth_service_record to Bluetooth transport
Date: Tue,  9 Apr 2013 13:54:03 +0200
Message-Id: <1365508448-13171-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This function makes the cached SDP record available for the profile
implementations.
---
 obexd/client/bluetooth.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index be06ec7..20b4164 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -479,11 +479,25 @@ static int bluetooth_getpacketopt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
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
-- 
1.8.2.1

