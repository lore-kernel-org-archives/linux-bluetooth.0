Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] map: Fix dbus call after method rename
Date: Thu, 15 Dec 2011 13:58:02 +0100
Message-Id: <1323953882-5261-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/map-client |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/map-client b/test/map-client
index 1a4afdb..5c7c447 100755
--- a/test/map-client
+++ b/test/map-client
@@ -57,6 +57,6 @@ if  __name__ == '__main__':
         print map.GetFolderListing(dict())
 
     if options.ls_msg is not None:
-	print map.GetMessagesListing(options.ls_msg, dict())
+	print map.GetMessageListing(options.ls_msg, dict())
 
     mainloop.run()
-- 
1.7.4.1

