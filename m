Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/8] doc/advertising-api: Add DiscoverableTimeout property
Date: Tue, 22 May 2018 12:50:09 +0300
Message-Id: <20180522095011.517-6-luiz.dentz@gmail.com>
In-Reply-To: <20180522095011.517-1-luiz.dentz@gmail.com>
References: <20180522095011.517-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This property can control how long an instance is visible.
---
 doc/advertising-api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 96deeeccd..cfce0f9a3 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -86,6 +86,15 @@ Properties	string Type
 			Note: This property shall not be set when Type is set
 			to broadcast.
 
+		uint16 DiscoverableTimeout [Experimental]
+
+			The discoverable timeout in seconds. A value of zero
+			means that the timeout is disabled and it will stay in
+			discoverable/limited mode forever.
+
+			Note: This property shall not be set when Type is set
+			to broadcast.
+
 		array{string} Includes
 
 			List of features to be included in the advertising
-- 
2.14.3

