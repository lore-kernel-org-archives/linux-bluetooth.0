Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 8/9] TODO: Remove item related to GATT service over basic rate
Date: Mon, 11 Apr 2011 15:26:16 -0300
Message-Id: <1302546376-24272-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-8-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-8-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/TODO b/TODO
index d52808b..461b179 100644
--- a/TODO
+++ b/TODO
@@ -114,16 +114,6 @@ Low Energy
 ATT/GATT
 ========
 
-- For BR/EDR, primary services can be registered based on the information
-  extracted from the service records. UUIDs, start and end handles information
-  are available in the record, Discover All Primary Services procedure is not
-  necessary. If a GATT service doesn't export a service record means that
-  it should not be used over BR/EDR. Don't start this task before to move the
-  attribute client code to the bluetoothd core.
-
-  Priority: Medium
-  Complexity: C1
-
 - At the moment authentication and authorization is not supported at the
   same time, read/write requirements in the attribute server needs to
   be extended. According to Bluetooth Specification a server shall check
-- 
1.7.4.1

