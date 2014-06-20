Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] doc: Add extra mode for a reduced LE privacy mode
Date: Fri, 20 Jun 2014 23:52:58 +0200
Message-Id: <1403301178-18988-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e15a78f3e4b7..dfcf719dc757 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1646,8 +1646,25 @@ Set Privacy Command
 	This command is used to enable Low Energy Privacy feature using
 	resolvable private addresses.
 
-	The value 0x00 disables privacy mode, the value 0x01 enables
-	privacy mode.
+	The value 0x00 disables privacy mode, the values 0x01 and 0x02
+	enable privacy mode.
+
+	With value 0x01 the kernel will always use the privacy mode. This
+	means resolvable private address is used when the controller is
+	discoverable and also when pairing is initiated.
+
+	With value 0x02 the kernel will use privacy mode with resolvable
+	private address. In case the conroller is pairable and discoverable
+	the identity address is used. Also when pairing is initiated, the
+	connection will be established with the identity address.
+
+	Exposing the identity address when pairable and discoverable or
+	during initated pairing can be a privacy issue. For dual-mode
+	controllers this can be neglected since its public address will
+	be exposed over BR/EDR anyway. The benefit of exposing the
+	identity address for pairing purposes is that it makes matching
+	up devices with dual-mode topology during device discovery now
+	possible.
 
 	When the controller has a public address (mandatory for dual-mode
 	controllers) it is used as identity address. In case the controller
-- 
1.9.3

