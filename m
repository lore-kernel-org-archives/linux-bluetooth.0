Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] test: Fix ftp-client not printing progress
Date: Wed, 02 Dec 2015 19:55:49 +0530
Message-id: <1449066349-2852-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the keyError while printing transfer progress.
---
 test/ftp-client | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/test/ftp-client b/test/ftp-client
index 78c32b3..4540602 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -77,16 +77,18 @@ class FtpClient:
 		if path != self.transfer_path:
 			return
 
-		if properties['Status'] == 'complete' or \
-				properties['Status'] == 'error':
+		if "Status" in properties and \
+				(properties['Status'] == 'complete' or \
+				properties['Status'] == 'error'):
 			if self.verbose:
 				print("Transfer %s" % properties['Status'])
 			mainloop.quit()
 			return
 
-		if properties["Transferred"] == None:
+		if "Transferred" not in properties:
 			return
 
+		value = properties["Transferred"]
 		speed = (value - self.transferred) / 1000
 		print("Transfer progress %d/%d at %d kBps" % (value,
 							self.transfer_size,
-- 
1.9.1

