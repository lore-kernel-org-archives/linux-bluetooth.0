Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Fix typos in adapter documentation
Date: Mon, 15 Nov 2010 19:48:03 +0100
Message-Id: <1289846883-8748-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 6a28d30..65e2887 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -178,18 +178,18 @@ Signals		PropertyChanged(string name, variant value)
 
 		DeviceFound(string address, dict values)
 
-			This signal will be send every time an inquiry result
+			This signal will be sent every time an inquiry result
 			has been found by the service daemon. In general they
 			only appear during a device discovery.
 
-			The dictionary can contain bascially the same values
-			that we be returned by the GetProperties method
+			The dictionary can contain basically the same values
+			that are returned by the GetProperties method
 			from the org.bluez.Device interface. In addition there
 			can be values for the RSSI and the TX power level.
 
 		DeviceDisappeared(string address)
 
-			This signal will be send when an inquiry session for
+			This signal will be sent when an inquiry session for
 			a periodic discovery finishes and previously found
 			devices are no longer in range or visible.
 
-- 
1.7.1

