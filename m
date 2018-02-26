Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/14] shared/shell: Fix not handling sort options
Date: Mon, 26 Feb 2018 17:53:27 +0200
Message-Id: <20180226155336.25875-6-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getopt_long index is only valid for long options.
---
 src/shared/shell.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index eae4ffbdd..7f726c2dd 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -775,7 +775,7 @@ static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 
 void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 {
-	int c, index = 0;
+	int c, index = -1;
 	struct option options[256];
 	char optstr[256];
 	size_t offset;
@@ -805,6 +805,13 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			data.timeout = atoi(optarg);
 			break;
 		default:
+			if (index < 0) {
+				for (index = 0; options[index].val; index++) {
+					if (c == options[index].val)
+						break;
+				}
+			}
+
 			if (c != opt->options[index - offset].val) {
 				usage(argc, argv, opt);
 				exit(EXIT_SUCCESS);
-- 
2.14.3

