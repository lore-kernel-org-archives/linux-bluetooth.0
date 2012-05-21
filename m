Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 10/12] client-doc: Replace parameter dict with conventional ones
Date: Mon, 21 May 2012 11:07:12 +0200
Message-Id: <1337591234-24919-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Required arguments are passed as formal parameters in the D-Bus API, and
an additional dictionary is used to pass target-specific parameters.
This will allow future extensions without breaking the method signature.
---
 doc/client-api.txt |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index a467d40..cfb4ec9 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -11,22 +11,29 @@ Service		org.openobex.client
 Interface	org.openobex.Client
 Object path	/
 
-Methods		object CreateSession(dict device)
+Methods		object CreateSession(string destination, dict args)
 
-			Create a new OBEX session. The device is configured
-			via properties like in SendFiles.
+			Create a new OBEX session for the given remote address.
 
-		void RemoveSession(object session)
+			The last parameter is a dictionary to hold optional or
+			type-specific parameters. Typical parameters that can
+			be set in this dictionary include the following:
 
-			Unregister session and abort pending transfers.
+				string "Target" : type of session to be created
+				string "Source" : local address to be used
+				byte "Channel"
 
-Properties	string Target
+			The currently supported targets are the following:
 
-		string Source
+				"FTP"
+				"MAP"
+				"OPP"
+				"PBAP"
+				"SYNC"
 
-		string Destination
+		void RemoveSession(object session)
 
-		byte Channel
+			Unregister session and abort pending transfers.
 
 Session hierarchy
 =================
-- 
1.7.7.6

