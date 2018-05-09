Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 3/3] android/client: Fix compilation with GCC 8
Date: Wed,  9 May 2018 14:11:13 +0200
Message-Id: <20180509121113.4110-3-szymon.janc@codecoup.pl>
In-Reply-To: <20180509121113.4110-1-szymon.janc@codecoup.pl>
References: <20180509121113.4110-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC       android/client/android_haltest-if-gatt.o
android/client/if-gatt.c: In function ‘multi_adv_set_inst_data_p’:
android/client/if-gatt.c:2034:7: error: ‘set_scan_rsp’ may be used
      uninitialized in this function [-Werror=maybe-uninitialized]
  EXEC(if_gatt->client->multi_adv_set_inst_data, client_if, set_scan_rsp,
       ^~~~~~~
android/client/if-gatt.c:2034:7: error: ‘include_name’ may be used
         uninitialized in this function [-Werror=maybe-uninitialized]
android/client/if-gatt.c:2034:7: error: ‘include_txpower’ may be used
         uninitialized in this function [-Werror=maybe-uninitialized]
android/client/if-gatt.c: In function ‘set_adv_data_p’:
android/client/if-gatt.c:1859:7: error: ‘set_scan_rsp’ may be used
         uninitialized in this function [-Werror=maybe-uninitialized]
  EXEC(if_gatt->client->set_adv_data, client_if, set_scan_rsp,
       ^~~~~~~
android/client/if-gatt.c:1859:7: error: ‘include_name’ may be used
         uninitialized in this function [-Werror=maybe-uninitialized]
android/client/if-gatt.c:1859:7: error: ‘include_txpower’ may be used
         uninitialized in this function [-Werror=maybe-uninitialized]
cc1: all warnings being treated as errors
make[1]: *** [Makefile:6431: android/client/android_haltest-if-gatt.o] Error 1
make: *** [Makefile:3262: all] Error 2
---
 android/client/if-gatt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 35267832f..ed14f92c4 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1825,8 +1825,9 @@ static void set_adv_data_c(int argc, const char **argv,
 static void set_adv_data_p(int argc, const char **argv)
 {
 	int client_if;
-	bool set_scan_rsp;
-	bool include_name, include_txpower;
+	bool set_scan_rsp = false;
+	bool include_name = false;
+	bool include_txpower = false;
 	int min_interval, max_interval;
 	int appearance;
 	uint16_t manufacturer_len;
@@ -2003,8 +2004,9 @@ static void multi_adv_set_inst_data_c(int argc, const char **argv,
 static void multi_adv_set_inst_data_p(int argc, const char **argv)
 {
 	int client_if;
-	bool set_scan_rsp;
-	bool include_name, include_txpower;
+	bool set_scan_rsp = false;
+	bool include_name = false;
+	bool include_txpower = false;
 	int appearance;
 	uint16_t manufacturer_len;
 	uint8_t manufacturer_data[100];
-- 
2.17.0

