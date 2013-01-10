Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ] unit: Avoid D-Bus calling _exit() during SDP tests
Date: Thu, 10 Jan 2013 08:30:30 -0400
Message-Id: <1357821030-11412-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While running tests, the D-Bus library was set to call _exit() when the
client leaves the bus. This caused the second test to be interrupted
without providing a PASS/FAIL result. This was confirmed by running
test-sdp with DBUS_VERBOSE=1.

This commit disables this behavior, which does not exist on BlueZ
because g_dbus_set_disconnect_function() implicitly does this.
---
 unit/test-gdbus-client.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index aaf8342..34c714e 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -78,6 +78,9 @@ static struct context *create_context(void)
 		return NULL;
 	}
 
+	/* Avoid D-Bus library calling _exit() before next test finishes. */
+	dbus_connection_set_exit_on_disconnect(context->dbus_conn, FALSE);
+
 	return context;
 }
 
-- 
1.7.9.5

