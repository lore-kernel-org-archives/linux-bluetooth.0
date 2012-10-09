Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 6/8] adapter: Fix calling mgmt_set_pairable() with error set
Date: Tue,  9 Oct 2012 04:59:54 -0300
Message-Id: <1349769596-6050-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 src/adapter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 26016f6..a6593b2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -415,8 +415,12 @@ static DBusMessage *set_pairable(DBusMessage *msg,
 		goto store;
 
 	err = set_mode(adapter, MODE_DISCOVERABLE);
-	if (err < 0 && msg)
-		return btd_error_failed(msg, strerror(-err));
+	if (err < 0) {
+		if (msg != NULL)
+			return btd_error_failed(msg, strerror(-err));
+
+		return NULL;
+	}
 
 store:
 	mgmt_set_pairable(adapter->dev_id, pairable);
-- 
1.7.12.2

