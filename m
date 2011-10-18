Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: chanyeol.park@samsung.com
Subject: [PATCH] Fix missing initialization of eir name_len
Date: Tue, 18 Oct 2011 19:42:02 +0900
Message-id: <1318934522-31475-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 src/eir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index e82d30b..b76bfa2 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -70,7 +70,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
 	uuid_t service;
 	char *uuid_str;
 	const char *name = NULL;
-	size_t name_len;
+	size_t name_len = 0;
 	unsigned int i;
 
 	eir->flags = -1;
-- 
1.7.4.1

