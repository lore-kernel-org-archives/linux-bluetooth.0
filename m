Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] tools/btmgmt: refactor of repeated scan type
Date: Thu, 12 Mar 2015 09:38:33 -0700
Message-Id: <1426178313-28011-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

this patch replaces often repeated scan type with defined constants.
---
 tools/btmgmt.c | 54 +++++++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index e8f76bb..fe25874 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -58,6 +58,10 @@
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 
+#define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
+#define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
+#define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
+
 static struct mgmt *mgmt = NULL;
 static uint16_t mgmt_index = MGMT_INDEX_NONE;
 
@@ -1739,7 +1743,7 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 	uuid_t uuid;
 	uint128_t uint128;
 	uuid_t uuid128;
-	uint8_t type;
+	uint8_t type = SCAN_TYPE_DUAL;
 	int8_t rssi;
 	uint16_t count;
 	int opt;
@@ -1747,10 +1751,6 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
-	type = 0;
-	type |= (1 << BDADDR_BREDR);
-	type |= (1 << BDADDR_LE_PUBLIC);
-	type |= (1 << BDADDR_LE_RANDOM);
 	rssi = 127;
 	count = 0;
 
@@ -1763,14 +1763,12 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 					find_service_options, NULL)) != -1) {
 		switch (opt) {
 		case 'l':
-			type &= ~(1 << BDADDR_BREDR);
-			type |= (1 << BDADDR_LE_PUBLIC);
-			type |= (1 << BDADDR_LE_RANDOM);
+			type &= ~SCAN_TYPE_BREDR;
+			type |= SCAN_TYPE_LE;
 			break;
 		case 'b':
-			type |= (1 << BDADDR_BREDR);
-			type &= ~(1 << BDADDR_LE_PUBLIC);
-			type &= ~(1 << BDADDR_LE_RANDOM);
+			type |= SCAN_TYPE_BREDR;
+			type &= ~SCAN_TYPE_LE;
 			break;
 		case 'u':
 			if (count == MAX_UUIDS) {
@@ -1850,29 +1848,22 @@ static struct option find_options[] = {
 static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 {
 	struct mgmt_cp_start_discovery cp;
-	uint8_t type;
+	uint8_t type = SCAN_TYPE_DUAL;
 	int opt;
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
-	type = 0;
-	type |= (1 << BDADDR_BREDR);
-	type |= (1 << BDADDR_LE_PUBLIC);
-	type |= (1 << BDADDR_LE_RANDOM);
-
 	while ((opt = getopt_long(argc, argv, "+lbh", find_options,
 								NULL)) != -1) {
 		switch (opt) {
 		case 'l':
-			type &= ~(1 << BDADDR_BREDR);
-			type |= (1 << BDADDR_LE_PUBLIC);
-			type |= (1 << BDADDR_LE_RANDOM);
+			type &= ~SCAN_TYPE_BREDR;
+			type |= SCAN_TYPE_LE;
 			break;
 		case 'b':
-			type |= (1 << BDADDR_BREDR);
-			type &= ~(1 << BDADDR_LE_PUBLIC);
-			type &= ~(1 << BDADDR_LE_RANDOM);
+			type |= SCAN_TYPE_BREDR;
+			type &= ~SCAN_TYPE_LE;
 			break;
 		case 'h':
 			find_usage();
@@ -1930,29 +1921,22 @@ static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
 			  char **argv)
 {
 	struct mgmt_cp_stop_discovery cp;
-	uint8_t type;
+	uint8_t type = SCAN_TYPE_DUAL;
 	int opt;
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
-	type = 0;
-	type |= (1 << BDADDR_BREDR);
-	type |= (1 << BDADDR_LE_PUBLIC);
-	type |= (1 << BDADDR_LE_RANDOM);
-
 	while ((opt = getopt_long(argc, argv, "+lbh", stop_find_options,
 								NULL)) != -1) {
 		switch (opt) {
 		case 'l':
-			type &= ~(1 << BDADDR_BREDR);
-			type |= (1 << BDADDR_LE_PUBLIC);
-			type |= (1 << BDADDR_LE_RANDOM);
+			type &= ~SCAN_TYPE_BREDR;
+			type |= SCAN_TYPE_LE;
 			break;
 		case 'b':
-			type |= (1 << BDADDR_BREDR);
-			type &= ~(1 << BDADDR_LE_PUBLIC);
-			type &= ~(1 << BDADDR_LE_RANDOM);
+			type |= SCAN_TYPE_BREDR;
+			type &= ~SCAN_TYPE_LE;
 			break;
 		case 'h':
 		default:
-- 
2.2.0.rc0.207.ga3a616c

