Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 05/10] test: Update map-client to the changes in GetMessageListing
Date: Wed, 27 Jun 2012 15:04:50 +0300
Message-Id: <1340798695-6785-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes map-client to print the message properties dictionary
---
 test/map-client |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/map-client b/test/map-client
index da357a9..986fcad 100755
--- a/test/map-client
+++ b/test/map-client
@@ -54,6 +54,9 @@ if  __name__ == '__main__':
 			print "%s/" % (i["Name"])
 
 	if options.ls_msg is not None:
-		print map.GetMessageListing(options.ls_msg, dict())
+		for i in map.GetMessageListing(options.ls_msg, dict()):
+			for (key, value) in i.items():
+				print("%s = %s" % (key, value))
+			print "\n"
 
 	mainloop.run()
-- 
1.7.10.2

