Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH] mgmt-api: add read Tx power level command
Date: Mon, 12 Mar 2012 00:10:37 +0200
Message-Id: <1331503837-19015-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command reads the Tx power level for a given connected device
---
 doc/mgmt-api.txt |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 4ede43d..8dae2b4 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -815,6 +815,34 @@ Unblock Device Command
 	or failure.
 
 
+Read Tx Power Level Command
+======================
+
+	Command Code:		0x0028
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Status (1 Octet)
+				Level (1 Octet)
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	Possible values for the Type parameter:
+		0	Current Transmit Power Level
+		1	Maximum Transmit Power Level
+
+	This command can only be used when the controller is powered.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+
 Set Device ID Command
 =====================
 
-- 
1.7.5.4

