Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/7] Remove CCC for read by group
Date: Thu, 13 Oct 2011 11:43:19 -0300
Message-Id: <1318517004-17003-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read by group is used to discover all primary services. Client
Characteristic Configuration is not applied to service definition.
---
 src/attrib-server.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 9ba5f74..25fe8b3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -314,7 +314,6 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 	last_handle = end;
 	for (l = database, groups = NULL, cur = NULL; l; l = l->next) {
-		struct attribute *client_attr;
 
 		a = l->data;
 
@@ -344,10 +343,6 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 		status = att_check_reqs(channel, ATT_OP_READ_BY_GROUP_REQ,
 								a->read_reqs);
 
-		client_attr = client_cfg_attribute(channel, a, a->data, a->len);
-		if (client_attr)
-			a = client_attr;
-
 		if (status == 0x00 && a->read_cb)
 			status = a->read_cb(a, a->cb_user_data);
 
-- 
1.7.7

