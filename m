Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: avichal <avichal.a@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
        avichal <avichal.a@samsung.com>
Subject: [PATCH BlueZ 1/2] doc/gatt-api.txt: Add support for Included
 Service
Date: Thu, 15 Mar 2018 20:15:36 +0530
Message-id: <1521125138-24229-2-git-send-email-avichal.a@samsung.com>
In-reply-to: <1521125138-24229-1-git-send-email-avichal.a@samsung.com>
References: <avichal.a@samsung.com>
        <1521125138-24229-1-git-send-email-avichal.a@samsung.com>
        <CGME20180315144716epcas1p4a2b031836b8c1977ed9c47edf4645f55@epcas1p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

included service support implemented at server side

Signed-off-by: avichal <avichal.a@samsung.com>
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

