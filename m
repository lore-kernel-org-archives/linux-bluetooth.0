Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 3/3] android: Add help to hidhost in haltest
Date: Tue, 22 Oct 2013 13:02:27 +0200
Message-ID: <1382439747-13864-4-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382439747-13864-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382439747-13864-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds help to methods of hidhost interface.
This also adds tab completion for hidhost.
---
 android/client/if-hh.c |   86 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/android/client/if-hh.c b/android/client/if-hh.c
index 09eaf9c..e23e4d5 100644
--- a/android/client/if-hh.c
+++ b/android/client/if-hh.c
@@ -68,6 +68,7 @@ SINTMAP(bthh_status_t, -1, "(unknown)")
 	DELEMENT(BTHH_ERR_HDL),
 ENDMAP
 
+static char connected_device_addr[MAX_ADDR_STR_LEN];
 /*
  * Callback for connection state change.
  * state will have one of the values from bthh_connection_state_t
@@ -80,6 +81,8 @@ static void connection_state_cb(bt_bdaddr_t *bd_addr,
 	haltest_info("%s: bd_addr=%s connection_state=%s\n", __func__,
 			bt_bdaddr_t2str(bd_addr, addr),
 					bthh_connection_state_t2str(state));
+	if (state == BTHH_CONN_STATE_CONNECTED)
+		strcpy(connected_device_addr, addr);
 }
 
 /*
@@ -104,7 +107,7 @@ static void hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 {
 	char addr[MAX_ADDR_STR_LEN];
 
-	/* TODO: print actual hid_info */
+	/* TODO: bluedroid does not seem to ever call this callback */
 	haltest_info("%s: bd_addr=%s\n", __func__,
 						bt_bdaddr_t2str(bd_addr, addr));
 }
@@ -174,6 +177,15 @@ static void init_p(int argc, const char **argv)
 
 /* connect */
 
+static void connect_c(int argc, const const char **argv,
+				enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = (void *) connected_device_addr;
+		*penum_func = enum_one_string;
+	}
+}
+
 static void connect_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -186,6 +198,9 @@ static void connect_p(int argc, const char **argv)
 
 /* disconnect */
 
+/* Same completion as connect_c */
+#define disconnect_c connect_c
+
 static void disconnect_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -198,6 +213,9 @@ static void disconnect_p(int argc, const char **argv)
 
 /* virtual_unplug */
 
+/* Same completion as connect_c */
+#define virtual_unplug_c connect_c
+
 static void virtual_unplug_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -217,13 +235,25 @@ static void set_info_p(int argc, const char **argv)
 
 	RETURN_IF_NULL(if_hh);
 	VERIFY_ADDR_ARG(2, &addr);
-	/* TODO: not implemented yet */
+	/* TODO: set_info does not seem to be called anywhere */
 
 	EXEC(if_hh->set_info, &addr, hid_info);
 }
 
 /* get_protocol */
 
+static void get_protocol_c(int argc, const const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = connected_device_addr;
+		*penum_func = enum_one_string;
+	} else if (argc == 4) {
+		*puser = TYPE_ENUM(bthh_protocol_mode_t);
+		*penum_func = enum_defines;
+	}
+}
+
 static void get_protocol_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -243,6 +273,9 @@ static void get_protocol_p(int argc, const char **argv)
 
 /* set_protocol */
 
+/* Same completion as get_protocol_c */
+#define set_protocol_c get_protocol_c
+
 static void set_protocol_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -262,6 +295,18 @@ static void set_protocol_p(int argc, const char **argv)
 
 /* get_report */
 
+static void get_report_c(int argc, const const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = connected_device_addr;
+		*penum_func = enum_one_string;
+	} else if (argc == 4) {
+		*puser = TYPE_ENUM(bthh_report_type_t);
+		*penum_func = enum_defines;
+	}
+}
+
 static void get_report_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -295,6 +340,18 @@ static void get_report_p(int argc, const char **argv)
 
 /* set_report */
 
+static void set_report_c(int argc, const const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = connected_device_addr;
+		*penum_func = enum_one_string;
+	} else if (argc == 4) {
+		*puser = TYPE_ENUM(bthh_report_type_t);
+		*penum_func = enum_defines;
+	}
+}
+
 static void set_report_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -319,6 +376,15 @@ static void set_report_p(int argc, const char **argv)
 
 /* send_data */
 
+static void send_data_c(int argc, const const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = connected_device_addr;
+		*penum_func = enum_one_string;
+	}
+}
+
 static void send_data_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -346,15 +412,15 @@ static void cleanup_p(int argc, const char **argv)
 /* Methods available in bthh_interface_t */
 static struct method methods[] = {
 	STD_METHOD(init),
-	STD_METHOD(connect),
-	STD_METHOD(disconnect),
-	STD_METHOD(virtual_unplug),
+	STD_METHODCH(connect, "<addr>"),
+	STD_METHODCH(disconnect, "<addr>"),
+	STD_METHODCH(virtual_unplug, "<addr>"),
 	STD_METHOD(set_info),
-	STD_METHOD(get_protocol),
-	STD_METHOD(set_protocol),
-	STD_METHOD(get_report),
-	STD_METHOD(set_report),
-	STD_METHOD(send_data),
+	STD_METHODCH(get_protocol, "<addr> <mode>"),
+	STD_METHODCH(set_protocol, "<addr> <mode>"),
+	STD_METHODCH(get_report, "<addr> <type> <report_id> <size>"),
+	STD_METHODCH(set_report, "<addr> <type> <hex_encoded_report>"),
+	STD_METHODCH(send_data, "<addr> <hex_encoded_data>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.7.9.5

