Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] adapter: Fix not removing a device when the adapter is down
Date: Fri, 25 Jan 2013 11:30:59 -0300
Message-Id: <1359124259-31316-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is a documented error that MGMT_UNPAIR_DEVICE should return an error
if the controller is not powered.

This error is being ignored, and if the user asks for a device to be removed
while the controller is powered down, the keys associated with that device
will still be in the kernel side.

The solution is to return the user an error when it is asked to remove a
device and the controller is not powered.
---
 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index beb50cd..3f39d82 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2097,6 +2097,9 @@ static DBusMessage *remove_device(DBusConnection *conn,
 	if (!list)
 		return btd_error_does_not_exist(msg);
 
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
 	device = list->data;
 
 	device_set_temporary(device, TRUE);
-- 
1.8.1.1

