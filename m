Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/3] unit/test-gatt: Fix duplicate test case number
Date: Mon, 09 Feb 2015 17:53:24 +0530
Message-id: <1423484604-24982-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1423484604-24982-1-git-send-email-gowtham.ab@samsung.com>
References: <1423484604-24982-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

TP/GAR/CL/BI-22-C was duplicated as TP/GAR/CL/BI-21-C.
---
 unit/test-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 22c9823..cd90d83 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2238,7 +2238,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x05));
 
-	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_db_1,
+	define_test_client("/TP/GAR/CL/BI-22-C", test_client, service_db_1,
 			&test_multiple_read_6,
 			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
-- 
1.9.1

