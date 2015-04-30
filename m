Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCH 2/4] src/eir: Fix eir parser
Date: Thu, 30 Apr 2015 13:26:16 +0200
Message-Id: <1430393178-29983-2-git-send-email-mariusz.skamra@gmail.com>
In-Reply-To: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com>
References: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some devices (like Gigaset's G-Tag) sends Advertising Report with significant part
set to 0. According specification (Core 4.2, Vol 3, Part C, Sec 11) it is proper
behaviour. So if ADV and SCAN_RSP data are merged, there is a possibility to lose
SCAN_RSP data if the parser found early terminator.

This patch fixes this issue by checking the address type. For LE, early termination
won't be not used.
---
 android/bluetooth.c |  2 +-
 src/adapter.c       |  4 ++--
 src/eir.c           | 19 +++++++++++++------
 src/eir.h           |  3 ++-
 unit/test-eir.c     |  6 ++++--
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4d0cd48..09a31f8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1920,7 +1920,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 	memset(&eir, 0, sizeof(eir));
 
-	eir_parse(&eir, data, data_len);
+	eir_parse(&eir, data, data_len, bdaddr_type);
 
 	dev = get_device(bdaddr, bdaddr_type);
 
diff --git a/src/adapter.c b/src/adapter.c
index 8ee5b5b..762fb19 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5384,7 +5384,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	char addr[18];
 
 	memset(&eir_data, 0, sizeof(eir_data));
-	eir_parse(&eir_data, data, data_len);
+	eir_parse(&eir_data, data, data_len, bdaddr_type);
 
 	if (bdaddr_type == BDADDR_BREDR)
 		discoverable = true;
@@ -7467,7 +7467,7 @@ static void connected_callback(uint16_t index, uint16_t length,
 
 	memset(&eir_data, 0, sizeof(eir_data));
 	if (eir_len > 0)
-		eir_parse(&eir_data, ev->eir, eir_len);
+		eir_parse(&eir_data, ev->eir, eir_len, ev->addr.type);
 
 	if (eir_data.class != 0)
 		device_set_class(device, eir_data.class);
diff --git a/src/eir.c b/src/eir.c
index c984fa5..423a37f 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -226,7 +226,8 @@ static void eir_parse_uuid128_data(struct eir_data *eir, const uint8_t *data,
 	eir_parse_sd(eir, &service, data + 16, len - 16);
 }
 
-void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
+void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len,
+							uint8_t bdaddr_type)
 {
 	uint16_t len = 0;
 
@@ -242,15 +243,21 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 		const uint8_t *data;
 		uint8_t data_len;
 
-		/* Check for the end of EIR */
-		if (field_len == 0)
+		/* Do not continue EIR Data parsing if got incorrect length */
+		if (len > eir_len)
 			break;
 
 		len += field_len + 1;
 
-		/* Do not continue EIR Data parsing if got incorrect length */
-		if (len > eir_len)
+		if (field_len == 0) {
+			/* Ignore redundant advertising data over LE*/
+			if (bdaddr_type != BDADDR_BREDR) {
+				eir_data += field_len + 1;
+				continue;
+			}
+			/* field_len == 0 for BREDR means the end of EIR */
 			break;
+		}
 
 		data = &eir_data[2];
 		data_len = field_len - 1;
@@ -370,7 +377,7 @@ int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len)
 
 	/* optional OOB EIR data */
 	if (eir_len > 0)
-		eir_parse(eir, eir_data, eir_len);
+		eir_parse(eir, eir_data, eir_len, 0);
 
 	return 0;
 }
diff --git a/src/eir.h b/src/eir.h
index 219ee79..944413d 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -95,7 +95,8 @@ struct eir_data {
 };
 
 void eir_data_free(struct eir_data *eir);
-void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len);
+void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len,
+							uint8_t bdaddr_type);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
 int eir_create_oob(const bdaddr_t *addr, const char *name, uint32_t cod,
 			const uint8_t *hash, const uint8_t *randomizer,
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 53abfa4..09d9865 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -44,6 +44,7 @@ struct test_data {
 	bool name_complete;
 	int8_t tx_power;
 	const char **uuid;
+	uint8_t bdaddr_type;
 };
 
 static const unsigned char macbookair_data[] = {
@@ -536,7 +537,7 @@ static void test_basic(const void *data)
 	memset(buf, 0, sizeof(buf));
 	memset(&eir, 0, sizeof(eir));
 
-	eir_parse(&eir, buf, HCI_MAX_EIR_LENGTH);
+	eir_parse(&eir, buf, HCI_MAX_EIR_LENGTH, BDADDR_BREDR);
 	g_assert(eir.services == NULL);
 	g_assert(eir.name == NULL);
 
@@ -560,7 +561,7 @@ static void test_parsing(gconstpointer data)
 
 	memset(&eir, 0, sizeof(eir));
 
-	eir_parse(&eir, test->eir_data, test->eir_size);
+	eir_parse(&eir, test->eir_data, test->eir_size, test->bdaddr_type);
 
 	tester_debug("Flags: %d", eir.flags);
 	tester_debug("Name: %s", eir.name);
@@ -639,6 +640,7 @@ static const struct test_data gigaset_gtag_test = {
 	.uuid = gigaset_gtag_uuid,
 	.name = "Gigaset G-tag",
 	.name_complete = true,
+	.bdaddr_type = BDADDR_LE_PUBLIC,
 };
 
 static const char *uri_beacon_uuid[] = {
-- 
1.9.1

