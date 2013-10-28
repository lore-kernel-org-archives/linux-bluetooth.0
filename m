Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 4/4] android/client: Add completion for hf methods
Date: Mon, 28 Oct 2013 12:39:03 +0100
Message-ID: <1382960343-10765-5-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds completion functions to handsfree methods.
---
 android/client/if-hf.c |  124 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 114 insertions(+), 10 deletions(-)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index 585a569..c23fb13 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -269,6 +269,14 @@ static void init_p(int argc, const char **argv)
 
 /* connect */
 
+static void connect_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
+}
 
 static void connect_p(int argc, const char **argv)
 {
@@ -282,6 +290,22 @@ static void connect_p(int argc, const char **argv)
 
 /* disconnect */
 
+/*
+ * This completion function will be used for several methods
+ * returning recently connected address
+ */
+static void connected_addr_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = last_addr;
+		*enum_func = enum_one_string;
+	}
+}
+
+/* Map completion to connected_addr_c */
+#define disconnect_c connected_addr_c
+
 static void disconnect_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -294,6 +318,9 @@ static void disconnect_p(int argc, const char **argv)
 
 /* create an audio connection */
 
+/* Map completion to connected_addr_c */
+#define connect_audio_c connected_addr_c
+
 static void connect_audio_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -306,6 +333,9 @@ static void connect_audio_p(int argc, const char **argv)
 
 /* close the audio connection */
 
+/* Map completion to connected_addr_c */
+#define disconnect_audio_c connected_addr_c
+
 static void disconnect_audio_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -336,6 +366,15 @@ static void stop_voice_recognition_p(int argc, const char **argv)
 
 /* volume control */
 
+static void volume_control_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = TYPE_ENUM(bthf_volume_type_t);
+		*enum_func = enum_defines;
+	}
+}
+
 static void volume_control_p(int argc, const char **argv)
 {
 	bthf_volume_type_t type;
@@ -362,6 +401,19 @@ static void volume_control_p(int argc, const char **argv)
 
 /* Combined device status change notification */
 
+static void device_status_notification_c(int argc, const char **argv,
+							enum_func *enum_func,
+							void **user)
+{
+	if (argc == 3) {
+		*user = TYPE_ENUM(bthf_network_state_t);
+		*enum_func = enum_defines;
+	} else if (argc == 4) {
+		*user = TYPE_ENUM(bthf_service_type_t);
+		*enum_func = enum_defines;
+	}
+}
+
 static void device_status_notification_p(int argc, const char **argv)
 {
 	bthf_network_state_t ntk_state;
@@ -420,6 +472,15 @@ static void cops_response_p(int argc, const char **argv)
 
 /* Response for CIND command */
 
+static void cind_response_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 6) {
+		*user = TYPE_ENUM(bthf_call_state_t);
+		*enum_func = enum_defines;
+	}
+}
+
 static void cind_response_p(int argc, const char **argv)
 {
 	int svc;
@@ -502,6 +563,15 @@ static void formatted_at_response_p(int argc, const char **argv)
 
 /* at_response */
 
+static void at_response_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = TYPE_ENUM(bthf_at_response_t);
+		*enum_func = enum_defines;
+	}
+}
+
 static void at_response_p(int argc, const char **argv)
 {
 	bthf_at_response_t response_code;
@@ -525,6 +595,27 @@ static void at_response_p(int argc, const char **argv)
 
 /* response for CLCC command */
 
+static void clcc_response_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 4) {
+		*user = TYPE_ENUM(bthf_call_direction_t);
+		*enum_func = enum_defines;
+	} else if (argc == 5) {
+		*user = TYPE_ENUM(bthf_call_state_t);
+		*enum_func = enum_defines;
+	} else if (argc == 6) {
+		*user = TYPE_ENUM(bthf_call_mode_t);
+		*enum_func = enum_defines;
+	} else if (argc == 7) {
+		*user = TYPE_ENUM(bthf_call_mpty_type_t);
+		*enum_func = enum_defines;
+	} else if (argc == 9) {
+		*user = TYPE_ENUM(bthf_call_addrtype_t);
+		*enum_func = enum_defines;
+	}
+}
+
 static void clcc_response_p(int argc, const char **argv)
 {
 	int index;
@@ -591,6 +682,19 @@ static void clcc_response_p(int argc, const char **argv)
 }
 
 /* phone state change */
+
+static void phone_state_change_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 5) {
+		*user = TYPE_ENUM(bthf_call_state_t);
+		*enum_func = enum_defines;
+	} else if (argc == 7) {
+		*user = TYPE_ENUM(bthf_call_addrtype_t);
+		*enum_func = enum_defines;
+	}
+}
+
 static void phone_state_change_p(int argc, const char **argv)
 {
 	int num_active;
@@ -652,23 +756,23 @@ static void cleanup_p(int argc, const char **argv)
 
 static struct method methods[] = {
 	STD_METHOD(init),
-	STD_METHODH(connect, "<addr>"),
-	STD_METHODH(disconnect, "<addr>"),
-	STD_METHODH(connect_audio, "<addr>"),
-	STD_METHODH(disconnect_audio, "<addr>"),
+	STD_METHODCH(connect, "<addr>"),
+	STD_METHODCH(disconnect, "<addr>"),
+	STD_METHODCH(connect_audio, "<addr>"),
+	STD_METHODCH(disconnect_audio, "<addr>"),
 	STD_METHOD(start_voice_recognition),
 	STD_METHOD(stop_voice_recognition),
-	STD_METHODH(volume_control, "<vol_type> <volume>"),
-	STD_METHODH(device_status_notification,
+	STD_METHODCH(volume_control, "<vol_type> <volume>"),
+	STD_METHODCH(device_status_notification,
 			"<ntk_state> <svt_type> <signal> <batt_chg>"),
 	STD_METHODH(cops_response, "<cops string>"),
-	STD_METHODH(cind_response,
+	STD_METHODCH(cind_response,
 			"<svc> <num_active> <num_held> <setup_state> <signal> <roam> <batt_chg>"),
 	STD_METHODH(formatted_at_response, "<at_response>"),
-	STD_METHODH(at_response, "<response_code> [<error_code>]"),
-	STD_METHODH(clcc_response,
+	STD_METHODCH(at_response, "<response_code> [<error_code>]"),
+	STD_METHODCH(clcc_response,
 			"<index> <direction> <state> <mode> <mpty> <number> <type>"),
-	STD_METHODH(phone_state_change,
+	STD_METHODCH(phone_state_change,
 			"<num_active> <num_held> <setup_state> <number> <type>"),
 	STD_METHOD(cleanup),
 	END_METHOD
-- 
1.7.9.5

