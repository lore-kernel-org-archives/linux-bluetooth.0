Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v2 08/13] gatttool: Show connection state using color
Date: Tue,  2 Apr 2013 19:31:25 -0400
Message-Id: <1364945490-17059-9-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When device is connected, the Bluetooth address is shown in blue color.
---
 attrib/interactive.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index ecb8b7d..5ffe2fb 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -79,15 +79,15 @@ static char *get_prompt(void)
 	}
 
 	if (conn_state == STATE_CONNECTED)
-		g_string_assign(prompt, "[CON]");
-	else
-		g_string_assign(prompt, "[   ]");
+		g_string_append(prompt, COLOR_BLUE);
 
 	if (opt_dst)
 		g_string_append_printf(prompt, "[%17s]", opt_dst);
 	else
 		g_string_append_printf(prompt, "[%17s]", "");
 
+	g_string_append(prompt, COLOR_OFF);
+
 	if (opt_psm)
 		g_string_append(prompt, "[BR]");
 	else
-- 
1.7.9.5

