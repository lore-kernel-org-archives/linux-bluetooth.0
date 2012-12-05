Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adapter: Fix compilation on some architectures
Date: Wed, 5 Dec 2012 11:02:30 +0100
Message-ID: <1354701750-15578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

plain char may be treated as signed or unsigned depending on compiler
(as oposite to other integer types). Use signed char explicitly when
signed type is needed.

This fix following compilation error on ARM:

  CC     src/bluetoothd-adapter.o
src/adapter.c: In function ‘convert_entry’:
src/adapter.c:2710:2: error: comparison is always true due to limited
	range of data type [-Werror=type-limits]
cc1: all warnings being treated as errors
make[1]: *** [src/bluetoothd-adapter.o] Error 1
---
 src/adapter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3c5d277..0cbce78 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2673,7 +2673,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
-	char device_type = -1;
+	signed char device_type = -1;
 	char filename[PATH_MAX + 1];
 	GKeyFile *key_file;
 	char *data;
-- 
1.7.9.5

