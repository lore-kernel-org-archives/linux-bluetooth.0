Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv9 15/21] android/hal-utils: Fix possible NULL pointer dereference
Date: Mon, 25 Nov 2013 15:08:51 +0200
Message-Id: <1385384937-29858-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/hal-utils.c b/android/hal-utils.c
index 4f44d98..e3c0c60 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -33,6 +33,9 @@ const char *bt_uuid_t2str(const uint8_t *uuid, char *buf)
 	unsigned int i;
 	int is_bt;
 
+	if (!uuid)
+		return strcpy(buf, "NULL");
+
 	is_bt = !memcmp(&uuid[4], &BT_BASE_UUID[4], HAL_UUID_LEN - 4);
 
 	for (i = 0; i < HAL_UUID_LEN; i++) {
@@ -167,6 +170,9 @@ const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
 {
 	const uint8_t *p = bd_addr->address;
 
+	if (!bd_addr)
+		return strcpy(buf, "NULL");
+
 	snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
 					p[0], p[1], p[2], p[3], p[4], p[5]);
 
-- 
1.8.3.2

