Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 7/7] doc: add SimAccess client API
Date: Thu,  4 Aug 2011 16:39:34 -0300
Message-Id: <1312486774-20350-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1312486774-20350-7-git-send-email-padovan@profusion.mobi>
References: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-3-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-4-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-5-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-6-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 doc/simaccess-api.txt |   90 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 doc/simaccess-api.txt

diff --git a/doc/simaccess-api.txt b/doc/simaccess-api.txt
new file mode 100644
index 0000000..e79bae7
--- /dev/null
+++ b/doc/simaccess-api.txt
@@ -0,0 +1,90 @@
+SimAccess client hierarchy
+==========================
+
+Service		org.bluez
+Interface	org.bluez.SimAccessServer
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+This interface is available for remote devices which support remote Sim Access profile.
+It is intended to be used with external application which wants to manage connections and/or
+read remote SIM information.
+
+Methods		void Connect()
+
+			Connect to the Sim Access service on the remote device.
+
+			Possible Errors: org.bluez.Error.AlreadyConnected
+					 org.bluez.Error.AgentNotAvailable
+					 org.bluez.Error.Failed
+
+		void Disconnect()
+
+			Disconnect from the Sim Access service on the remote device
+
+			Possible Errors: org.bluez.Error.NotConnected
+					 org.bluez.Error.InProgress
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+		void RegisterAgent(object path)
+
+			The object path defines the path the of the agent
+			that will be called when a new Sim Access connection
+			is established.
+
+			If an application disconnects from the bus, agent will be
+			automatically unregistered.
+
+			Possible Errors: org.bluez.Error.AlreadyExists
+					 org.bluez.Error.InvalidArguments
+
+		void UnregisterAgent(object path)
+
+			This unregisters the agent that has been previously
+			registered. The object path parameter must match the
+			same value that has been used on registration.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotAuthorized
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string State [readonly]
+
+			Indicates the state of the connection.  Possible
+			values are:
+				"disconnected"
+				"connecting"
+				"connected"
+
+SimAccessAgent hierarchy
+=========================
+
+Service         unique name
+Interface       org.bluez.SimAccessServerAgent
+Object path     freely definable
+
+Methods		void NewConnection(filedescriptor fd)
+
+			This method gets called whenever a new Sim Access
+			connection has been established. This method assumes
+			that DBus daemon with file descriptor passing
+			capability is being used.
+
+			The agent should only return successfully once the
+			remote Sim Access mode has been enabled successfuly.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent. Reply is not required for this
+			method call.
-- 
1.7.6

