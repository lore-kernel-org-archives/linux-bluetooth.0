Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 1/4] Add LEAddressType property for Adapter1 and Device1 interfaces
Date: Mon, 11 Dec 2017 11:38:34 +0100
Message-Id: <20171211103837.25150-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This provides information about LE Identity Address Type used. This
information is needed for L2CAP sockets and for PTS testing purposes.
---
 doc/adapter-api.txt | 9 +++++++++
 doc/device-api.txt  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index d852aa6b9..b5abdda39 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -149,6 +149,15 @@ Properties	string Address [readonly]
 
 			The Bluetooth device address.
 
+		string LEAddressType [readonly, optional]
+
+			The Bluetooth device LE Identity Address Type. This is
+			present only if LE is supported by adapter.
+
+			Possible values:
+				"public" - Public address
+				"static" - Static Random address
+
 		string Name [readonly]
 
 			The Bluetooth system name (pretty hostname).
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 8b69c2ef3..dfeca305c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -124,6 +124,15 @@ Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
 
+		string LEAddressType [readonly, optional]
+
+			The Bluetooth device LE Identity Address Type. This is
+			present only if device supports LE.
+
+			Possible values:
+				"public" - Public address
+				"static" - Static Random address
+
 		string Name [readonly, optional]
 
 			The Bluetooth remote name. This value can not be
-- 
2.14.3

