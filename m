Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] hciconfig: Clarify what oobdata command do
Date: Fri, 28 Sep 2012 13:58:53 +0200
Message-ID: <1348833533-25427-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

oobdata command results in reading new local OOB data and invalidates
previously read data. Current command description is misleading.

---
 tools/hciconfig.8 |    2 +-
 tools/hciconfig.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hciconfig.8 b/tools/hciconfig.8
index 35956c4..6397427 100644
--- a/tools/hciconfig.8
+++ b/tools/hciconfig.8
@@ -223,7 +223,7 @@ This command deletes the stored link key for
 from the device.
 .TP
 .BI oobdata
-Display local OOB data.
+Get local OOB data (invalidates previously read data).
 .TP
 .BI commands
 Display supported commands.
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index f1458b9..64f2650 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1924,7 +1924,7 @@ static struct {
 	{ "scomtu",	cmd_scomtu,	"<mtu:pkt>",	"Set SCO MTU and number of packets" },
 	{ "putkey",	cmd_putkey,	"<bdaddr>",	"Store link key on the device" },
 	{ "delkey",	cmd_delkey,	"<bdaddr>",	"Delete link key from the device" },
-	{ "oobdata",	cmd_oob_data,	0,		"Display local OOB data" },
+	{ "oobdata",	cmd_oob_data,	0,		"Get local OOB data" },
 	{ "commands",	cmd_commands,	0,		"Display supported commands" },
 	{ "features",	cmd_features,	0,		"Display device features" },
 	{ "version",	cmd_version,	0,		"Display version information" },
-- 
1.7.9.5

