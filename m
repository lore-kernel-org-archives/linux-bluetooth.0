Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] doc: Add extra mode for Set Advertising management command
Date: Thu, 12 Mar 2015 19:35:47 -0700
Message-Id: <1426214148-9259-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d4df8d94208d..fdca60fc6c1a 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1565,12 +1565,33 @@ Set Advertising Command
 	Return Parameters:	Current_Settings (4 Octets)
 
 	This command is used to enable LE advertising on a controller
-	that supports it. The allowed values for the Advertising
-	command parameter are 0x00 and 0x01. All other values will
-	return Invalid Parameters.
+	that supports it. The allowed values for the Advertising command
+	parameter are 0x00, 0x01 and 0x02. All other values will return
+	Invalid Parameters.
 
-	A pre-requisite is that LE is already enabled, otherwise
-	this command will return a "rejected" response.
+	The value 0x00 disables advertising, the value 0x01 enables
+	advertising with considering of connectable setting and the
+	value 0x02 enables advertising in connectable mode.
+
+	Using value 0x01 means that when connectable setting is disabled,
+	the advertising happens with undirected non-connectable advertising
+	packets and a non-resovable random address is used. If connectable
+	setting is enabled, then undirected connectable advertising packets
+	and the identity address or resolvable private address are used.
+
+	Devices configured via Add Device command have no affect when using
+	value 0x01 since only the connectable setting is taken into account.
+
+	To utilize undirect connectable advertising without changing the
+	connectable setting, the value 0x02 can be utilized. It makes the
+	device connectable via LE without the requirement for being
+	connectable on BR/EDR (and/or LE).
+
+	The value 0x02 should be the preferred mode of operation when
+	implementing peripheral mode.
+
+	A pre-requisite is that LE is already enabled, otherwise this
+	command will return a "rejected" response.
 
 	This command generates a Command Complete event on success or a
 	Command Status event on failure.
-- 
2.1.0

