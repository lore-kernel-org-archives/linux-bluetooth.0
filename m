Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/6] Add org.bluez.ThermometerWatcher interface to default policy
Date: Wed,  9 Nov 2011 11:52:00 +0100
Message-Id: <1320835923-10989-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1320835923-10989-3-git-send-email-sancane@gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
 <1320835923-10989-2-git-send-email-sancane@gmail.com>
 <1320835923-10989-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/bluetooth.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index b5a6af3..664dbd9 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -15,6 +15,7 @@
     <allow send_interface="org.bluez.MediaEndpoint"/>
     <allow send_interface="org.bluez.MediaPlayer"/>
     <allow send_interface="org.bluez.Watcher"/>
+    <allow send_interface="org.bluez.ThermometerWatcher"/>
   </policy>
 
   <policy at_console="true">
-- 
1.7.7.2

