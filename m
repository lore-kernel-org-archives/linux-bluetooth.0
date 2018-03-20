Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Avichal Agarwal <avichal.a@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
        Avichal Agarwal <avichal.a@samsung.com>
Subject: [PATCH v3 BlueZ 1/2] doc/gatt-api.txt: Add support for Included
 Service
Date: Tue, 20 Mar 2018 10:39:41 +0530
Message-id: <1521522581-13036-1-git-send-email-avichal.a@samsung.com>
References: <CGME20180320051001epcas1p3945a3b9beb4f980540c77f487f0c8d80@epcas1p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

included service support implemented at server side

---
 doc/gatt-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index ccf3a8b..9579381 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -45,7 +45,7 @@ Properties	string UUID [read-only]
 			belongs to. Only present on services from remote
 			devices.
 
-		array{object} Includes [read-only]: Not implemented
+		array{object} Includes [read-only]
 
 			Array of object paths representing the included
 			services of this service.
-- 
2.7.4

