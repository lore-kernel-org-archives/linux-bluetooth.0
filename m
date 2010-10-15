Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Avoid Characteristic discovery for non connectable device
Date: Fri, 15 Oct 2010 10:03:01 -0300
Message-Id: <1287147783-14998-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index 2c17c6b..1d4e789 100644
--- a/TODO
+++ b/TODO
@@ -14,8 +14,17 @@ Background
   Higher complexity tasks should be refined into several lower complexity tasks
   once the task is better understood.
 
-LE Generic Access Profile
-=========================
+Low Energy
+==========
+
+- Avoid Characteristic discovery for non connectable devices. Proper parsing
+  of LE Advertising Report Event is missing. Event_Type field needs to be
+  extracted and its value shall be considered before to start the LE
+  connection on the channel 4. Characteristic discovery should not be
+  started for non connectable devices.
+
+  Priority: Medium
+  Complexity: C2
 
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
-- 
1.7.3.1

