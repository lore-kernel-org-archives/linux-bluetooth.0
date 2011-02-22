Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/7] TODO: Remove interactive gatttool item
Date: Tue, 22 Feb 2011 17:43:07 -0300
Message-Id: <1298407391-19260-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/TODO b/TODO
index 5ee892c..8cb205a 100644
--- a/TODO
+++ b/TODO
@@ -105,14 +105,6 @@ ATT/GATT
   Priority: Medium
   Complexity: C2
 
-- gatttool: add an interactive command prompt mode. Many LE devices
-  expect the connection to stay up a long time and disable advertising
-  after a disconnection so it's inconvenient to use gatttool in the
-  current "single operation at a time" mode.
-
-  Priority: Medium
-  Complexity: C2
-
 - gatttool should have the ability to wait for req responses before
   quitting (some servers require a small sleep even with cmd's). Maybe a
   --delay-exit or --timeout command line switch.
-- 
1.7.4.1

