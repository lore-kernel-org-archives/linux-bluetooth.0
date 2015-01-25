Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] doc: Add new command and events for extended controller index list
Date: Sun, 25 Jan 2015 01:36:38 +0100
Message-Id: <1422146198-129941-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b4bc6836eb69..04e2d9408076 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2310,6 +2310,56 @@ Read Local Out Of Band Extended Data Command
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
+	be monitored using the Extended Index Added and Extended Index
+	Removed events.
+
+	The existing Index Added, Index Removed, Unconfigured Index Added
+	and Unconfigured Index Removed are no longer sent after this command
+	has been used at least once.
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
+	Controllers in configured state will be listed as 0x00 and controllers
+	in unconfigured state will be listed as 0x01. A controller that is
+	fully configured and supports configuration changes will be listed
+	as 0x00.
+
+	Alternate MAC/PHY controllers will be listed as 0x02. They do not
+	support the difference between configured and unconfigured state.
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
 
@@ -2363,6 +2413,10 @@ Index Added Event
 	system. It is usually followed by a Read Controller Information
 	command.
 
+	Once the Read Extended Controller Index List command has been
+	used at least once, the Extended Index Added event will be
+	send instead of this one.
+
 
 Index Removed Event
 ===================
@@ -2374,6 +2428,10 @@ Index Removed Event
 	This event indicates that a controller has been removed from the
 	system.
 
+	Once the Read Extended Controller Index List command has been
+	used at least once, the Extended Index Removed event will be
+	send instead of this one.
+
 
 New Settings Event
 ==================
@@ -3014,6 +3072,10 @@ Unconfigured Index Added Event
 	be announced with this event. If it supports configuration, but
 	does not require it, then an Index Added event will be used.
 
+	Once the Read Extended Controller Index List command has been
+	used at least once, the Extended Index Added event will be
+	send instead of this one.
+
 
 Unconfigured Index Removed Event
 ================================
@@ -3025,6 +3087,10 @@ Unconfigured Index Removed Event
 	This event indicates that an unconfigured controller has been
 	removed from the system.
 
+	Once the Read Extended Controller Index List command has been
+	used at least once, the Extended Index Removed event will be
+	send instead of this one.
+
 
 New Configuration Options Event
 ===============================
@@ -3035,3 +3101,33 @@ New Configuration Options Event
 
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
+	This event will only be used after Read Extended Controller Index
+	List has been used at least once. If it has not been used, then
+	Index Added and Unconfigured Index Added are send instead.
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
+	This event will only be used after Read Extended Controller Index
+	List has been used at least once. If it has not been used, then
+	Index Removed and Unconfigured Index Removed are send instead.
-- 
2.1.0

