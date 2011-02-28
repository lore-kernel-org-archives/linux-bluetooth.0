Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/4] TODO: Remove item related to Client Characteristic Configuration
Date: Mon, 28 Feb 2011 10:44:11 -0300
Message-Id: <1298900653-7567-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298900653-7567-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298900653-7567-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Client Characteristic Configuration is already implemented in the
attribute server. Implementation in the attribute client is still
missing.
---
 TODO |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/TODO b/TODO
index 45ecb09..cf37179 100644
--- a/TODO
+++ b/TODO
@@ -188,15 +188,6 @@ ATT/GATT
   Priority: Low
   Complexity: C2
 
-- Implement Client Characteristic Configuration support in the attribute
-  server to manage indications and notications. This is a per client attribute
-  to control how the client wants to receive reports of changes in a given
-  characteristic value.
-  See Volume 3, Part G, section 3.3.3.3 for more information
-
-  Priority: Low
-  Complexity: C2
-
 - Define attribute server API. External applications needs to register,
   change attributes and to be notified about changes. Example: Proximity,
   Time and Alert Profiles. "Local Service hierarchy" in the attribute-api
-- 
1.7.4.1

