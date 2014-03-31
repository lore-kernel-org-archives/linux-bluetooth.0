Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 17/20] android/avrcp: Fix clang warning
Date: Mon, 31 Mar 2014 15:25:11 +0300
Message-Id: <1396268714-4056-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
index 28c2445..e99653c 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1543,7 +1543,10 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 		ptr[0] = attrs[i];
 		put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
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

