Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/7] TODO: Change item related to read/write long characteristic
Date: Tue, 22 Feb 2011 17:43:08 -0300
Message-Id: <1298407391-19260-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/TODO b/TODO
index 8cb205a..4c5cd55 100644
--- a/TODO
+++ b/TODO
@@ -155,7 +155,8 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
-- Long reads/writes don't work (consisting of multiple request packets)
+- Long write is not implemented. Attribute server, client and command line
+  tool shall be changed to support this feature.
 
   Priority: Low
   Complexity: C2
-- 
1.7.4.1

