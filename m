Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 1/4] gas: Fix memory leak at gas struct removal
Date: Fri, 30 Nov 2012 15:31:30 -0300
Message-Id: <1354300294-9105-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/gatt/gas.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 0e82097..e6cddad 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -64,6 +64,7 @@ static void gas_free(struct gas *gas)
 	if (gas->attioid)
 		btd_device_remove_attio_callback(gas->device, gas->attioid);
 
+	g_attrib_unref(gas->attrib);
 	btd_device_unref(gas->device);
 	g_free(gas);
 }
-- 
1.7.9.5

