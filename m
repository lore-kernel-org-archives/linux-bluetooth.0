Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 12/20] client-doc: ObjectPush sessions return transfers
Date: Tue, 13 Dec 2011 17:44:15 +0100
Message-ID: <1323794663-2711-13-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 50b0b6f..00f56e1 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -72,21 +72,43 @@ Service		org.openobex.client
 Interface	org.openobex.ObjectPush
 Object path	[variable prefix]/{session0,session1,...}
 
-Methods		void SendFile(string sourcefile)
+Methods		object SendFile(string sourcefile)
 
 			Send one local file to the remote device.
 
-		void PullBusinessCard(string targetfile)
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+		object PullBusinessCard(string targetfile)
 
 			Request the business card from a remote device and
 			store it in the local file.
 
-		void ExchangeBusinessCards(string clientfile, string targetfile)
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			This object will represent the whole list of files in a
+			single transfer.
+
+		object ExchangeBusinessCards(string clientfile,
+							string targetfile)
 
 			Push the client's business card to the remote device
 			and then retrieve the remote business card and store
 			it in a local file.
 
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
 File Transfer hierarchy
 =======================
 
-- 
1.7.6.4

