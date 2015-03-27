Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/avrcp-lib: Fix possible invalid read
Date: Fri, 27 Mar 2015 13:55:34 +0100
Message-Id: <1427460934-20283-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1427460934-20283-1-git-send-email-szymon.janc@tieto.com>
References: <1427460934-20283-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If item length was 0 text was left uninitialized.
---
 android/avrcp-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index eba99ab..2f7d05d 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -2445,6 +2445,8 @@ static int parse_attribute_list(uint8_t *params, uint16_t params_len,
 			text[i] = g_strndup(item->data, item->len);
 			params_len -= item->len;
 			params += item->len;
+		} else {
+			text[i] = NULL;
 		}
 	}
 
-- 
1.9.3

