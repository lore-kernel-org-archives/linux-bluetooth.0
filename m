Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 2/3] Add generic descriptor support to Attribute API document
Date: Wed, 16 Feb 2011 16:13:40 -0200
Message-Id: <1297880021-31728-2-git-send-email-epx@signove.com>
In-Reply-To: <1297880021-31728-1-git-send-email-epx@signove.com>
References: <1297880021-31728-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes extensions to Attribute API, giving access to all
characteristic descriptors (beyond 'Description' and 'Format').
---
 doc/attribute-api.txt |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 23808e6..5ee189e 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -104,6 +104,14 @@ Methods		dict GetProperties()
 
 			Possible Errors: org.bluez.Error.InvalidArguments
 
+		void SetDescriptorValue(object descriptor, array{byte} value)
+
+			Sets descriptor value, provided that it is writable.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotAuthorized
+
+
 Properties 	string UUID [readonly]
 
 			UUID128 of this characteristic.
@@ -143,6 +151,26 @@ Properties 	string UUID [readonly]
 			Friendly representation of the Characteristic Value
 			based on the format attribute.
 
+		dict Descriptors [readonly]
+
+			List of descriptors for this characteristic.
+
+			This list contains only the descriptors not already
+			covered by other properties (v.g. Description, Format).
+
+			Each descriptor is mapped to an unique object path,
+			which is the key for the dict.
+
+			Each dict value is, in turn, a dict with at least
+			the following keys:
+
+			{
+				"UUID": string (descriptor UUID - mandatory),
+				"Value": array of bytes (raw descriptor value -
+					 optional, shows up when value can be
+					 fetched)
+			}
+
 
 Characteristic Watcher hierarchy
 ===============================
-- 
1.7.1

