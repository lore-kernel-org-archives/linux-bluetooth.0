Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] health: Fix not setting error
Date: Tue, 17 Jun 2014 16:53:01 +0300
Message-Id: <1403013181-8793-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When error is not set err->message may be accessed from the other code
resulting in NULL dereference.
---
 android/mcap-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/mcap-lib.c b/android/mcap-lib.c
index b04eaac..e0e1258 100644
--- a/android/mcap-lib.c
+++ b/android/mcap-lib.c
@@ -1932,6 +1932,8 @@ gboolean mcap_create_mcl(struct mcap_instance *mi,
 		}
 		mcap_mcl_unref(con->mcl);
 		g_free(con);
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"MCP connect failed");
 		return FALSE;
 	}
 
-- 
1.8.3.2

