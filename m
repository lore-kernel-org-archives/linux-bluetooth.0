Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: Fix clang warning
Date: Tue, 18 Mar 2014 16:33:42 +0200
Message-Id: <1395153222-15809-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check len before memcpy(). Fixes:
...
android/avrcp-lib.c:885:3: warning: Null pointer passed as an argument
to a 'nonnull' parameter
                memcpy(&ptr[4], text[i], len);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
...
---
 android/avrcp-lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index a7a819d..ea4bad9 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -889,7 +889,10 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 		ptr[0] = attrs[i];
 		bt_put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
 		ptr[3] = len;
-		memcpy(&ptr[4], text[i], len);
+
+		if (len)
+			memcpy(&ptr[4], text[i], len);
+
 		ptr += 4 + len;
 		length += 4 + len;
 	}
-- 
1.8.3.2

