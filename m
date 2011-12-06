Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 3/4] agent: Fix D-Bus reply memory leaks
Date: Tue, 06 Dec 2011 20:29:17 +0530
Message-id: <1323183558-26574-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1323183558-26574-1-git-send-email-s.syam@samsung.com>
References: <1323183558-26574-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/agent.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index ae74074..5cdeeb4 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -504,6 +504,7 @@ static char *get_default_adapter_path(DBusConnection *conn)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
@@ -562,6 +563,7 @@ static char *get_adapter_path(DBusConnection *conn, const char *adapter)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
-- 
1.7.4.1

