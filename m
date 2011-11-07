Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 3/7] Remove CCC for read by type
Date: Mon,  7 Nov 2011 10:59:48 -0300
Message-Id: <1320674388-22637-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517004-17003-4-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517004-17003-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read by type is never used to iterate through attributes related to
Client Characteristic Configuration or any other descriptor.
---
 src/attrib-server.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index a996884..b2e218c 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -415,7 +415,6 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
 	for (l = database, length = 0, types = NULL; l; l = l->next) {
-		struct attribute *client_attr;
 
 		a = l->data;
 
@@ -431,10 +430,6 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 		status = att_check_reqs(channel, ATT_OP_READ_BY_TYPE_REQ,
 								a->read_reqs);
 
-		client_attr = client_cfg_attribute(channel, a, a->data, a->len);
-		if (client_attr)
-			a = client_attr;
-
 		if (status == 0x00 && a->read_cb)
 			status = a->read_cb(a, a->cb_user_data);
 
-- 
1.7.7.2

