Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 40/62] Replace att_put_uuid16() by put_le16()
Date: Thu, 20 Mar 2014 11:43:05 -0300
Message-Id: <1395326607-27068-41-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/attrib/att.c b/attrib/att.c
index e28be25..c408568 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -34,6 +34,7 @@
 
 #include <glib.h>
 
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "att.h"
 
@@ -267,7 +268,7 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 	pdu[0] = ATT_OP_FIND_BY_TYPE_REQ;
 	att_put_u16(start, &pdu[1]);
 	att_put_u16(end, &pdu[3]);
-	att_put_uuid16(*uuid, &pdu[5]);
+	put_le16(uuid->value.u16, &pdu[5]);
 
 	if (vlen > 0) {
 		memcpy(&pdu[7], value, vlen);
-- 
1.8.3.1

