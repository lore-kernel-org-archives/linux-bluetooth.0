Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix potential NULL pointer dereference in smp_conn_security
Date: Mon, 24 Mar 2014 17:36:25 +0200
Message-Id: <1395675385-4680-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The smp pointer might not be initialized for jumps to the "done" label
in the smp_conn_security function. Furthermore doing the set_bit after
done might "overwrite" a previous value of the flag in case pairing was
already in progress. This patch moves the call to set_bit before the
label so that it is only done for a newly created smp context (as
returned by smp_chan_create).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2c7370844731..dfb4e1161c10 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -928,9 +928,9 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
-done:
 	set_bit(SMP_FLAG_INITIATOR, &smp->smp_flags);
 
+done:
 	hcon->pending_sec_level = sec_level;
 
 	return 0;
-- 
1.8.5.3

