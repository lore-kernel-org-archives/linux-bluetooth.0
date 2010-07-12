Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Code consitency for signal strength in HFP maemo6
Date: Mon, 12 Jul 2010 20:06:01 +0300
Message-Id: <1278954361-3876-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch simplifies and makes maemo6 telephony driver code consistent
with libscnet API regarding SignalBarsChanged. RSSI percents and RSSI
dBs are not among the parameters when SignalBarsChanged emited.
Therefore, these parameters are removed. Names are changed to reflect
libscnet d-bus interface notations. Comments and debug information are
updated in places where units or operations are unclear.
---
 audio/telephony-maemo6.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index d5499ed..0e2a3d4 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -134,11 +134,14 @@ struct csd_call {
 static struct {
 	char *operator_name;
 	uint8_t status;
-	int32_t signals_bar;
+	int32_t signal_bars;
 } net = {
 	.operator_name = NULL,
 	.status = NETWORK_REG_STATUS_UNKOWN,
-	.signals_bar = 0,
+	 /* Init as 0 meaning inactive mode. In modem power off state */
+	 /* can be be -1, but we treat all values as 0s regardless */ 
+	 /* inactive or power off. */
+	.signal_bars = 0,
 };
 
 static int get_property(const char *iface, const char *prop);
@@ -181,6 +184,7 @@ static guint create_request_timer = 0;
 static struct indicator maemo_indicators[] =
 {
 	{ "battchg",	"0-5",	5,	TRUE },
+	/* signal strength in terms of bars */
 	{ "signal",	"0-5",	0,	TRUE },
 	{ "service",	"0,1",	0,	TRUE },
 	{ "call",	"0,1",	0,	TRUE },
@@ -1227,41 +1231,37 @@ static void handle_registration_changed(DBusMessage *msg)
 	update_registration_status(status);
 }
 
-static void update_signal_strength(int32_t signals_bar)
+static void update_signal_strength(int32_t signal_strength_bars)
 {
-	int signal;
-
-	if (signals_bar < 0)
-		signals_bar = 0;
-	else if (signals_bar > 5) {
-		DBG("signals_bar greater than expected: %u", signals_bar);
-		signals_bar = 5;
+	if (signal_strength_bars < 0) {
+		DBG("signal strength smaller than expected: %d<0", signal_strength_bars);
+		signal_strength_bars = 0;
+	} else if (signal_strength_bars > 5) {
+		DBG("signal strength greater than expected: %d>5", signal_strength_bars);
+		signal_strength_bars = 5;
 	}
 
-	if (net.signals_bar == signals_bar)
+	if (net.signal_bars == signal_strength_bars)
 		return;
 
-	/* no need in any conversion */
-	signal = signals_bar;
-
-	telephony_update_indicator(maemo_indicators, "signal", signal);
+	telephony_update_indicator(maemo_indicators, "signal", signal_strength_bars);
 
-	net.signals_bar = signals_bar;
-	DBG("telephony-maemo6: signal strength updated: %d/5", signal);
+	net.signal_bars = signal_strength_bars;
+	DBG("telephony-maemo6: signal strength updated: %d/5", signal_strength_bars);
 }
 
-static void handle_signal_strength_changed(DBusMessage *msg)
+static void handle_signal_bars_changed(DBusMessage *msg)
 {
-	int32_t signals_bar;
+	int32_t signal_bars;
 
 	if (!dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_INT32, &signals_bar,
+					DBUS_TYPE_INT32, &signal_bars,
 					DBUS_TYPE_INVALID)) {
 		error("Unexpected parameters in SignalBarsChanged");
 		return;
 	}
 
-	update_signal_strength(signals_bar);
+	update_signal_strength(signal_bars);
 }
 
 static gboolean iter_get_basic_args(DBusMessageIter *iter,
@@ -1528,7 +1528,7 @@ static void get_property_reply(DBusPendingCall *call, void *user_data)
 		dbus_message_iter_get_basic(&sub, &name);
 		update_operator_name(name);
 	} else if (g_strcmp0(prop, "SignalBars") == 0) {
-		int32_t signal_bars; /* signal bars can be -1 */
+		int32_t signal_bars;
 
 		dbus_message_iter_get_basic(&sub, &signal_bars);
 		update_signal_strength(signal_bars);
@@ -1898,7 +1898,7 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
 		handle_operator_name_changed(msg);
 	else if (dbus_message_is_signal(msg, CSD_CSNET_SIGNAL,
 				"SignalBarsChanged"))
-		handle_signal_strength_changed(msg);
+		handle_signal_bars_changed(msg);
 	else if (dbus_message_is_signal(msg, "org.freedesktop.Hal.Device",
 					"PropertyModified"))
 		handle_hal_property_modified(msg);
-- 
1.7.0.4

