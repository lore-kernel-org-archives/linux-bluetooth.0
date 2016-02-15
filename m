Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] core/device: Fix not reseting database if attributes cannot be loaded
Date: Mon, 15 Feb 2016 14:30:41 +0200
Message-Id: <1455539442-31843-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
References: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If one or more attributes cannot be loaded it means the database is
probably in a bad state so just clear it so the attributes can be
discovered again.
---
 src/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 235145a..89462ca 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3165,8 +3165,10 @@ static int load_gatt_db_impl(GKeyFile *key_file, char **keys,
 		}
 
 		g_free(value);
-		if (ret)
+		if (ret) {
+			gatt_db_clear(db);
 			return ret;
+		}
 	}
 
 	if (current_service)
-- 
2.5.0

