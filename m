Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] attrib: Fix discovering descriptors
Date: Thu, 17 Jul 2014 10:42:44 +0200
Message-Id: <1405586570-16851-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discover all attributes in given range. In same cases we ommited
last attribute in range.
---
 attrib/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 27fb0b3..f8ff2a5 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -1004,7 +1004,7 @@ static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 
 	att_data_list_free(list);
 
-	if (last + 1 < dd->end && !uuid_found) {
+	if (last < dd->end && !uuid_found) {
 		guint16 oplen;
 		size_t buflen;
 		uint8_t *buf;
-- 
1.9.0

