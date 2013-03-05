Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] test: Adapt map-client interface org.bluez.obex.Message2
Date: Tue,  5 Mar 2013 12:13:00 +0100
Message-Id: <1362481981-7813-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1362481981-7813-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1362481981-7813-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 test/map-client | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/map-client b/test/map-client
index f3c657f..48b2e12 100755
--- a/test/map-client
+++ b/test/map-client
@@ -17,7 +17,7 @@ PATH = '/org/bluez/obex'
 CLIENT_INTERFACE = 'org.bluez.obex.Client1'
 SESSION_INTERFACE = 'org.bluez.obex.Session1'
 MESSAGE_ACCESS_INTERFACE = 'org.bluez.obex.MessageAccess1'
-MESSAGE_INTERFACE = 'org.bluez.obex.Message1'
+MESSAGE_INTERFACE = 'org.bluez.obex.Message2'
 TRANSFER_INTERFACE = 'org.bluez.obex.Transfer1'
 
 def unwrap(x):
-- 
1.8.1.4

