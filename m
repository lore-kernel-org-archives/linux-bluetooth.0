Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] adapter: Use int for storing signed value
Date: Tue, 18 Dec 2012 12:10:58 +0100
Message-ID: <1355829058-10033-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355829058-10033-1-git-send-email-szymon.janc@tieto.com>
References: <1355829058-10033-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

char can be signed or unsigned depending on architecture. This fix
following compilation error on ARM:

src/adapter.c: In function 'convert_primaries_entry`:
src/adapter:2272:2: error: comparison is always true due to limited
	range of data type [-Werror=type-limits]
cc1: all warnings being treated as errors
make[1]: *** [src/adapter.o] Error 1
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index a41eb15..bb54d8b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2215,7 +2215,7 @@ failed:
 static void convert_primaries_entry(char *key, char *value, void *user_data)
 {
 	char *address = user_data;
-	char device_type = -1;
+	int device_type = -1;
 	uuid_t uuid;
 	char **services, **service, *prim_uuid;
 	char filename[PATH_MAX + 1];
-- 
1.8.0

