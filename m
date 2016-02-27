Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 27 Feb 2016 23:54:54 +0100
From: Maxime Chevallier <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: [PATCH] tools/btgatt-client: Fix register-notify prompt
Message-ID: <20160227225454.GA10246@vps217108.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added missing carriage return in register_notify_cb.
Changed a call to PRLOG to a simple printf to avoid
getting a extra prompt in cmd_register_notify.
---
 tools/btgatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 2153bec..b1bb538 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1112,7 +1112,7 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
 		return;
 	}
 
-	PRLOG("Registered notify handler!");
+	PRLOG("Registered notify handler!\n");
 }
 
 static void cmd_register_notify(struct client *cli, char *cmd_str)
@@ -1147,7 +1147,7 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	PRLOG("Registering notify handler with id: %u\n", id);
+	printf("Registering notify handler with id: %u\n", id);
 }
 
 static void unregister_notify_usage(void)
-- 
2.5.0

