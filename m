Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 01/23 v2] obexd-api: Change D-Bus namespace to org.bluez.obexd
Date: Tue,  5 Jun 2012 16:02:49 +0300
Message-Id: <1338901391-17138-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

obexd not longer depend on openobex so it doesn't make any sense to use
its namespace.
---
 doc/obexd-api.txt |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/obexd-api.txt b/doc/obexd-api.txt
index a7920f4..3244479 100644
--- a/doc/obexd-api.txt
+++ b/doc/obexd-api.txt
@@ -8,8 +8,8 @@ Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
 Manager hierarchy
 ===============
 
-Service		org.openobex
-Interface	org.openobex.Manager
+Service		org.bluez.obex
+Interface	org.bluez.obex.Manager
 Object path	/
 
 Methods
@@ -19,7 +19,7 @@ Methods
 			the user to accept/reject objects. Object push
 			service needs to authorize each received object.
 
-			Possible errors: org.openobex.Error.AlreadyExists
+			Possible errors: org.bluez.obex.Error.AlreadyExists
 
 		void UnregisterAgent(object agent)
 
@@ -27,7 +27,7 @@ Methods
 			registered. The object path parameter must match the
 			same value that has been used on registration.
 
-			Possible errors: org.openobex.Error.DoesNotExist
+			Possible errors: org.bluez.obex.Error.DoesNotExist
 
 Signals		SessionCreated(object session)
 			
@@ -54,8 +54,8 @@ Signals		SessionCreated(object session)
 Transfer hierarchy
 ===============
 
-Service		org.openobex
-Interface	org.openobex.Transfer
+Service		org.bluez.obex
+Interface	org.bluez.obex.Transfer
 Object path	/transfer{0, 1, 2, ...}
 
 Methods
@@ -70,8 +70,8 @@ Signals
 Session hierarchy
 ===============
 
-Service		org.openobex
-Interface	org.openobex.Session
+Service		org.bluez.obex
+Interface	org.bluez.obex.Session
 Object path	/session{0, 1, 2, ...}
 
 Methods
-- 
1.7.10.2

