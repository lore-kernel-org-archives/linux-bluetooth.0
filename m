Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] client: Fix indent
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: <linux-bluetooth@vger.kernel.org>
References: <611fb226-d99a-166d-a211-521872866d5d@jp.fujitsu.com>
Message-ID: <f678253f-e009-3402-2c79-4f7e7c3d4439@jp.fujitsu.com>
Date: Tue, 5 Sep 2017 13:54:00 +0900
MIME-Version: 1.0
In-Reply-To: <611fb226-d99a-166d-a211-521872866d5d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index d487eaf..68e7635 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2192,7 +2192,7 @@ static char *generic_generator(const char *text, int state,
 
 		if (!strncasecmp(str, text, len))
 			return strdup(str);
-        }
+	}
 
 	return NULL;
 }
-- 
2.7.4

