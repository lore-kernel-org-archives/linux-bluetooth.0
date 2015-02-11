Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/4] tools/l2cap-tester: Add L2CAP LE Connection Reject test
Date: Wed, 11 Feb 2015 12:32:11 +0100
Message-Id: <1423654332-32424-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test checks if kernel correctly rejects LE connection when host is
not configured to support LE.
---
 tools/l2cap-tester.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index cf0fa38..7f03591 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -82,6 +82,9 @@ struct l2cap_data {
 	const void *pin;
 	uint8_t client_pin_len;
 	const void *client_pin;
+
+	bool addr_type_avail;
+	uint8_t addr_type;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -441,6 +444,12 @@ static const struct l2cap_data le_client_connect_reject_test_1 = {
 	.expect_err = ECONNREFUSED,
 };
 
+static const struct l2cap_data le_client_connect_reject_test_2 = {
+	.client_psm = 0x0080,
+	.addr_type_avail = true,
+	.addr_type = BDADDR_LE_PUBLIC,
+};
+
 static const struct l2cap_data le_client_connect_nval_psm_test = {
 	.client_psm = 0x0080,
 	.expect_err = ECONNREFUSED,
@@ -943,6 +952,7 @@ failed:
 static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 						uint16_t cid, int sec_level)
 {
+	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *master_bdaddr;
 	struct sockaddr_l2 addr;
 	int sk, err;
@@ -968,7 +978,10 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 	addr.l2_psm = htobs(psm);
 	addr.l2_cid = htobs(cid);
 	bacpy(&addr.l2_bdaddr, (void *) master_bdaddr);
-	if (data->hciemu_type == HCIEMU_TYPE_LE)
+
+	if (l2data && l2data->addr_type_avail)
+		addr.l2_bdaddr_type = l2data->addr_type;
+	else if (data->hciemu_type == HCIEMU_TYPE_LE)
 		addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
 	else
 		addr.l2_bdaddr_type = BDADDR_BREDR;
@@ -1003,6 +1016,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm,
 								uint16_t cid)
 {
+	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
 	struct sockaddr_l2 addr;
 	int err;
@@ -1018,7 +1032,10 @@ static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm,
 	bacpy(&addr.l2_bdaddr, (void *) client_bdaddr);
 	addr.l2_psm = htobs(psm);
 	addr.l2_cid = htobs(cid);
-	if (data->hciemu_type == HCIEMU_TYPE_LE)
+
+	if (l2data && l2data->addr_type_avail)
+		addr.l2_bdaddr_type = l2data->addr_type;
+	else if (data->hciemu_type == HCIEMU_TYPE_LE)
 		addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
 	else
 		addr.l2_bdaddr_type = BDADDR_BREDR;
@@ -1084,6 +1101,27 @@ static void test_connect(const void *test_data)
 	tester_print("Connect in progress");
 }
 
+static void test_connect_reject(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	int sk;
+
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level);
+	if (sk < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	if (connect_l2cap_sock(data, sk, l2data->client_psm,
+							l2data->cid) < 0)
+		tester_test_passed();
+	else
+		tester_test_failed();
+
+	close(sk);
+}
+
 static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1396,6 +1434,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - Command Reject",
 					&le_client_connect_reject_test_1,
 					setup_powered_client, test_connect);
+	test_l2cap_bredr("L2CAP LE Client - Connection Reject",
+				&le_client_connect_reject_test_2,
+				setup_powered_client, test_connect_reject);
 	test_l2cap_le("L2CAP LE Client - Invalid PSM",
 					&le_client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
1.8.4

