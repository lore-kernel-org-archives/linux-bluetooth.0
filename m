Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 7/9] deviceinfo: Fix indentation and tab misuse
Date: Fri, 27 Apr 2012 10:36:50 -0400
Message-Id: <1335537412-26478-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 deviceinfo/deviceinfo.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 6345f52..5dd9293 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -104,8 +104,8 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	device_set_pnpid(ch->d->dev,value[0],att_get_u16(&value[1]),
-				att_get_u16(&value[3]),	att_get_u16(&value[5]));
+	device_set_pnpid(ch->d->dev, value[0], att_get_u16(&value[1]),
+				att_get_u16(&value[3]), att_get_u16(&value[5]));
 }
 
 static void process_deviceinfo_char(struct characteristic *ch)
-- 
1.7.5.4

