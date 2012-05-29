Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] GATT: Avoid unneeded discover transaction
Date: Tue, 29 May 2012 10:55:26 -0300
Message-Id: <1338299726-25822-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1338299726-25822-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1338299726-25822-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix unneeded discover characteristics transaction when the
last characteristic declaration contains the handle number equals to the
end handle of the primary service.
---
 attrib/gatt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index b9c2bbb..6f9a11d 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -303,7 +303,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	att_data_list_free(list);
 	err = 0;
 
-	if (last != 0) {
+	if (last != 0 && (last + 1 < dc->end)) {
 		buf = g_attrib_get_buffer(dc->attrib, &buflen);
 
 		bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-- 
1.7.8.6

