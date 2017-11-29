Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 4/4] doc/mgmt-api: Update Duration Parameter description of Add Advertising
Date: Wed, 29 Nov 2017 12:22:53 +0530
Message-Id: <1511938373-22396-5-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e7453ea..afc43da 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2670,6 +2670,9 @@ Add Advertising Command
 	A value of 0 indicates a default value is chosen for the
 	Duration. The default is 2 seconds.
 
+	Duration parameter will be ignored if controller supports extended
+	advertising and instance scheduling will be done by the controller.
+
 	If only one advertising Instance has been added, then the Duration
 	value will be ignored. It only applies for the case where multiple
 	Instances are configured. In that case every Instance will be
-- 
2.7.4

