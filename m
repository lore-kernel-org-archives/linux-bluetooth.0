Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCH 1/4] unit/eir: Fix G-tag test data
Date: Thu, 30 Apr 2015 13:26:15 +0200
Message-Id: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds SCAN_RSP data to gigaset_gtag_data.
Since MGMT 1.6 advertising and scan response data are merged.
So eir parser shall be able to parse this data.
---
 unit/test-eir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index 421d0db..53abfa4 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -621,7 +621,9 @@ static const unsigned char gigaset_gtag_data[] = {
 		0x02, 0x01, 0x06, 0x0d, 0xff, 0x80, 0x01, 0x02,
 		0x15, 0x12, 0x34, 0x80, 0x91, 0xd0, 0xf2, 0xbb,
 		0xc5, 0x03, 0x02, 0x0f, 0x18, 0x00, 0x00, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x09,
+		0x47, 0x69, 0x67, 0x61, 0x73, 0x65, 0x74, 0x20,
+		0x47, 0x2d, 0x74, 0x61, 0x67
 };
 
 static const char *gigaset_gtag_uuid[] = {
@@ -635,6 +637,8 @@ static const struct test_data gigaset_gtag_test = {
 	.flags = 0x06,
 	.tx_power = 127,
 	.uuid = gigaset_gtag_uuid,
+	.name = "Gigaset G-tag",
+	.name_complete = true,
 };
 
 static const char *uri_beacon_uuid[] = {
-- 
1.9.1

