Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove unnecessary assignment
Date: Tue, 12 Jul 2011 14:11:58 -0300
Message-Id: <1310490718-16776-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

D-Bus connection is set by the callers of the discover primary service
function on both situations: create device without bonding or after
bonding complete.
---
 src/device.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2c0eec3..21b3d8d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1781,9 +1781,6 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 		return -EIO;
 	}
 
-	if (conn == NULL)
-		conn = get_dbus_connection();
-
 	req->conn = dbus_connection_ref(conn);
 	device->browse = req;
 
-- 
1.7.6

