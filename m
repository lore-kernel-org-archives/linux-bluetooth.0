Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 04/16] attrib: Change is_response return type from gboolean
Date: Thu, 28 Mar 2013 11:39:08 -0400
Message-Id: <1364485160-22720-5-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to use gboolean as return type of is_response.
---
 attrib/gattrib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index bd8e380..9470457 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -124,7 +124,7 @@ static guint8 opcode2expected(guint8 opcode)
 	return 0;
 }
 
-static gboolean is_response(guint8 opcode)
+static bool is_response(guint8 opcode)
 {
 	switch (opcode) {
 	case ATT_OP_ERROR:
@@ -140,10 +140,10 @@ static gboolean is_response(guint8 opcode)
 	case ATT_OP_PREP_WRITE_RESP:
 	case ATT_OP_EXEC_WRITE_RESP:
 	case ATT_OP_HANDLE_CNF:
-		return TRUE;
+		return true;
 	}
 
-	return FALSE;
+	return false;
 }
 
 GAttrib *g_attrib_ref(GAttrib *attrib)
-- 
1.8.2

