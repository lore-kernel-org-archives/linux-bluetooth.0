Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 05/20] Bluetooth: A2MP: Remove AMP manager in state_change
Date: Thu, 22 Dec 2011 13:06:11 +0200
Message-Id: <1324551986-29431-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle BT_CLOSED state change by removing AMP manager.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 3f69823..b197cf3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -82,7 +82,21 @@ static void a2mp_data_ready(struct sock *sk, int bytes)
 
 static void a2mp_state_change(struct sock *sk)
 {
-	BT_DBG("sk %p", sk);
+	struct amp_mgr *mgr = NULL;
+
+	mgr = get_amp_mgr_sk(sk);
+	if (!mgr)
+		return;
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
 }
 
 static void l2cap_fixed_channel_config(struct sock *sk)
-- 
1.7.4.1

