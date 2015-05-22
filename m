Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] tests/example-advertisement: Change type to peripheral
Date: Fri, 22 May 2015 13:15:42 +0300
Message-Id: <1432289742-23389-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1432289742-23389-1-git-send-email-luiz.dentz@gmail.com>
References: <1432289742-23389-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With broadcast type it won't be connectable which is much more convenient
when testing.
---
 test/example-advertisement | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/example-advertisement b/test/example-advertisement
index 151ddfe..ce6e40f 100755
--- a/test/example-advertisement
+++ b/test/example-advertisement
@@ -115,7 +115,7 @@ class Advertisement(dbus.service.Object):
 class TestAdvertisement(Advertisement):
 
     def __init__(self, bus, index):
-        Advertisement.__init__(self, bus, index, 'broadcast')
+        Advertisement.__init__(self, bus, index, 'peripheral')
         self.add_service_uuid('180D')
         self.add_service_uuid('180F')
         self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
-- 
2.1.0

