Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] gatttool: Add Write Without Response option
Date: Wed,  9 Mar 2011 16:03:51 -0300
Message-Id: <1299697431-7670-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1299697431-7670-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1299697431-7670-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sub-procedure used to write a Characteristic Value to a server when
the client knows the Characteristic Value Handle and the client does
not need acknowledgement.
---
 attrib/interactive.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 5fc0af5..d92caa8 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -530,7 +530,7 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	printf("Characteristic value was written successfully\n");
 }
 
-static void cmd_char_write_req(int argcp, char **argvp)
+static void cmd_char_write(int argcp, char **argvp)
 {
 	uint8_t *value;
 	size_t plen;
@@ -542,7 +542,7 @@ static void cmd_char_write_req(int argcp, char **argvp)
 	}
 
 	if (argcp < 3) {
-		printf("Usage: char-write-req <handle> <new value>\n");
+		printf("Usage: %s <handle> <new value>\n", argvp[0]);
 		return;
 	}
 
@@ -558,7 +558,11 @@ static void cmd_char_write_req(int argcp, char **argvp)
 		return;
 	}
 
-	gatt_write_char(attrib, handle, value, plen, char_write_req_cb, NULL);
+	if (g_strcmp0("char-write-req", argvp[0]) == 0)
+		gatt_write_char(attrib, handle, value, plen,
+					char_write_req_cb, NULL);
+	else
+		gatt_write_char(attrib, handle, value, plen, NULL, NULL);
 
 	g_free(value);
 }
@@ -629,8 +633,10 @@ static struct {
 		"Characteristics Value/Descriptor Read by handle" },
 	{ "char-read-uuid",	cmd_read_uuid,	"<UUID> [start hnd] [end hnd]",
 		"Characteristics Value/Descriptor Read by UUID" },
-	{ "char-write-req",	cmd_char_write_req,	"<handle> <new value>",
+	{ "char-write-req",	cmd_char_write,	"<handle> <new value>",
 		"Characteristic Value Write (Write Request)" },
+	{ "char-write-cmd",	cmd_char_write,	"<handle> <new value>",
+		"Characteristic Value Write (No response)" },
 	{ "sec-level",		cmd_sec_level,	"[low | medium | high]",
 		"Set security level. Default: low" },
 	{ NULL, NULL, NULL}
-- 
1.7.4.1

