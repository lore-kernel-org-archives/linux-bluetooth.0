Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 2/2] media: register disconnect watch at transport add
Date: Tue, 21 Feb 2012 17:46:50 +0100
Message-Id: <1329842810-13449-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

disconnect watch is not removed when the media owner is freed if
an error occurs while resuming in acquire (id == 0).
---
 audio/transport.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index b319e0e..7bf7309 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -599,6 +599,9 @@ static void media_transport_add(struct media_transport *transport,
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 	transport->owners = g_slist_append(transport->owners, owner);
 	owner->transport = transport;
+	owner->watch = g_dbus_add_disconnect_watch(transport->conn, owner->name,
+							media_owner_exit,
+							owner, NULL);
 }
 
 static struct media_owner *media_owner_create(DBusConnection *conn,
@@ -610,9 +613,6 @@ static struct media_owner *media_owner_create(DBusConnection *conn,
 	owner = g_new0(struct media_owner, 1);
 	owner->name = g_strdup(dbus_message_get_sender(msg));
 	owner->accesstype = g_strdup(accesstype);
-	owner->watch = g_dbus_add_disconnect_watch(conn, owner->name,
-							media_owner_exit,
-							owner, NULL);
 
 	DBG("Owner created: sender=%s accesstype=%s", owner->name,
 			accesstype);
-- 
1.7.5.4

