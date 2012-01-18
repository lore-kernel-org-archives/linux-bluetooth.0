Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 2/4] Use the helper function to convert a string to a binary buffer
Date: Wed, 18 Jan 2012 20:13:30 -0300
Message-Id: <1326928412-25910-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326928412-25910-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326928412-25910-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When loading Link Keys from storage we are able to re-use the function
that was introduced earlier for the LTK case.
---
 src/adapter.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6e8552b..d5075db 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1819,7 +1819,6 @@ static struct link_key_info *get_key_info(const char *addr, const char *value)
 	struct link_key_info *info;
 	char tmp[3];
 	long int l;
-	int i;
 
 	if (strlen(value) < 36) {
 		error("Unexpectedly short (%zu) link key line", strlen(value));
@@ -1830,12 +1829,7 @@ static struct link_key_info *get_key_info(const char *addr, const char *value)
 
 	str2ba(addr, &info->bdaddr);
 
-	memset(tmp, 0, sizeof(tmp));
-
-	for (i = 0; i < 16; i++) {
-		memcpy(tmp, value + (i * 2), 2);
-		info->key[i] = (uint8_t) strtol(tmp, NULL, 16);
-	}
+	str2buf(value, info->key, sizeof(info->key));
 
 	memcpy(tmp, value + 33, 2);
 	info->type = (uint8_t) strtol(tmp, NULL, 10);
-- 
1.7.8.1

