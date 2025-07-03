Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483B2D3A65
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533010; cv=none; b=go1doiDJ9QBR1/a1383Sh7ifc9MCgVaAHSYZc6GrUt5LqJXX0SNgcjn5mPxaBsa2t3gr6Df3048yNVkYfPDMXJQV3IJoO4zAf6Yoi3WG3NJPROSPILYsss1TKIKXd72zbtbIpetiZ05e7zPYgHhzAKJrZjCfp4YaOZJqhPTY8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533010; c=relaxed/simple;
	bh=qAclJkohbPyJh7ROMmadxrQMLtTxbcRjToGBpktHCTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfYx46ph2D95Osbr2OYePs6oX0rymsViymyrA5z3PStDsMrx5QBcoFqMHKLZH4JQ+xC8COlGtAy6dVyriGcz0lCDbWLJllZGarRETZz8RS7+/LKB2iHhuBodZLrTmf0GszmJzKjdUroZBUa60lKyrMwjrUeRlpkmh4yl4Hqo6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A61064317A;
	Thu,  3 Jul 2025 08:56:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 01/19] android: Fix typos
Date: Thu,  3 Jul 2025 10:53:09 +0200
Message-ID: <20250703085630.935452-2-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 android/a2dp.c                  |  6 +++---
 android/audio-ipc-api.txt       |  2 +-
 android/bluetoothd.te           |  2 +-
 android/client/haltest.c        |  4 ++--
 android/client/if-bt.c          | 16 ++++++++--------
 android/client/if-gatt.c        | 14 +++++++-------
 android/client/if-hl.c          |  2 +-
 android/gatt.c                  |  8 ++++----
 android/hal-audio.c             |  2 +-
 android/hal-ipc-api.txt         | 32 ++++++++++++++++----------------
 android/handsfree-client.c      |  8 ++++----
 android/hardware/audio_effect.h |  4 ++--
 android/hardware/bluetooth.h    |  2 +-
 android/hardware/bt_hf.h        |  2 +-
 android/hardware/bt_hh.h        |  8 ++++----
 android/hardware/bt_rc.h        |  6 +++---
 android/hardware/hardware.h     |  4 ++--
 android/health.c                |  4 ++--
 android/hidhost.c               |  6 +++---
 android/pics-avctp.txt          |  2 +-
 android/pics-avrcp.txt          |  2 +-
 android/pics-gap.txt            |  2 +-
 android/pics-opp.txt            |  4 ++--
 android/pts-gatt.txt            |  2 +-
 android/system-emulator.c       |  2 +-
 android/system/audio.h          |  4 ++--
 android/tester-gatt.c           |  2 +-
 android/tester-hidhost.c        |  2 +-
 android/tester-main.c           |  8 ++++----
 29 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index ee607a32dabe..8d0e4d62e10c 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -295,13 +295,13 @@ static int sbc_check_config(void *caps, uint8_t caps_len, void *conf,
 	}
 
 	if (config->max_bitpool < cap->min_bitpool) {
-		error("SBC: Invalid maximun bitpool (%u < %u)",
+		error("SBC: Invalid maximum bitpool (%u < %u)",
 					config->max_bitpool, cap->min_bitpool);
 		return -EINVAL;
 	}
 
 	if (config->min_bitpool > cap->max_bitpool) {
-		error("SBC: Invalid minimun bitpool (%u > %u)",
+		error("SBC: Invalid minimum bitpool (%u > %u)",
 					config->min_bitpool, cap->min_bitpool);
 		return -EINVAL;
 	}
@@ -375,7 +375,7 @@ static int aptx_check_config(void *caps, uint8_t caps_len, void *conf,
 	config = conf;
 
 	if (!(cap->frequency & config->frequency)) {
-		error("APTX: Unsupported frequenct (%u) by endpoint",
+		error("APTX: Unsupported frequency (%u) by endpoint",
 							config->frequency);
 		return -EINVAL;
 	}
diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
index f4a497dd8d5b..ba4d1c1c86d0 100644
--- a/android/audio-ipc-api.txt
+++ b/android/audio-ipc-api.txt
@@ -46,7 +46,7 @@ Audio Service (ID 0)
 
 		Response parameters: Status (1 octet)
 
-	Opcode 0x01 - Open Audio Endpoint commmand
+	Opcode 0x01 - Open Audio Endpoint command
 
 		Command parameters: Service UUID (16 octets)
 				    Codec ID (1 octet)
diff --git a/android/bluetoothd.te b/android/bluetoothd.te
index 532bfbb353ae..1ac719b62161 100644
--- a/android/bluetoothd.te
+++ b/android/bluetoothd.te
@@ -12,7 +12,7 @@ allow bluetoothd bluetooth_data_file:notdevfile_class_set create_file_perms;
 allow bluetoothd self:capability { setuid net_admin net_bind_service net_raw };
 allow bluetoothd kernel:system module_request;
 
-# TODO: this may be romoved for userbuild where we don't use bluetoothd_wrapper
+# TODO: this may be removed for userbuild where we don't use bluetoothd_wrapper
 allow bluetoothd bluetoothd_main_exec:file { execute execute_no_trans read open };
 
 # IPC socket communication
diff --git a/android/client/haltest.c b/android/client/haltest.c
index cb5f68833fe8..f1b3f7261c81 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -145,7 +145,7 @@ static void help_p(int argc, const char **argv)
 		}
 
 		terminal_print("\nTo get help on methods for each interface type:\n");
-		terminal_print("\n\thelp <inerface>\n");
+		terminal_print("\n\thelp <interface>\n");
 		terminal_print("\nBasic scenario:\n\tbluetooth init\n");
 		terminal_print("\tbluetooth enable\n\tbluetooth start_discovery\n");
 		terminal_print("\tbluetooth get_profile_interface handsfree\n");
@@ -217,7 +217,7 @@ static struct method commands[] = {
 	END_METHOD
 };
 
-/* Gets comman by name */
+/* Gets command by name */
 struct method *get_command(const char *name)
 {
 	return get_method(commands, name);
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 68001a15132e..978834ebefc4 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -65,7 +65,7 @@ static void dump_properties(int num_properties, bt_property_t *properties)
 
 	for (i = 0; i < num_properties; i++) {
 		/*
-		 * properities sometimes come unaligned hence memcp to
+		 * properties sometimes come unaligned hence memcp to
 		 * aligned buffer
 		 */
 		bt_property_t prop;
@@ -152,7 +152,7 @@ static void add_remote_device_from_props(int num_properties,
 
 	for (i = 0; i < num_properties; i++) {
 		/*
-		 * properities sometimes come unaligned hence memcp to
+		 * properties sometimes come unaligned hence memcp to
 		 * aligned buffer
 		 */
 		bt_property_t property;
@@ -216,7 +216,7 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 }
 
 /*
- * Buffer for remote addres that came from one of bind request.
+ * Buffer for remote address that came from one of bind request.
  * It's stored for command completion.
  */
 static char last_remote_addr[MAX_ADDR_STR_LEN];
@@ -595,7 +595,7 @@ static void complete_addr_c(int argc, const char **argv, enum_func *enum_func,
 	}
 }
 
-/* Just addres to complete, use complete_addr_c */
+/* Just address to complete, use complete_addr_c */
 #define get_remote_device_properties_c complete_addr_c
 
 static void get_remote_device_properties_p(int argc, const char **argv)
@@ -696,7 +696,7 @@ static void get_remote_service_record_p(int argc, const char **argv)
 	EXEC(if_bluetooth->get_remote_service_record, &addr, &uuid);
 }
 
-/* Just addres to complete, use complete_addr_c */
+/* Just address to complete, use complete_addr_c */
 #define get_remote_services_c complete_addr_c
 
 static void get_remote_services_p(int argc, const char **argv)
@@ -723,7 +723,7 @@ static void cancel_discovery_p(int argc, const char **argv)
 	EXEC(if_bluetooth->cancel_discovery);
 }
 
-/* Just addres to complete, use complete_addr_c */
+/* Just address to complete, use complete_addr_c */
 #define create_bond_c complete_addr_c
 
 static void create_bond_p(int argc, const char **argv)
@@ -748,7 +748,7 @@ static void create_bond_p(int argc, const char **argv)
 #endif
 }
 
-/* Just addres to complete, use complete_addr_c */
+/* Just address to complete, use complete_addr_c */
 #define remove_bond_c complete_addr_c
 
 static void remove_bond_p(int argc, const char **argv)
@@ -761,7 +761,7 @@ static void remove_bond_p(int argc, const char **argv)
 	EXEC(if_bluetooth->remove_bond, &addr);
 }
 
-/* Just addres to complete, use complete_addr_c */
+/* Just address to complete, use complete_addr_c */
 #define cancel_bond_c complete_addr_c
 
 static void cancel_bond_p(int argc, const char **argv)
diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index d00afffcb5ce..89a48171cf09 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -89,7 +89,7 @@ const btgatt_interface_t *if_gatt = NULL;
 						"No min interval specified\n")
 #define VERIFY_MAX_INTERVAL(n, v) VERIFY_INT_ARG(n, v, \
 						"No max interval specified\n")
-#define VERIFY_APPEARANCE(n, v) VERIFY_INT_ARG(n, v, "No apperance specified\n")
+#define VERIFY_APPEARANCE(n, v) VERIFY_INT_ARG(n, v, "No appearance specified\n")
 #define VERIFY_MANUFACTURER_LEN(n, v) VERIFY_INT_ARG(n, v, \
 					"No manufacturer len specified\n")
 #define VERIFY_SERVICE_DATA_LEN(n, v) VERIFY_INT_ARG(n, v, \
@@ -311,7 +311,7 @@ static void gatt_str2bt_uuid_t(const char *str, int len, bt_uuid_t *uuid)
 	}
 }
 
-/* char_id formating function */
+/* char_id formatting function */
 static char *btgatt_gatt_id_t2str(const btgatt_gatt_id_t *char_id, char *buf)
 {
 	char uuid_buf[MAX_UUID_STR_LEN];
@@ -346,7 +346,7 @@ static void str2btgatt_gatt_id_t(const char *buf, btgatt_gatt_id_t *char_id)
 	}
 }
 
-/* service_id formating function */
+/* service_id formatting function */
 static char *btgatt_srvc_id_t2str(const btgatt_srvc_id_t *srvc_id, char *buf)
 {
 	char uuid_buf[MAX_UUID_STR_LEN];
@@ -653,7 +653,7 @@ static void gattc_read_remote_rssi_cb(int client_if, bt_bdaddr_t *bda, int rssi,
 {
 	char buf[MAX_ADDR_STR_LEN];
 
-	haltest_info("%s: client_if=%d bda=%s rssi=%d satus=%d\n", __func__,
+	haltest_info("%s: client_if=%d bda=%s rssi=%d status=%d\n", __func__,
 			client_if, bt_bdaddr_t2str(bda, buf), rssi, status);
 }
 
@@ -1413,7 +1413,7 @@ static void write_characteristic_c(int argc, const char **argv,
 					enum_func *enum_func, void **user)
 {
 	/*
-	 * This should be from tGATT_WRITE_TYPE but it's burried
+	 * This should be from tGATT_WRITE_TYPE but it's buried
 	 * inside bluedroid guts
 	 */
 	static const char *wrtypes[] = { "1", "2", "3", NULL };
@@ -1492,7 +1492,7 @@ static void write_descriptor_c(int argc, const char **argv,
 					enum_func *enum_func, void **user)
 {
 	/*
-	 * This should be from tGATT_WRITE_TYPE but it's burried
+	 * This should be from tGATT_WRITE_TYPE but it's buried
 	 * inside bluedroid guts
 	 */
 	static const char *wrtypes[] = { "1", "2", "3", NULL };
@@ -2646,7 +2646,7 @@ static struct method server_methods[] = {
 	GATTS_METHODCH(add_included_service,
 			"<server_if> <service_handle> <included_handle>"),
 	GATTS_METHODCH(add_characteristic,
-		"<server_if> <service_handle> <uuid> <properites> <permissions>"),
+		"<server_if> <service_handle> <uuid> <properties> <permissions>"),
 	GATTS_METHODCH(add_descriptor,
 			"<server_if> <service_handle> <uuid> <permissions>"),
 	GATTS_METHODCH(start_service,
diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 826c81750478..90a4a1fab4a7 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -173,7 +173,7 @@ static void register_application_p(int argc, const char **argv)
 	memset(&reg, 0, sizeof(reg));
 
 	if (argc != ((atoi(argv[6]) * 4) + 7)) {
-		haltest_error("mdep cfg argumetns are not proper\n");
+		haltest_error("mdep cfg arguments are not proper\n");
 		return;
 	}
 
diff --git a/android/gatt.c b/android/gatt.c
index 89fcdb114429..aba88fcf8c87 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3500,7 +3500,7 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	DBG("");
 
 	if (len != sizeof(*cmd) + cmd->len) {
-		error("Invalid write desriptor command (%u bytes), terminating",
+		error("Invalid write descriptor command (%u bytes), terminating",
 									len);
 		raise(SIGTERM);
 		return;
@@ -4742,7 +4742,7 @@ static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 
 	app = find_app_by_id(app_id);
 	if (!app) {
-		error("gatt: read_cb, cound not found app id");
+		error("gatt: read_cb, could not found app id");
 		goto failed;
 	}
 
@@ -4753,7 +4753,7 @@ static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 
 	conn = find_conn(&bdaddr, app->id);
 	if (!conn) {
-		error("gatt: read_cb, cound not found connection");
+		error("gatt: read_cb, could not found connection");
 		goto failed;
 	}
 
@@ -6433,7 +6433,7 @@ static void write_confirm(struct gatt_db_attribute *attrib,
 	if (!err)
 		return;
 
-	error("Error writting attribute %p", attrib);
+	error("Error writing attribute %p", attrib);
 }
 
 static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-audio.c b/android/hal-audio.c
index f3d9b40a62fe..f9169bf289db 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -500,7 +500,7 @@ static bool open_endpoint(struct audio_endpoint **epp,
 		}
 
 	if (!ep) {
-		error("Cound not find opened endpoint");
+		error("Could not find opened endpoint");
 		goto failed;
 	}
 
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e3b7798b3d26..3c41e9871db6 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1162,7 +1162,7 @@ Commands and responses:
 		                    Data type (2 octets)
 		                    Channel type (1 octet)
 		                    MDEP description length (2 octets)
-		                    MDEP description (MDEP desciption length)
+		                    MDEP description (MDEP description length)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
@@ -1827,7 +1827,7 @@ Commands and responses:
 		                    Transaction ID (4 octets)
 		                    Handle (2 octets)
 		                    Offset (2 octets)
-		                    Auth Request (1 octect)
+		                    Auth Request (1 octet)
 		                    Status (4 octets)
 		                    GATT Response (4 octets)
 		Response parameters: <none>
@@ -2352,14 +2352,14 @@ Commands and response:
 
 	Opcode 0x00 - Error response
 
-	Opcode 0x01 - Connect command/respose
+	Opcode 0x01 - Connect command/response
 
-		Command parameters: Remote address (6 octects)
+		Command parameters: Remote address (6 octets)
 		Response parameters: <none>
 
 		 In case of an error, the error response will be returned.
 
-	Opcode 0x02 - Disonnect command/response
+	Opcode 0x02 - Disconnect command/response
 
 		Command parameters: Remote address (6 octetcs)
 		Response parameters: <none>
@@ -2440,7 +2440,7 @@ Commands and response:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x11 - Query Current Calls commad/response
+	Opcode 0x11 - Query Current Calls command/response
 
 		Command parameters: <none>
 		Response parameters: <none>
@@ -2512,7 +2512,7 @@ Notifications:
 			1	Release active calls and accept other call
 			2	Release specified active call only
 			3	Place all active calls on hold and accept other call
-			4	Request private mode with secified call
+			4	Request private mode with specified call
 			5	Add a held call to the multiparty
 			6	Connect two calls and leave multiparty
 			7-31	Reserved for future use
@@ -2563,7 +2563,7 @@ Notifications:
 
 		Notification parameters: Name (string)
 
-	Opcode 0x89 - Call Indicatior notification
+	Opcode 0x89 - Call Indicator notification
 
 		Notification parameters: Call (1 octet)
 
@@ -2587,7 +2587,7 @@ Notifications:
 		                        0x01 = Hold and Active
 					0x02 = Hold
 
-	Opcode 0x8c - Resposne and Hold Status notification
+	Opcode 0x8c - Response and Hold Status notification
 
 		Notification parameters: Status (1 octet)
 
@@ -2617,13 +2617,13 @@ Notifications:
 		Valid Direction values: 0x00 = Outgoing
 		                        0x01 = Incoming
 
-		Valid Call Sate values: 0x00 = Active
-		                        0x01 = Held
-		                        0x02 = Dialing
-		                        0x03 = Alerting
-		                        0x04 = Incoming
-		                        0x05 = Waiting
-		                        0x06 = Call held by Response and Hold
+		Valid Call State values: 0x00 = Active
+		                         0x01 = Held
+		                         0x02 = Dialing
+		                         0x03 = Alerting
+		                         0x04 = Incoming
+		                         0x05 = Waiting
+		                         0x06 = Call held by Response and Hold
 
 		Valid Multiparty values: 0x00 = Single Call
 		                         0x01 = Multiparty (conference) Call
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index c8f9e690eaa7..31be27fc3247 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -1308,7 +1308,7 @@ static void slc_cind_status_resp(enum hfp_result result,
 	/* Continue with SLC creation */
 	if (!hfp_hf_send_command(dev->hf, slc_cmer_resp, dev,
 							"AT+CMER=3,0,0,1")) {
-		error("hf-client: Counld not send AT+CMER");
+		error("hf-client: Could not send AT+CMER");
 		goto failed;
 	}
 
@@ -1335,13 +1335,13 @@ static void slc_cind_resp(enum hfp_result result, enum hfp_error cme_err,
 	/* Continue with SLC creation */
 	if (!hfp_hf_register(dev->hf, slc_cind_status_cb, "+CIND", dev,
 								NULL)) {
-		error("hf-client: Counld not register +CIND");
+		error("hf-client: Could not register +CIND");
 		goto failed;
 	}
 
 	if (!hfp_hf_send_command(dev->hf, slc_cind_status_resp, dev,
 								"AT+CIND?")) {
-		error("hf-client: Counld not send AT+CIND?");
+		error("hf-client: Could not send AT+CIND?");
 		goto failed;
 	}
 
@@ -1886,7 +1886,7 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 	}
 
 	if (dev->state != HAL_HF_CLIENT_CONN_STATE_DISCONNECTED) {
-		/* TODO: Handle colision */
+		/* TODO: Handle collision */
 		error("hf-client: Connections is up or ongoing ?");
 		goto drop;
 	}
diff --git a/android/hardware/audio_effect.h b/android/hardware/audio_effect.h
index 2c63f1ccf4ca..1f9b5463376a 100644
--- a/android/hardware/audio_effect.h
+++ b/android/hardware/audio_effect.h
@@ -63,7 +63,7 @@ typedef struct effect_descriptor_s {
     uint16_t cpuLoad;       // CPU load indication (see below)
     uint16_t memoryUsage;   // Data Memory usage (see below)
     char    name[EFFECT_STRING_LEN_MAX];   // human readable effect name
-    char    implementor[EFFECT_STRING_LEN_MAX];    // human readable effect implementor name
+    char    implementor[EFFECT_STRING_LEN_MAX];    // human readable effect implementer name
 } effect_descriptor_t;
 
 // CPU load and memory usage indication: each effect implementation must provide an indication of
@@ -911,7 +911,7 @@ typedef struct audio_effect_library_s {
     uint32_t version;
     // Name of this library
     const char *name;
-    // Author/owner/implementor of the library
+    // Author/owner/implementer of the library
     const char *implementor;
 
     ////////////////////////////////////////////////////////////////////////////////
diff --git a/android/hardware/bluetooth.h b/android/hardware/bluetooth.h
index 21253e00ab91..0808a11fc053 100644
--- a/android/hardware/bluetooth.h
+++ b/android/hardware/bluetooth.h
@@ -420,7 +420,7 @@ typedef struct {
     size_t size;
     /**
      * Opens the interface and provides the callback routines
-     * to the implemenation of this interface.
+     * to the implementation of this interface.
      */
     int (*init)(bt_callbacks_t* callbacks );
 
diff --git a/android/hardware/bt_hf.h b/android/hardware/bt_hf.h
index c3f952415c25..6cc37ed89128 100644
--- a/android/hardware/bt_hf.h
+++ b/android/hardware/bt_hf.h
@@ -282,7 +282,7 @@ typedef struct {
     /** Closes the interface. */
     void  (*cleanup)( void );
 
-    /** configureation for the SCO codec */
+    /** configuration for the SCO codec */
     bt_status_t (*configure_wbs)( bt_bdaddr_t *bd_addr ,bthf_wbs_config_t config );
 } bthf_interface_t;
 
diff --git a/android/hardware/bt_hh.h b/android/hardware/bt_hh.h
index 2dd61beacaf2..51bb75ae5c6f 100644
--- a/android/hardware/bt_hh.h
+++ b/android/hardware/bt_hh.h
@@ -34,7 +34,7 @@ typedef enum
     BTHH_HS_HID_NOT_READY,        /* handshake error : device not ready */
     BTHH_HS_INVALID_RPT_ID,       /* handshake error : invalid report ID */
     BTHH_HS_TRANS_NOT_SPT,        /* handshake error : transaction not spt */
-    BTHH_HS_INVALID_PARAM,        /* handshake error : invalid paremter */
+    BTHH_HS_INVALID_PARAM,        /* handshake error : invalid parameter */
     BTHH_HS_ERROR,                /* handshake error : unspecified HS error */
     BTHH_ERR,                     /* general BTA HH error */
     BTHH_ERR_SDP,                 /* SDP error */
@@ -79,8 +79,8 @@ typedef struct
  */
 typedef void (* bthh_connection_state_callback)(bt_bdaddr_t *bd_addr, bthh_connection_state_t state);
 
-/** Callback for vitual unplug api.
- *  the status of the vitual unplug
+/** Callback for virtual unplug api.
+ *  the status of the virtual unplug
  */
 typedef void (* bthh_virtual_unplug_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status);
 
@@ -100,7 +100,7 @@ typedef void (* bthh_idle_time_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_
 
 
 /** Callback for get report api.
- *  if staus is ok rpt_data contains the report data
+ *  if status is ok rpt_data contains the report data
  */
 typedef void (* bthh_get_report_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status, uint8_t* rpt_data, int rpt_size);
 
diff --git a/android/hardware/bt_rc.h b/android/hardware/bt_rc.h
index c1290aeb1f59..1b34fa734519 100644
--- a/android/hardware/bt_rc.h
+++ b/android/hardware/bt_rc.h
@@ -111,7 +111,7 @@ typedef struct {
     uint8_t text[BTRC_MAX_ATTR_STR_LEN];
 } btrc_element_attr_val_t;
 
-/** Callback for the controller's supported feautres */
+/** Callback for the controller's supported features */
 typedef void (* btrc_remote_features_callback)(bt_bdaddr_t *bd_addr,
                                                       btrc_remote_features_t features);
 
@@ -189,7 +189,7 @@ typedef struct {
      */
     bt_status_t (*init)( btrc_callbacks_t* callbacks );
 
-    /** Respose to GetPlayStatus request. Contains the current
+    /** Response to GetPlayStatus request. Contains the current
     **  1. Play status
     **  2. Song duration/length
     **  3. Song position
@@ -243,7 +243,7 @@ typedef struct {
     /**Send current volume setting to remote side. Support limited to SetAbsoluteVolume
     ** This can be enhanced to support Relative Volume (AVRCP 1.0).
     ** With RelateVolume, we will send VOLUME_UP/VOLUME_DOWN opposed to absolute volume level
-    ** volume: Should be in the range 0-127. bit7 is reseved and cannot be set
+    ** volume: Should be in the range 0-127. bit7 is reserved and cannot be set
     */
     bt_status_t (*set_volume)(uint8_t volume);
 
diff --git a/android/hardware/hardware.h b/android/hardware/hardware.h
index 74470a31a41e..dc55b73b3264 100644
--- a/android/hardware/hardware.h
+++ b/android/hardware/hardware.h
@@ -44,7 +44,7 @@ __BEGIN_DECLS
 #define HARDWARE_HAL_API_VERSION HARDWARE_MAKE_API_VERSION(1, 0)
 
 /*
- * Helper macros for module implementors.
+ * Helper macros for module implementers.
  *
  * The derived modules should provide convenience macros for supported
  * versions so that implementations can explicitly specify module/device
@@ -122,7 +122,7 @@ typedef struct hw_module_t {
     /** Name of this module */
     const char *name;
 
-    /** Author/owner/implementor of the module */
+    /** Author/owner/implementer of the module */
     const char *author;
 
     /** Modules methods */
diff --git a/android/health.c b/android/health.c
index 9a29964b1be2..39cf3748e36a 100644
--- a/android/health.c
+++ b/android/health.c
@@ -948,7 +948,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 	 * register with different role and different configurations.
 	 * 1) Does device supports SOURCE and SINK at the same time ?
 	 * 2) Does it require different SDP records or one record with
-	 *    multile MDEP configurations ?
+	 *    multiple MDEP configurations ?
 	 */
 	if (update_sdp_record(app) < 0) {
 		error("health: HDP SDP record preparation failed");
@@ -1221,7 +1221,7 @@ static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 
 static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 {
-	DBG("Not Implemeneted");
+	DBG("Not Implemented");
 }
 
 static struct health_device *create_device(struct health_app *app,
diff --git a/android/hidhost.c b/android/hidhost.c
index 598bec326ca8..2e88f8c7292e 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -357,7 +357,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	}
 
 	/*
-	 * Report porotocol mode reply contains id after hdr, in boot
+	 * Report protocol mode reply contains id after hdr, in boot
 	 * protocol mode id doesn't exist
 	 */
 	ev_len += (dev->boot_dev) ? (len - 1) : (len - 2);
@@ -366,7 +366,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	bdaddr2android(&dev->dst, ev->bdaddr);
 
 	/*
-	 * Report porotocol mode reply contains id after hdr, in boot
+	 * Report protocol mode reply contains id after hdr, in boot
 	 * protocol mode id doesn't exist
 	 */
 	if (dev->boot_dev) {
@@ -1043,7 +1043,7 @@ static void bt_hid_info(const void *buf, uint16_t len)
 	}
 
 	/*
-	 * Data from hal_cmd_hidhost_set_info is usefull only when we create
+	 * Data from hal_cmd_hidhost_set_info is useful only when we create
 	 * UHID device. Once device is created all the transactions will be
 	 * done through the fd. There is no way to use this information
 	 * once device is created with HID internals.
diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
index 34479623c9f0..1262feed8422 100644
--- a/android/pics-avctp.txt
+++ b/android/pics-avctp.txt
@@ -41,7 +41,7 @@ TSPC_AVCTP_2_2	True		Transaction label management (M)
 TSPC_AVCTP_2_3	True		Packet type field management (M)
 TSPC_AVCTP_2_4	True		Message type field management (M)
 TSPC_AVCTP_2_5	True		PID field management (M)
-TSPC_AVCTP_2_6	True		IPID field mangement (M)
+TSPC_AVCTP_2_6	True		IPID field management (M)
 TSPC_AVCTP_2_7	True		Message information management (M)
 TSPC_AVCTP_2_8	False		Event registration for message reception (O)
 TSPC_AVCTP_2_9	False		Event registration for connection request (O)
diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
index 7bd68fa77213..f6ab74d88c32 100644
--- a/android/pics-avrcp.txt
+++ b/android/pics-avrcp.txt
@@ -617,7 +617,7 @@ TSPC_AVRCP_11_24  False		TG: category 4 - Operation id: 9 (O)
 TSPC_AVRCP_11_25  False		TG: category 4 - Operation id: dot (O)
 TSPC_AVRCP_11_26  False		TG: category 4 - Operation id: enter (O)
 TSPC_AVRCP_11_27  False		TG: category 4 - Operation id: clear (O)
-TSPC_AVRCP_11_28  False		TG: category 4 - Operation id: disply (O)
+TSPC_AVRCP_11_28  False		TG: category 4 - Operation id: display (O)
 TSPC_AVRCP_11_29  False		TG: category 4 - Operation id: help (O)
 TSPC_AVRCP_11_30  False		TG: category 4 - Operation id: page up (O)
 TSPC_AVRCP_11_31  False		TG: category 4 - Operation id: page down (O)
diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index 37759955f8a4..a96984a4873d 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -101,7 +101,7 @@ C.2: Excluded if TSPC_GAP_2_7 is supported, otherwise Optional.
 C.5: Mandatory If (TSPC_GAP_2_5 or TSPC_GAP_2_6 or TSPC_GAP_2_7) is supported,
 	otherwise Optional.
 C.4: Mandatory if (Core Spec 2.1 or later) is supported, otherwise Excluded.
-Note 2. If a Core 2.0 and earlier design claims to support secure communcation
+Note 2. If a Core 2.0 and earlier design claims to support secure communication
 	it should support either Security mode 2 or 3.
 Note 3. A Core 2.1 or later device shall always support secure communication
 	in Security Mode 4, and shall use that mode to connect with another
diff --git a/android/pics-opp.txt b/android/pics-opp.txt
index 145198d487fa..846d6f68fc00 100644
--- a/android/pics-opp.txt
+++ b/android/pics-opp.txt
@@ -75,7 +75,7 @@ TSPC_OPP_2_14	False		Client: vCard 2.1 (C.1)
 TSPC_OPP_2_15	False		Client: Exchange business card (O)
 TSPC_OPP_2_16	False		Client: vCard 2.1 (C.2)
 TSPC_OPP_2_17	False		GOEP v2 (C.9)
-TSPC_OPP_2_18	False		GOEP v2 Backward Compability (C.9)
+TSPC_OPP_2_18	False		GOEP v2 Backward Compatibility (C.9)
 TSPC_OPP_2_19	False		OBEX over L2CAP (C.9)
 TSPC_OPP_2_20	False		OBEX Reliable Session (C.10)
 TSPC_OPP_2_21	False		OBEX SRM (C.10)
@@ -147,7 +147,7 @@ TSPC_OPP_3_16	False		Server: Business card exchange (O.2)
 TSPC_OPP_3_17	False		Server: vCard 2.1 (C.2)
 TSPC_OPP_3_18	False		Server: Business card exchange reject. (O)
 TSPC_OPP_3_19	False		GOEP v2 (C.5)
-TSPC_OPP_3_20	False		GOEP v2 Backward Compability (C.5)
+TSPC_OPP_3_20	False		GOEP v2 Backward Compatibility (C.5)
 TSPC_OPP_3_21	False		OBEX over L2CAP (C.5)
 TSPC_OPP_3_22	False		OBEX Reliable Session (C.16)
 TSPC_OPP_3_23	False		OBEX SRM (C.6)
diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 3531ccae9e7c..04c7ebe721ae 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -925,7 +925,7 @@ TC_GAW_SR_BV_01_C	PASS	haltest:
 TC_GAW_SR_BV_02_C	PASS	haltest:
 				gatts add service
 				gatts add_characteristics:
-					<properties> 66 <permisions> 145
+					<properties> 66 <permissions> 145
 				gatts start_service
 				gattc listen
 				gatts send_response: (twice)
diff --git a/android/system-emulator.c b/android/system-emulator.c
index 50bb088d3188..48423b842d5e 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -137,7 +137,7 @@ static void snoop_start(void)
 
 static void snoop_stop(void)
 {
-	printf("Stoping %s/%s\n", exec_dir, "bluetoothd-snoop");
+	printf("Stopping %s/%s\n", exec_dir, "bluetoothd-snoop");
 
 	kill(snoop_pid, SIGTERM);
 }
diff --git a/android/system/audio.h b/android/system/audio.h
index 0c5af5e8404a..337866264f99 100644
--- a/android/system/audio.h
+++ b/android/system/audio.h
@@ -224,8 +224,8 @@ typedef enum {
  * The main format indicates the main codec type. The sub format field
  * indicates options and parameters for each format. The sub format is mainly
  * used for record to indicate for instance the requested bitrate or profile.
- * It can also be used for certain formats to give informations not present in
- * the encoded audio stream (e.g. octet alignement for AMR).
+ * It can also be used for certain formats to give information not present in
+ * the encoded audio stream (e.g. octet alignment for AMR).
  */
 typedef enum {
     AUDIO_FORMAT_INVALID             = 0xFFFFFFFFUL,
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 30db7684d66e..42006bbc003a 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -3582,7 +3582,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-	/* This tests embeded ccc */
+	/* This tests embedded ccc */
 	TEST_CASE_BREDRLE("Gatt Server - Srvc change write req. success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index f9daf559067a..53a5d778775c 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -241,7 +241,7 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 		hid_prepare_reply_report(cid_data);
 		break;
 	/*
-	 * HID device doesnot reply for this commads, so reaching pdu's
+	 * HID device doesn't reply for this commands, so reaching pdu's
 	 * to hid device means assuming test passed
 	 */
 	case HID_SET_INPUT_REPORT:
diff --git a/android/tester-main.c b/android/tester-main.c
index 361c519ef5a3..6e635b77d3e9 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -498,20 +498,20 @@ static bool match_mas_inst(btmce_mas_instance_t *exp_inst,
 				btmce_mas_instance_t *rec_inst, int inst_num)
 {
 	if (exp_inst->id && (exp_inst->id != rec_inst->id)) {
-		tester_debug("MAS inst. [%d] id missmatch %d vs %d", inst_num,
+		tester_debug("MAS inst. [%d] id mismatch %d vs %d", inst_num,
 						rec_inst->id, exp_inst->id);
 		return 0;
 	}
 
 	if (exp_inst->scn && (exp_inst->scn != rec_inst->scn)) {
-		tester_debug("MAS inst. [%d] scn missmatch %d vs %d", inst_num,
+		tester_debug("MAS inst. [%d] scn mismatch %d vs %d", inst_num,
 						rec_inst->scn, exp_inst->scn);
 		return 0;
 	}
 
 	if (exp_inst->msg_types &&
 			(exp_inst->msg_types != rec_inst->msg_types)) {
-		tester_debug("Mas inst. [%d] mesg type missmatch %d vs %d",
+		tester_debug("Mas inst. [%d] mesg type mismatch %d vs %d",
 					inst_num, rec_inst->scn, exp_inst->scn);
 		return 0;
 	}
@@ -614,7 +614,7 @@ static bool match_data(struct step *step)
 	exp = queue_peek_head(data->steps);
 
 	if (!exp) {
-		/* Can occure while test passed already */
+		/* Can occur while test passed already */
 		tester_debug("Cannot get step to match");
 		return false;
 	}
-- 
2.50.0

