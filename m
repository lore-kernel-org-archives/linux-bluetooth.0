Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 5/7] TODO: Add item for static random address
Date: Tue, 22 Feb 2011 17:43:09 -0300
Message-Id: <1298407391-19260-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 4c5cd55..b5e4d09 100644
--- a/TODO
+++ b/TODO
@@ -72,6 +72,12 @@ Low Energy
   Priority: Medium
   Complexity: C1
 
+- Static random address setup and storage. Once this address is written
+  in the a given remote, the address can not be changed anymore.
+
+  Priority: Low
+  Complexity: C1
+
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
   ideia is to report the value of this characteristic using DeviceFound signals.
-- 
1.7.4.1

