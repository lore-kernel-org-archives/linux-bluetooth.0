Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Add doc for the Icon property
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-opVUxikPHbruIZp9s7XB"
Date: Thu, 23 Oct 2008 21:59:38 +0100
Message-Id: <1224795578.2895.165.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-opVUxikPHbruIZp9s7XB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As mentioned on IRC.

--=-opVUxikPHbruIZp9s7XB
Content-Disposition: attachment; filename="0001-Add-doc-for-the-device-Icon-property.patch"
Content-Type: text/x-patch; name="0001-Add-doc-for-the-device-Icon-property.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From d07e3ab49f75a2bb37611d3fe1f5320a34987447 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 23 Oct 2008 21:57:06 +0100
Subject: [PATCH] Add doc for the device Icon property

.
---
 doc/device-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 9e39946..b2010f6 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -169,3 +169,11 @@ Properties	string Address [readonly]
 		object Adapter [readonly]
 
 			The object path of the adpater the device belongs to.
+
+		string Icon [readonly]
+
+			The icon name for the remote device. The icon name
+			follows the Icon Naming specification from
+			freedesktop.org. For unknown, or unrecognised types
+			of devices, this is simply "bluetooth".
+
-- 
1.6.0.3


--=-opVUxikPHbruIZp9s7XB--

