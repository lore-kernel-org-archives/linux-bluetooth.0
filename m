Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: Add extra mode for a reduced LE privacy mode
Date: Fri, 20 Jun 2014 14:06:24 +0200
Message-Id: <1403265984-41194-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e15a78f3e4b7..7001142cede6 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1646,8 +1646,16 @@ Set Privacy Command
 	This command is used to enable Low Energy Privacy feature using
 	resolvable private addresses.
 
-	The value 0x00 disables privacy mode, the value 0x01 enables
-	privacy mode.
+	The value 0x00 disables privacy mode, the values 0x01 and 0x02
+	enable privacy mode.
+
+	With value 0x01 the kernel will always use the privacy mode and
+	this resolvable private addresses. With value 0x02 the kernel will
+	use the identity address when discoverable. When the controller
+	is not discoverable, the resolvable private address is used.
+
+	In addition with value 0x02 the kernel will also use the identity
+	address when pairing is initiated.
 
 	When the controller has a public address (mandatory for dual-mode
 	controllers) it is used as identity address. In case the controller
-- 
1.9.3

