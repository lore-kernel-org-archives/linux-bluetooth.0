Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] Fix not showing name if first EIR has no name info
Date: Tue, 17 Jan 2012 12:18:02 -0400
Message-Id: <1326817082-6787-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some devices may not advertise their name right on the first EIR data
sent (e.g. LE devices where name is set on either advertises or scan
responses, but not both). Given that the "found devices" cache does not
refresh the name on each EIR received, the UI may never show the name
during a discovery session.

This fix improves the Discovery UI by showing names immediately as they
are received. This works by emitting DeviceFound signals when the name
is received, even if RSSI stays the same.

Further discovery sessions will use the stored complete name, as usual.
---
 src/adapter.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7e4bbb6..2984d80 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2806,6 +2806,15 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	if (dev) {
 		adapter->oor_devices = g_slist_remove(adapter->oor_devices,
 							dev);
+
+		/* If an existing device had no name but the newly received EIR
+		 * data has (complete or not), we want to present it to the
+		 * user. */
+		if (dev->name == NULL && eir_data.name != NULL) {
+			dev->name = g_strdup(eir_data.name);
+			goto done;
+		}
+
 		if (dev->rssi != rssi)
 			goto done;
 
-- 
1.7.0.4

