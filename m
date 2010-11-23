Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv4 7/7] Add RequestPairing method in simple-agent for accepting incoming OOB pairing requests
Date: Tue, 23 Nov 2010 11:53:12 +0100
Message-ID: <1290509592-9262-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-agent |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index f2cc3dd..bbadd31 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -69,6 +69,16 @@ class Agent(dbus.service.Object):
 		raise Rejected("Mode change by user")
 
 	@dbus.service.method("org.bluez.Agent",
+			in_signature="o", out_signature="")
+
+	def RequestPairing(self, device):
+		print "RequestPairing (%s)" % (device)
+		pair = raw_input("Incoming pairing request, allow? (yes/no): ")
+		if (pair == "yes"):
+			return
+		raise Rejected("Not allowed")
+
+	@dbus.service.method("org.bluez.Agent",
 					in_signature="", out_signature="")
 	def Cancel(self):
 		print "Cancel"
-- 
1.7.1

