Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/hal-utils: Make hal-utils functions return const string
Date: Fri,  8 Nov 2013 16:08:50 +0200
Message-Id: <1383919730-13597-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383919730-13597-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383919730-13597-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-utils.c |    4 ++--
 android/hal-utils.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-utils.c b/android/hal-utils.c
index 96dc234..7ac5047 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -27,7 +27,7 @@
  *
  * returns string representation of uuid
  */
-char *bt_uuid_t2str(const uint8_t *uuid, char *buf)
+const char *bt_uuid_t2str(const uint8_t *uuid, char *buf)
 {
 	int shift = 0;
 	unsigned int i;
@@ -49,7 +49,7 @@ char *bt_uuid_t2str(const uint8_t *uuid, char *buf)
 	return buf;
 }
 
-char *btuuid2str(const uint8_t *uuid)
+const char *btuuid2str(const uint8_t *uuid)
 {
 	static char buf[MAX_UUID_STR_LEN];
 
diff --git a/android/hal-utils.h b/android/hal-utils.h
index 5287180..8c74653 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -23,5 +23,5 @@ static const char BT_BASE_UUID[] = {
 	0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb
 };
 
-char *bt_uuid_t2str(const uint8_t *uuid, char *buf);
-char *btuuid2str(const uint8_t *uuid);
+const char *bt_uuid_t2str(const uint8_t *uuid, char *buf);
+const char *btuuid2str(const uint8_t *uuid);
-- 
1.7.10.4

