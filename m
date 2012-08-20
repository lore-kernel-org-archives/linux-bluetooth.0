Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 4/4] gatt: Don't raise error if declaration was found
Date: Mon, 20 Aug 2012 14:32:22 -0300
Message-Id: <1345483942-27973-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch avoids raising errors to the upper layer if at least one
characteristic declaration has been found. According to the Core SPEC
Characteristic declarations shall be read without authentication or
authorization.
---
 attrib/gatt.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index aea59ec..6880e2d 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -253,7 +253,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 {
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
-	unsigned int i, err;
+	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
 	size_t buflen;
 	uint8_t *buf;
 	guint16 oplen;
@@ -261,7 +261,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	uint16_t last = 0;
 
 	if (status) {
-		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		err = status;
 		goto done;
 	}
 
@@ -320,9 +320,9 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		return;
 	}
 
-	err = (dc->characteristics ? 0 : ATT_ECODE_ATTR_NOT_FOUND);
-
 done:
+	err = (dc->characteristics ? 0 : err);
+
 	dc->cb(dc->characteristics, err, dc->user_data);
 	discover_char_free(dc);
 }
-- 
1.7.8.6

