Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] doc: Add new command and events for extended controller index list
Date: Sun, 25 Jan 2015 01:01:08 +0100
Message-Id: <1422144068-129775-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b4bc6836eb69..aef37389c82e 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2310,6 +2310,66 @@ Read Local Out Of Band Extended Data Command
 				Invalid Index
 
 
+Read Extended Controller Index List Command
+===========================================
+
+	Command Code:		0x003c
+	Controller Index:	<non-controller>
+	Command Parameters:
+	Return Parameters:	Num_Controllers (2 Octets)
+				Controller_Index[i] (2 Octets)
+				Controller_Type[i] (1 Octet)
+
+	This command returns the list of currently known controllers. It
+	includes configured, unconfigured and alternate controllers.
+
+	Controllers added or removed after calling this command can be
+	monitored using the Index Added, Index Removed, Unconfigured Index
+	Added and Unconfigured Index Removed events.
+
+	When clients only use this command, then addition and removal of
+	controllers can be monitored using the Extended Index Added and
+	Extended Index Removed events.
+
+	Instead of calling Read Controller Index List and Read Unconfigured
+	Controller Index List, this command combines all the information
+	and can be used to retrieve the controller list.
+
+	The Controller_Type parameter has these values:
+
+		0x00	Primary Controller (BR/EDR and/or LE)
+		0x01	Unconfigured Controller (BR/EDR and/or LE)
+		0x02	Alternate MAC/PHY Controller (AMP)
+
+	The 0x00 and 0x01 types indiciate a primary BR/EDR and/or LE
+	controller. The difference is just if they need extra configuration
+	or if they are fully configured.
+
+	An unconfigured controller can either move to a configured state
+	by indicating Unconfigured Index Removed event followed by an
+	Index Added event; or it can be removed from the system which
+	would be indicated by the Unconfigured Index Removed event.
+
+	Controllers in configured state will be listed as 0x00 and controllers
+	in unconfigured state will be listed as 0x01. A controller that is
+	fully configured and supports configuration changes will be listed
+	as 0x00.
+
+	Alternate MAC/PHY controllers will be listed as 0x02. They do not
+	support the difference between configured and unconfigured state.
+
+	Calling this command and filtering for primary controllers will
+	return the same index list as Read Controller Index List. The same
+	applies for filtering for unconfigured controllers. In that case
+	it is the same as calling Read Unconfigured Controller Index List.
+
+	Controllers marked as RAW only operation are currently not listed
+	by this command.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
 Command Complete Event
 ======================
 
@@ -3035,3 +3095,51 @@ New Configuration Options Event
 
 	This event indicates that one or more of the options for the
 	controller configuration has changed.
+
+
+Extended Index Added Event
+==========================
+
+	Event Code:		0x0020
+	Controller Index:	<controller id>
+	Event Parameters:	Controller_Type[i] (1 Octet)
+
+	This event indicates that a new controller index has been
+	added to the system.
+
+	Clients using the Read Controller Index List command will see
+	the Index Added event instead and not a second event to indicate
+	addition of a controller will be sent.
+
+	Clients using the Read Unconfigured Controller Index List command
+	will see Unconfigured Index Added event instead and not a second
+	event to indicate addition of an unconfigured controller will be sent.
+
+	Clients using only Read Extended Controller Index List will only see
+	this event to indicate addition of any new controller type. However
+	using Read Controller Index List and Read Unconfigured Controller
+	Index List once will force the usage of the existing events.
+
+
+Extended Index Removed Event
+============================
+
+	Event Code:		0x0021
+	Controller Index:	<controller id>
+	Event Parameters:	Controller_Type[i] (1 Octet)
+
+	This event indicates that an existing controller index has been
+	removed from the system.
+
+	Clients using the Read Controller Index List command will see
+	the Index Removed event instead and not a second event to indicate
+	removal of a controller will be sent.
+
+	Clients using the Read Unconfigured Controller Index List command
+	will see Unconfigured Index Removed event instead and not a second
+	event to indicate removal of an unconfigured controller will be sent.
+
+	Clients using only Read Extended Controller Index List will only see
+	this event to indicate removal of any new controller type. However
+	using Read Controller Index List and Read Unconfigured Controller
+	Index List once will force the usage of the existing events.
-- 
2.1.0

