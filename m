Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 06/20] Bluetooth: A2MP: Remove AMP manager in state_change
Date: Wed,  2 Nov 2011 16:02:34 +0200
Message-Id: <1320242568-372-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle BT_CLOSED state change by removing AMP manager.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index d505c77..190827f 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -110,8 +110,20 @@ static void state_change_worker(struct work_struct *w)
 {
 	struct a2mp_work_state_change *work = (struct a2mp_work_state_change *) w;
 	struct sock *sk = work->sk;
+	struct amp_mgr *mgr;
+
+	BT_DBG("sk %p state %d", sk, sk->sk_state);
+
+	switch(sk->sk_state) {
+	case BT_CLOSED:
+		mgr = get_amp_mgr_sk(sk);
+		if (mgr) {
+			BT_DBG("sk %p closing", sk);
+			remove_amp_mgr(mgr);
+		}
+		break;
+	}
 
-	BT_DBG("sk %p", sk);
 	sock_put(work->sk);
 	kfree(work);
 }
-- 
1.7.4.1

