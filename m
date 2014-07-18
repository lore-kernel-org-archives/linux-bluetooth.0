Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/6] core: Remove unneeded assignment
Date: Fri, 18 Jul 2014 16:28:26 +0300
Message-Id: <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Variable rfcomm is never used after assignment
---
 src/profile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index 528525a..7aca3be 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1272,7 +1272,6 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 			error("RFCOMM server failed for %s: %s",
 						ext->name, err->message);
 			g_free(rfcomm);
-			rfcomm = NULL;
 			g_clear_error(&err);
 			goto failed;
 		} else {
-- 
1.9.1

