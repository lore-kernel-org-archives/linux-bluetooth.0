Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH] Fix endian conversion for appparams in pbap client
Date: Sun,  8 May 2011 18:00:15 +0000
Message-Id: <1304877615-10038-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/pbap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 837419c..dee85c8 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -312,6 +312,7 @@ static void read_return_apparam(struct session_data *session,
 			if (hdr->len == PHONEBOOKSIZE_LEN) {
 				guint16 val;
 				memcpy(&val, hdr->val, sizeof(val));
+                                val = get_be16(&val);
 				*phone_book_size = val;
 			}
 			break;
-- 
1.7.5.rc3

