Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] Add rule to enabling talking to org.bluez.MediaEndpoint
Date: Mon, 13 Sep 2010 17:15:29 +0300
Message-Id: <1284387337-18822-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto Von Dentz <luiz.dentz-von@nokia.com>

---
 src/bluetooth.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 56e7a83..354e5e0 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -12,6 +12,7 @@
     <allow send_destination="org.bluez"/>
     <allow send_interface="org.bluez.Agent"/>
     <allow send_interface="org.bluez.HandsfreeAgent"/>
+    <allow send_interface="org.bluez.MediaEndpoint"/>
   </policy>
 
   <policy at_console="true">
-- 
1.7.1

