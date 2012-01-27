Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 2/2] Add Alert Notification API
Date: Fri, 27 Jan 2012 18:10:29 -0300
Message-Id: <1327698629-11104-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1327698629-11104-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1327698629-11104-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Generic API to access platform notifications. Maps one or a group of
commands defined in the Alert Notification Profile to methods and
signals implemented by the agent.
---
 doc/alert-api.txt |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/doc/alert-api.txt b/doc/alert-api.txt
index 3fd2487..037141a 100644
--- a/doc/alert-api.txt
+++ b/doc/alert-api.txt
@@ -12,10 +12,10 @@ Service		org.bluez
 Interface	org.bluez.Alert
 Object path	[variable prefix]/{hci0,hci1,...}
 
-Methods		void RegisterAgent(object agent)
+Methods		void RegisterAgent(object agent, string uuid)
 
-			Register a Phone Alert agent responsible
-			for interact with the platform's ringer.
+			Register a Phone Alert or Alert Notification agent
+			responsible for interact with the platform's ringer.
 
 			Possible Errors: org.bluez.Error.AlreadyExists
 
@@ -77,3 +77,51 @@ Properties	uint8 RingerMode [readwrite]
 
 			Current value of platform's alert status. Exposes
 			Ringer, Vibrator and Display current states.
+
+
+Alert Notification Agent hierarchy
+==================================
+
+Service		unique name
+Interface	org.bluez.AlertNotificationAgent
+Object path	freely definable
+
+Generic API to control and expose platform alerts.
+
+Methods 	dict GetProperties()
+
+			Returns all properties for the agent. See the
+			properties section for available properties.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+		NewAlert(uint8 category, uint16 count, string last)
+
+			Signal sent from the platform/agent indicating the
+			amount of new alerts not acknowledged by the user.
+			"last" is implementation specific field to represent
+			the subject, sender or any other content related to
+			the alert(s).
+
+		UnreadAlert(uint8 category, uint16 count)
+
+			Signal sent from the platform/agent indicating the
+			amount of unread alerts not acknowledged by the user.
+
+
+Properties	uint16 SupportedNewAlerts[readOnly]
+
+			Represents supported New Alert Category in the
+			platform.
+
+		uint16 SupportedUnreadAlerts[readOnly]
+
+			Represents Alert Category ID Bit Mask for supported
+			unread alert category in the platform.
-- 
1.7.8.1

