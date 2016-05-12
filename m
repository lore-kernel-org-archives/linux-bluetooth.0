Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gap: Enable external flag
Date: Thu, 12 May 2016 15:48:40 +0200
Message-Id: <1463060920-1175-2-git-send-email-beaufort.francois@gmail.com>
In-Reply-To: <1463060920-1175-1-git-send-email-beaufort.francois@gmail.com>
References: <1463060920-1175-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/gap/gas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 35b996c..e3b2c40 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -306,6 +306,7 @@ static int gap_driver_accept(struct btd_service *service)
 static struct btd_profile gap_profile = {
 	.name		= "gap-profile",
 	.remote_uuid	= GAP_UUID,
+	.external	= true,
 	.device_probe	= gap_driver_probe,
 	.device_remove	= gap_driver_remove,
 	.accept		= gap_driver_accept
-- 
2.7.0

