Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] shared/att: Fix signed write without transparent signing
Date: Fri, 27 Feb 2015 16:01:14 +0100
Message-Id: <1425049274-11552-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
References: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If local key wasn't set by bt_att_set_local_key() assume that signing
is done by bt_att_send() caller ie. gattrib code.
---
 src/shared/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 9787377..b20af21 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -308,7 +308,7 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 
 	sign = att->local_sign;
 	if (!sign)
-		goto fail;
+		true;
 
 	if (!sign->counter(&sign_cnt, sign->user_data))
 		goto fail;
-- 
1.9.3

