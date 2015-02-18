Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 01/11] unit/test-gatt: Fix invalid handle test case
Date: Wed, 18 Feb 2015 16:39:56 +0530
Message-id: <1424257806-25815-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
References: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The main aim of TC TP/GAR/CL/BI-14-C is to check the handle validity.
So, the requested handle in the pdu should be invalid (0x0000).
---
 unit/test-gatt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 441cf34..2fc0595 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1591,7 +1591,7 @@ static const struct test_step test_long_read_4 = {
 };
 
 static const struct test_step test_long_read_5 = {
-	.handle = 0x0003,
+	.handle = 0x0000,
 	.func = test_long_read,
 	.expected_att_ecode = 0x01
 };
@@ -2415,8 +2415,8 @@ int main(int argc, char *argv[])
 	define_test_client("/TP/GAR/CL/BI-14-C", test_client, service_db_1,
 			&test_long_read_5,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x01));
+			raw_pdu(0x0c, 0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x00, 0x00, 0x01));
 
 	define_test_client("/TP/GAR/CL/BI-15-C", test_client, service_db_1,
 			&test_long_read_6,
-- 
1.9.1

