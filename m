Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 07/13] peripheral: Disable support for static random addresses
Date: Thu,  2 Jul 2015 11:33:48 -0300
Message-Id: <1435847634-22831-8-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is mostly to make testing easier. I don't have any device which
support this properly.
---
 peripheral/gap.c  | 2 +-
 peripheral/gatt.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/peripheral/gap.c b/peripheral/gap.c
index fe65700..9c45057 100644
--- a/peripheral/gap.c
+++ b/peripheral/gap.c
@@ -48,7 +48,7 @@ static bool adv_features = false;
 static bool adv_instances = false;
 static bool require_connectable = true;
 
-static uint8_t static_addr[6] = { 0x90, 0x78, 0x56, 0x34, 0x12, 0xc0 };
+static uint8_t static_addr[6] = { 0 };
 static uint8_t dev_name[260] = { 0x00, };
 static uint8_t dev_name_len = 0;
 
diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index a859adc..0cb4f6d 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -285,8 +285,7 @@ void gatt_server_start(void)
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_cid = htobs(ATT_CID);
-	memcpy(&addr.l2_bdaddr, static_addr, 6);
-	addr.l2_bdaddr_type = BDADDR_LE_RANDOM;
+	addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
 
 	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		fprintf(stderr, "Failed to bind ATT server socket: %m\n");
-- 
2.4.5

