Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] core/profile: Fix MNS record version
Date: Wed,  9 Oct 2013 14:11:39 +0300
Message-Id: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To be able to use OBEX over L2CAP the version number should be at least
0x102, in addition to that ERTM mode should be used to comply to
GOEP 2.0.
---
 src/profile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index e2473a6..6e769c6 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1996,9 +1996,10 @@ static struct default_settings {
 		.name		= "Message Notification",
 		.channel	= MNS_DEFAULT_CHANNEL,
 		.psm		= BTD_PROFILE_PSM_AUTO,
+		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_mns_record,
-		.version	= 0x0100
+		.version	= 0x0102
 	},
 };
 
-- 
1.8.3.1

