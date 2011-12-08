Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 02/21] client-doc: wrap OPP into specific session type
Date: Thu, 8 Dec 2011 16:27:36 +0100
Message-ID: <1323358075-27857-3-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This modification makes the OPP API more consistent with the rest of the
supported target types, and also it allows to perform several operations
on the same session.
---
 doc/client-api.txt |   43 ++++++++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index ceb3c35..65f2c0a 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -11,25 +11,7 @@ Service		org.openobex.client
 Interface	org.openobex.Client
 Object path	/
 
-Methods		void SendFiles(dict device, array{string} files, object agent)
-
-			Send one or multiple local files to the specified
-			device. The device is configured via properties. At
-			least the Destination property should be specified.
-
-		void PullBusinessCard(dict device, string file)
-
-			Request the business card from a remote device and
-			store it in the local file.
-
-		void ExchangeBusinessCards(dict device, string clientfile,
-								string file)
-
-			Push the client's business card to the remote device
-			and then retrieve the remote business card and store
-			it in a local file.
-
-		object CreateSession(dict device)
+Methods		object CreateSession(dict device)
 
 			Create a new OBEX session. The device is configured
 			via properties like in SendFiles.
@@ -76,6 +58,29 @@ Properties	string Source [readonly]
 
 		byte Channel [readonly]
 
+Object Push hierarchy
+=====================
+
+Service		org.openobex.client
+Interface	org.openobex.ObjectPush
+Object path	[variable prefix]/{session0,session1,...}
+
+Methods		void SendFiles(array{string} files, string destination)
+
+			Send one or multiple local files to the remote device,
+			and the given destination.
+
+		void PullBusinessCard(string targetfile)
+
+			Request the business card from a remote device and
+			store it in the local file.
+
+		void ExchangeBusinessCards(string clientfile, string targetfile)
+
+			Push the client's business card to the remote device
+			and then retrieve the remote business card and store
+			it in a local file.
+
 File Transfer hierarchy
 =======================
 
-- 
1.7.6.4

