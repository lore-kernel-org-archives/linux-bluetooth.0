Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] device: Remove unused variable
Date: Thu,  9 Feb 2012 12:41:38 -0300
Message-Id: <1328802098-26789-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802098-26789-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802098-26789-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index ac2a93c..3f4ac76 100644
--- a/src/device.c
+++ b/src/device.c
@@ -83,7 +83,6 @@ struct btd_disconnect_data {
 struct bonding_req {
 	DBusConnection *conn;
 	DBusMessage *msg;
-	GIOChannel *io;
 	guint listener_id;
 	struct btd_device *device;
 };
@@ -2217,9 +2216,6 @@ static void bonding_request_free(struct bonding_req *bonding)
 	if (bonding->conn)
 		dbus_connection_unref(bonding->conn);
 
-	if (bonding->io)
-		g_io_channel_unref(bonding->io);
-
 	device = bonding->device;
 	g_free(bonding);
 
-- 
1.7.8.4

