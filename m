Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 1/4] doc: Add IncludeTXPower to LE Advertising API
Date: Fri, 10 Apr 2015 12:06:05 -0700
Message-Id: <1428692768-31941-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/advertising-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 7fb34ee..54ab106 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -61,6 +61,11 @@ Properties	string Type
 			Service Data elements to include. The keys are the
 			UUID to associate with the data.
 
+		bool IncludeTXPower
+
+			Includes the TX Power in the advertising packet.
+			If missing, the TX Power is not included.
+
 
 LE Advertising Manager hierarchy
 ================================
-- 
2.2.0.rc0.207.ga3a616c

