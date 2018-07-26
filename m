Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] doc/adapter-api: Add Discoverable option to SetDiscoveryFilter
Date: Thu, 26 Jul 2018 17:17:19 +0300
Message-Id: <20180726141723.20199-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the client to set its discoverable setting while
discovering which is very typical situation as usually the setings
application would allow incoming pairing request while scanning, so
this would reduce the number of calls setting Discoverable and
DiscoverableTimeout and restoring after done with discovery.
---
 doc/adapter-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index d14d0ca50..4791af2c7 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -113,6 +113,12 @@ Methods		void StartDiscovery()
 				generated for either ManufacturerData and
 				ServiceData everytime they are discovered.
 
+			bool Discoverable (Default: false)
+
+				Make adapter discoverable while discovering,
+				if the adapter is already discoverable this
+				setting this filter won't do anything.
+
 			When discovery filter is set, Device objects will be
 			created as new devices with matching criteria are
 			discovered regardless of they are connectable or
-- 
2.17.1

