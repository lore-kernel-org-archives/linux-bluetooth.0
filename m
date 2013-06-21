Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] client: Add description for default-agent command
Date: Fri, 21 Jun 2013 11:17:34 -0300
Message-Id: <1371824255-3071-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 client/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index b0a66d8..ff2afc6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1057,7 +1057,8 @@ static const struct {
 	{ "agent",        "<on/off/capability>", cmd_agent,
 				"Enable/disable agent with given capability",
 							capability_generator},
-	{ "default-agent",NULL,       cmd_default_agent },
+	{ "default-agent",NULL,       cmd_default_agent,
+				"Set agent as the default one" },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices" },
 	{ "info",         "<dev>",    cmd_info, "Device information",
 							dev_generator },
-- 
1.8.3.1

