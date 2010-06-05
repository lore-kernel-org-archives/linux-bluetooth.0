Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 5/5] Document the new Debug and DebugString property
Date: Sat,  5 Jun 2010 04:25:36 -0300
Message-Id: <1275722736-28895-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275722736-28895-4-git-send-email-gustavo@padovan.org>
References: <1275722736-28895-1-git-send-email-gustavo@padovan.org>
 <1275722736-28895-2-git-send-email-gustavo@padovan.org>
 <1275722736-28895-3-git-send-email-gustavo@padovan.org>
 <1275722736-28895-4-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/manager-api.txt |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index d2c1caf..07d4fde 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -22,6 +22,15 @@ Methods		dict GetProperties()
 			Possible Errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.InvalidArguments
 
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed a read-write are changeable.
+			On success this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
 		object DefaultAdapter()
 
 			Returns object path for the default adapter.
@@ -72,3 +81,13 @@ Signals		PropertyChanged(string name, variant value)
 Properties	array{object} Adapters [readonly]
 
 			List of adapter object paths.
+
+		boolean Debug [readwrite]
+
+			Switch dynamic debug on or off.
+
+		string DebugString [readwrite]
+
+			Change the dynamic debug match string. Use it to
+			restrict debug to specific files. The default value is
+			"*" to debug all files.
-- 
1.7.1

