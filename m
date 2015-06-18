Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v9 15/16] tools/mgmt-tester: fix duplicate code
Date: Thu, 18 Jun 2015 03:17:45 +0200
Message-Id: <1434590266-26744-16-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
References: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The definition of the test advertising instance was duplicated in
several places. This patch refactors the duplicate code into a
common subroutine.
---
 tools/mgmt-tester.c | 79 +++++++++++++----------------------------------------
 1 file changed, 19 insertions(+), 60 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 78091c4..e8333de 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5025,18 +5025,9 @@ static void setup_add_advertising_callback(uint8_t status, uint16_t length,
 	setup_bthost();
 }
 
-static void setup_add_advertising_not_powered(const void *test_data)
+static void setup_add_adv_param(struct mgmt_cp_add_advertising *cp)
 {
-	struct test_data *data = tester_get_data();
-	struct mgmt_cp_add_advertising *cp;
-	unsigned char adv_param[sizeof(*cp) + 6];
-	unsigned char param[] = { 0x01 };
-
-	tester_print("Adding advertising instance while unpowered");
-
-	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	memset(cp, 0, sizeof(*cp));
-
 	cp->instance = 1;
 	cp->adv_data_len = 6;
 	cp->data[0] = 0x05; /* AD len */
@@ -5045,6 +5036,19 @@ static void setup_add_advertising_not_powered(const void *test_data)
 	cp->data[3] = 'e';
 	cp->data[4] = 's';
 	cp->data[5] = 't';
+}
+
+static void setup_add_advertising_not_powered(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while unpowered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5066,16 +5070,7 @@ static void setup_add_advertising(const void *test_data)
 	tester_print("Adding advertising instance while powered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	memset(cp, 0, sizeof(*cp));
-
-	cp->instance = 1;
-	cp->adv_data_len = 6;
-	cp->data[0] = 0x05; /* AD len */
-	cp->data[1] = 0x08; /* AD type: shortened local name */
-	cp->data[2] = 't';  /* adv data ... */
-	cp->data[3] = 'e';
-	cp->data[4] = 's';
-	cp->data[5] = 't';
+	setup_add_adv_param(cp);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5101,16 +5096,7 @@ static void setup_add_advertising_connectable(const void *test_data)
 	tester_print("Adding advertising instance while connectable");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	memset(cp, 0, sizeof(*cp));
-
-	cp->instance = 1;
-	cp->adv_data_len = 6;
-	cp->data[0] = 0x05; /* AD len */
-	cp->data[1] = 0x08; /* AD type: shortened local name */
-	cp->data[2] = 't';  /* adv data ... */
-	cp->data[3] = 'e';
-	cp->data[4] = 's';
-	cp->data[5] = 't';
+	setup_add_adv_param(cp);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5140,17 +5126,8 @@ static void setup_add_advertising_timeout(const void *test_data)
 	tester_print("Adding advertising instance with timeout");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	memset(cp, 0, sizeof(*cp));
-
-	cp->instance = 1;
+	setup_add_adv_param(cp);
 	cp->timeout = 1;
-	cp->adv_data_len = 6;
-	cp->data[0] = 0x05; /* AD len */
-	cp->data[1] = 0x08; /* AD type: shortened local name */
-	cp->data[2] = 't';  /* adv data ... */
-	cp->data[3] = 'e';
-	cp->data[4] = 's';
-	cp->data[5] = 't';
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5194,16 +5171,7 @@ static void setup_add_advertising_power_cycle(const void *test_data)
 	tester_print("Adding instance without timeout and power cycle");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	memset(cp, 0, sizeof(*cp));
-
-	cp->instance = 1;
-	cp->adv_data_len = 6;
-	cp->data[0] = 0x05; /* AD len */
-	cp->data[1] = 0x08; /* AD type: shortened local name */
-	cp->data[2] = 't';  /* adv data ... */
-	cp->data[3] = 'e';
-	cp->data[4] = 's';
-	cp->data[5] = 't';
+	setup_add_adv_param(cp);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param_on), &param_on,
@@ -5229,16 +5197,7 @@ static void setup_set_and_add_advertising(const void *test_data)
 	tester_print("Set and add advertising instance");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	memset(cp, 0, sizeof(*cp));
-
-	cp->instance = 1;
-	cp->adv_data_len = 6;
-	cp->data[0] = 0x05; /* AD len */
-	cp->data[1] = 0x08; /* AD type: shortened local name */
-	cp->data[2] = 't';  /* adv data ... */
-	cp->data[3] = 'e';
-	cp->data[4] = 's';
-	cp->data[5] = 't';
+	setup_add_adv_param(cp);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
-- 
1.9.1

