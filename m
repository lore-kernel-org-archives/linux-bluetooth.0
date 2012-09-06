Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/7 v3] test: Update pbap-client to work with changes in PhonebookAcess
Date: Thu,  6 Sep 2012 12:26:00 +0300
Message-Id: <1346923562-2654-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1346923562-2654-1-git-send-email-luiz.dentz@gmail.com>
References: <1346923562-2654-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/pbap-client | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/test/pbap-client b/test/pbap-client
index 498f8a3..7dd54ef 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -70,16 +70,16 @@ class PbapClient:
 		print "Transfer finished with error %s: %s" % (code, message)
 		mainloop.quit()
 
-	def pull(self, vcard, func):
+	def pull(self, vcard, params, func):
 		req = Transfer(func)
-		self.pbap.Pull(vcard, "",
+		self.pbap.Pull(vcard, "", params,
 				reply_handler=lambda r: self.register(r, req),
 				error_handler=self.error)
 		self.transfers += 1
 
-	def pull_all(self, func):
+	def pull_all(self, params, func):
 		req = Transfer(func)
-		self.pbap.PullAll("",
+		self.pbap.PullAll("", params,
 				reply_handler=lambda r: self.register(r, req),
 				error_handler=self.error)
 		self.transfers += 1
@@ -135,18 +135,15 @@ if  __name__ == '__main__':
 		print "Size = %d\n" % (ret)
 
 		print "\n--- List vCard ---\n"
-		ret = pbap_client.interface().List()
+		ret = pbap_client.interface().List(dbus.Dictionary())
+		params = dbus.Dictionary({ "Format" : "vcard30",
+					"Fields" : [ "VERSION", "FN", "TEL"] })
 		for item in ret:
 			print "%s : %s" % (item[0], item[1])
-			pbap_client.interface().SetFormat("vcard30")
-			pbap_client.interface().SetFilter(["VERSION", "FN",
-								"TEL"]);
-			pbap_client.pull(item[0],
+			pbap_client.pull(item[0], params,
 					lambda x: process_result(x, None))
 
-		pbap_client.interface().SetFormat("vcard30")
-		pbap_client.interface().SetFilter(["VERSION", "FN", "TEL"]);
-		pbap_client.pull_all(lambda x: process_result(x,
+		pbap_client.pull_all(params, lambda x: process_result(x,
 							"\n--- PullAll ---\n"))
 
 		pbap_client.flush_transfers(lambda: test_paths(paths[1:]))
-- 
1.7.11.4

