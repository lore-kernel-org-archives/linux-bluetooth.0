Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v5 2/5] map_ap.h: Remove MAP_AP_INVALID
Date: Thu, 19 Jan 2012 18:01:53 +0100
Message-Id: <1326992516-2800-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1326992516-2800-1-git-send-email-lkslawek@gmail.com>
References: <1326992516-2800-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due to the change in MAP AP definitions resolving, there is no need for
guard value.
---
 src/map_ap.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/map_ap.h b/src/map_ap.h
index c0fb79a..24254af 100644
--- a/src/map_ap.h
+++ b/src/map_ap.h
@@ -51,7 +51,6 @@ enum map_ap_tag {
 	MAP_AP_STATUSINDICATOR		= 0x17,		/* uint8_t	*/
 	MAP_AP_STATUSVALUE		= 0x18,		/* uint8_t	*/
 	MAP_AP_MSETIME			= 0x19,		/* char *	*/
-	MAP_AP_INVALID			= 0x100,
 };
 
 /* Data type representing MAP application parameters. Consider opaque. */
-- 
1.7.5.1

