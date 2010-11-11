Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] g_string_free shell be used in IRMC
Date: Thu, 11 Nov 2010 22:46:19 +0200
Message-Id: <1289508380-8873-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_string_free instead of string_free shell be used in IRMC plugin.
string_free is a callback function specific to filesystem plugin
only and used by OBEX drivers to close an OBEX object.
---
 plugins/irmc.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 28c5e50..f7ad33b 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -254,10 +254,8 @@ static void irmc_disconnect(struct obex_session *os, void *user_data)
 		g_free(irmc->params);
 	}
 
-	if (irmc->buffer) {
-		string_free(irmc->buffer);
-		irmc->buffer = NULL;
-	}
+	if (irmc->buffer)
+		g_string_free(irmc->buffer, TRUE);
 
 	g_free(irmc);
 }
@@ -355,7 +353,7 @@ static void *irmc_open_pb(const char *name, struct irmc_session *irmc,
 		irmc->buffer = mybuf;
 	else {
 		irmc->buffer = g_string_append(irmc->buffer, mybuf->str);
-		string_free(mybuf);
+		g_string_free(mybuf, TRUE);
 	}
 
 	return irmc;
@@ -433,7 +431,7 @@ static int irmc_close(void *object)
 	DBG("");
 
 	if (irmc->buffer) {
-		string_free(irmc->buffer);
+		g_string_free(irmc->buffer, TRUE);
 		irmc->buffer = NULL;
 	}
 
-- 
1.7.0.4

