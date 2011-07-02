Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] avrcp: mark signals as deprecated
Date: Sat,  2 Jul 2011 19:42:11 -0300
Message-Id: <1309646531-3681-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Connected and Disconnected are deprecated signals
---
 doc/control-api.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index 1a42846..7d72c1c 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -83,12 +83,12 @@ Methods		void Connect()
 				System		powered, unpowered, unplugged
 				Volume		uint8
 
-Signals		Connected()
+Signals		Connected() {deprecated}
 
 			Sent when a successful AVRCP connection has been made
 			to the remote device.
 
-		Disconnected()
+		Disconnected() {deprecated}
 
 			Sent when the AVRCP connection to the remote device
 			has been disconnected.
-- 
1.7.6

