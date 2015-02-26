Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 04/16] attrib/gatt: Minor refactor in char_discovered_cb
Date: Thu, 26 Feb 2015 10:39:31 +0100
Message-Id: <1424943583-30061-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be needed by next patch
---
 attrib/gatt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index b8d766c..4bffd64 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -574,10 +574,16 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 {
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
-	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
+	unsigned int i, err = 0;
 	uint16_t last = 0;
 	uint8_t type;
 
+	/* We have all the characteristic now, lets send it up */
+	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
+		err = dc->characteristics ? 0 : status;
+		goto done;
+	}
+
 	if (status) {
 		err = status;
 		goto done;
@@ -647,7 +653,6 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	}
 
 done:
-	err = (dc->characteristics ? 0 : err);
 	dc->cb(err, dc->characteristics, dc->user_data);
 }
 
-- 
1.8.4

