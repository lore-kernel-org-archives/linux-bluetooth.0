Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] shared/gatt-client: Don't discovery secondaries if there is no primary
Date: Mon,  8 Jun 2015 16:35:45 +0300
Message-Id: <1433770545-14938-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1433770545-14938-1-git-send-email-luiz.dentz@gmail.com>
References: <1433770545-14938-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec state that a secondary needs to referenced by at least one
primary, Version 4.2 [Vol 1, Part A] page 101:

  'A secondary service is a service that provides auxiliary
  functionality of a device and is referenced from at least one
  primary service on the device.'
---
 src/shared/gatt-client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 724fc53..7e9d550 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1009,6 +1009,15 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	}
 
 secondary:
+	/*
+	 * Version 4.2 [Vol 1, Part A] page 101:
+	 * A secondary service is a service that provides auxiliary
+	 * functionality of a device and is referenced from at least one
+	 * primary service on the device.
+	 */
+	if (queue_isempty(op->pending_svcs))
+		goto done;
+
 	/* Discover secondary services */
 	client->discovery_req = bt_gatt_discover_secondary_services(client->att,
 						NULL, op->start, op->end,
-- 
2.1.0

