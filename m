Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 7/8] tools/btmgmt: Change help message of some commands
 to usage
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <15396185-1a51-85c6-48a6-050ddaf3bf1b@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:28:30 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Display the usage including the command name even if passing an invalid
argument.
---
 tools/btmgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index ee2cb18..8eee2b1 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1790,7 +1790,7 @@ done:
 static bool parse_setting(int argc, char **argv, uint8_t *val)
 {
 	if (argc < 2) {
-		print("Specify \"on\" or \"off\"");
+		cmd_usage(argv[0]);
 		return false;
 	}
 
@@ -1893,7 +1893,7 @@ static void cmd_sc(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	uint8_t val;
 
 	if (argc < 2) {
-		print("Specify \"on\" or \"off\" or \"only\"");
+		cmd_usage(argv[0]);
 		return noninteractive_quit(EXIT_FAILURE);
 	}
 
-- 
2.7.4

