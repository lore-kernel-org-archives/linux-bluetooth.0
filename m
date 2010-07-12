Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Fix signal strength for HFP in maemo6 telephony
Date: Mon, 12 Jul 2010 20:04:43 +0300
Message-Id: <1278954283-3832-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signal strength in terms of bars units is updated by emited
SignalBarsChanged instead of SignalStrengthChanged from libscnet library.
It contains required number of bars to display in scale 0..5. Conversion
from percent or decibel units to bars is not needed and therefore removed.

Same holds when initializing by request of SignalBars, where bars are in
0..5 range. Conversion from percents is removed. Sanity check is done to
prevent -1 that may be returned when the property is unavailabe (modem
state off).

RSSI percents and dBs are neither present among SignalBarsChanged
properties nor requested during initialization and, therefore, removed.
---
 audio/telephony-maemo6.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 31704c3..d5499ed 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1233,33 +1233,31 @@ static void update_signal_strength(int32_t signals_bar)
 
 	if (signals_bar < 0)
 		signals_bar = 0;
-	else if (signals_bar > 100) {
+	else if (signals_bar > 5) {
 		DBG("signals_bar greater than expected: %u", signals_bar);
-		signals_bar = 100;
+		signals_bar = 5;
 	}
 
 	if (net.signals_bar == signals_bar)
 		return;
 
-	/* A simple conversion from 0-100 to 0-5 (used by HFP) */
-	signal = (signals_bar + 20) / 21;
+	/* no need in any conversion */
+	signal = signals_bar;
 
 	telephony_update_indicator(maemo_indicators, "signal", signal);
 
 	net.signals_bar = signals_bar;
-
-	DBG("telephony-maemo6: signal strength updated: %u/100, %d/5", signals_bar, signal);
+	DBG("telephony-maemo6: signal strength updated: %d/5", signal);
 }
 
 static void handle_signal_strength_changed(DBusMessage *msg)
 {
-	int32_t signals_bar, rssi_in_dbm;
+	int32_t signals_bar;
 
 	if (!dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_INT32, &signals_bar,
-					DBUS_TYPE_INT32, &rssi_in_dbm,
 					DBUS_TYPE_INVALID)) {
-		error("Unexpected parameters in SignalStrengthChanged");
+		error("Unexpected parameters in SignalBarsChanged");
 		return;
 	}
 
@@ -1530,7 +1528,7 @@ static void get_property_reply(DBusPendingCall *call, void *user_data)
 		dbus_message_iter_get_basic(&sub, &name);
 		update_operator_name(name);
 	} else if (g_strcmp0(prop, "SignalBars") == 0) {
-		uint32_t signal_bars;
+		int32_t signal_bars; /* signal bars can be -1 */
 
 		dbus_message_iter_get_basic(&sub, &signal_bars);
 		update_signal_strength(signal_bars);
@@ -1899,7 +1897,7 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
 				"OperatorNameChanged"))
 		handle_operator_name_changed(msg);
 	else if (dbus_message_is_signal(msg, CSD_CSNET_SIGNAL,
-				"SignalStrengthChanged"))
+				"SignalBarsChanged"))
 		handle_signal_strength_changed(msg);
 	else if (dbus_message_is_signal(msg, "org.freedesktop.Hal.Device",
 					"PropertyModified"))
-- 
1.7.0.4

