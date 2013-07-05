Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 6/6] sco-tester: Test BT_VOICE option with 1.1 adapter
Date: Fri,  5 Jul 2013 17:46:47 +0200
Message-Id: <1373039207-20959-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c    |   25 +++++++++++++++++++
 emulator/btdev.h    |    1 +
 src/shared/hciemu.c |    8 +++++++
 src/shared/hciemu.h |    1 +
 tools/sco-tester.c  |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ddeee63..506b519 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -450,6 +450,11 @@ const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
 	return btdev->bdaddr;
 }
 
+uint8_t *btdev_get_features(struct btdev *btdev)
+{
+	return btdev->features;
+}
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data)
 {
@@ -683,6 +688,22 @@ static void sync_conn_complete(struct btdev *btdev, uint16_t voice_setting,
 	send_event(btdev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
 }
 
+static void sco_conn_complete(struct btdev *btdev, uint8_t status)
+{
+	struct bt_hci_evt_conn_complete cc;
+
+	if (!btdev->conn)
+		return;
+
+	cc.status = status;
+	memcpy(cc.bdaddr, btdev->conn->bdaddr, 6);
+	cc.handle = cpu_to_le16(status == BT_HCI_ERR_SUCCESS ? 257 : 0);
+	cc.link_type = 0x00;
+	cc.encr_mode = 0x00;
+
+	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+}
+
 static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
 {
 	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
@@ -1524,6 +1545,10 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 							BT_HCI_ERR_SUCCESS);
 		break;
 
+	case BT_HCI_CMD_ADD_SCO_CONN:
+		sco_conn_complete(btdev, BT_HCI_ERR_SUCCESS);
+		break;
+
 	default:
 		goto unsupported;
 	}
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 9fb023c..a69e899 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -66,6 +66,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id);
 void btdev_destroy(struct btdev *btdev);
 
 const uint8_t *btdev_get_bdaddr(struct btdev *btdev);
+uint8_t *btdev_get_features(struct btdev *btdev);
 
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index a0b347c..60df435 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -353,6 +353,14 @@ const char *hciemu_get_address(struct hciemu *hciemu)
 	return hciemu->bdaddr_str;
 }
 
+uint8_t *hciemu_get_features(struct hciemu *hciemu)
+{
+	if (!hciemu || !hciemu->master_dev)
+		return NULL;
+
+	return btdev_get_features(hciemu->master_dev);
+}
+
 const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->master_dev)
diff --git a/src/shared/hciemu.h b/src/shared/hciemu.h
index a473c0e..aa53caf 100644
--- a/src/shared/hciemu.h
+++ b/src/shared/hciemu.h
@@ -40,6 +40,7 @@ void hciemu_unref(struct hciemu *hciemu);
 struct bthost *hciemu_client_get_host(struct hciemu *hciemu);
 
 const char *hciemu_get_address(struct hciemu *hciemu);
+uint8_t *hciemu_get_features(struct hciemu *hciemu);
 
 const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 80a199d..70b8a5d 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -50,6 +50,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	unsigned int io_id;
+	bool disable_esco;
 };
 
 struct sco_client_data {
@@ -162,6 +163,16 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	}
 
 	tester_print("New hciemu instance created");
+
+	if (data->disable_esco) {
+		uint8_t *features;
+
+		tester_print("Disabling eSCO packet type support");
+
+		features = hciemu_get_features(data->hciemu);
+		if (features)
+			features[3] &= ~0x80;
+	}
 }
 
 static void test_pre_setup(const void *test_data)
@@ -200,7 +211,7 @@ static void test_data_free(void *test_data)
 	free(data);
 }
 
-#define test_sco(name, data, setup, func) \
+#define test_sco_full(name, data, setup, func, _disable_esco) \
 	do { \
 		struct test_data *user; \
 		user = malloc(sizeof(struct test_data)); \
@@ -209,11 +220,18 @@ static void test_data_free(void *test_data)
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
 		user->io_id = 0; \
 		user->test_data = data; \
+		user->disable_esco = _disable_esco; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
 	} while (0)
 
+#define test_sco(name, data, setup, func) \
+	test_sco_full(name, data, setup, func, false)
+
+#define test_sco_11(name, data, setup, func) \
+	test_sco_full(name, data, setup, func, true)
+
 static const struct sco_client_data connect_success = {
 	.expect_err = 0
 };
@@ -518,6 +536,43 @@ static void test_connect(const void *test_data)
 	tester_print("Connect in progress");
 }
 
+static void test_connect_transp(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct sco_client_data *scodata = data->test_data;
+	int sk, err;
+	struct bt_voice voice;
+
+	sk = create_sco_sock(data, 0);
+	if (sk < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	voice.setting = BT_VOICE_TRANSPARENT;
+	err = setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice));
+	if (err < 0) {
+		tester_warn("Can't set socket option : %s (%d)",
+							strerror(errno), errno);
+		tester_test_failed();
+		goto end;
+	}
+
+	err = connect_sco_sock(data, sk);
+
+	tester_warn("Connect returned %s (%d), expected %s (%d)",
+			strerror(-err), -err,
+			strerror(scodata->expect_err), scodata->expect_err);
+
+	if (-err != scodata->expect_err)
+		tester_test_failed();
+	else
+		tester_test_passed();
+
+end:
+	close(sk);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -537,5 +592,14 @@ int main(int argc, char *argv[])
 	test_sco("eSCO CVSD - Success", &connect_success, setup_powered,
 							test_connect);
 
+	test_sco("eSCO MSBC - Success", &connect_success, setup_powered,
+							test_connect_transp);
+
+	test_sco_11("SCO CVSD 1.1 - Success", &connect_success, setup_powered,
+							test_connect);
+
+	test_sco_11("SCO MSBC 1.1 - Failure", &connect_failure, setup_powered,
+							test_connect_transp);
+
 	return tester_run();
 }
-- 
1.7.9.5

