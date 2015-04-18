Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 3/3] client: Make command info print TxPower and RSSI
Date: Fri, 17 Apr 2015 18:09:32 -0700
Message-Id: <1429319372-25172-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
References: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes command info to also print TxPower and RSSI if available.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index 5250a33..46ef72a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -952,6 +952,8 @@ static void cmd_info(const char *arg)
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
 	print_property(proxy, "ServiceData");
+	print_property(proxy, "RSSI");
+	print_property(proxy, "TxPower");
 }
 
 static void pair_reply(DBusMessage *message, void *user_data)
-- 
2.2.0.rc0.207.ga3a616c

