Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/5] TODO: Rename glib-helper file to a more convenient name
Date: Mon,  3 Jan 2011 18:45:52 -0300
Message-Id: <1294091154-7367-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 8d34035..319bdf5 100644
--- a/TODO
+++ b/TODO
@@ -14,6 +14,15 @@ Background
   Higher complexity tasks should be refined into several lower complexity tasks
   once the task is better understood.
 
+General
+==========
+
+- Rename glib-helper file to a more convenient name. The ideia is try to keep
+  only sdp helpers functions. bt_* prefix shall be also changed.
+
+  Priority: Low
+  Complexity: C1
+
 Low Energy
 ==========
 
-- 
1.7.3.4

