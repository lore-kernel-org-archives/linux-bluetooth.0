Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] gitignore: Move entries to the right place
Date: Tue, 10 Jul 2012 15:17:15 -0300
Message-Id: <1341944235-6029-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3ff750e..38318cd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,11 +36,13 @@ lib/bluetooth
 src/builtin.h
 src/bluetoothd
 audio/telephony.c
-sap/sap.c
 scripts/bluetooth.rules
 scripts/97-bluetooth.rules
 scripts/97-bluetooth-hid2hci.rules
 
+profiles/sap/sap.c
+profiles/cups/bluetooth
+
 sbc/sbcdec
 sbc/sbcenc
 sbc/sbcinfo
@@ -63,7 +65,6 @@ tools/rfcomm
 tools/l2ping
 tools/ppporc
 tools/sdptool
-cups/bluetooth
 test/agent
 test/bdaddr
 test/hciemu
-- 
1.7.11.1

