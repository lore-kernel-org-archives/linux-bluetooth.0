Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 2/2] Remove CCC if the device is not bonded
Date: Mon,  7 Nov 2011 11:09:18 -0300
Message-Id: <1320674958-23076-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517589-17372-3-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517589-17372-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes attrib server to remove CCC entries of the device when the
connection is established if the device is not bonded.
---
 src/attrib-server.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index b84b01d..b767b72 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -38,10 +38,14 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "log.h"
+#include "gdbus.h"
 #include "glib-compat.h"
 #include "btio.h"
 #include "sdpd.h"
 #include "hcid.h"
+#include "adapter.h"
+#include "device.h"
+#include "manager.h"
 #include "att.h"
 #include "gattrib.h"
 #include "storage.h"
@@ -834,9 +838,12 @@ done:
 
 guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 {
+	struct btd_adapter *adapter;
+	struct btd_device *device;
 	struct gatt_channel *channel;
 	GIOChannel *io;
 	GError *gerr = NULL;
+	char addr[18];
 	uint16_t cid;
 
 	io = g_attrib_get_channel(attrib);
@@ -856,6 +863,14 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 		return 0;
 	}
 
+	adapter = manager_find_adapter(&channel->src);
+
+	ba2str(&channel->dst, addr);
+	device = adapter_find_device(adapter, addr);
+
+	if (device_is_bonded(device) == FALSE)
+		delete_device_ccc(&channel->src, &channel->dst);
+
 	if (channel->mtu > ATT_MAX_MTU)
 		channel->mtu = ATT_MAX_MTU;
 
-- 
1.7.7.2

