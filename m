Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 02/10] test: Update map-client to the changes in GetFolderListing
Date: Wed, 27 Jun 2012 15:04:47 +0300
Message-Id: <1340798695-6785-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes map-client to print only the name of the folders similar
to what ftp-client does.
---
 test/map-client |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/map-client b/test/map-client
index bf843f3..da357a9 100755
--- a/test/map-client
+++ b/test/map-client
@@ -50,7 +50,8 @@ if  __name__ == '__main__':
 		set_folder(map, options.new_dir)
 
 	if options.ls_dir:
-		print map.GetFolderListing(dict())
+		for i in map.GetFolderListing(dict()):
+			print "%s/" % (i["Name"])
 
 	if options.ls_msg is not None:
 		print map.GetMessageListing(options.ls_msg, dict())
-- 
1.7.10.2

