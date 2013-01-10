Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] unit: Fix intermitent failure of SDP tests
Date: Wed,  9 Jan 2013 21:03:27 -0400
Message-Id: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While running tests, the D-Bus library was set to call _exit() when the
client leaves the bus. This caused the second test to be interrupted
without providing a PASS/FAIL result. This was confirmed by running
test-sdp with DBUS_VERBOSE=1.

This commit disables this behavior, which does not exist on BlueZ
because g_dbus_set_disconnect_function() implicitly does this.
---
 unit/test-gdbus-client.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 7c849f0..cfbe4e0 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -68,6 +68,10 @@ static struct context *create_context(void)
 		return NULL;
 	}
 
+	/* Make sure D-Bus library will not call _exit() and interrupt the next
+	 * tests. */
+	dbus_connection_set_exit_on_disconnect(context->dbus_conn, FALSE);
+
 	return context;
 }
 
-- 
1.7.9.5

