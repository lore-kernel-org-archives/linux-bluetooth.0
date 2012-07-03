Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 08/10] client-doc: Add documentation of org.bluez.obex.Message
Date: Tue,  3 Jul 2012 21:28:12 +0300
Message-Id: <1341340094-32522-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
References: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

org.bluez.obex.Message have Get method which can be used to
download the contents of message represented by the object.
---
 doc/client-api.txt |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 6f7d13f..1938a38 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -437,6 +437,27 @@ Methods		void SetFolder(string name)
 
 					Message protected flag
 
+Message hierarchy
+=================
+
+Service		org.bluez.obex.client
+Interface	org.bluez.obex.Message
+Object path	[variable prefix]/{session0,session1,...}/{message0,...}
+
+Methods		object, dict Get(string targetfile)
+
+			Download message and store it in the target file.
+
+			If an empty target file is given, a temporary file
+			will be automatically generated.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
+
 Transfer hierarchy
 ==================
 
-- 
1.7.10.4

