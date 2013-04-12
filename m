Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] obexd: Add bluetooth_getattribute to Bluetooth transport
Date: Fri, 12 Apr 2013 11:29:03 +0200
Message-Id: <1365758946-8682-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This function makes the cached SDP attributes available for the profile
implementations.
---
 obexd/client/bluetooth.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index a14b75b..63c8a25 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -467,11 +467,35 @@ static int bluetooth_getpacketopt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
 	return 0;
 }
 
+static const void *bluetooth_getattribute(guint id, int attribute_id)
+{
+	GSList *l;
+	sdp_data_t *data;
+
+	for (l = sessions; l; l = l->next) {
+		struct bluetooth_session *session = l->data;
+
+		if (session->id != id)
+			continue;
+
+		if (!session->sdp_record)
+			break;
+
+		data = sdp_data_get(session->sdp_record, attribute_id);
+		if (!data)
+			break;
+
+		return &data->val;
+	}
+	return NULL;
+}
+
 static struct obc_transport bluetooth = {
 	.name = "Bluetooth",
 	.connect = bluetooth_connect,
 	.getpacketopt = bluetooth_getpacketopt,
 	.disconnect = bluetooth_disconnect,
+	.getattribute = bluetooth_getattribute,
 };
 
 int bluetooth_init(void)
-- 
1.8.2.1

