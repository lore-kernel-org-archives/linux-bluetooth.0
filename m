Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] gap: Fix not handling accept properly
Date: Mon, 12 Sep 2016 17:07:33 +0300
Message-Id: <1473689259-9523-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On accept the profile shall check about existing attribute, etc and once
done call btd_service_connecting_complete updating the service state
properly.
---
 profiles/gap/gas.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 35b996c..b10b6ac 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -300,6 +300,13 @@ static int gap_driver_accept(struct btd_service *service)
 	bt_uuid16_create(&gap_uuid, GAP_UUID16);
 	gatt_db_foreach_service(db, &gap_uuid, foreach_gap_service, gas);
 
+	if (!gas->attr) {
+		error("GAP attribute not found");
+		return -1;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
 	return 0;
 }
 
-- 
2.7.4

