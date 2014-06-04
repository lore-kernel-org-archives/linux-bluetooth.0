Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] core: Fix cleaning pending services when ACL connection failed
Date: Wed, 4 Jun 2014 17:14:44 +0200
Message-ID: <1401894885-7444-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case ACL connection failed to establish, all pending services shall
be always removed. At the moment it's only done in case there's pending
Connect message which does not take into account reconnect scenario,
i.e. service connection was triggered by reconnection timeout and there
is no pending message.

In such case, when reconnection failed there will be some services on
pending list and subsequent reconnect attempts will fail with EBUSY
immediately.
---
 src/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8222610..a9b644b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1220,6 +1220,9 @@ static void device_profile_connected(struct btd_device *dev,
 		return;
 
 done:
+	g_slist_free(dev->pending);
+	dev->pending = NULL;
+
 	if (!dev->connect)
 		return;
 
@@ -1241,9 +1244,6 @@ done:
 		g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
 	}
 
-	g_slist_free(dev->pending);
-	dev->pending = NULL;
-
 	dbus_message_unref(dev->connect);
 	dev->connect = NULL;
 }
-- 
1.9.3

