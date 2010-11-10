Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv2 7/7] simple-agent - add RequestApproval method for OOB pairing
Date: Wed, 10 Nov 2010 14:31:17 +0100
Message-ID: <1289395877-12384-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1289395877-12384-1-git-send-email-szymon.janc@tieto.com>
References: <1289395877-12384-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-agent |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index f2cc3dd..43f03fe 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -69,6 +69,16 @@ class Agent(dbus.service.Object):
 		raise Rejected("Mode change by user")
 
 	@dbus.service.method("org.bluez.Agent",
+			in_signature="o", out_signature="")
+
+	def RequestApproval(self, device):
+		print "RequestApproval (%s)" % (device)
+		approve = raw_input("Approve pairing (yes/no): ")
+		if (approve == "yes"):
+			return
+		raise Rejected("Not approved")
+
+	@dbus.service.method("org.bluez.Agent",
 					in_signature="", out_signature="")
 	def Cancel(self):
 		print "Cancel"
-- 
1.7.1

