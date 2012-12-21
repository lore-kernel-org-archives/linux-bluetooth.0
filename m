Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 01/25] mgmt-api: Broadcaster/Observer management API
Date: Fri, 21 Dec 2012 16:26:28 -0400
Message-Id: <1356121612-15172-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

Add new management commands for enabling or disabling broadcasting and
observation modes, as defined by the Observer and Broadcaster GAP roles
on the Core specification 4.0.

The commands can also be used for adding information to EIR on BR/EDR
controllers. For a list of all available AD/EIR types, see the Core
Specification Supplement (CSS) document.

Note that some AD/EIR types are managed internally by the kernel and are
not available through these new commands.
---
 doc/mgmt-api.txt |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 60f4da4..fe052af 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -141,6 +141,8 @@ Read Controller Information Command
 		8	Basic Rate/Enhanced Data Rate
 		9	High Speed
 		10	Low Energy
+		11	Broadcaster
+		12	Observer
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -845,6 +847,68 @@ Set Device ID Command
 	a Command Status event on failure.
 
 
+Set Controller Data Command
+===========================
+
+	Command Code:		0x0029
+	Controller Index:	<controller id>
+	Command Parameters:	Flags (1 Octet)
+				Type (1 Octet)
+				Length (1 Octet)
+				Data (0-255 Octets)
+	Return Parameters:
+
+	This command can be used to set AD for LE capable controllers or EIR
+	for BR/EDR controllers. Multiple AD/EIR types can be configured by
+	calling this command multiple times. If the controller is BR/EDR/LE
+	capable (also known as "dual mode"), only the LE advertising is set.
+
+	The Flags parameter is currently unused, but it will contain bitwise
+	flags to fine tune how and when the data will set on the controller.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Unset Controller Data Command
+=============================
+
+	Command Code:		0x002A
+	Controller Index:	<controller id>
+	Command Parameters:	Type (1 Octet)
+	Return Parameters:
+
+	Remove the AD/EIR information identified by Type, so it will not be
+	broadcasted anymore.
+
+	This command generates a Command Complete event on success or
+	on failure.
+
+
+Set Broadcaster Command
+=======================
+
+	Command Code:		0x002B
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
+	Command Code:		0x002C
+	Controller Index:	<controller id>
+	Command Parameters:	Observer (1 Octet)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
 Command Complete Event
 ======================
 
-- 
1.7.9.5

