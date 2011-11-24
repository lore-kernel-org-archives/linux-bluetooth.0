Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd 05/10] client-doc: replace parameter dict with conventional ones
Date: Thu, 24 Nov 2011 15:08:57 +0100
Message-ID: <1322143742-31182-6-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The usage of a dictionary as a parameter passing mechanism seems not to
be necessary any more.
---
 doc/client-api.txt |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index a6f30af..67355c6 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -12,27 +12,25 @@ Service		org.openobex.client
 Interface	org.openobex.Client
 Object path	/
 
-Methods		object CreateSession(dict device)
+Methods		object CreateSession(string source, string destination,
+					string target)
 
-			Create a new OBEX session. The device is configured
-			via properties like in SendFiles.
+			Create a new OBEX session for the given source (local)
+			address, destination (remote) address and target. The
+			supported target values are:
+				- "OPP"
+				- "FTP"
+				- "SYNC"
+				- "PBAP"
 
 		void RemoveSession(object session)
 
 			Unregister session and abort pending transfers.
 
-		string GetCapabilities(dict device)
+		string GetCapabilities(string source, string destination)
 
 			Get remote device capabilities.
 
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

