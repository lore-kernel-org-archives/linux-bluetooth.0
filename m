Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] tools/hcitool: Fix help message for lecup
Date: Mon, 12 Jan 2015 17:19:37 +0100
Message-Id: <1421079580-26470-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Command options don't support short options and long options require
equal mark.
---
 tools/hcitool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 0bd416f..cbd32f3 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -3296,11 +3296,11 @@ static const char *lecup_help =
 	"Usage:\n"
 	"\tlecup <handle> <min> <max> <latency> <timeout>\n"
 	"\tOptions:\n"
-	"\t    -H, --handle <0xXXXX>  LE connection handle\n"
-	"\t    -m, --min <interval>   Range: 0x0006 to 0x0C80\n"
-	"\t    -M, --max <interval>   Range: 0x0006 to 0x0C80\n"
-	"\t    -l, --latency <range>  Slave latency. Range: 0x0000 to 0x03E8\n"
-	"\t    -t, --timeout  <time>  N * 10ms. Range: 0x000A to 0x0C80\n"
+	"\t    --handle=<0xXXXX>  LE connection handle\n"
+	"\t    --min=<interval>   Range: 0x0006 to 0x0C80\n"
+	"\t    --max=<interval>   Range: 0x0006 to 0x0C80\n"
+	"\t    --latency=<range>  Slave latency. Range: 0x0000 to 0x03E8\n"
+	"\t    --timeout=<time>   N * 10ms. Range: 0x000A to 0x0C80\n"
 	"\n\t min/max range: 7.5ms to 4s. Multiply factor: 1.25ms"
 	"\n\t timeout range: 100ms to 32.0s. Larger than max interval\n";
 
-- 
1.9.1

