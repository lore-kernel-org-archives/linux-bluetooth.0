Return-Path: <cyrus@holtmann.org>
From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Subject: [PATCH 3/4] client-doc: Add documentation for Message.SetProperty and Message.GetProperties
Date: Thu,  4 Oct 2012 19:52:39 +0530
Message-Id: <1349360560-21631-3-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
In-Reply-To: <1349360560-21631-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349360560-21631-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 25fd3e4..e680427 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -534,6 +534,85 @@ Methods		object, dict Get(string targetfile, boolean attachment)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
+		dict GetProperties()
+
+			Returns all properties for the message. See the
+			properties section for available properties.
+
+		void SetProperty (string name, variant value)
+
+			Sets value to the mentioned property.
+
+			Possible properties: Read and Deleted.
+
+
+Properties	string Subject [readonly]
+
+			Message subject
+
+		string Timestamp [readonly]
+
+			Message timestamp
+
+		string Sender [readonly]
+
+			Message sender name
+
+		string SenderAddress [readonly]
+
+			Message sender address
+
+		string ReplyTo [readonly]
+
+			Message Reply-To address
+
+		string Recipient [readonly]
+
+			Message recipient name
+
+		string RecipientAddress [readonly]
+
+			Message recipient address
+
+		string Type [readonly]
+
+			Message type
+
+			Possible values: "EMAIL", "SMS_GSM",
+			"SMS_CDMA" and "MMS"
+
+		uint64 Size [readonly]
+
+			Message size in bytes
+
+		string Status [readonly]
+
+			Message reception status
+
+			Possible values: "complete",
+			"fractioned" and "notification"
+
+		boolean Priority [readonly]
+
+			Message priority flag
+
+		boolean Read [read/write]
+
+			Message read flag
+
+		boolean Deleted [writeonly]
+
+			Message read flag
+
+		boolean Sent [readonly]
+
+			Message sent flag
+
+		boolean Protected [readonly]
+
+			Message protected flag
+
+
 Transfer hierarchy
 ==================
 
-- 
1.7.10.4

