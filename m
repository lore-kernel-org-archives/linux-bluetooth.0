Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 03/10] client-doc: Add documentation of MessageAccess.GetFolderListing
Date: Wed, 27 Jun 2012 15:04:48 +0300
Message-Id: <1340798695-6785-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/client-api.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 58a824d..5a960e1 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -352,6 +352,15 @@ Methods		void SetFolder(string name)
 			Set working directory for current session, *name* may
 			be the directory name or '..[/dir]'.
 
+		array{dict} GetFolderListing(dict filter)
+
+			Returns a dictionary containing information about
+			the current folder content.
+
+			The following keys are defined:
+
+				string Name : Folder name
+
 Transfer hierarchy
 ==================
 
-- 
1.7.10.2

