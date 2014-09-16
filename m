Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools: Fix memory leak
Date: Tue, 16 Sep 2014 17:03:50 +0300
Message-Id: <1410876230-10175-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Simplify code and fix memory leaks
---
 tools/btgatt-client.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index f628bbb..41b85ad 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -539,8 +539,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 			if (strlen(argv[i]) != 2) {
 				printf("Invalid value byte: %s\n",
 								argv[i]);
-				free(value);
-				return;
+				goto done;
 			}
 
 			value[i-1] = strtol(argv[i], &endptr, 16);
@@ -548,8 +547,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 							|| errno == ERANGE) {
 				printf("Invalid value byte: %s\n",
 								argv[i]);
-				free(value);
-				return;
+				goto done;
 			}
 		}
 	}
@@ -559,11 +557,11 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 							false, value, length)) {
 			printf("Failed to initiate write without response "
 								"procedure\n");
-			return;
+			goto done;
 		}
 
 		printf("Write command sent\n");
-		return;
+		goto done;
 	}
 
 	if (!bt_gatt_client_write_value(cli->gatt, handle, value, length,
@@ -571,6 +569,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 								NULL, NULL))
 		printf("Failed to initiate write procedure\n");
 
+done:
 	free(value);
 }
 
-- 
1.9.1

