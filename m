Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 06/21] Bluetooth: A2MP: Remove AMP manager in state_change
Date: Thu, 10 Nov 2011 16:54:13 +0200
Message-Id: <1320936868-7978-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle BT_CLOSED state change by removing AMP manager.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index e7b7534..21fae45 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -114,8 +114,23 @@ static void state_change_worker(struct work_struct *w)
 {
 	struct a2mp_work_state_change *work = (struct a2mp_work_state_change *) w;
 	struct sock *sk = work->sk;
+	struct amp_mgr *mgr = NULL;
 
-	BT_DBG("sk %p", sk);
+	mgr = get_amp_mgr_sk(sk);
+	if (!mgr)
+		goto out;
+
+	BT_DBG("sk %p mgr %p state %d", sk, mgr, sk->sk_state);
+
+	switch (sk->sk_state) {
+	case BT_CLOSED:
+		amp_mgr_put(mgr);
+		break;
+	}
+
+	amp_mgr_put(mgr);
+
+out:
 	sock_put(work->sk);
 	kfree(work);
 }
-- 
1.7.4.1

