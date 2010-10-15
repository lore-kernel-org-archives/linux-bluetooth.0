Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Define attribute server API
Date: Fri, 15 Oct 2010 10:03:02 -0300
Message-Id: <1287147783-14998-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1287147783-14998-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1287147783-14998-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 1d4e789..b4682e8 100644
--- a/TODO
+++ b/TODO
@@ -129,3 +129,11 @@ ATT/GATT
 
   Priority: Low
   Complexity: C2
+
+- Define attribute server API. External applications needs to register,
+  change attributes and to be notified about changes. Example: Proximity,
+  Time and Alert Profiles. "Local Service hierarchy" in the attribute-api
+  needs to be proposed and a RFC shall be sent to the ML.
+
+  Priority: Low
+  Complexity: C2
-- 
1.7.3.1

