Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v6 02/15] gdbus: do not call memset for terminating NUL
Date: Thu, 17 May 2012 15:19:59 -0300
Message-Id: <1337278812-4837-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 7a94156..e378074 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -72,7 +72,6 @@ static void print_arguments(GString *gstr, const char *sig,
 
 		complete = FALSE;
 		struct_level = dict_level = 0;
-		memset(type, 0, sizeof(type));
 
 		/* Gather enough data to have a single complete type */
 		for (len = 0; len < (sizeof(type) - 1) && sig[i]; len++, i++) {
@@ -107,6 +106,8 @@ static void print_arguments(GString *gstr, const char *sig,
 				break;
 		}
 
+		type[len + 1] = '\0';
+
 		if (!complete) {
 			error("Unexpected signature: %s", sig);
 			return;
-- 
1.7.10.2

