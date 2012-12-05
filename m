Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adapter: Always write address type when converting to new storage
Date: Wed, 5 Dec 2012 13:32:55 +0100
Message-ID: <1354710775-2670-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <20121205111430.GA5233@x220.ger.corp.intel.com>
References: <20121205111430.GA5233@x220.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When address type is not present in legacy storage assume BDADDR_BREDR
type and store it.

This also fix following compilation error on ARM:

  CC     src/bluetoothd-adapter.o
src/adapter.c: In function ‘convert_entry’:
src/adapter.c:2710:2: error: comparison is always true due to limited
	range of data type [-Werror=type-limits]
cc1: all warnings being treated as errors
make[1]: *** [src/bluetoothd-adapter.o] Error 1
---
 src/adapter.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3c5d277..9bef239 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2673,7 +2673,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
-	char device_type = -1;
+	char type = BDADDR_BREDR;
 	char filename[PATH_MAX + 1];
 	GKeyFile *key_file;
 	char *data;
@@ -2681,7 +2681,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 
 	if (key[17] == '#') {
 		key[17] = '\0';
-		device_type = key[18] - '0';
+		type = key[18] - '0';
 	}
 
 	if (bachk(key) != 0)
@@ -2707,8 +2707,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	if (device_type >= 0)
-		set_device_type(key_file, device_type);
+	set_device_type(key_file, type);
 
 	converter->cb(key_file, value);
 
-- 
1.7.9.5

