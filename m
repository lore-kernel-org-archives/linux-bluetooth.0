Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Don't require prepare write authorization for trusted devices
Date: Tue, 29 May 2018 10:32:18 +0200
Message-Id: <20180529083218.32603-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180529083218.32603-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180529083218.32603-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds possibility to ommit prepare write authorization
request from trusted devices.
---
 src/gatt-database.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 22c78e840..99c8ea231 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2569,7 +2569,8 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
-		if (!desc->prep_authorized && desc->req_prep_authorization)
+		if (!device_is_trusted(device) && !desc->prep_authorized &&
+						desc->req_prep_authorization)
 			send_write(device, attrib, desc->proxy,
 					desc->pending_writes, id, value, len,
 					offset, bt_att_get_link_type(att),
@@ -2672,7 +2673,8 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		queue = NULL;
 
 	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
-		if (!chrc->prep_authorized && chrc->req_prep_authorization)
+		if (!device_is_trusted(device) && !chrc->prep_authorized &&
+						chrc->req_prep_authorization)
 			send_write(device, attrib, chrc->proxy, queue,
 					id, value, len, offset,
 					bt_att_get_link_type(att), true, true);
-- 
2.13.6

