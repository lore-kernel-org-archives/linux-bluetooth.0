Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] test: Fix pbap-client to handle PullAll reply properly
Date: Mon, 17 Dec 2012 15:25:27 +0200
Message-Id: <1355750727-23222-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355750727-23222-1-git-send-email-luiz.dentz@gmail.com>
References: <1355750727-23222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

PullAll reply consist in 2 parameters, the transfer object followed by
its properties not a structure containing both.
---
 test/pbap-client | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/test/pbap-client b/test/pbap-client
index fbe930c..7be8bad 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -33,8 +33,7 @@ class PbapClient:
 				signal_name="Error",
 				path_keyword="path")
 
-	def register(self, reply, transfer):
-		(path, properties) = reply
+	def register(self, path, properties, transfer):
 		transfer.path = path
 		transfer.filename = properties["Filename"]
 		self.props[path] = transfer
@@ -73,15 +72,15 @@ class PbapClient:
 	def pull(self, vcard, params, func):
 		req = Transfer(func)
 		self.pbap.Pull(vcard, "", params,
-				reply_handler=lambda r: self.register(r, req),
-				error_handler=self.error)
+			reply_handler=lambda o, p: self.register(o, p, req),
+			error_handler=self.error)
 		self.transfers += 1
 
 	def pull_all(self, params, func):
 		req = Transfer(func)
 		self.pbap.PullAll("", params,
-				reply_handler=lambda r: self.register(r, req),
-				error_handler=self.error)
+			reply_handler=lambda o, p: self.register(o, p, req),
+			error_handler=self.error)
 		self.transfers += 1
 
 	def flush_transfers(self, func):
-- 
1.7.11.7

