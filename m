Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gatt: Fix memory leak in profile_add
Date: Tue, 19 May 2015 10:49:57 +0300
Message-Id: <1432021797-24630-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Cleanup memory correctly.
---
 src/gatt-database.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index dd80aa0..ca514db 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2299,8 +2299,11 @@ static int profile_add(struct external_profile *profile, const char *uuid)
 		return -ENOMEM;
 
 	p->remote_uuid = (const void *) g_strdup(uuid);
-	if (!p->remote_uuid)
+	if (!p->remote_uuid) {
+		g_free((void *) p->name);
+		free((void *) p);
 		return -ENOMEM;
+	}
 
 	p->auto_connect = true;
 
-- 
2.1.4

