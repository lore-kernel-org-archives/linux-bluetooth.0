Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] mgmt: Fix Set LE command complete
Date: Wed, 15 Aug 2012 18:13:59 -0300
Message-Id: <1345065240-9250-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Once we get a Set LE command complete event, we should update
current_settings from the controller_info. Otherwise, features
which depend on that, such as device discovery, will not work
properly.
---
 src/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index b3ae776..fbd2a6b 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1388,7 +1388,7 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 		DBG("set_ssp complete");
 		break;
 	case MGMT_OP_SET_LE:
-		DBG("set_le complete");
+		mgmt_new_settings(sk, index, ev->data, len);
 		break;
 	case MGMT_OP_ADD_UUID:
 		mgmt_add_uuid_complete(sk, index, ev->data, len);
-- 
1.7.11.4

