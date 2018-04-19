Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] doc/advertising-api: Add Data property
Date: Thu, 19 Apr 2018 16:46:27 +0300
Message-Id: <20180419134630.15624-4-luiz.dentz@gmail.com>
In-Reply-To: <20180419134630.15624-1-luiz.dentz@gmail.com>
References: <20180419134630.15624-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Data property can be used to add advertising data with arbitrary/profile
specific type.
---
 doc/advertising-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 15e64d38a..eef98ad91 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -61,6 +61,23 @@ Properties	string Type
 			Service Data elements to include. The keys are the
 			UUID to associate with the data.
 
+		dict Data [Experimental]
+
+			Advertising Type to include in the Advertising
+			Data. Key is the advertising type and value is the
+			data as byte array.
+
+			Note: Types already handled by other properties shall
+			not be used.
+
+			Possible values:
+				<type> <byte array>
+				...
+
+			Example:
+				<Transport Discovery> <Organization Flags...>
+				0x26                   0x01         0x01...
+
 		array{string} Includes
 
 			List of features to be included in the advertising
-- 
2.14.3

