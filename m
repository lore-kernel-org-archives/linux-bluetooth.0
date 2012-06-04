Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 02/15] client-doc: ObjectPush sessions return transfers
Date: Mon,  4 Jun 2012 15:50:15 +0200
Message-Id: <1338817828-12166-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 doc/client-api.txt |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 3b5444d..a57f6c2 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -63,21 +63,49 @@ Service		org.openobex.client
 Interface	org.openobex.ObjectPush
 Object path	[variable prefix]/{session0,session1,...}
 
-Methods		void SendFile(string sourcefile)
+Methods		object, dict SendFile(string sourcefile)
 
 			Send one local file to the remote device.
 
-		void PullBusinessCard(string targetfile)
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
+
+		object, dict PullBusinessCard(string targetfile)
 
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
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
+
+		object, dict ExchangeBusinessCards(string clientfile,
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
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
+
 File Transfer hierarchy
 =======================
 
-- 
1.7.7.6

