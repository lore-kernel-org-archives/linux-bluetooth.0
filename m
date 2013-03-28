Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 12/16] attrib: Change command->opcode type from guint8
Date: Thu, 28 Mar 2013 11:39:16 -0400
Message-Id: <1364485160-22720-13-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change type of command->opcode, command->expected and event->expected
for a standard type.
---
 attrib/gattrib.c | 12 ++++++------
 attrib/gattrib.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 2cb8265..e7238a6 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -62,10 +62,10 @@ struct _GAttrib {
 
 struct command {
 	guint id;
-	guint8 opcode;
+	uint8_t opcode;
 	guint8 *pdu;
 	guint16 len;
-	guint8 expected;
+	uint8_t expected;
 	bool sent;
 	GAttribResultFunc func;
 	gpointer user_data;
@@ -74,14 +74,14 @@ struct command {
 
 struct event {
 	guint id;
-	guint8 expected;
+	uint8_t expected;
 	guint16 handle;
 	GAttribNotifyFunc func;
 	gpointer user_data;
 	GDestroyNotify notify;
 };
 
-static guint8 opcode2expected(guint8 opcode)
+static uint8_t opcode2expected(uint8_t opcode)
 {
 	switch (opcode) {
 	case ATT_OP_MTU_REQ:
@@ -124,7 +124,7 @@ static guint8 opcode2expected(guint8 opcode)
 	return 0;
 }
 
-static bool is_response(guint8 opcode)
+static bool is_response(uint8_t opcode)
 {
 	switch (opcode) {
 	case ATT_OP_ERROR:
@@ -672,7 +672,7 @@ bool g_attrib_set_mtu(GAttrib *attrib, int mtu)
 	return true;
 }
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
+guint g_attrib_register(GAttrib *attrib, uint8_t opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
 {
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 03f4911..2cf5b4d 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -61,7 +61,7 @@ bool g_attrib_cancel_all(GAttrib *attrib);
 bool g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
 							gpointer user_data);
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
+guint g_attrib_register(GAttrib *attrib, uint8_t opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify);
 
-- 
1.8.2

