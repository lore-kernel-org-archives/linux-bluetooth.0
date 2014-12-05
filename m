Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] tools/gatt: Fix not checking malloc() failure
Date: Fri,  5 Dec 2014 09:30:36 +0200
Message-Id: <1417764636-28857-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1417764636-28857-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1417764636-28857-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This follows standard practice elsewhere in this file.
---
 tools/btgatt-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index fe94ae8..01cfd93 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -458,6 +458,10 @@ static void cmd_read_multiple(struct client *cli, char *cmd_str)
 	}
 
 	value = malloc(sizeof(uint16_t) * argc);
+	if (!value) {
+		printf("Failed to construct value\n");
+		return;
+	}
 
 	for (i = 0; i < argc; i++) {
 		value[i] = strtol(argv[i], &endptr, 0);
-- 
1.9.1

