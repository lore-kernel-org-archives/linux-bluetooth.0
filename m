Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 1/5] doc: Add D-Bus signal to provide disconnect reason
Date: Mon, 14 May 2012 17:33:00 +0200
Message-Id: <1337009584-17181-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This signal is needed to propagate the reason in case of disconnection.
Some use-cases require this information, for example if there is a
policy to automatically reconnect in case of connection timeout.
---
 doc/device-api.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4a170e4..58b0957 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -108,6 +108,20 @@ Signals		PropertyChanged(string name, variant value)
 			disconnection to a remote device has been requested.
 			The actual disconnection will happen 2 seconds later.
 
+		Disconnected(uint8 reason)
+
+			This signal will be sent when the low-level ACL link
+			is disconnected, either because is was explicitly
+			requested (locally initiated) or not.
+
+			The actual reason of the disconnection is given by
+			the first parameter, which is a 8-bit error code as
+			defined in the HCI specification (or 0 if the
+			disconnection is due to a previous request).
+
+			This signal will be sent just before the corresponding
+			state property change to "disconnected".
+
 		NodeCreated(object node)
 
 			Parameter is object path of created device node.
-- 
1.7.7.6

