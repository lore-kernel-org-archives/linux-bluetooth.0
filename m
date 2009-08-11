Return-Path: <cyrus@holtmann.org>
Message-Id: <200908110622.n7B6MsPa013874@home.pavel.comp>
From: Paul Fertser <fercerpav@gmail.com>
Date: Tue, 11 Aug 2009 10:19:13 +0400
Subject: [PATCH] network-api: improve documentation
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Information about ways of specifying uuids and about disconnect conditions.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 doc/network-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 7271193..d935863 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -17,6 +17,14 @@ Methods		string Connect(string uuid)
 			device name. Examples of the device name are bnep0,
 			bnep1 etc.
 
+			uuid can be either one of "gn"/"panu"/"nap" (case
+			insensitive) or traditional string representation
+			of uuid or a hexadecimal number.
+
+			The connection will be closed and network device
+			released either upon calling Disconnect() or when
+			the client disappears from the bus.
+
 			Possible errors: org.bluez.Error.AlreadyConnected
 					 org.bluez.Error.ConnectionAttemptFailed
 
-- 
1.6.0.6

