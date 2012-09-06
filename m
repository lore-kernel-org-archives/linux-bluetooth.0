Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] gatt: Fix reading Service Changed CCC
Date: Thu, 6 Sep 2012 11:15:08 +0200
Message-ID: <1346922908-16016-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Find Information Request is only sent when there are no more attributes
following Service Changed Value (incorrect) and thus will never find CCC.
---
 profiles/gatt/gas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index ddd4e70..28d7fbf 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -245,7 +245,7 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 	start = chr->value_handle + 1;
 	end = gas->gatt.end;
 
-	if (start <= end) {
+	if (start > end) {
 		error("Inconsistent database: Service Changed CCC missing");
 		return;
 	}
-- 
1.7.11.3

