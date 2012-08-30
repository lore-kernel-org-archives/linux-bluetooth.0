Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v4 01/15] core: Fix missing g_io_channel_ref
Date: Thu, 30 Aug 2012 19:15:46 -0300
Message-Id: <1346364960-7699-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
References: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 3b44d9b..2c40ec2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2027,7 +2027,7 @@ static gboolean att_connect(gpointer user_data)
 		return FALSE;
 	}
 
-	device->att_io = io;
+	device->att_io = g_io_channel_ref(io);
 
 	return FALSE;
 }
-- 
1.7.11.4

