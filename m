Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable LTK distribution to slave devices
Date: Wed, 29 Jan 2014 13:55:59 -0800
Message-Id: <1391032559-25183-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

So far we've only been requesting the LTK to be distributed to the
master (initiator) of pairing, which is usually enough since it's the
master that will establish future connections and initiate encryption.
However, in the case that both devices support switching to the opposing
role (which seems to be increasingly common) pairing will have to
performed again since the "new" master will not have all information.

As there is no real harm in it, this patch updates the code to always
try distributing the LTK also to the slave device, thereby enabling role
switches for future connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 45007362683b..9b1167007653 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -216,7 +216,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = SMP_OOB_NOT_PRESENT;
 		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-		req->init_key_dist = 0;
+		req->init_key_dist = dist_keys;
 		req->resp_key_dist = dist_keys;
 		req->auth_req = (authreq & AUTH_REQ_MASK);
 		return;
@@ -225,7 +225,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	rsp->io_capability = conn->hcon->io_capability;
 	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
 	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-	rsp->init_key_dist = 0;
+	rsp->init_key_dist = req->init_key_dist & dist_keys;
 	rsp->resp_key_dist = req->resp_key_dist & dist_keys;
 	rsp->auth_req = (authreq & AUTH_REQ_MASK);
 }
-- 
1.8.5.3

