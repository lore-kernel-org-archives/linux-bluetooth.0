Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] tools/hcitool: Fix support for simple lecup format
Date: Mon, 12 Jan 2015 17:19:38 +0100
Message-Id: <1421079580-26470-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1421079580-26470-1-git-send-email-szymon.janc@tieto.com>
References: <1421079580-26470-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allow to call lecup in simple form:
"hcitool lecup <handle> <min> <max> <latency> <timeout>".
---
 tools/hcitool.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index cbd32f3..612e5bc 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -3308,6 +3308,7 @@ static void cmd_lecup(int dev_id, int argc, char **argv)
 {
 	uint16_t handle = 0, min, max, latency, timeout;
 	int opt, dd, base;
+	int options = 0;
 
 	/* Aleatory valid values */
 	min = 0x0C8;
@@ -3341,6 +3342,18 @@ static void cmd_lecup(int dev_id, int argc, char **argv)
 			printf("%s", lecup_help);
 			return;
 		}
+
+		options = 1;
+	}
+
+	if (options == 0) {
+		helper_arg(5, 5, &argc, &argv, lecup_help);
+
+		handle = strtoul(argv[0], NULL, 0);
+		min = strtoul(argv[1], NULL, 0);
+		max = strtoul(argv[2], NULL, 0);
+		latency = strtoul(argv[3], NULL, 0);
+		timeout = strtoul(argv[4], NULL, 0);
 	}
 
 	if (handle == 0) {
-- 
1.9.1

