Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Petri Gynther <pgynther@google.com>
Subject: [PATCH 2/2] shared/gatt-client: Fix discover_secondary_cb()
Date: Thu,  1 Dec 2016 12:16:02 -0800
Message-Id: <1480623362-49499-2-git-send-email-pgynther@google.com>
In-Reply-To: <1480623362-49499-1-git-send-email-pgynther@google.com>
References: <1480623362-49499-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If included services discovery cannot be started, the services discovery
operation has failed.
---
 src/shared/gatt-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 84145e7..dc98aaa 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1027,6 +1027,7 @@ next:
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start included services discovery");
 	discovery_op_unref(op);
+	success = false;
 
 done:
 	discovery_op_complete(op, success, att_ecode);
-- 
2.8.0.rc3.226.g39d4020

