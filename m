Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH BlueZ 2/4] AVRCP: Get media transport DBus connection
Date: Fri, 11 May 2012 16:32:56 +0530
Message-ID: <1336734176-16669-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Defines a function that will return DBus connection
for media transport
---
 audio/transport.c |    5 +++++
 audio/transport.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 audio/transport.c
 mode change 100644 => 100755 audio/transport.h

diff --git a/audio/transport.c b/audio/transport.c
old mode 100644
new mode 100755
index 7bf7309..6ea0748
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -1054,3 +1054,8 @@ struct audio_device *media_transport_get_dev(struct media_transport *transport)
 {
 	return transport->device;
 }
+
+DBusConnection *media_transport_get_conn(struct media_transport *transport)
+{
+	return transport->conn;
+}
diff --git a/audio/transport.h b/audio/transport.h
old mode 100644
new mode 100755
index 1f86cde..94dbb69
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -37,3 +37,4 @@ void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
+DBusConnection *media_transport_get_conn(struct media_transport *transport);
-- 
1.7.5.4

