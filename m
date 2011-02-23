Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/2 v3] Add generic descriptor support to Attribute API document
Date: Wed, 23 Feb 2011 10:49:39 -0300
Message-Id: <1298468980-2215-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes extensions to Attribute API, giving access to all
characteristic descriptors (beyond 'Description' and 'Format').

Client Characteristic Configuration automatic update upon Watcher
registering will be handled by another patch series.
---
 doc/attribute-api.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 23808e6..bb7cbfa 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -104,6 +104,7 @@ Methods		dict GetProperties()
 
 			Possible Errors: org.bluez.Error.InvalidArguments
 
+
 Properties 	string UUID [readonly]
 
 			UUID128 of this characteristic.
@@ -143,6 +144,35 @@ Properties 	string UUID [readonly]
 			Friendly representation of the Characteristic Value
 			based on the format attribute.
 
+		dict Descriptors [readwrite]
+
+			Dict of descriptors for this characteristic.
+
+			This dict contains only the descriptors not already
+			covered by other properties (v.g. Description, Format).
+
+			Each descriptor is mapped to an unique object path,
+			which is the dict key.
+
+			Each dict value is, in turn, a dict with at least
+			the following keys:
+
+			{
+				"UUID": string. Descriptor UUID, always present
+				"Value": array of bytes. Raw descriptor value,
+					 present only when/if descriptor value
+					 has been fetched.
+			}
+
+			When updating a descriptor value using SetProperty(),
+			only one descriptor at a time may be updated in order
+			to guarantee unambiguous error reporting. In other
+			words, when calling SetProperty('Descriptors', dict),
+			dict must have exactly one entry.
+
+			Descriptor's UUID may not be updated. If present, it is
+			ignored by SetProperty().
+
 
 Characteristic Watcher hierarchy
 ===============================
-- 
1.7.1

