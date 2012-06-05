Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 07/23 v2] client-api: Change D-Bus namespace to org.bluez.obex.client
Date: Tue,  5 Jun 2012 16:02:55 +0300
Message-Id: <1338901391-17138-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/client-api.txt |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 2165c22..6d2c05f 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -8,8 +8,8 @@ Copyright (C) 2011-2012  BMW Car IT GmbH. All rights reserved.
 Client hierarchy
 ================
 
-Service		org.openobex.client
-Interface	org.openobex.Client
+Service		org.bluez.obex.client
+Interface	org.bluez.obex.Client
 Object path	/
 
 Methods		object CreateSession(string destination, dict args)
@@ -39,7 +39,7 @@ Methods		object CreateSession(string destination, dict args)
 Session hierarchy
 =================
 
-Service		org.openobex.client
+Service		org.bluez.obex.client
 Interface	org.openobex.Session
 Object path	[variable prefix]/{session0,session1,...}
 
@@ -60,7 +60,7 @@ Properties	string Source [readonly]
 Object Push hierarchy
 =====================
 
-Service		org.openobex.client
+Service		org.bluez.obex.client
 Interface	org.openobex.ObjectPush
 Object path	[variable prefix]/{session0,session1,...}
 
@@ -110,7 +110,7 @@ Methods		object, dict SendFile(string sourcefile)
 File Transfer hierarchy
 =======================
 
-Service		org.openobex.client
+Service		org.bluez.obex.client
 Interface	org.openobex.FileTransfer
 Object path	[variable prefix]/{session0,session1,...}
 
@@ -183,7 +183,7 @@ Methods		void ChangeFolder(string folder)
 Phonebook Access hierarchy
 =======================
 
-Service		org.openobex.client
+Service		org.bluez.obex.client
 Interface	org.openobex.PhonebookAccess
 Object path	[variable prefix]/{session0,session1,...}
 
@@ -297,7 +297,7 @@ Methods		void Select(string location, string phonebook)
 Synchronization hierarchy
 =======================
 
-Service		org.openobex.client
+Service		org.bluez.obex.client
 Interface	org.openobex.Synchronization
 Object path	[variable prefix]/{session0,session1,...}
 
@@ -343,7 +343,7 @@ Methods		void SetLocation(string location)
 Message Access hierarchy
 =========================
 
-Service		org.openobex.client
+Service		org.bluez.obex.client
 Interface	org.openobex.MessageAccess
 Object path	[variable prefix]/{session0,session1,...}
 
@@ -355,7 +355,7 @@ Methods		void SetFolder(string name)
 Transfer hierarchy
 ==================
 
-Service		org.openobex.client
+Service		org.bluez.obex.client
 Interface	org.openobex.Transfer
 Object path	[variable prefix]/{transfer0,transfer1,...}
 
-- 
1.7.10.2

