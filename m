Return-Path: <cyrus@holtmann.org>
From: Jacob Siverskog <jacob@teenageengineering.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jacob Siverskog <jacob@teenageengineering.com>
Subject: [PATCH] core: Add ControllerMode to list of supported options
Date: Tue, 21 Oct 2014 09:48:58 +0200
Message-Id: <1413877738-23941-1-git-send-email-jacob@teenageengineering.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jacob Siverskog <jacob@teenageengineering.com>

Prevent warning message 'Unknown key ControllerMode in main.conf'.
---
 src/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/main.c b/src/main.c
index 191dc11..061060d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -79,6 +79,7 @@ static const char * const supported_options[] = {
 	"ReverseServiceDiscovery",
 	"NameResolving",
 	"DebugKeys",
+	"ControllerMode",
 };
 
 GKeyFile *btd_get_main_conf(void)
-- 
1.8.3.2

