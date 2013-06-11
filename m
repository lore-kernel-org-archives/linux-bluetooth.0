Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 9/9] test: add pairing command to test-adapter
Date: Tue, 11 Jun 2013 11:56:27 +0100
Message-Id: <1370948187-3702-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
References: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

It creates and then release the Pairing Session after 20 seconds.
---
 test/test-adapter | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/test-adapter b/test/test-adapter
index 5deeda4..2ed5348 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -136,6 +136,14 @@ if (args[0] == "discoverabletimeout"):
 		adapter.Set("org.bluez.Adapter1", "DiscoverableTimeout", to)
 	sys.exit(0)
 
+if (args[0] == "pairing"):
+	adapter1 = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+					"org.bluez.Adapter1")
+	adapter1.EnablePairing()
+	time.sleep(20);
+	adapter1.DisablePairing()
+	sys.exit(0)
+
 if (args[0] == "discovering"):
 	discovering = adapter.Get("org.bluez.Adapter1", "Discovering")
 	print(discovering)
-- 
1.8.1.4

