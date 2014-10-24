Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 7/7] attrib: fix GATTRIB_ALL_REQS behavior
Date: Fri, 24 Oct 2014 13:36:23 -0700
Message-Id: <1414182983-23959-8-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
References: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_attrib_register(..., GATTRIB_ALL_REQS, ...) behavior would previously
include indications, this fixes it to only include requests and
commands.
---
 attrib/gattrib.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index a65d1ca..f678435 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -147,6 +147,27 @@ static bool is_response(guint8 opcode)
 	return false;
 }
 
+static bool is_request(guint8 opcode)
+{
+	switch (opcode) {
+	case ATT_OP_MTU_REQ:
+	case ATT_OP_FIND_INFO_REQ:
+	case ATT_OP_FIND_BY_TYPE_REQ:
+	case ATT_OP_READ_BY_TYPE_REQ:
+	case ATT_OP_READ_REQ:
+	case ATT_OP_READ_BLOB_REQ:
+	case ATT_OP_READ_MULTI_REQ:
+	case ATT_OP_READ_BY_GROUP_REQ:
+	case ATT_OP_WRITE_REQ:
+	case ATT_OP_WRITE_CMD:
+	case ATT_OP_PREP_WRITE_REQ:
+	case ATT_OP_EXEC_WRITE_REQ:
+		return true;
+	}
+
+	return false;
+}
+
 GAttrib *g_attrib_ref(GAttrib *attrib)
 {
 	int refs;
@@ -373,7 +394,7 @@ static bool match_event(struct event *evt, const uint8_t *pdu, gsize len)
 	if (evt->expected == GATTRIB_ALL_EVENTS)
 		return true;
 
-	if (!is_response(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
+	if (is_request(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
 		return true;
 
 	if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
-- 
2.1.0.rc2.206.gedb03e5

