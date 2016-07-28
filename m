Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] main.conf: Remove spaces in reconnect list parameters
Date: Thu, 28 Jul 2016 17:27:48 +0300
Message-Id: <1469716070-16506-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
References: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These spaces are not removed when parsing the file which may lead to
unexpected behavior when using the values commented out as default.
---
 src/main.conf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.conf b/src/main.conf
index 372fd8c..49528b9 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -71,7 +71,7 @@
 # timeout). The policy plugin should contain a sane set of values by
 # default, but this list can be overridden here. By setting the list to
 # empty the reconnection feature gets disabled.
-#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb, 0000111f-0000-1000-8000-00805f9b34fb, 0000110a-0000-1000-8000-00805f9b34fb
+#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb
 
 # ReconnectAttempts define the number of attempts to reconnect after a link
 # lost. Setting the value to 0 disables reconnecting feature.
@@ -81,7 +81,7 @@
 # attempts.
 # If the number of attempts defined in ReconnectAttempts is bigger than the
 # set of intervals the last interval is repeated until the last attempt.
-#ReconnectIntervals=1, 2, 4, 8, 16, 32, 64
+#ReconnectIntervals=1,2,4,8,16,32,64
 
 # AutoEnable defines option to enable all controllers when they are found.
 # This includes adapters present on start as well as adapters that are plugged
-- 
2.7.4

