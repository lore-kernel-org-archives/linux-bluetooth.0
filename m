Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ] mgmt-api: Broadcaster/Observer management API
Date: Wed, 11 Jul 2012 17:34:48 -0300
Message-Id: <1342038888-10102-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1342038888-10102-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1342038888-10102-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add new management commands for enabling or disabling broadcasting and
observation modes, as defined by the Observer and Broadcaster GAP roles
on the Core specification 4.0.

The commands can also be used for adding information to EIR on BR/EDR
controllers. For a list of all available AD/EIR types, see the Core
Specification Suplement (CSS) document.

Note that some AD/EIR types are managed internally by the kernel and are
not available thhrough these new commands.
---
 doc/mgmt-api.txt |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 51c9b46..1841434 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -139,6 +139,8 @@ Read Controller Information Command
 		8	Basic Rate/Enhanced Data Rate
 		9	High Speed
 		10	Low Energy
+		11	Broadcaster
+		12	Observer
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -845,6 +847,74 @@ Set Device ID Command
 	a Command Status event on failure.
 
 
+Set Broadcaster Command
+=======================
+
+	Command Code:		0x0029
+	Controller Index:	<controller id>
+	Command Parameters:	Broadcaster (1 Octet)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Set Observer Command
+====================
+
+	Command Code:		0x002A
+	Controller Index:	<controller id>
+	Command Parameters:	Observer (1 Octet)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Set Controller Data Command
+===========================
+
+	Command Code:		0x002B
+	Controller Index:	<controller id>
+	Command Parameters:	Flags (1 Octet)
+				Data_Type (1 Octet)
+				Data_Length (1 Octet)
+				Data (0-255 Octets)
+	Return Parameters:
+
+	This command can be used to set AD for LE capable controllers or EIR
+	for BR/EDR controllers. Multiple AD/EIR types can be configured by
+	calling this command multiple times. If the data does not fit on a
+	single AD/EIR on the controller, it will be rotated based on the "High
+	priority" flag, so data with this flag set will stay longer over the
+	air than those with this flag cleared.
+
+	Data_Type is the AD Type or EIR data type related to the provided data.
+
+	The following bits are defined for the Flags parameter:
+		0	High priority
+		1	Add to LE advertising data
+		2	Add to BR/EDR EIR
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Remove Controller Data Command
+==============================
+
+	Command Code:		0x002C
+	Controller Index:	<controller id>
+	Command Parameters:	Data_Type (1 Octet)
+	Return Parameters:
+
+	Remove the AD/EIR information identified by Data_Type, so it will not
+	be broadcasted anymore.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
 Command Complete Event
 ======================
 
-- 
1.7.9.5

