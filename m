Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] test: Allow to pass custom DataType to test-health-sink
Date: Thu,  3 Jul 2014 16:32:56 +0200
Message-Id: <1404397976-7940-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1404397976-7940-1-git-send-email-szymon.janc@tieto.com>
References: <1404397976-7940-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-health-sink | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/test/test-health-sink b/test/test-health-sink
index 2343a23..37e630a 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -23,9 +23,13 @@ loop = GObject.MainLoop()
 
 bus = dbus.SystemBus()
 
+type = 4103
+if len(sys.argv) > 1:
+	type = int(sys.argv[1])
+
 hdp_manager = dbus.Interface(bus.get_object(BUS_NAME, PATH),
 						HEALTH_MANAGER_INTERFACE)
-app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(4103),
+app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(type),
 					"Role": "sink"})
 
 print(app_path)
-- 
1.9.1

