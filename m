Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC 7/7] Update Management API documentation
Date: Wed, 15 Jun 2011 17:03:04 -0400
Message-Id: <4df91d74.0b73650a.190f.17ad@mx.google.com>
In-Reply-To: <1308171784-24442-1-git-send-email-y>
References: <y>
 <1308171784-24442-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Add Read RSSI and Read TX Power level commands in Management API
documentation.
---
 doc/mgmt-api.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 353705e..b442cc5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -319,6 +319,26 @@ Stop Discovery Command
 	Command Parameters:
 	Return Parameters:
 
+Read RSSI Command
+=================
+
+	Command Code:		0x001D
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Parameters:	Status (1 Octet)
+				Address (6 Octets)
+				RSSI (1 Octet)
+
+Read TX Power Level Command
+===========================
+
+	Command Code:		0x001E
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Parameters:	Address (6 Octets)
+				Status (1 Octet)
+				Level (1 Octet)
+
 Read Tracing Buffer Size Command
 ================================
 
-- 
1.7.4.1

