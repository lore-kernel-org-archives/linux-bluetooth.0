Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Fix eir parsing function.
Date: Tue, 10 Dec 2013 10:15:40 +0200
Message-Id: <1386663340-12730-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20131129082247.GA6800@x220.p-661hnu-f1>
References: <20131129082247.GA6800@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Currently eir_parse always return 0 but it is checked throughout the code
(in android/bluetooth code as well in src/adapteri, etc) for return value
(err < 0) which never happens. Make function eir_parse return void. This
fixes warnings from static analyzer tools.
---
 android/bluetooth.c | 7 +------
 src/adapter.c       | 7 +------
 src/eir.c           | 8 +++-----
 src/eir.h           | 2 +-
 unit/test-eir.c     | 8 ++------
 5 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6174b1f..a3145cb 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -798,16 +798,11 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	uint8_t *num_prop;
 	uint8_t opcode;
 	int size = 0;
-	int err;
 
 	memset(buf, 0, sizeof(buf));
 	memset(&eir, 0, sizeof(eir));
 
-	err = eir_parse(&eir, data, data_len);
-	if (err < 0) {
-		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
-		return;
-	}
+	eir_parse(&eir, data, data_len);
 
 	if (!g_slist_find_custom(found_devices, bdaddr, bdaddr_cmp)) {
 		bdaddr_t *new_bdaddr;
diff --git a/src/adapter.c b/src/adapter.c
index 8ec9e92..9480103 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4083,16 +4083,11 @@ static void update_found_devices(struct btd_adapter *adapter,
 	struct btd_device *dev;
 	struct eir_data eir_data;
 	char addr[18];
-	int err;
 	GSList *list;
 	bool name_known;
 
 	memset(&eir_data, 0, sizeof(eir_data));
-	err = eir_parse(&eir_data, data, data_len);
-	if (err < 0) {
-		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
-		return;
-	}
+	eir_parse(&eir_data, data, data_len);
 
 	/* Avoid creating LE device if it's not discoverable */
 	if (bdaddr_type != BDADDR_BREDR &&
diff --git a/src/eir.c b/src/eir.c
index 084884e..7745ff3 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -129,7 +129,7 @@ static char *name2utf8(const uint8_t *name, uint8_t len)
 	return g_strdup(utf8_name);
 }
 
-int eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
+void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 {
 	uint16_t len = 0;
 
@@ -138,7 +138,7 @@ int eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 
 	/* No EIR data to parse */
 	if (eir_data == NULL)
-		return 0;
+		return;
 
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
@@ -226,8 +226,6 @@ int eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 
 		eir_data += field_len + 1;
 	}
-
-	return 0;
 }
 
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len)
@@ -248,7 +246,7 @@ int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len)
 
 	/* optional OOB EIR data */
 	if (eir_len > 0)
-		return eir_parse(eir, eir_data, eir_len);
+		eir_parse(eir, eir_data, eir_len);
 
 	return 0;
 }
diff --git a/src/eir.h b/src/eir.h
index 1b6242d..411986e 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -52,7 +52,7 @@ struct eir_data {
 };
 
 void eir_data_free(struct eir_data *eir);
-int eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len);
+void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
 int eir_create_oob(const bdaddr_t *addr, const char *name, uint32_t cod,
 			const uint8_t *hash, const uint8_t *randomizer,
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 1a6e1c9..6d9d554 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -537,13 +537,11 @@ static void test_basic(void)
 {
 	struct eir_data data;
 	unsigned char buf[HCI_MAX_EIR_LENGTH];
-	int err;
 
 	memset(buf, 0, sizeof(buf));
 	memset(&data, 0, sizeof(data));
 
-	err = eir_parse(&data, buf, HCI_MAX_EIR_LENGTH);
-	g_assert(err == 0);
+	eir_parse(&data, buf, HCI_MAX_EIR_LENGTH);
 	g_assert(data.services == NULL);
 	g_assert(data.name == NULL);
 
@@ -554,12 +552,10 @@ static void test_parsing(gconstpointer data)
 {
 	const struct test_data *test = data;
 	struct eir_data eir;
-	int err;
 
 	memset(&eir, 0, sizeof(eir));
 
-	err = eir_parse(&eir, test->eir_data, test->eir_size);
-	g_assert(err == 0);
+	eir_parse(&eir, test->eir_data, test->eir_size);
 
 	if (g_test_verbose() == TRUE) {
 		GSList *list;
-- 
1.8.3.2

