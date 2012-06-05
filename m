Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 04/23 v2] agent-api: Change D-Bus namespace to org.bluez.obexd
Date: Tue,  5 Jun 2012 16:02:52 +0300
Message-Id: <1338901391-17138-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/agent-api.txt |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 74f339c..20181a6 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -9,7 +9,7 @@ Agent hierarchy
 ===============
 
 Service		unique name
-Interface	org.openobex.Agent
+Interface	org.bluez.obex.Agent
 Object path	freely definable
 
 Methods
@@ -21,8 +21,8 @@ Methods
 			Returns the full path (including the filename) where
 			the object shall be stored.
 
-			Possible errors: org.openobex.Error.Rejected
-			                 org.openobex.Error.Canceled
+			Possible errors: org.bluez.obex.Error.Rejected
+			                 org.bluez.obex.Error.Canceled
 
 		void Cancel()
 
-- 
1.7.10.2

