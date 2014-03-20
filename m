Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 39/62] Replace att_put_u32() by put_le32()
Date: Thu, 20 Mar 2014 11:43:04 -0300
Message-Id: <1395326607-27068-40-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 918f237..1222532 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -1167,7 +1167,7 @@ static DBusMessage *set_cumulative_wheel_rev(DBusConnection *conn,
 	csc->pending_req = req;
 
 	att_val[0] = SET_CUMULATIVE_VALUE;
-	att_put_u32(value, att_val + 1);
+	put_le32(value, att_val + 1);
 
 	gatt_write_char(csc->attrib, csc->controlpoint_val_handle, att_val,
 		sizeof(att_val), controlpoint_write_cb, req);
-- 
1.8.3.1

