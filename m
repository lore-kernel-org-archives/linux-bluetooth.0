Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/7] doc/advertising-api: Add Data property
Date: Wed, 18 Apr 2018 14:04:59 +0300
Message-Id: <20180418110502.13099-4-luiz.dentz@gmail.com>
In-Reply-To: <20180418110502.13099-1-luiz.dentz@gmail.com>
References: <20180418110502.13099-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Data property can be used to add advertising data with arbitrary/profile
specific type.
---
 doc/advertising-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 15e64d38a..758c4e687 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -61,6 +61,12 @@ Properties	string Type
 			Service Data elements to include. The keys are the
 			UUID to associate with the data.
 
+		dict Data [Experimental]
+
+			Advertising Type to include in the Advertising
+			Data. Key is the advertising type and value is the
+			data as byte array.
+
 		array{string} Includes
 
 			List of features to be included in the advertising
-- 
2.14.3

