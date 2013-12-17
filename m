Return-Path: <cyrus@holtmann.org>
From: Marcin <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 3/4] tools/l2cap-tester: Add client test with write data
Date: Tue, 17 Dec 2013 15:49:38 +0100
Message-Id: <1387291779-14960-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387291779-14960-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387291779-14960-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This test checks if data is received on server side.
---
 tools/l2cap-tester.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index e4dade2..cbea26e 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -56,6 +56,8 @@ struct l2cap_client_data {
 	uint16_t client_psm;
 	uint16_t server_psm;
 	int expect_err;
+	const void *write_data;
+	uint16_t write_data_len;
 };
 
 struct l2cap_server_data {
@@ -247,6 +249,15 @@ static const struct l2cap_client_data client_connect_success_test = {
 	.server_psm = 0x1001,
 };
 
+static const uint8_t l2cap_write_data[] = { 0x01, 0x02, 0x03, 0x04 };
+
+static const struct l2cap_client_data client_connect_success_write_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.write_data = l2cap_write_data,
+	.write_data_len = sizeof(l2cap_write_data),
+};
+
 static const struct l2cap_client_data client_connect_nval_psm_test = {
 	.client_psm = 0x1001,
 	.expect_err = ECONNREFUSED,
@@ -455,6 +466,22 @@ static void test_basic(const void *test_data)
 	tester_test_passed();
 }
 
+static void l2cap_client_data(const void *data, uint16_t len)
+{
+	struct test_data *test_data = tester_get_data();
+	const struct l2cap_client_data *l2data = test_data->test_data;
+
+	if (len != l2data->write_data_len) {
+		tester_test_failed();
+		return;
+	}
+
+	if (memcmp(data, l2data->write_data, len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+}
+
 static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -477,10 +504,23 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 	else
 		tester_print("Successfully connected");
 
-	if (-err != l2data->expect_err)
-		tester_test_failed();
-	else
-		tester_test_passed();
+	if (l2data->write_data) {
+		struct bthost *temp;
+		int len;
+
+		temp = hciemu_client_get_host(data->hciemu);
+		bthost_l2cap_set_data_handler(temp, l2cap_client_data,
+							l2data->client_psm);
+
+		len = write(sk, l2data->write_data, l2data->write_data_len);
+		if (len != l2data->write_data_len)
+			tester_test_failed();
+	} else {
+		if (-err != l2data->expect_err)
+			tester_test_failed();
+		else
+			tester_test_passed();
+	}
 
 	return FALSE;
 }
@@ -744,6 +784,9 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP BR/EDR Client - Success",
 					&client_connect_success_test,
 					setup_powered_client, test_connect);
+	test_l2cap_bredr("L2CAP BR/EDR Client - Write Success",
+					&client_connect_success_write_test,
+					setup_powered_client, test_connect);
 	test_l2cap_bredr("L2CAP BR/EDR Client - Invalid PSM",
 					&client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
1.8.3.1

