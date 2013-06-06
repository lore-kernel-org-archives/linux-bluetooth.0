Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC v0 5/5] test: add requestdiscoverable command to test-adapter
Date: Thu,  6 Jun 2013 15:18:59 +0100
Message-Id: <1370528339-7921-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
References: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 test/test-adapter | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/test-adapter b/test/test-adapter
index 5deeda4..764330d 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -136,6 +136,14 @@ if (args[0] == "discoverabletimeout"):
 		adapter.Set("org.bluez.Adapter1", "DiscoverableTimeout", to)
 	sys.exit(0)
 
+if (args[0] == "requestdiscoverable"):
+	adapter1 = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+					"org.bluez.Adapter1")
+	adapter1.RequestDiscoverable()
+	time.sleep(20);
+	adapter1.ReleaseDiscoverable()
+	sys.exit(0)
+
 if (args[0] == "discovering"):
 	discovering = adapter.Get("org.bluez.Adapter1", "Discovering")
 	print(discovering)
-- 
1.8.1.4

