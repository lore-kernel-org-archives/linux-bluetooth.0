Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 14/14] thermometer: Fix missing braces
Date: Tue, 25 Sep 2012 16:52:43 +0200
Message-ID: <1348584763-22824-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 8733843..0e2bf0a 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -335,8 +335,9 @@ static void change_property(struct thermometer *t, const char *name,
 		emit_property_changed(device_get_path(t->dev),
 					THERMOMETER_INTERFACE, name,
 					DBUS_TYPE_UINT16, &t->min);
-	} else
+	} else {
 		DBG("%s is not a thermometer property", name);
+	}
 }
 
 static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
@@ -421,8 +422,9 @@ static void process_thermometer_desc(struct descriptor *desc)
 			val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
 			msg = g_strdup("Enable Measurement Interval "
 								"indication");
-		} else
+		} else {
 			goto done;
+		}
 
 		att_put_u16(val, atval);
 		gatt_write_char(ch->t->attrib, desc->handle, atval, 2,
@@ -548,12 +550,13 @@ static void process_thermometer_char(struct characteristic *ch)
 		gboolean intermediate = TRUE;
 		change_property(ch->t, "Intermediate", &intermediate);
 		return;
-	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0)
+	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0) {
 		gatt_read_char(ch->t->attrib, ch->attr.value_handle, 0,
 							read_temp_type_cb, ch);
-	else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
+	} else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
 		gatt_read_char(ch->t->attrib, ch->attr.value_handle, 0,
 							read_interval_cb, ch);
+	}
 }
 
 static void configure_thermometer_cb(GSList *characteristics, guint8 status,
@@ -591,10 +594,11 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 			if (start == c->handle)
 				continue;
 			end = c->handle - 1;
-		} else if (c->value_handle != t->svc_range->end)
+		} else if (c->value_handle != t->svc_range->end) {
 			end = t->svc_range->end;
-		else
+		} else {
 			continue;
+		}
 
 		gatt_find_info(t->attrib, start, end, discover_desc_cb, ch);
 	}
-- 
1.7.11.3

