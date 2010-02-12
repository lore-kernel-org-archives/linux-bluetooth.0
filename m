Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Add {deprecated} annotation to ListDevices()
Date: Fri, 12 Feb 2010 16:16:31 -0200
Message-Id: <1265998592-7249-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 213bc02..48cab40 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -80,9 +80,11 @@ Methods		dict GetProperties()
 			Possible Errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.InvalidArguments
 
-		array{object} ListDevices()
+		array{object} ListDevices() {deprecated}
 
 			Returns list of device object paths.
+			This method is deprecated, instead use the Devices
+			Property to get the list of devices object paths.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.Failed
-- 
1.6.4.4

