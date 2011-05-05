Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Fix set but not used variable in attrib code
Date: Thu,  5 May 2011 17:33:56 -0300
Message-Id: <1304627636-22358-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 360218b..095b157 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -71,13 +71,11 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 {
 	bt_uuid_t prim;
 	guint16 plen;
-	uint8_t op;
 
 	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
 
 	if (uuid == NULL) {
 		/* Discover all primary services */
-		op = ATT_OP_READ_BY_GROUP_REQ;
 		plen = enc_read_by_grp_req(start, end, &prim, pdu, len);
 	} else {
 		uint16_t u16;
@@ -86,8 +84,6 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 		int vlen;
 
 		/* Discover primary service by service UUID */
-		op = ATT_OP_FIND_BY_TYPE_REQ;
-
 		if (uuid->type == BT_UUID16) {
 			u16 = htobs(uuid->value.u16);
 			value = &u16;
-- 
1.7.5.rc3

