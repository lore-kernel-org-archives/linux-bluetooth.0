Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 02/12] client: Use constant instead of NULL variable
Date: Mon, 21 May 2012 11:07:04 +0200
Message-Id: <1337591234-24919-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The filename will always be NULL for capability-requesting sessions, so
it doesn't make much sense to use such field.
---
 client/manager.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 3dd0220..3005fe8 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -510,8 +510,7 @@ static void capability_obc_session_callback(struct obc_session *session,
 	if (err != NULL)
 		goto fail;
 
-	pull = obc_transfer_get("x-obex/capability", NULL, data->filename,
-									&gerr);
+	pull = obc_transfer_get("x-obex/capability", NULL, NULL, &gerr);
 	if (pull == NULL)
 		goto fail;
 
-- 
1.7.7.6

