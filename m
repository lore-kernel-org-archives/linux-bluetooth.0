Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] test: Fix opp-client not printing progress
Date: Wed, 10 Apr 2013 17:17:09 +0300
Message-Id: <1365603430-29030-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid KeyError expection and fixes print usage.
---
 test/opp-client | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/test/opp-client b/test/opp-client
index 3078d49..878c263 100755
--- a/test/opp-client
+++ b/test/opp-client
@@ -49,23 +49,25 @@ class OppClient:
 			print("Transfer created: %s" % path)
 
 	def error(self, err):
-		print err
+		print(err)
 		mainloop.quit()
 
 	def properties_changed(self, interface, properties, invalidated, path):
 		if path != self.transfer_path:
 			return
 
-		if properties['Status'] == 'complete' or \
-				properties['Status'] == 'error':
+		if "Status" in properties and \
+				(properties["Status"] == "complete" or \
+				properties["Status"] == "error"):
 			if self.verbose:
-				print("Transfer %s" % properties['Status'])
+				print("Transfer %s" % properties["Status"])
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
1.8.1.4

