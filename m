Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v6 4/4] doc/mgmt-api: Update Duration Parameter description of Add Advertising
Date: Wed, 28 Feb 2018 17:37:48 +0530
Message-Id: <1519819668-7664-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1519819668-7664-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1519819668-7664-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 7973b62..cac84d2 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2671,6 +2671,9 @@ Add Advertising Command
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

