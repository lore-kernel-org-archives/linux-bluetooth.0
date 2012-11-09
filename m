Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 09/15] thermometer: Discover Measurement Interval descriptors only if needed
Date: Fri, 9 Nov 2012 09:55:51 +0100
Message-ID: <1352451357-22097-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will make descriptor discovery started only if Measurement
Interval characteristic properties are either write or indicate, otherwise
there are no known descriptors to be discovered.
---
 profiles/thermometer/thermometer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 63d9c1e..30f79b0 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -718,15 +718,24 @@ static void process_thermometer_char(struct thermometer *t,
 		gatt_read_char(t->attrib, c->value_handle,
 							read_temp_type_cb, t);
 	} else if (g_strcmp0(c->uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
+		bool need_desc = false;
+
 		gatt_read_char(t->attrib, c->value_handle, read_interval_cb, t);
 
-		t->interval_val_handle = c->value_handle;
+		if (c->properties & ATT_CHAR_PROPER_WRITE) {
+			t->interval_val_handle = c->value_handle;
+			need_desc = true;
+		}
 
-		t->attio_interval_id = g_attrib_register(t->attrib,
+		if (c->properties & ATT_CHAR_PROPER_INDICATE) {
+			t->attio_interval_id = g_attrib_register(t->attrib,
 					ATT_OP_HANDLE_IND, c->value_handle,
 					interval_ind_handler, t, NULL);
+			need_desc = true;
+		}
 
-		discover_desc(t, c, c_next);
+		if (need_desc)
+			discover_desc(t, c, c_next);
 	}
 }
 
-- 
1.8.0

