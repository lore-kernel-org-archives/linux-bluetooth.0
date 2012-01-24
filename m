Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 8/8] simple-agent: add DisplayPinCode
Date: Mon, 23 Jan 2012 16:27:52 -0800
Message-Id: <1327364872-32313-9-git-send-email-scott@netsplit.com>
In-Reply-To: <1327364872-32313-1-git-send-email-scott@netsplit.com>
References: <1327364872-32313-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-agent |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index 8d65860..4416adb 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -52,6 +52,11 @@ class Agent(dbus.service.Object):
 		print "DisplayPasskey (%s, %d)" % (device, passkey)
 
 	@dbus.service.method("org.bluez.Agent",
+					in_signature="os", out_signature="")
+	def DisplayPinCode(self, device, pincode):
+		print "DisplayPinCode (%s, %s)" % (device, pincode)
+
+	@dbus.service.method("org.bluez.Agent",
 					in_signature="ou", out_signature="")
 	def RequestConfirmation(self, device, passkey):
 		print "RequestConfirmation (%s, %d)" % (device, passkey)
-- 
1.7.7.3

