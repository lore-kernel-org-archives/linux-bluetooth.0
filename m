Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] test/example-gatt-server: Make test service primary
Date: Wed, 21 Sep 2016 22:35:52 +0200
Message-Id: <1474490152-627-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474490152-627-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474490152-627-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to test from Android until included services support is
added.
---
 test/example-gatt-server | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/example-gatt-server b/test/example-gatt-server
index ecf614f..52c2029 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -438,7 +438,7 @@ class TestService(Service):
     TEST_SVC_UUID = '12345678-1234-5678-1234-56789abcdef0'
 
     def __init__(self, bus, index):
-        Service.__init__(self, bus, index, self.TEST_SVC_UUID, False)
+        Service.__init__(self, bus, index, self.TEST_SVC_UUID, True)
         self.add_characteristic(TestCharacteristic(bus, 0, self))
         self.add_characteristic(TestEncryptCharacteristic(bus, 1, self))
         self.add_characteristic(TestSecureCharacteristic(bus, 2, self))
-- 
2.7.4

