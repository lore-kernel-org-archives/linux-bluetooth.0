Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 08/16] attrib/gatt: Minor refactor in desc_discovered_cb
Date: Thu, 26 Feb 2015 10:39:35 +0100
Message-Id: <1424943583-30061-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for next patch
---
 attrib/gatt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 2749c46..df4e3a7 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -1008,12 +1008,17 @@ static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 {
 	struct discover_desc *dd = user_data;
 	struct att_data_list *list;
-	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
+	unsigned int i, err = 0;
 	guint8 format;
 	uint16_t last = 0xffff;
 	uint8_t type;
 	gboolean uuid_found = FALSE;
 
+	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
+		err = dd->descriptors ? 0 : status;
+		goto done;
+	}
+
 	if (status) {
 		err = status;
 		goto done;
@@ -1086,7 +1091,6 @@ static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 	}
 
 done:
-	err = (dd->descriptors ? 0 : err);
 	dd->cb(err, dd->descriptors, dd->user_data);
 }
 
-- 
1.8.4

