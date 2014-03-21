Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] eir: Use unsigned int for flags in struct eir_data
Date: Fri, 21 Mar 2014 18:21:32 +0100
Message-Id: <1395422492-21425-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds assumption that if flags field is not present in EIR all
flags are unset:
"The Flags data type shall be included when any of the Flag bits are
non-zero, otherwise the Flags data type may be omitted."

This also fix reporting non-discoverable LE devices as limited
discoverable due to no explicit check for flags == -1 as empty
flags.
---
 src/eir.c       |  2 +-
 src/eir.h       |  2 +-
 unit/test-eir.c | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index db9175b..d22ad91 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -141,7 +141,7 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 {
 	uint16_t len = 0;
 
-	eir->flags = -1;
+	eir->flags = 0;
 	eir->tx_power = 127;
 
 	/* No EIR data to parse */
diff --git a/src/eir.h b/src/eir.h
index 3fa1cb3..9e53983 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -40,7 +40,7 @@
 
 struct eir_data {
 	GSList *services;
-	int flags;
+	unsigned int flags;
 	char *name;
 	uint32_t class;
 	uint16_t appearance;
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 2061a11..3960c0f 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -38,7 +38,7 @@
 struct test_data {
 	const void *eir_data;
 	size_t eir_size;
-	int flags;
+	unsigned int flags;
 	const char *name;
 	bool name_complete;
 	int8_t tx_power;
@@ -93,7 +93,7 @@ static const char *macbookair_uuid[] = {
 static const struct test_data macbookair_test = {
 	.eir_data = macbookair_data,
 	.eir_size = sizeof(macbookair_data),
-	.flags = -1,
+	.flags = 0,
 	.name = "Marcel’s MacBook Air",
 	.name_complete = true,
 	.tx_power = 127,
@@ -148,7 +148,7 @@ static const char *iphone5_uuid[] = {
 static const struct test_data iphone5_test = {
 	.eir_data = iphone5_data,
 	.eir_size = sizeof(iphone5_data),
-	.flags = -1,
+	.flags = 0,
 	.name = "Marcel’s iPhone 5",
 	.name_complete = true,
 	.tx_power = 127,
@@ -201,7 +201,7 @@ static const char *ipadmini_uuid[] = {
 static const struct test_data ipadmini_test = {
 	.eir_data = ipadmini_data,
 	.eir_size = sizeof(ipadmini_data),
-	.flags = -1,
+	.flags = 0,
 	.name = "Marcel's iPad mini",
 	.name_complete = true,
 	.tx_power = 127,
@@ -253,7 +253,7 @@ static const char *gigaset_sl400h_uuid[] = {
 static const struct test_data gigaset_sl400h_test = {
 	.eir_data = gigaset_sl400h_data,
 	.eir_size = sizeof(gigaset_sl400h_data),
-	.flags = -1,
+	.flags = 0,
 	.name = "Marcel's SL400H",
 	.name_complete = true,
 	.tx_power = 127,
@@ -305,7 +305,7 @@ static const char *gigaset_sl910_uuid[] = {
 static const struct test_data gigaset_sl910_test = {
 	.eir_data = gigaset_sl910_data,
 	.eir_size = sizeof(gigaset_sl910_data),
-	.flags = -1,
+	.flags = 0,
 	.name = "Marcel's SL910",
 	.name_complete = true,
 	.tx_power = 127,
@@ -359,7 +359,7 @@ static const char *nokia_bh907_uuid[] = {
 static const struct test_data nokia_bh907_test = {
 	.eir_data = nokia_bh907_data,
 	.eir_size = sizeof(nokia_bh907_data),
-	.flags = -1,
+	.flags = 0,
 	.name = "Nokia Reaction BH-907",
 	.name_complete = true,
 	.tx_power = 4,
@@ -407,7 +407,7 @@ static const char *fuelband_uuid[] = {
 static const struct test_data fuelband_test = {
 	.eir_data = fuelband_data,
 	.eir_size = sizeof(fuelband_data),
-	.flags = -1,
+	.flags = 0,
 	.name = "Nike+ FuelBand",
 	.name_complete = true,
 	.tx_power = 0,
@@ -530,7 +530,7 @@ static const char *citizen_scan_uuid[] = {
 static const struct test_data citizen_scan_test = {
 	.eir_data = citizen_scan_data,
 	.eir_size = sizeof(citizen_scan_data),
-	.flags = -1,
+	.flags = 0,
 	.tx_power = 0,
 	.uuid = citizen_scan_uuid,
 };
-- 
1.8.3.2

