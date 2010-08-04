Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	rshaffer@codeaurora.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH] Use a valid PSM as the default in l2test.
Date: Wed,  4 Aug 2010 15:31:13 -0700
Message-Id: <1280961073-22296-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth spec requires PSMs to be odd numbers, with the least
significant bit of the most significant byte set to 0.  This
change is a prerequisite for PSM validation in the kernel.
---
 test/l2test.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 0bb46f3..32cd27a 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -87,7 +87,7 @@ static long buffer_size = 2048;
 
 /* Default addr and psm */
 static bdaddr_t bdaddr;
-static unsigned short psm = 10;
+static unsigned short psm = 0x1001;
 
 /* Default number of frames to send (-1 = infinite) */
 static int num_frames = -1;
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
