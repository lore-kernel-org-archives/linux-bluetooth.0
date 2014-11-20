Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] tools/gatt: Fix memory leak
Date: Thu, 20 Nov 2014 15:13:15 +0200
Message-Id: <1416489195-26477-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1416489195-26477-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1416489195-26477-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes following clang warning:
...
tools/btgatt-client.c:451:4: warning: Potential leak of memory pointed
to by 'value'
                        printf("Invalid value byte: %s\n", argv[i]);
                        ^~~~~~
...
---
 tools/btgatt-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index ca84780..dadfa37 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -449,6 +449,7 @@ static void cmd_read_multiple(struct client *cli, char *cmd_str)
 		value[i] = strtol(argv[i], &endptr, 0);
 		if (endptr == argv[i] || *endptr != '\0' || !value[i]) {
 			printf("Invalid value byte: %s\n", argv[i]);
+			free(value);
 			return;
 		}
 	}
-- 
1.9.1

