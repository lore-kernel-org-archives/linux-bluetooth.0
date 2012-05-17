Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v6 01/15] gdbus: return if method signature is malformed
Date: Thu, 17 May 2012 15:19:58 -0300
Message-Id: <1337278812-4837-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 8bc12f5..7a94156 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -107,6 +107,10 @@ static void print_arguments(GString *gstr, const char *sig,
 				break;
 		}
 
+		if (!complete) {
+			error("Unexpected signature: %s", sig);
+			return;
+		}
 
 		if (direction)
 			g_string_append_printf(gstr,
-- 
1.7.10.2

