Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/5] Remove unnecessary assignment from attrib_db_update()
Date: Wed, 16 Mar 2011 16:30:14 -0400
Message-Id: <1300307416-29909-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

attrib_db_update() uses g_try_realloc() only to expand/shrink space for
the variable "data" field. Therefore existing fields (like handle) are
guaranteed to remain unchanged.
---
 src/attrib-server.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 98b3fa3..e705310 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1249,7 +1249,6 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 		return -ENOMEM;
 
 	l->data = a;
-	a->handle = handle;
 	if (uuid != NULL)
 		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->len = len;
-- 
1.7.0.4

