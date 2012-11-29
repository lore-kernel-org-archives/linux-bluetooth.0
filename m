Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] media-api: Update documentation of MediaTransport interface
Date: Thu, 29 Nov 2012 11:06:35 +0200
Message-Id: <1354179996-17019-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354179996-17019-1-git-send-email-luiz.dentz@gmail.com>
References: <1354179996-17019-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/media-api.txt | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index a814b60..20aad19 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -261,12 +261,7 @@ Service		org.bluez
 Interface	org.bluez.MediaTransport
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/fdX
 
-Methods		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-		fd, uint16, uint16 Acquire(string accesstype)
+Methods		fd, uint16, uint16 Acquire(string accesstype)
 
 			Acquire transport file descriptor and the MTU for read
 			and write respectively.
@@ -294,13 +289,6 @@ Methods		dict GetProperties()
 
 			Releases file descriptor.
 
-		void SetProperty(string name, variant value)
-
-			Changes the value of the specified property. Only
-			properties that are listed as read-write can be changed.
-
-			On success this will emit a PropertyChanged signal.
-
 Signals		void PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
-- 
1.7.11.7

