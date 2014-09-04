Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] emulator/bthost: Fix not matching cid data properly
Date: Thu,  4 Sep 2014 17:24:04 +0300
Message-Id: <1409840644-32200-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409840644-32200-1-git-send-email-luiz.dentz@gmail.com>
References: <1409840644-32200-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using bthost_add_l2cap_server the caller expect that both scid and
dcid are the same since the callback only take one value.
---
 emulator/bthost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 1394fca..1fd9ef9 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1226,7 +1226,7 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 
 	cb_data = bthost_find_l2cap_cb_by_psm(bthost, psm);
 	if (cb_data)
-		rsp.dcid = cpu_to_le16(conn->next_cid++);
+		rsp.dcid = rsp.scid;
 	else
 		rsp.result = cpu_to_le16(0x0002); /* PSM Not Supported */
 
-- 
1.9.3

