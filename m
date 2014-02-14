Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrick.ohly@intel.com
Subject: [PATCH BlueZ 8/8] doc/obex-api: Update documentation
Date: Fri, 14 Feb 2014 17:53:04 +0200
Message-Id: <1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Suspend and Resume methods and 'suspended' value as status in
the Transfer interface documentation.
---
 doc/obex-api.txt | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 1f22fea..0f57ce1 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -90,12 +90,26 @@ Methods		void Cancel()
 					 org.bluez.obex.Error.InProgress
 					 org.bluez.obex.Error.Failed
 
+		void Suspend()
+
+			Suspend transference.
+
+			Possible errors: org.bluez.obex.Error.NotAuthorized
+					 org.bluez.obex.Error.NotInProgress
+
+		void Resume()
+
+			Resume transference.
+
+			Possible errors: org.bluez.obex.Error.NotAuthorized
+					 org.bluez.obex.Error.NotInProgress
+
 Properties	string Status [readonly]
 
 			Inform the current status of the transfer.
 
-			Possible values: "queued", "active", "complete" or
-					"error"
+			Possible values: "queued", "active", "suspended",
+					"complete" or "error"
 
 		object Session [readonly]
 
-- 
1.8.5.3

