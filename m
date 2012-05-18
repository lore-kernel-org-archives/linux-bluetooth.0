Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH obexd 1/9] gdbus: remove extra const after constification
Date: Fri, 18 May 2012 15:32:00 -0300
Message-Id: <1337365928-18953-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 88afd66..2ddc574 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -496,7 +496,7 @@ done:
 	g_free(parent_path);
 }
 
-static const const GDBusMethodTable introspect_methods[] = {
+static const GDBusMethodTable introspect_methods[] = {
 	{ _GDBUS_METHOD("Introspect", "", "s", NULL,
 			GDBUS_ARGS({ "xml", "s" }), introspect) },
 	{ }
-- 
1.7.10.2

