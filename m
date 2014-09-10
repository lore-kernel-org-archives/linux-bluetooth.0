Return-Path: <cyrus@holtmann.org>
From: gowtham babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	gowtham babu <gowtham.ab@samsung.com>
Subject: [PATCH 3/3] android/hal-utils.c : Fix null pointer dereference
Date: Wed, 10 Sep 2014 18:12:24 +0530
Message-id: <1410352944-16586-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handles the possible null pointer dereference: bd_addr by checking it against null.
---
 android/hal-utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-utils.c b/android/hal-utils.c
index ceefefc..64ab5a1 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -166,11 +166,13 @@ int int2str_findstr(const char *str, const struct int2str m[])
  */
 const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
 {
-	const uint8_t *p = bd_addr->address;
+	const uint8_t *p;
 
 	if (!bd_addr)
 		return strcpy(buf, "NULL");
 
+	p = bd_addr->address;
+
 	snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
 					p[0], p[1], p[2], p[3], p[4], p[5]);
 
-- 
1.9.1

