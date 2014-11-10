Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/5] android/client: Add support for new AVRCP CTRL interface
Date: Mon, 10 Nov 2014 16:05:08 +0200
Message-Id: <1415628309-7384-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-bt.c   |  2 ++
 android/client/if-main.h |  2 ++
 android/client/if-rc.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 48aff1b..50212fc 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -800,6 +800,8 @@ static void get_profile_interface_p(int argc, const char **argv)
 	else if (strcmp(BT_PROFILE_GATT_ID, id) == 0)
 		pif = (const void **) &if_gatt;
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	else if (strcmp(BT_PROFILE_AV_RC_CTRL_ID, id) == 0)
+		pif = (const void **) &if_rc_ctrl;
 	else if (strcmp(BT_PROFILE_HANDSFREE_CLIENT_ID, id) == 0)
 		pif = (const void **) &if_hf_client;
 	else if (strcmp(BT_PROFILE_MAP_CLIENT_ID, id) == 0)
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 93cc98d..96409aa 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -65,6 +65,7 @@ extern const btgatt_interface_t *if_gatt;
 extern const btgatt_server_interface_t *if_gatt_server;
 extern const btgatt_client_interface_t *if_gatt_client;
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+extern const btrc_ctrl_interface_t *if_rc_ctrl;
 extern const bthf_client_interface_t *if_hf_client;
 extern const btmce_interface_t *if_mce;
 #endif
@@ -92,6 +93,7 @@ extern const struct interface hf_if;
 extern const struct interface hh_if;
 extern const struct interface hl_if;
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+extern const struct interface ctrl_rc_if;
 extern const struct interface hf_client_if;
 extern const struct interface mce_if;
 #endif
diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index ed65600..b42b8c6 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -28,6 +28,10 @@
 
 const btrc_interface_t *if_rc = NULL;
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+const btrc_ctrl_interface_t *if_rc_ctrl = NULL;
+#endif
+
 SINTMAP(btrc_play_status_t, -1, "(unknown)")
 	DELEMENT(BTRC_PLAYSTATE_STOPPED),
 	DELEMENT(BTRC_PLAYSTATE_PLAYING),
@@ -398,3 +402,87 @@ const struct interface rc_if = {
 	.name = "rc",
 	.methods = methods
 };
+
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void passthrough_rsp_cb(int id, int key_state)
+{
+	haltest_info("%s: id=%d key_state=%d\n", __func__, id, key_state);
+}
+
+static void connection_state_cb(bool state, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
+					state ? "true" : "false",
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+
+static btrc_ctrl_callbacks_t rc_ctrl_cbacks = {
+	.size = sizeof(rc_ctrl_cbacks),
+	.passthrough_rsp_cb = passthrough_rsp_cb,
+	.connection_state_cb = connection_state_cb,
+};
+
+/* ctrl_init */
+
+static void ctrl_init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_rc_ctrl);
+
+	EXEC(if_rc_ctrl->init, &rc_ctrl_cbacks);
+}
+
+/* ctrl_cleanup */
+
+static void ctrl_cleanup_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_rc_ctrl);
+
+	EXECV(if_rc_ctrl->cleanup);
+	if_rc_ctrl = NULL;
+}
+
+/* send_pass_through_cmd */
+
+static void send_pass_through_cmd_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+}
+
+static void send_pass_through_cmd_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+	uint8_t key_code, key_state;
+
+	RETURN_IF_NULL(if_rc);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	if (argc <= 4) {
+		haltest_error("No key code specified");
+		return;
+	}
+
+	key_code = (uint8_t) atoi(argv[3]);
+
+	if (argc <= 5) {
+		haltest_error("No key state specified");
+		return;
+	}
+
+	key_state = (uint8_t) atoi(argv[4]);
+
+	EXEC(if_rc_ctrl->send_pass_through_cmd, &addr, key_code, key_state);
+}
+
+static struct method ctrl_methods[] = {
+	STD_METHOD(ctrl_init),
+	STD_METHODCH(send_pass_through_cmd,
+					"<bd_addr> <key_code> <key_state>"),
+	STD_METHOD(ctrl_cleanup),
+	END_METHOD
+};
+
+const struct interface ctrl_rc_if = {
+	.name = "rc-ctrl",
+	.methods = ctrl_methods
+};
+#endif
-- 
2.1.0

