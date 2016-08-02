Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: andrey.zheregelya@dsr-company.com
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>
Subject: [PATCH 2/2] doc/device-api.txt Information about D-Bus LastSeen property
Date: Tue,  2 Aug 2016 18:40:59 +0300
Message-Id: <20160802154059.24472-2-andrey.zheregelya@dsr-company.com>
In-Reply-To: <20160802154059.24472-1-andrey.zheregelya@dsr-company.com>
References: <20160802154059.24472-1-andrey.zheregelya@dsr-company.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>

---
 doc/device-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 087efb9..6387a0c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -216,3 +216,11 @@ Properties	string Address [readonly]
 
 			Indicate whether or not service discovery has been
 			resolved.
+
+    bool LastSeen [readonly, experimantal]
+
+      Unix time of last found device update. 
+      Indicates if device is alive and reachable.
+      Adapter should be in discovery mode.
+      Information about device's reachability is based
+      on advertisement packets.
-- 
2.9.2

