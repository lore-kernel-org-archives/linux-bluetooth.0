Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Change attrib server to use ATT CID & PSM defined in att.h
Date: Wed, 27 Apr 2011 10:07:40 -0300
Message-Id: <1303909660-30690-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 7ee496e..c55167f 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -47,9 +47,6 @@
 
 #include "attrib-server.h"
 
-#define GATT_PSM 0x1f
-#define GATT_CID 4
-
 static GSList *database = NULL;
 
 struct gatt_channel {
@@ -97,7 +94,7 @@ static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t en
 	uuid_t root_uuid, proto_uuid, l2cap;
 	sdp_record_t *record;
 	sdp_data_t *psm, *sh, *eh;
-	uint16_t lp = GATT_PSM;
+	uint16_t lp = ATT_PSM;
 
 	if (uuid == NULL)
 		return NULL;
@@ -949,7 +946,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	if (channel->mtu > ATT_MAX_MTU)
 		channel->mtu = ATT_MAX_MTU;
 
-	if (cid != GATT_CID)
+	if (cid != ATT_CID)
 		channel->le = FALSE;
 	else
 		channel->le = TRUE;
@@ -1089,7 +1086,7 @@ int attrib_server_init(void)
 	l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
 					NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
-					BT_IO_OPT_PSM, GATT_PSM,
+					BT_IO_OPT_PSM, ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
 	if (l2cap_io == NULL) {
@@ -1108,7 +1105,7 @@ int attrib_server_init(void)
 	le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
 					&le_io, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
-					BT_IO_OPT_CID, GATT_CID,
+					BT_IO_OPT_CID, ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
 	if (le_io == NULL) {
-- 
1.7.5.rc1

