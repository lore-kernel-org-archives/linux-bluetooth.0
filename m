Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 1/7] attrib-api: Remove local service hierarchy
Date: Mon, 23 Jul 2012 11:55:14 -0400
Message-Id: <1343058920-18608-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local GATT services will now share the same interface as remote
services.
---
 doc/attribute-api.txt |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 98d7f30..5f4209d 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -24,19 +24,6 @@ A service consists of some generic service information and a set of
 characteristics. All characteristic are presented as object path as well.
 
 
-Local Service hierarchy
-=======================
-
-Service		org.bluez
-Interface	org.bluez.Service
-		org.bluez.Characteristic
-Object path	[prefix]/{hci0}/{service0, service1, ...}
-
-Methods
-
-Properties
-
-
 Device Service hierarchy
 ========================
 
-- 
1.7.9.5

