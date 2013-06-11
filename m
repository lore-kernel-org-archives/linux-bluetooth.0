Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC v1 1/9] adapter: fix setting of discoverable timeout
Date: Tue, 11 Jun 2013 01:03:23 +0100
Message-Id: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The mgmt_cp_set_discoverable struct was getting reset for no reason after
we set up the discoverable timeout value.
---
 src/adapter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1250966..af3e3ea 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1907,9 +1907,6 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		goto failed;
 	}
 
-	memset(&cp, 0, sizeof(cp));
-	cp.val = (enable == TRUE) ? 0x01 : 0x00;
-
 	DBG("sending %s command for index %u", mgmt_opstr(opcode),
 							adapter->dev_id);
 
-- 
1.8.1.4

