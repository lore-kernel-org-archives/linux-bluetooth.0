Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] unit/test-gdbus-client: Fix hanging if D-Bus fails to launch
Date: Wed, 22 Apr 2015 10:39:57 +0200
Message-Id: <1429691997-6469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case D-Bus fails to launch make the test fails so it does not hang
other tests.
---
 unit/test-gdbus-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 5a4b974..7e16d16 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -72,6 +72,7 @@ static struct context *create_context(void)
 		}
 
 		g_free(context);
+		tester_test_failed();
 		return NULL;
 	}
 
-- 
2.1.0

