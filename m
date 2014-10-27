Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 3/7] tools/btgatt-client: Fix read-long-value offset parsing.
Date: Mon, 27 Oct 2014 07:35:38 -0700
Message-Id: <1414420542-15336-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1414420542-15336-1-git-send-email-armansito@chromium.org>
References: <1414420542-15336-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the way read-long-value command parses the "offset"
argument by interpreting it as base 10 instead of 16, which is more
intuitive.
---
 tools/btgatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index b7bfa24..e7cd31c 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -486,8 +486,8 @@ static void cmd_read_long_value(struct client *cli, char *cmd_str)
 	}
 
 	endptr = NULL;
-	offset = strtol(argv[1], &endptr, 16);
-	if (!endptr || *endptr != '\0' || !handle) {
+	offset = strtol(argv[1], &endptr, 10);
+	if (!endptr || *endptr != '\0') {
 		printf("Invalid offset: %s\n", argv[1]);
 		return;
 	}
-- 
2.1.0.rc2.206.gedb03e5

