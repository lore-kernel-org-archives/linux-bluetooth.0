Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [RFC 2/3] test/obex: Add AuthorizeGet on Agent2 interface
Date: Fri, 10 Jul 2015 20:41:51 +0530
Message-id: <1436541112-21844-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
References: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Expose method for authroizing opp GET request.
---
 test/simple-obex-agent | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/test/simple-obex-agent b/test/simple-obex-agent
index 05ec4ed..41cd386 100755
--- a/test/simple-obex-agent
+++ b/test/simple-obex-agent
@@ -15,6 +15,7 @@ BUS_NAME = 'org.bluez.obex'
 PATH = '/org/bluez/obex'
 AGENT_MANAGER_INTERFACE = 'org.bluez.obex.AgentManager1'
 AGENT_INTERFACE = 'org.bluez.obex.Agent1'
+AGENT_INTERFACE_2 = 'org.bluez.obex.Agent2'
 TRANSFER_INTERFACE = 'org.bluez.obex.Transfer1'
 
 def ask(prompt):
@@ -55,6 +56,32 @@ class Agent(dbus.service.Object):
 		print("Authorization Canceled")
 		self.pending_auth = False
 
+	@dbus.service.method(AGENT_INTERFACE_2, in_signature="",
+							out_signature="s")
+	def AuthorizeGet(self):
+		self.pending_auth = True
+		auth = ask("Authorize (Y/n):")
+
+		if auth == "n" or auth == "N":
+			self.pending_auth = False
+			raise dbus.DBusException(
+					"org.bluez.obex.Error.Rejected: "
+					"Not Authorized")
+
+		self.pending_auth = False
+		path = ask("Filename location:")
+
+		if path == "":
+			path = "vcard.vcf"
+
+		return path
+
+	@dbus.service.method(AGENT_INTERFACE_2, in_signature="",
+							out_signature="")
+	def Cancel(self):
+		print("Authorization Canceled")
+		self.pending_auth = False
+
 if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
-- 
1.9.1

