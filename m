Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@hotmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 8/8] simple-agent: add DisplayPinCode
Date: Thu,  5 Apr 2012 15:29:40 -0700
Message-Id: <1333664980-29165-9-git-send-email-scott@netsplit.com>
In-Reply-To: <1333664980-29165-1-git-send-email-scott@netsplit.com>
References: <1333664980-29165-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-agent |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index af84815..38d0235 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -52,6 +52,11 @@ class Agent(dbus.service.Object):
 		print "DisplayPasskey (%s, %06d)" % (device, passkey)
 
 	@dbus.service.method("org.bluez.Agent",
+					in_signature="os", out_signature="")
+	def DisplayPinCode(self, device, pincode):
+		print "DisplayPinCode (%s, %s)" % (device, pincode)
+
+	@dbus.service.method("org.bluez.Agent",
 					in_signature="ou", out_signature="")
 	def RequestConfirmation(self, device, passkey):
 		print "RequestConfirmation (%s, %06d)" % (device, passkey)
-- 
1.7.7.3

