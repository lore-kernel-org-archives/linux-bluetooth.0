Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android/avrcp-lib: Fix avrcp_get_player_attribute_text_rsp
Date: Tue, 18 Mar 2014 14:05:23 +0200
Message-Id: <1395144323-12283-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395144323-12283-1-git-send-email-luiz.dentz@gmail.com>
References: <1395144323-12283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

avrcp_get_player_attribute_text_rsp was generating invalid responses as
it fills the string data in the wrong field.
---
 android/avrcp-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index d360870..1d7fff5 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -882,7 +882,7 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 		ptr[0] = attrs[i];
 		bt_put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
 		ptr[3] = len;
-		memcpy(ptr, text[i], len);
+		memcpy(&ptr[4], text[i], len);
 		ptr += 4 + len;
 		length += 4 + len;
 	}
-- 
1.8.5.3

