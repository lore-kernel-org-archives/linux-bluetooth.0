Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/5] Return a D-Bus error if device_browse fails
Date: Wed, 24 Nov 2010 00:30:45 -0200
Message-Id: <1290565847-17382-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If Discover All Primary Services or SDP search fails, the CreateDevice
caller will not receive a response. Error reproducible when a Discover
All Primary Services is sent over a LE link and the kernel doesn't
address properly the connections in the channel ID 4.
---
 src/adapter.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 029bec8..6c3396c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1696,6 +1696,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 	struct remote_dev_info *dev, match;
 	const gchar *address;
 	gboolean le;
+	int err;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -1722,7 +1723,9 @@ static DBusMessage *create_device(DBusConnection *conn,
 	if (!device)
 		return NULL;
 
-	device_browse(device, conn, msg, NULL, FALSE);
+	err = device_browse(device, conn, msg, NULL, FALSE);
+	if (err < 0)
+		return failed_strerror(msg, -err);
 
 	return NULL;
 }
-- 
1.7.3.2

