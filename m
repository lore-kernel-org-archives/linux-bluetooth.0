Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: =?UTF-8?q?=5BRFC=20BlueZ=20v0=201/2=5D=20Add=20Alert=20Agent=20API?=
Date: Fri, 27 Jan 2012 18:10:28 -0300
Message-Id: <1327698629-11104-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1327698629-11104-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1327698629-11104-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Generic API to control and read platform ringer and alerts. Maps one
or a group of commands defined in the Phone Alert Status Profile to
methods and signals implemented by the agent.
---
 doc/alert-api.txt |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 doc/alert-api.txt

diff --git a/doc/alert-api.txt b/doc/alert-api.txt
new file mode 100644
index 0000000..3fd2487
--- /dev/null
+++ b/doc/alert-api.txt
@@ -0,0 +1,79 @@
+BlueZ D-Bus Alert Agent API description
+***************************************
+
+Copyright (C) 2012 Anderson Lizardo <anderson.lizardo@gmail.com>
+Copyright (C) 2012 Claudio Takahasi <claudio.takahasi@gmail.com>
+Copyright (C) 2012 João Paulo Rechi Vita <jprvita@gmail.com>
+
+Alert hierarchy
+===============
+
+Service		org.bluez
+Interface	org.bluez.Alert
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void RegisterAgent(object agent)
+
+			Register a Phone Alert agent responsible
+			for interact with the platform's ringer.
+
+			Possible Errors: org.bluez.Error.AlreadyExists
+
+		void UnregisterAgent(object agent)
+
+			This unregisters the agent that has been previously
+			registered. The object path parameter must match the
+			same value that has been used on registration.
+
+			Possible errors: org.bluez.Error.DoesNotExist
+
+Phone Alert Agent hierarchy
+===========================
+
+Service		unique name
+Interface	org.bluez.PhoneAlertAgent
+Object path	freely definable
+
+Generic API to control and expose platform ringer and alerts.
+
+Methods 	dict GetProperties()
+
+			Returns all properties for the agent. See the
+			properties section for available properties.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as readwrite are changeable.
+			On success this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
+		void SetMuteOnce()
+
+			Silence the platform's alerts temporarily. If
+			ringing or vibrating, the agent will disable the
+			alert temporarily. Ringer mode is not affected by
+			this action.
+
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	uint8 RingerMode [readwrite]
+
+			Current value of platform's ringer mode. Values:
+			0 - Ringer Silent
+			1 - Ringer Normal
+			2  to 255 - Reserved
+
+		uint8 AlertStatus [readonly]
+
+			Current value of platform's alert status. Exposes
+			Ringer, Vibrator and Display current states.
-- 
1.7.8.1

