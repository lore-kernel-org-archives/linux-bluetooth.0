Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/7] shared/gatt-client: Fix service discovery
Date: Thu, 19 Mar 2015 15:13:18 +0200
Message-Id: <1426770800-21649-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426770800-21649-1-git-send-email-luiz.dentz@gmail.com>
References: <1426770800-21649-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code should proceed to discover all descriptors before moving to
next service otherwise it may attempt to insert characteristics in the
wrong service which would probably fail.
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3e28c6e..729bd87 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -690,13 +690,13 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 			goto failed;
 	}
 
+next:
 	if (!discover_descs(op, &discovering))
 		goto failed;
 
 	if (discovering)
 		return;
 
-next:
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
-- 
2.1.0

