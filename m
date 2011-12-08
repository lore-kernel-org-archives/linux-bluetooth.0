Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 08/21] client-doc: replace parameter dict with conventional ones
Date: Thu, 8 Dec 2011 16:27:42 +0100
Message-ID: <1323358075-27857-9-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Common arguments are required as formal parameters in the D-Bus API, and
an additional dictionary is used to pass target-specific parameters.
This will allow future extensions without breaking the method signature.
---
 doc/client-api.txt |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 65de1f1..ad92869 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -11,23 +11,24 @@ Service		org.openobex.client
 Interface	org.openobex.Client
 Object path	/
 
-Methods		object CreateSession(dict device)
+Methods		object CreateSession(string source, string destination,
+					string target, dict args)
 
-			Create a new OBEX session. The device is configured
-			via properties like in SendFiles.
+			Create a new OBEX session for the given source (local)
+			address, destination (remote) address and target. The
+			supported target values are:
+				- "OPP"
+				- "FTP"
+				- "SYNC"
+				- "PBAP"
+
+			The fourth argument is used to pass target-specific
+			parameters.
 
 		void RemoveSession(object session)
 
 			Unregister session and abort pending transfers.
 
-Properties	string Target
-
-		string Source
-
-		string Destination
-
-		byte Channel
-
 Session hierarchy
 =================
 
-- 
1.7.6.4

