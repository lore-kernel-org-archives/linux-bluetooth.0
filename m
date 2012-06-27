Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 08/10] client-doc: Add documentation of MessageAccess.GetMessage
Date: Wed, 27 Jun 2012 15:04:53 +0300
Message-Id: <1340798695-6785-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GetMessage takes the message handle, which can be discovered using
GetMessageListing, and file location where the contents of the message
will be stored.

It returns the transfer object and its properties so the user application
can track progress of the operation.
---
 doc/client-api.txt |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 1ad9001..cf16a6a 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -385,6 +385,22 @@ Methods		void SetFolder(string name)
 				boolean Sent: Message sent flag
 				boolean Protected: Message protected flag
 
+		object, dict GetMessage(string handle, string targetfile)
+
+			Download message by its handle, the message handle can
+			be discovered using GetMessageListing, and store it
+			in the target file.
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
1.7.10.2

