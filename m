Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ 1/8] monitor: Fix 2-DH5 packet type print
Date: Fri,  6 Jul 2018 16:57:58 +0530
Message-Id: <1530876485-17218-2-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

3-DH5 is printed instaed of 2-DH5
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 6798373..bf69859 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -762,7 +762,7 @@ static const struct {
 	{  9, "3-DH3 may not be used"	},
 	{ 10, "DM3 may be used"		},
 	{ 11, "DH3 may be used"		},
-	{ 12, "3-DH5 may not be used"	},
+	{ 12, "2-DH5 may not be used"	},
 	{ 13, "3-DH5 may not be used"	},
 	{ 14, "DM5 may be used"		},
 	{ 15, "DH5 may be used"		},
-- 
2.7.4
