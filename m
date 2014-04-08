Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] android/avrcp-lib: Add checks in avrcp_get_item_attributes
Date: Tue,  8 Apr 2014 16:34:37 +0300
Message-Id: <1396964080-19642-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396964080-19642-1-git-send-email-luiz.dentz@gmail.com>
References: <1396964080-19642-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds checks for number of attributes is within the valid range and
if the data pointer is valid.
---
 android/avrcp-lib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 8224110..9412899 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1912,8 +1912,15 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 						iov, 1, get_item_attributes_rsp,
 						session);
 
-	for (i = 0; i < number; i++)
+	if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
+		return -EINVAL;
+
+	for (i = 0; i < number; i++) {
+		if (attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST ||
+				attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL)
+			return -EINVAL;
 		put_be32(attrs[i], &attrs[i]);
+	}
 
 	iov[1].iov_base = (void *) attrs;
 	iov[1].iov_len = number * sizeof(*attrs);
-- 
1.9.0

