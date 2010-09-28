Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/4] Add SetProperty in the Device characteristic hierarchy
Date: Tue, 28 Sep 2010 14:49:14 -0300
Message-Id: <1285696155-32766-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add SetProperty method to allow characteristic watchers or any other
D-Bus client application to change the value of a given characteristic.
Use cases: Changing sensors thresholds, client characteristic
configuration for notification/indication.
---
 doc/attribute-api.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index a5e475b..d0ce6f8 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -118,6 +118,13 @@ Methods		dict GetProperties()
 			Returns all properties for the characteristic. See the
 			properties section for available properties.
 
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			read-write properties can be changed. On success
+			this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
 
 Properties 	string UUID [readonly]
 
-- 
1.7.3

