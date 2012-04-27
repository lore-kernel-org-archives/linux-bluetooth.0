Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] mgmtops: Fix wrong parameter order for btd_event_ltk_notify()
Date: Fri, 27 Apr 2012 10:57:02 -0400
Message-Id: <1335538622-8271-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "master" parameter was in the wrong place.
---
 plugins/mgmtops.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

To those interested, this was not noticed before because:

* We don't use the stored information yet (although we will probably use soon
  the "authenticated" field for ATT requests that return "Insufficient
  Authentication")
* The storage types for master/authenticated/enc_size are compatible.

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index ddd544d..22fa329 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1694,9 +1694,9 @@ static void mgmt_new_ltk(int sk, uint16_t index, void *buf, size_t len)
 
 	if (ev->store_hint) {
 		btd_event_ltk_notify(&info->bdaddr, &ev->key.addr.bdaddr,
-				ev->key.addr.type, ev->key.val,
+				ev->key.addr.type, ev->key.val, ev->key.master,
 				ev->key.authenticated, ev->key.enc_size,
-				ev->key.master, ev->key.ediv, ev->key.rand);
+				ev->key.ediv, ev->key.rand);
 	}
 
 	if (ev->key.master)
-- 
1.7.5.4

