Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH BlueZ 2/3] AVRCP: Defines property Volume for Media Transport interface
Date: Thu, 10 May 2012 16:00:48 +0530
Message-ID: <1336645848-28590-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

This property shall be changed/updated
for Absolute Volume functionality
---
 doc/media-api.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 7a593c3..9ca9a4a 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -341,3 +341,7 @@ Properties	object Device [readonly]
 			Optional. Indicates where is the transport being routed
 
 			Possible Values: "HCI" or "PCM"
+
+		byte Volume [readwrite] 
+			
+			Indicates percentage value of maximum volume. 
-- 
1.7.5.4

