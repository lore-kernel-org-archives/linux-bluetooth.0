Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] lib/uuid: Fix bt_uuid_strcmp
Date: Fri,  4 Sep 2015 16:42:54 +0300
Message-Id: <1441374174-1732-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_uuid_strcmp shall first convert the strings to bt_uuid_t using
bt_string_to_uuid since bt_uuid_to_string can produce different formats
depending on the type.
---
 lib/uuid.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index fd61968..046b521 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -289,7 +289,12 @@ int bt_string_to_uuid(bt_uuid_t *uuid, const char *string)
 
 int bt_uuid_strcmp(const void *a, const void *b)
 {
-	return strcasecmp(a, b);
+	bt_uuid_t u1, u2;
+
+	bt_string_to_uuid(&u1, a);
+	bt_string_to_uuid(&u2, b);
+
+	return bt_uuid_cmp(&u1, &u2);
 }
 
 int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
-- 
2.4.3

