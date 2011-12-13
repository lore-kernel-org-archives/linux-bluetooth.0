Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 08/20] client-doc: replace parameter dict with conventional ones
Date: Tue, 13 Dec 2011 17:44:11 +0100
Message-ID: <1323794663-2711-9-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Required arguments are passed as formal parameters in the D-Bus API, and
an additional dictionary is used to pass target-specific parameters.
This will allow future extensions without breaking the method signature.
---
 doc/client-api.txt |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 7a47d78..3b87cb5 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -11,22 +11,28 @@ Service		org.openobex.client
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
+				"OPP"
+				"FTP"
+				"SYNC"
+				"PBAP"
 
-		string Destination
+		void RemoveSession(object session)
 
-		byte Channel
+			Unregister session and abort pending transfers.
 
 Session hierarchy
 =================
-- 
1.7.6.4

