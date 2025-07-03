Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253A2D3A6F
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533015; cv=none; b=beMNreQVvg7T9/2Z0vGpxu31pgtELgNcrNLMjZbpJxVyD6au15g0aPrR45OSsS/MpXU8SbEe2diq5/TJ+1IVZXlbYENzcE1Clbv6R0wuIf5HnLMpZh0m3p5IHmp6uhwxlltNyHJTFtRImaD09hPtCdc/+5z9pVimA/ir5v+jiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533015; c=relaxed/simple;
	bh=dSZg4Np4v+uOsSupDTED9/lxnHYKMM1MSwSlYf9w2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA8gfaDw4JkiM6S9T/rSn0Ison6N1chcLqsvFYcITkHPMfwERq7SwxAqptU/8hl0UmI8K/vdx/OxiBE5swv/EY4gQZ1TLeccc9t2bMQduJ82IwHzctlOEpR+jb0pSAs2LbF/AR9OhlFOL8/3U1AnB1dgPgSIiQRfN2p+svKvKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BDC44323C;
	Thu,  3 Jul 2025 08:56:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 19/19] tools: Fix typos
Date: Thu,  3 Jul 2025 10:53:27 +0200
Message-ID: <20250703085630.935452-20-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth

Found using codespell.
---
 tools/avtest.c             |  2 +-
 tools/bneptest.c           |  2 +-
 tools/btattach.rst         |  2 +-
 tools/btgatt-client.c      |  4 ++--
 tools/btgatt-server.c      |  2 +-
 tools/btpclient.c          | 18 +++++++++---------
 tools/btpclientctl.c       |  2 +-
 tools/ciptool.c            |  2 +-
 tools/hciattach_ath3k.c    |  2 +-
 tools/hciconfig.rst        |  2 +-
 tools/l2cap-tester.c       |  4 ++--
 tools/l2test.c             |  6 +++---
 tools/mesh-cfgclient.c     |  2 +-
 tools/mesh-gatt/mesh-net.h |  2 +-
 tools/mesh-gatt/node.c     |  2 +-
 tools/mesh-gatt/prov.c     |  4 ++--
 tools/meshctl.c            |  2 +-
 tools/mgmt-tester.c        | 10 +++++-----
 tools/parser/att.c         |  2 +-
 tools/parser/avrcp.c       | 12 ++++++------
 tools/parser/hci.c         |  6 +++---
 tools/parser/l2cap.c       |  2 +-
 tools/parser/parser.h      |  2 +-
 tools/parser/rfcomm.h      |  4 ++--
 tools/parser/smp.c         |  4 ++--
 tools/rctest.c             |  6 +++---
 26 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/avtest.c b/tools/avtest.c
index a52662d80e11..c68d7b5a3e3f 100644
--- a/tools/avtest.c
+++ b/tools/avtest.c
@@ -258,7 +258,7 @@ static void process_avdtp(int srv_sk, int sk, unsigned char reject,
 			if (reject == AVDTP_GET_CAPABILITIES) {
 				hdr->message_type = AVDTP_MSG_TYPE_REJECT;
 				buf[2] = 0x29; /* Unsupported configuration */
-				printf("Rejecting get capabilties command\n");
+				printf("Rejecting get capabilities command\n");
 				len = write(sk, buf, 3);
 			} else if (fragment) {
 				struct avdtp_start_header *start = (void *) buf;
diff --git a/tools/bneptest.c b/tools/bneptest.c
index 76ec1cfcd477..c0c123f63614 100644
--- a/tools/bneptest.c
+++ b/tools/bneptest.c
@@ -502,7 +502,7 @@ static void usage(void)
 	printf("Connect Mode:\n"
 		"\t-c connect <dst_addr>\n"
 		"\t-r remote role <16 bit svc value>\n"
-		"\t-l local role <16 bit svc valu>\n");
+		"\t-l local role <16 bit svc value>\n");
 	printf("Listen Mode:\n"
 		"\t-s start server listening\n");
 	printf("Send control command:\n"
diff --git a/tools/btattach.rst b/tools/btattach.rst
index e51772ea4d9e..b7ae09a11931 100644
--- a/tools/btattach.rst
+++ b/tools/btattach.rst
@@ -60,7 +60,7 @@ OPTIONS
 
    * - qca
 
--S baudrate, --speed baudrate       Specify wich baudrate to use
+-S baudrate, --speed baudrate       Specify which baudrate to use
 
 -N, --noflowctl            Disable flow control
 
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index b47914da3d44..f64d5bcf2d56 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -93,7 +93,7 @@ static const char *ecode_to_string(uint8_t ecode)
 	case BT_ATT_ERROR_ATTRIBUTE_NOT_LONG:
 		return "Attribute Not Long";
 	case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE:
-		return "Insuficient Encryption Key Size";
+		return "Insufficient Encryption Key Size";
 	case BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN:
 		return "Invalid Attribute value len";
 	case BT_ATT_ERROR_UNLIKELY:
@@ -178,7 +178,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 
 	cli->att = bt_att_new(fd, false);
 	if (!cli->att) {
-		fprintf(stderr, "Failed to initialze ATT transport layer\n");
+		fprintf(stderr, "Failed to initialize ATT transport layer\n");
 		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 90a6c9b0a2cd..9d05abd900c9 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -547,7 +547,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 
 	server->att = bt_att_new(fd, false);
 	if (!server->att) {
-		fprintf(stderr, "Failed to initialze ATT transport layer\n");
+		fprintf(stderr, "Failed to initialize ATT transport layer\n");
 		goto fail;
 	}
 
diff --git a/tools/btpclient.c b/tools/btpclient.c
index 055270edb51b..5223c6c2e4b5 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -465,7 +465,7 @@ static void unreg_advertising_reply(struct l_dbus_proxy *proxy,
 		l_info("Unable to remove ad instance");
 	if (!l_dbus_object_remove_interface(dbus, AD_PATH,
 						L_DBUS_INTERFACE_PROPERTIES))
-		l_info("Unable to remove propety instance");
+		l_info("Unable to remove property instance");
 	if (!l_dbus_unregister_interface(dbus, AD_IFACE))
 		l_info("Unable to unregister ad interface");
 
@@ -500,7 +500,7 @@ static void reset_unreg_agent_reply(struct l_dbus_proxy *proxy,
 
 	if (!l_dbus_object_remove_interface(dbus, AG_PATH,
 						L_DBUS_INTERFACE_PROPERTIES))
-		l_info("Unable to remove propety instance");
+		l_info("Unable to remove property instance");
 	if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
 		l_info("Unable to remove agent instance");
 	if (!l_dbus_unregister_interface(dbus, AG_IFACE))
@@ -1074,7 +1074,7 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 		case AD_TYPE_TX_POWER:
 			ad.tx_power = true;
 
-			/* XXX Value is ommited cause, stack fills it */
+			/* XXX Value is omitted cause, stack fills it */
 
 			break;
 		case AD_TYPE_SERVICE_DATA_UUID16:
@@ -1254,7 +1254,7 @@ static void stop_advertising_reply(struct l_dbus_proxy *proxy,
 		l_info("Unable to remove ad instance");
 	if (!l_dbus_object_remove_interface(dbus, AD_PATH,
 						L_DBUS_INTERFACE_PROPERTIES))
-		l_info("Unable to remove propety instance");
+		l_info("Unable to remove property instance");
 	if (!l_dbus_unregister_interface(dbus, AD_IFACE))
 		l_info("Unable to unregister ad interface");
 
@@ -2179,7 +2179,7 @@ static void rereg_unreg_agent_reply(struct l_dbus_proxy *proxy,
 
 	if (!l_dbus_object_remove_interface(dbus, AG_PATH,
 						L_DBUS_INTERFACE_PROPERTIES))
-		l_info("Unable to remove propety instance");
+		l_info("Unable to remove property instance");
 	if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
 		l_info("Unable to remove agent instance");
 	if (!l_dbus_unregister_interface(dbus, AG_IFACE))
@@ -2298,7 +2298,7 @@ static void btp_gap_pair(uint8_t index, const void *param, uint16_t length,
 	if (!device)
 		goto failed;
 
-	/* This command is asynchronous, send reply immediatelly to not block
+	/* This command is asynchronous, send reply immediately to not block
 	 * pairing process eg. passkey request.
 	 */
 	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PAIR, adapter->index, 0,
@@ -2494,7 +2494,7 @@ static void btp_gap_confirm_entry_rsp(uint8_t index, const void *param,
 	} else {
 		reply = l_dbus_message_new_error(ag.pending_req,
 						"org.bluez.Error.Rejected",
-						"Passkey missmatch");
+						"Passkey mismatch");
 	}
 
 	l_dbus_send_with_reply(dbus, ag.pending_req, passkey_confirm_rsp_reply,
@@ -2864,7 +2864,7 @@ static void extract_settings(struct l_dbus_proxy *proxy, uint32_t *current,
 	*supported |=  BTP_GAP_SETTING_PRIVACY;
 	/* *supported |=  BTP_GAP_SETTING_STATIC_ADDRESS; */
 
-	/* TODO not all info is availbe via D-Bus API so some are assumed to be
+	/* TODO not all info is available via D-Bus API so some are assumed to be
 	 * enabled by bluetoothd or simply hardcoded until API is extended
 	 */
 	*current |=  BTP_GAP_SETTING_CONNECTABLE;
@@ -3075,7 +3075,7 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 
 			btp_gap_device_connection_ev(proxy, prop);
 		} else if (!strcmp(name, "AddressType")) {
-			/* Addres property change came first along with address
+			/* Address property change came first along with address
 			 * type.
 			 */
 			btp_identity_resolved_ev(proxy);
diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
index f6f61ed5d651..1d89b51b55e9 100644
--- a/tools/btpclientctl.c
+++ b/tools/btpclientctl.c
@@ -328,7 +328,7 @@ static void null_evt(const void *data, uint16_t size)
 }
 
 static const struct indexstr_data error_table[] = {
-	{ 0x01, "Faile" },
+	{ 0x01, "Failed" },
 	{ 0x02, "Unknown Command" },
 	{ 0x03, "Not Ready" },
 	{ 0x04, "Invalid Index" },
diff --git a/tools/ciptool.c b/tools/ciptool.c
index 0d6272da9a71..4ba33f87ec6e 100644
--- a/tools/ciptool.c
+++ b/tools/ciptool.c
@@ -300,7 +300,7 @@ static void cmd_release(int ctl, bdaddr_t *bdaddr, int argc, char **argv)
 			return;
 
 		if (cl.cnum != 1) {
-			fprintf(stderr, "You have to specifiy the device address.\n");
+			fprintf(stderr, "You have to specify the device address.\n");
 			exit(1);
 		}
 
diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 8922b480f629..5bd63582267d 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -806,7 +806,7 @@ static int ath_ps_download(int fd)
 	FILE *stream;
 
 	/*
-	 * Verfiy firmware version. depending on it select the PS
+	 * Verify firmware version. depending on it select the PS
 	 * config file to download.
 	 */
 	if (get_device_type(fd, &dev_type) < 0) {
diff --git a/tools/hciconfig.rst b/tools/hciconfig.rst
index 992aafd931d8..8b548a01b453 100644
--- a/tools/hciconfig.rst
+++ b/tools/hciconfig.rst
@@ -102,7 +102,7 @@ name [*name*]
 class [*class*]
     With  no *class*, prints class of device. Otherwise, sets class of device
     to *class*. *class* is a 24-bit hex number describing the class of device,
-    as specified in section 1.2 of the Bluetooth Assigned Numers document.
+    as specified in section 1.2 of the Bluetooth Assigned Numbers document.
 
 voice [*voice*]
     With no *voice*, prints voice setting. Otherwise, sets voice setting to
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 7e9dd84d3195..f1eb79af1c97 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -2010,7 +2010,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 
 	tester_print("Will close socket during scan phase...");
 
-	/* We tried to conect to LE device that is not advertising. It
+	/* We tried to connect to LE device that is not advertising. It
 	 * was added to kernel accept list, and scan was started. We
 	 * should be still scanning.
 	 */
@@ -2526,7 +2526,7 @@ static void test_getpeername_not_connected(const void *test_data)
 	}
 
 	if (errno != ENOTCONN) {
-		tester_warn("Unexpexted getpeername error: %s (%d)",
+		tester_warn("Unexpected getpeername error: %s (%d)",
 						strerror(errno), errno);
 		tester_test_failed();
 		goto done;
diff --git a/tools/l2test.c b/tools/l2test.c
index 4c22968999c9..cb06a45f6013 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -922,7 +922,7 @@ static void recv_mode(int sk)
 			/* Check sequence */
 			sq = get_le32(buf);
 			if (seq != sq) {
-				syslog(LOG_INFO, "seq missmatch: %d -> %d", seq, sq);
+				syslog(LOG_INFO, "seq mismatch: %d -> %d", seq, sq);
 				seq = sq;
 			}
 			seq++;
@@ -930,14 +930,14 @@ static void recv_mode(int sk)
 			/* Check length */
 			l = get_le16(buf + 4);
 			if (len != l) {
-				syslog(LOG_INFO, "size missmatch: %d -> %d", len, l);
+				syslog(LOG_INFO, "size mismatch: %d -> %d", len, l);
 				continue;
 			}
 
 			/* Verify data */
 			for (i = 6; i < len; i++) {
 				if (buf[i] != 0x7f)
-					syslog(LOG_INFO, "data missmatch: byte %d 0x%2.2x", i, buf[i]);
+					syslog(LOG_INFO, "data mismatch: byte %d 0x%2.2x", i, buf[i]);
 			}
 
 			total += len;
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index b1d091be7496..8c53c8c932eb 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -766,7 +766,7 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 	if (local->mgmt_proxy)
 		l_queue_remove(node_proxies, local->mgmt_proxy);
 
-	/* Inititalize config client model */
+	/* Initialize config client model */
 	client_init();
 
 	if (l_dbus_proxy_get_property(local->proxy, "IvIndex", "u", &ivi) &&
diff --git a/tools/mesh-gatt/mesh-net.h b/tools/mesh-gatt/mesh-net.h
index 95a1346e75a9..7877192f4aa9 100644
--- a/tools/mesh-gatt/mesh-net.h
+++ b/tools/mesh-gatt/mesh-net.h
@@ -100,7 +100,7 @@
 #define PROXY_FILTER_ACCEPT_LIST	0x00
 #define PROXY_FILTER_REJECT_LIST	0x01
 
-/* Network Tranport Opcodes */
+/* Network Transport Opcodes */
 #define NET_OP_SEG_ACKNOWLEDGE		0x00
 #define NET_OP_FRND_POLL		0x01
 #define NET_OP_FRND_UPDATE		0x02
diff --git a/tools/mesh-gatt/node.c b/tools/mesh-gatt/node.c
index 356e1cd1ace4..9a106b53ec15 100644
--- a/tools/mesh-gatt/node.c
+++ b/tools/mesh-gatt/node.c
@@ -412,7 +412,7 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 
 		while (len >= 2 && m--) {
 			mod_id = get_le16(data);
-			/* initialize uppper 16 bits to 0xffff for SIG models */
+			/* initialize upper 16 bits to 0xffff for SIG models */
 			mod_id |= 0xffff0000;
 			if (!node_set_model(node, ele->index, mod_id)) {
 				g_free(comp);
diff --git a/tools/mesh-gatt/prov.c b/tools/mesh-gatt/prov.c
index 1f3f62dfdcba..54d66a00cfa4 100644
--- a/tools/mesh-gatt/prov.c
+++ b/tools/mesh-gatt/prov.c
@@ -70,7 +70,7 @@
 #define PROV_ERR_UNEXPECTED_ERR		0x07
 #define PROV_ERR_CANT_ASSIGN_ADDR	0x08
 
-/* For Deployment, Security levels below HIGH are *not* recomended */
+/* For Deployment, Security levels below HIGH are *not* recommended */
 static uint8_t prov_sec_level = MESH_PROV_SEC_MED;
 
 /* Expected Provisioning PDU sizes */
@@ -618,7 +618,7 @@ bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len)
 
 	/* Compose appropriate reply for the prov state message */
 	/* Send reply via mesh_gatt_write() */
-	/* If done, call prov_done calllback and free prov housekeeping data */
+	/* If done, call prov_done callback and free prov housekeeping data */
 	bt_shell_printf("Got provisioning data (%d bytes)\n", len);
 	print_byte_array("\t", buf, len);
 
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 7b9c44b11e49..152fc0139849 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -777,7 +777,7 @@ static void disconnect_device(GDBusReturnFunction cb, void *user_data)
 
 	net_session_close(connection.data_in);
 
-	/* Stop notificiation on prov_out or proxy out characteristics */
+	/* Stop notification on prov_out or proxy out characteristics */
 	if (connection.data_out) {
 		if (g_dbus_proxy_get_property(connection.data_out, "Notifying",
 							&iter) == TRUE) {
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a1d48152f23b..35035827c47e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6192,7 +6192,7 @@ static void setup_pairing_acceptor(const void *test_data)
 	setup_bthost();
 }
 
-/* Generic callback for checking the mgmt evnet status
+/* Generic callback for checking the mgmt event status
  */
 static void generic_mgmt_status_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
@@ -10045,8 +10045,8 @@ static void setup_set_exp_feature_alt(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	/* Send the Read Experiemental Features Information command to receive
-	 * the Experiemental Feature Changed event
+	/* Send the Read Experimental Features Information command to receive
+	 * the Experimental Feature Changed event
 	 */
 	mgmt_send(data->mgmt_alt, MGMT_OP_READ_EXP_FEATURES_INFO,
 			data->mgmt_index, 0, NULL,
@@ -14396,7 +14396,7 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set PHY 2m Success", &set_phy_2m_success,
 					NULL, test_command_generic);
 
-	test_bredrle50("Set PHY coded Succcess", &set_phy_coded_success,
+	test_bredrle50("Set PHY coded Success", &set_phy_coded_success,
 					NULL, test_command_generic);
 
 	test_bredrle50("Set PHY 2m tx success", &set_phy_2m_tx_success,
@@ -15001,7 +15001,7 @@ int main(int argc, char *argv[])
 	 * Setup: Enable Privacy, LL Privacy
 	 * Run: Pair device, disconnect, add device, add 2nd device, and
 	 *      remove the client, then unpair.
-	 * Expect: Expect the clinet is removed from the Accept List.
+	 * Expect: Expect the client is removed from the Accept List.
 	 */
 	test_bredrle50_full("LL Privacy - Unpair 2 (Remove from AL)",
 				&ll_privacy_unpair_2,
diff --git a/tools/parser/att.c b/tools/parser/att.c
index bef583a1a8d5..fe1165bdd083 100644
--- a/tools/parser/att.c
+++ b/tools/parser/att.c
@@ -522,7 +522,7 @@ static void att_exec_write_req_dump(int level, struct frame *frm)
 	if (flags == 0x00)
 		printf("cancel all prepared writes ");
 	else
-		printf("immediatelly write all pending prepared values ");
+		printf("immediately write all pending prepared values ");
 
 	printf("(0x%2.2x)\n", flags);
 }
diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
index d574c7ee3cd6..9f0c1596b4b9 100644
--- a/tools/parser/avrcp.c
+++ b/tools/parser/avrcp.c
@@ -379,7 +379,7 @@ static const char *error2str(uint8_t status)
 	case AVRCP_STATUS_NOW_PLAYING_LIST_FULL:
 		return "Now Playing List Full";
 	case AVRCP_STATUS_SEARCH_NOT_SUPPORTED:
-		return "Seach Not Supported";
+		return "Search Not Supported";
 	case AVRCP_STATUS_SEARCH_IN_PROGRESS:
 		return "Search in Progress";
 	case AVRCP_STATUS_INVALID_PLAYER_ID:
@@ -1091,12 +1091,12 @@ static void avrcp_get_play_status_dump(int level, struct frame *frm,
 	}
 
 	interval = p_get_u32(frm);
-	printf("SongLength: 0x%08x (%u miliseconds)\n", interval, interval);
+	printf("SongLength: 0x%08x (%u milliseconds)\n", interval, interval);
 
 	p_indent(level, frm);
 
 	interval = p_get_u32(frm);
-	printf("SongPosition: 0x%08x (%u miliconds)\n", interval, interval);
+	printf("SongPosition: 0x%08x (%u milliconds)\n", interval, interval);
 
 	p_indent(level, frm);
 
@@ -1157,7 +1157,7 @@ response:
 		break;
 	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
 		interval = p_get_u32(frm);
-		printf("Position: 0x%08x (%u miliseconds)\n", interval,
+		printf("Position: 0x%08x (%u milliseconds)\n", interval,
 								interval);
 		break;
 	case AVRCP_EVENT_BATT_STATUS_CHANGED:
@@ -1179,7 +1179,7 @@ response:
 			printf("(UNPLUGGED)\n");
 			break;
 		default:
-			printf("(UNKOWN)\n");
+			printf("(UNKNOWN)\n");
 			break;
 		}
 		break;
@@ -1565,7 +1565,7 @@ static void avrcp_passthrough_dump(int level, struct frame *frm)
 
 	len = p_get_u8(frm);
 
-	printf("Lenght: 0x%02x\n", len);
+	printf("Length: 0x%02x\n", len);
 
 	raw_dump(level, frm);
 }
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index a1a639eba035..4af142c4a3bd 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -1174,7 +1174,7 @@ static inline void qos_setup_dump(int level, struct frame *frm)
 	p_indent(level, frm);
 	printf("Token rate: %d\n", btohl(cp->qos.token_rate));
 	p_indent(level, frm);
-	printf("Peak bandwith: %d\n", btohl(cp->qos.peak_bandwidth));
+	printf("Peak bandwidth: %d\n", btohl(cp->qos.peak_bandwidth));
 	p_indent(level, frm);
 	printf("Latency: %d\n", btohl(cp->qos.latency));
 	p_indent(level, frm);
@@ -3155,7 +3155,7 @@ static inline void qos_setup_complete_dump(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("Token rate: %d\n", btohl(evt->qos.token_rate));
 		p_indent(level, frm);
-		printf("Peak bandwith: %d\n", btohl(evt->qos.peak_bandwidth));
+		printf("Peak bandwidth: %d\n", btohl(evt->qos.peak_bandwidth));
 		p_indent(level, frm);
 		printf("Latency: %d\n", btohl(evt->qos.latency));
 		p_indent(level, frm);
@@ -3310,7 +3310,7 @@ static inline void flow_spec_complete_dump(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("Token rate: %d\n", btohl(evt->qos.token_rate));
 		p_indent(level, frm);
-		printf("Peak bandwith: %d\n", btohl(evt->qos.peak_bandwidth));
+		printf("Peak bandwidth: %d\n", btohl(evt->qos.peak_bandwidth));
 		p_indent(level, frm);
 		printf("Latency: %d\n", btohl(evt->qos.latency));
 		p_indent(level, frm);
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index 8675aa74191c..abc1c77361b6 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -279,7 +279,7 @@ static char *status2str(uint16_t status)
 {
 	switch (status) {
 	case 0x0000:
-		return "No futher information available";
+		return "No further information available";
 	case 0x0001:
 		return "Authentication pending";
 	case 0x0002:
diff --git a/tools/parser/parser.h b/tools/parser/parser.h
index b9f8f2c20671..dcc0e9b96897 100644
--- a/tools/parser/parser.h
+++ b/tools/parser/parser.h
@@ -149,7 +149,7 @@ static inline void p_ba2str(const bdaddr_t *ba, char *str)
 		ba2str(ba, str);
 }
 
-/* get_uXX functions do byte swaping */
+/* get_uXX functions do byte swapping */
 
 static inline uint8_t p_get_u8(struct frame *frm)
 {
diff --git a/tools/parser/rfcomm.h b/tools/parser/rfcomm.h
index c3a1dfb22eea..b1cb1741c453 100644
--- a/tools/parser/rfcomm.h
+++ b/tools/parser/rfcomm.h
@@ -50,7 +50,7 @@
 
 /* FIXME: Should this one be defined here? */
 #define SHORT_PAYLOAD_SIZE 127
-/* Used for setting the EA field in different packets, really neccessary? */
+/* Used for setting the EA field in different packets, really necessary? */
 #define EA 1
 /* Yes the FCS size is only one byte */
 #define FCS_SIZE 1
@@ -183,7 +183,7 @@ typedef struct rpn_values {
 #error "Unknown byte order"
 #endif
 
-/* Typedefinitions of stuctures used for creating and parsing packets, for a
+/* Typedefinitions of structures used for creating and parsing packets, for a
  * further description of the structures please se the bluetooth core
  * specification part F:1 and the ETSI TS 07.10 specification  */
 
diff --git a/tools/parser/smp.c b/tools/parser/smp.c
index 733795ac682c..10d51de4d522 100644
--- a/tools/parser/smp.c
+++ b/tools/parser/smp.c
@@ -107,7 +107,7 @@ static const char *smpio2str(uint8_t cap)
 	case SMP_IO_KEYBOARD_DISPLAY:
 		return "KeyboardDisplay";
 	default:
-		return "Unkown";
+		return "Unknown";
 	}
 }
 
@@ -133,7 +133,7 @@ static const char *smpreason2str(uint8_t reason)
 	case SMP_REASON_REPEATED_ATTEMPTS:
 		return "Repeated Attempts";
 	default:
-		return "Unkown";
+		return "Unknown";
 	}
 }
 
diff --git a/tools/rctest.c b/tools/rctest.c
index 367e41e3c7e9..c102a6cd1a2c 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -512,7 +512,7 @@ static void recv_mode(int sk)
 			/* Check sequence */
 			sq = btohl(*(uint32_t *) buf);
 			if (seq != sq) {
-				syslog(LOG_INFO, "seq missmatch: %d -> %d", seq, sq);
+				syslog(LOG_INFO, "seq mismatch: %d -> %d", seq, sq);
 				seq = sq;
 			}
 			seq++;
@@ -520,14 +520,14 @@ static void recv_mode(int sk)
 			/* Check length */
 			l = btohs(*(uint16_t *) (buf + 4));
 			if (r != l) {
-				syslog(LOG_INFO, "size missmatch: %d -> %d", r, l);
+				syslog(LOG_INFO, "size mismatch: %d -> %d", r, l);
 				continue;
 			}
 
 			/* Verify data */
 			for (i = 6; i < r; i++) {
 				if (buf[i] != 0x7f)
-					syslog(LOG_INFO, "data missmatch: byte %d 0x%2.2x", i, buf[i]);
+					syslog(LOG_INFO, "data mismatch: byte %d 0x%2.2x", i, buf[i]);
 			}
 #endif
 			total += r;
-- 
2.50.0

