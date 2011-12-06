Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 4/4] mpris-player: Fix D-Bus reply memory leaks
Date: Tue, 06 Dec 2011 20:29:18 +0530
Message-id: <1323183558-26574-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1323183558-26574-1-git-send-email-s.syam@samsung.com>
References: <1323183558-26574-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/mpris-player.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/test/mpris-player.c b/test/mpris-player.c
index a1632f3..a2c4cc6 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -700,6 +700,7 @@ static char *get_default_adapter(DBusConnection *conn)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
@@ -756,6 +757,7 @@ static char *get_adapter(DBusConnection *conn, const char *adapter)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
@@ -802,8 +804,10 @@ static char *get_name_owner(DBusConnection *conn, const char *name)
 
 	if (!dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_STRING, &owner,
-					DBUS_TYPE_INVALID))
+					DBUS_TYPE_INVALID)) {
+		dbus_message_unref(reply);
 		return NULL;
+	}
 
 	owner = g_strdup(owner);
 
-- 
1.7.4.1

