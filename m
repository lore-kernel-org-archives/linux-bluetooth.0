Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 9/9] TODO: Add hard-coded PSM for GATT over basic rate
Date: Mon, 11 Apr 2011 15:26:34 -0300
Message-Id: <1302546394-24310-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-9-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-9-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 461b179..fab3ec0 100644
--- a/TODO
+++ b/TODO
@@ -136,6 +136,11 @@ ATT/GATT
   Priority: Medium
   Complexity: C1
 
+- Fix hard-coded PSM for GATT services over basic rate.
+
+  Priority: Low
+  Complexity: C1
+
 - Refactor read_by_group() and read_by_type() in src/attrib-server.c
   (they've grown simply too big). First step could be to move out the
   long for-loops to new functions called e.g. get_groups() and get_types().
-- 
1.7.4.1

