Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v2 03/11] unit/test-gatt: Extend large-db
Date: Fri, 27 Nov 2015 12:11:42 +0100
Message-Id: <1448622711-17562-4-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds characteristic extended descriptor to characteristic
handle 0x0081. Also fixes testes using this.

We need this to make script pass when following patches start
to look into this descriptor on reliable write session
---
 unit/test-gatt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9554bcb..68cdcff 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -223,7 +223,7 @@ struct context {
 			0x60, 0x00, 0x6B, 0x00, 0x0B, 0xA0),		\
 		raw_pdu(0x10, 0x6C, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x70, 0x00, 0x76, 0x00, 0x0B, 0xA0,	\
-			0x80, 0x00, 0x85, 0x00, 0x0B, 0xA0),		\
+			0x80, 0x00, 0x86, 0x00, 0x0B, 0xA0),		\
 		raw_pdu(0x10, 0x86, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x14, 0x90, 0x00, 0x96, 0x00,		\
 			0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,	\
@@ -1614,7 +1614,7 @@ static struct gatt_db *make_test_spec_small_db(void)
 static struct gatt_db *make_test_spec_large_db_1(void)
 {
 	const struct att_handle_spec specs[] = {
-		PRIMARY_SERVICE(0x0080, "a00b", 6),
+		PRIMARY_SERVICE(0x0080, "a00b", 7),
 		CHARACTERISTIC(0xb008, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
 					BT_GATT_CHRC_PROP_READ |
 					BT_GATT_CHRC_PROP_WRITE,
@@ -1623,6 +1623,8 @@ static struct gatt_db *make_test_spec_large_db_1(void)
 		DESCRIPTOR(0xb016, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE, 0x02),
 		DESCRIPTOR(0xb017, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE |
 						BT_ATT_PERM_ENCRYPT, 0x03),
+		DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x01,
+									0x00),
 
 		SECONDARY_SERVICE(0x0001, "a00d", 6),
 		INCLUDE(0x0080),
@@ -2438,7 +2440,7 @@ int main(int argc, char *argv[])
 				0xa0),
 			raw_pdu(0x07, 0x30, 0x00, 0x32, 0x00, 0x50, 0x00, 0x52,
 				0x00, 0x60, 0x00, 0x6b, 0x00, 0x70, 0x00, 0x76,
-				0x00, 0x80, 0x00, 0x85, 0x00),
+				0x00, 0x80, 0x00, 0x86, 0x00),
 			raw_pdu(0x06, 0x86, 0x00, 0xff, 0xff, 0x00, 0x28, 0x0b,
 				0xa0),
 			raw_pdu(0x01, 0x06, 0x86, 0x00, 0x0a));
@@ -2514,7 +2516,7 @@ int main(int argc, char *argv[])
 			ts_large_db_1, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x02, 0x28),
-			raw_pdu(0x09, 0x08, 0x02, 0x00, 0x80, 0x00, 0x85, 0x00,
+			raw_pdu(0x09, 0x08, 0x02, 0x00, 0x80, 0x00, 0x86, 0x00,
 				0x0b, 0xa0, 0x21, 0x00, 0x01, 0x00, 0x06, 0x00,
 				0x0d, 0xa0),
 			raw_pdu(0x08, 0x22, 0x00, 0xff, 0xff, 0x02, 0x28),
-- 
2.5.0

