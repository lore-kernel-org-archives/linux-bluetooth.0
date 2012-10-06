Return-Path: <cyrus@holtmann.org>
From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Subject: [PATCH 2/3] client-doc: Add documentation for UpdateInbox
Date: Sat,  6 Oct 2012 19:22:12 +0530
Message-Id: <1349531535-706-4-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
In-Reply-To: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index e680427..1222ff3 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -460,6 +460,11 @@ Methods		void SetFolder(string name)
 
 					Message protected flag
 
+		void UpdateInbox(void)
+
+			Requests the MSE to update its inbox.
+
+
 Filter:		uint16 Offset:
 
 			Offset of the first item, default is 0
-- 
1.7.10.4

