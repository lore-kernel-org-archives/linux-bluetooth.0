Return-Path: <cyrus@holtmann.org>
From: Emilio Pozuelo Monfort <pochu27@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] ftp-client: fix syntax error
Date: Thu, 16 May 2013 19:27:23 +0200
Message-Id: <1368725243-21324-1-git-send-email-emilio.pozuelo@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/ftp-client | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/ftp-client b/test/ftp-client
index eec910a..ae3cbcb 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -68,7 +68,7 @@ class FtpClient:
 			print("Operation succeeded")
 
 	def error(self, err):
-		print err
+		print(err)
 		mainloop.quit()
 
 	def properties_changed(self, interface, properties, invalidated, path):
-- 
1.8.3.rc2

