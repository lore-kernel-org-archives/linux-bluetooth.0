Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/13] adapter: Fix invalid read in conversions
Date: Mon, 17 Dec 2012 16:09:52 +0100
Message-Id: <1355756994-18953-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

==8664== Invalid read of size 1
==8664==    at 0x45B214: convert_entry (adapter.c:2325)
==8664==    by 0x456A44: textfile_foreach (textfile.c:464)
==8664==    by 0x45A823: convert_file (adapter.c:2387)
==8664==    by 0x45ABDE: convert_device_storage (adapter.c:2869)
==8664==    by 0x45F6CE: adapter_init (adapter.c:3043)
==8664==    by 0x4594D9: btd_manager_register_adapter (manager.c:176)
==8664==    by 0x46DB3E: mgmt_event.part.38 (mgmt.c:1206)
==8664==    by 0x4E79D52: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
==8664==    by 0x4E7A09F: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
==8664==    by 0x4E7A499: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
==8664==    by 0x409D53: main (main.c:513)
==8664==  Address 0x60b99c1 is not stack'd, malloc'd or (recently) free'd
==8664==
---
 src/adapter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dd1b0b1..ab86b83 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2204,7 +2204,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 	char *data;
 	gsize length = 0;
 
-	if (key[17] == '#') {
+	if (strchr(key, '#')) {
 		key[17] = '\0';
 		type = key[18] - '0';
 	}
@@ -2446,7 +2446,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	char *data;
 	gsize length = 0;
 
-	if (key[17] == '#') {
+	if (strchr(key, '#')) {
 		key[17] = '\0';
 		device_type = key[18] - '0';
 	}
-- 
1.7.9.5

