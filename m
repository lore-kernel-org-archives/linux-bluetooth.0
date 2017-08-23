Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ] advertising: Fix UUIDs in adv_parser
Date: Tue, 22 Aug 2017 23:44:58 -0700
Message-Id: <20170823064458.36961-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index f125ca5c8..b03c36fb6 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -496,7 +496,7 @@ static struct adv_parser {
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
 } parsers[] = {
 	{ "Type", parse_type },
-	{ "UUIDs", parse_service_uuids },
+	{ "ServiceUUIDs", parse_service_uuids },
 	{ "SolicitUUIDs", parse_solicit_uuids },
 	{ "ManufacturerData", parse_manufacturer_data },
 	{ "ServiceData", parse_service_data },
-- 
2.14.1.480.gb18f417b89-goog

