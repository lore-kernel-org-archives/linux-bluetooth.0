Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v2 3/3] rfcomm: Fix typo in man page
Date: Mon, 30 Jul 2012 17:06:13 -0300
Message-Id: <1343678773-24050-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1343678773-24050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1343678773-24050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/rfcomm.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rfcomm.1 b/tools/rfcomm.1
index f880f52..51df284 100644
--- a/tools/rfcomm.1
+++ b/tools/rfcomm.1
@@ -108,7 +108,7 @@ parameters.
 .TP
 .BI bind " <dev> [bdaddr] [channel]"
 This binds the RFCOMM device to a remote Bluetooth device. The
-command did not establish a connection to the remote device, it
+command does not establish a connection to the remote device, it
 only creates the binding. The connection will be established right
 after an application tries to open the RFCOMM device. If no channel
 number is specified, it uses the channel number 1.
-- 
1.7.11.3

