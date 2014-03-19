Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] test: Fix cyclingspeed manager interface name
Date: Wed, 19 Mar 2014 12:34:33 +0100
Message-ID: <1395228873-32719-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1395228873-32719-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1395228873-32719-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-cyclingspeed | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index 4b8d841..393f79c 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -144,7 +144,7 @@ if __name__ == "__main__":
 	device_path = device.object_path
 
 	cscmanager = dbus.Interface(bus.get_object(BUS_NAME, adapter_path),
-						CYCLINGSPEED_WATCHER_INTERFACE)
+						CYCLINGSPEED_MANAGER_INTERFACE)
 
 	watcher_path = "/test/watcher"
 	watcher = Watcher(bus, watcher_path)
-- 
1.9.0

