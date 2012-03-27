Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] event: Store Class of Device after connection
Date: Tue, 27 Mar 2012 09:06:14 -0400
Message-Id: <1332853574-26832-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Class of Device is usually sent on the EIR returned by the Device
Connected mgmt event. For hciops, the Class of Device is always NULL on
the connection complete event.

The stored Class of Device is used later for Class/Icon device
properties.
---
 src/event.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/event.c b/src/event.c
index 113a2b6..78d2757 100644
--- a/src/event.c
+++ b/src/event.c
@@ -455,6 +455,14 @@ void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
 
 	update_lastused(local, peer);
 
+	if (dev_class != NULL) {
+		uint32_t class = dev_class[0] | (dev_class[1] << 8) |
+							(dev_class[2] << 16);
+
+		if (class != 0)
+			write_remote_class(local, peer, class);
+	}
+
 	device_set_addr_type(device, type);
 
 	adapter_add_connection(adapter, device);
-- 
1.7.5.4

