Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 01/12] client-doc: Wrap OPP into specific session type
Date: Mon, 21 May 2012 11:07:03 +0200
Message-Id: <1337591234-24919-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This modification makes the OPP API more consistent with the rest of the
supported target types, and also it allows to perform several operations
on the same session.
---
 doc/client-api.txt |   42 +++++++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 7dd83d9..32caa17 100644
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
@@ -76,6 +58,28 @@ Properties	string Source [readonly]
 
 		byte Channel [readonly]
 
+Object Push hierarchy
+=====================
+
+Service		org.openobex.client
+Interface	org.openobex.ObjectPush
+Object path	[variable prefix]/{session0,session1,...}
+
+Methods		void SendFiles(array{string} files)
+
+			Send one or multiple local files to the remote device.
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
1.7.7.6

