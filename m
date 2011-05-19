Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Removed unused variable "secmode3" in btd_device
Date: Thu, 19 May 2011 11:15:40 -0300
Message-Id: <1305814540-13342-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9b8591b..271c14c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -127,9 +127,6 @@ struct btd_device {
 
 	gboolean	connected;
 
-	/* Whether were creating a security mode 3 connection */
-	gboolean	secmode3;
-
 	sdp_list_t	*tmp_records;
 
 	gboolean	trusted;
-- 
1.7.5.rc3

