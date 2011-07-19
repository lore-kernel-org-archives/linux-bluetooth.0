Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH] Add RSSI Monitor documentation API
Date: Tue, 19 Jul 2011 19:15:33 -0300
Message-Id: <1311113733-7425-2-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <1311113733-7425-1-git-send-email-anderson.briglia@openbossa.org>
References: <1311113733-7425-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds new Management API in order to implement a RSSI Monitor.
It will be used on Proximity profile, at least.
---
 doc/mgmt-api.txt |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e5cf5de..4e7cd03 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -388,6 +388,30 @@ Write Controller Tracing Filter Command
 	Return Parameters:	Status (1 Octet)
 
 
+Enable RSSI Monitor Command
+===========================
+
+	Command Code:		<not yet assigned>
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octects)
+				Low_Alert_Trigger (1 Octect)
+				High_Alert_Trigger (1 Octect)
+	Return Parameters:	Status (1 Octet)
+
+	Low/High_Alert_Trigger range: -128 to 127 dBm
+	The alert trigger values are used to determine when a RSSI Monitor
+	Alert event will be sent.
+
+
+Disable RSSI Monitor Command
+============================
+
+	Command Code:		<not yet assigned>
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octects)
+	Return Parameters:	Status (1 Octet)
+
+
 Command Complete Event
 ======================
 
@@ -552,3 +576,19 @@ Discovering Event
 Event Code		0x00014
 Controller Index	<controller id>
 Event Parameters	Discovering (1 Octet)
+
+
+RSSI Monitor Alert Event
+========================
+
+Event Code		<not yet assigned>
+Controller Index	<controller id>
+Event Parameters	Address (6 octets)
+			Alert_Type (1 Octet)
+
+	Alert_Type:	0x00 In Range
+			0x01 Low
+			0x02 High
+
+	The Monitor Alert Event is sent when a configured trigger
+	is reached (see Enable RSSI Monitor cmd).
-- 
1.7.4.1

