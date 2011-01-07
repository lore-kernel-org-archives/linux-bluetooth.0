Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Remove unused variable from browse_req structure
Date: Fri,  7 Jan 2011 20:00:03 -0300
Message-Id: <1294441204-31780-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index c33b22b..4d53228 100644
--- a/src/device.c
+++ b/src/device.c
@@ -103,7 +103,6 @@ struct browse_req {
 	int search_uuid;
 	int reconnect_attempt;
 	guint listener_id;
-	guint timer;
 };
 
 struct btd_device {
-- 
1.7.4.rc1

