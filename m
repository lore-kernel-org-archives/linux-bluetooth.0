Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/1] doc: MAP Notification API
Date: Mon, 24 Jun 2013 09:56:28 +0200
Message-Id: <1372060588-4595-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1372060588-4595-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1372060588-4595-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 22449c4..6faa0bf 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -711,6 +711,10 @@ Filter:		uint16 Offset:
 			Possible values: True for high priority or False for
 			non-high priority
 
+Properties	boolean MemoryAvailable [readonly]
+
+			Indicate memory full / memory available status
+
 Message hierarchy
 =================
 
@@ -800,3 +804,14 @@ Properties	string Subject [readonly]
 		boolean Protected [readonly]
 
 			Message protected flag
+
+		string Folder [readonly]
+
+			Message folder
+
+		string DeliveryStatus [readonly]
+
+			Message delivery status (only for outgoing messages)
+
+			Possible values: "delivery-success", "sending-success",
+			"delivery-failure" and "sending-failure"
-- 
1.8.2.3

