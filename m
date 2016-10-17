Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 1/2] unit/test-gatt: Add /TP/GAD/CL/BV-02-C-1-alternative
Date: Mon, 17 Oct 2016 12:02:31 +0200
Message-Id: <1476698552-8030-1-git-send-email-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to GATT.TS.4.2.1,
4.4.3 TP/GAD/CL/BV-02-C [Discover Primary Services by Service UUID – by Client]

Pass verdict is also when response has end_handle = 0xffff.
This patch add such test.
---
 unit/test-gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 8129719..c7a8fa5 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2414,6 +2414,14 @@ int main(int argc, char *argv[])
 					0x18),
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
+	define_test_att("/TP/GAD/CL/BV-02-C-1-alternative",
+			test_search_primary, &uuid_16,
+			NULL,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
+					0x18),
+			raw_pdu(0x07, 0x01, 0x00, 0xFF, 0xFF));
+
 	define_test_att("/TP/GAD/CL/BV-02-C-2", test_search_primary, &uuid_128,
 			NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
-- 
2.7.4

