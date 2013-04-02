Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] attrib: Fix memory leak on low memory condition
Date: Tue,  2 Apr 2013 11:07:43 -0400
Message-Id: <1364915265-4191-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If g_try_new0() fails due to low memory condition, "list" should be
freed before returning from primary_all_cb().
---
 attrib/gatt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 44d3eb6..e4c5385 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -226,6 +226,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 		primary = g_try_new0(struct gatt_primary, 1);
 		if (!primary) {
+			att_data_list_free(list);
 			err = ATT_ECODE_INSUFF_RESOURCES;
 			goto done;
 		}
-- 
1.7.9.5

