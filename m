Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH v2] Fix endian conversion for appparams in pbap client
Date: Sun, 15 May 2011 12:37:41 +0200
Message-Id: <1305455861-26395-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/pbap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 837419c..589b1ca 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -312,7 +312,7 @@ static void read_return_apparam(struct session_data *session,
 			if (hdr->len == PHONEBOOKSIZE_LEN) {
 				guint16 val;
 				memcpy(&val, hdr->val, sizeof(val));
-				*phone_book_size = val;
+				*phone_book_size = get_be16(&val);
 			}
 			break;
 		case NEWMISSEDCALLS_TAG:
-- 
1.7.5.rc3

