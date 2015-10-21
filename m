Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix missing hdev locking in hci_conn_timeout()
Date: Wed, 21 Oct 2015 10:26:05 +0300
Message-Id: <1445412365-10150-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_conn objects don't have a dedicated lock themselves but rely
on the caller to hold the hci_dev lock for most types of access. The
hci_conn_timeout function does various operations on hci_conn but
hasn't so far taken the hdev lock. The recent changes to do LE
scanning before connect attempts added even more operations to
hci_conn from hci_conn_timeout, thereby exposing race conditions such
as the hci_conn being removed from the global list but another piece
of code still managing to grab a reference to it.

Here there's a timeout but an l2cap_sock_connect() call manages to
race with the cleanup routine:

[Oct21 08:14] l2cap_chan_timeout: chan ee4b12c0 state BT_CONNECT
[  +0.000004] l2cap_chan_close: chan ee4b12c0 state BT_CONNECT
[  +0.000002] l2cap_chan_del: chan ee4b12c0, conn f3141580, err 111, state BT_CONNECT
[  +0.000002] l2cap_sock_teardown_cb: chan ee4b12c0 state BT_CONNECT
[  +0.000005] l2cap_chan_put: chan ee4b12c0 orig refcnt 4
[  +0.000010] hci_conn_drop: hcon f53d56e0 orig refcnt 1
[  +0.000013] l2cap_chan_put: chan ee4b12c0 orig refcnt 3
[  +0.000063] hci_conn_timeout: hcon f53d56e0 state BT_CONNECT
[  +0.000049] hci_conn_params_del: addr ee:0d:30:09:53:1f (type 1)
[  +0.000002] hci_chan_list_flush: hcon f53d56e0
[  +0.000001] hci_chan_del: hci0 hcon f53d56e0 chan f4e7ccc0
[  +0.004528] l2cap_sock_create: sock e708fc00
[  +0.000023] l2cap_chan_create: chan ee4b1770
[  +0.000001] l2cap_chan_hold: chan ee4b1770 orig refcnt 1
[  +0.000002] l2cap_sock_init: sk ee4b3390
[  +0.000029] l2cap_sock_bind: sk ee4b3390
[  +0.000010] l2cap_sock_setsockopt: sk ee4b3390
[  +0.000037] l2cap_sock_connect: sk ee4b3390
[  +0.000002] l2cap_chan_connect: 00:02:72:d9:e5:8b -> ee:0d:30:09:53:1f (type 2) psm 0x00
[  +0.000002] hci_get_route: 00:02:72:d9:e5:8b -> ee:0d:30:09:53:1f
[  +0.000001] hci_dev_hold: hci0 orig refcnt 8
[  +0.000003] hci_conn_hold: hcon f53d56e0 orig refcnt 0

Above the l2cap_chan_connect() shouldn't have been able to reach the
hci_conn f53d56e0 anymore but since hci_conn_timeout didn't do proper
locking that's not the case. The end result is a reference to hci_conn
that's not in the conn_hash list, resulting in list corruption when
trying to remove it later:

[Oct21 08:15] l2cap_chan_timeout: chan ee4b1770 state BT_CONNECT
[  +0.000004] l2cap_chan_close: chan ee4b1770 state BT_CONNECT
[  +0.000003] l2cap_chan_del: chan ee4b1770, conn f3141580, err 111, state BT_CONNECT
[  +0.000001] l2cap_sock_teardown_cb: chan ee4b1770 state BT_CONNECT
[  +0.000005] l2cap_chan_put: chan ee4b1770 orig refcnt 4
[  +0.000002] hci_conn_drop: hcon f53d56e0 orig refcnt 1
[  +0.000015] l2cap_chan_put: chan ee4b1770 orig refcnt 3
[  +0.000038] hci_conn_timeout: hcon f53d56e0 state BT_CONNECT
[  +0.000003] hci_chan_list_flush: hcon f53d56e0
[  +0.000002] hci_conn_hash_del: hci0 hcon f53d56e0
[  +0.000001] ------------[ cut here ]------------
[  +0.000461] WARNING: CPU: 0 PID: 1782 at lib/list_debug.c:56 __list_del_entry+0x3f/0x71()
[  +0.000839] list_del corruption, f53d56e0->prev is LIST_POISON2 (00000200)

This patch fixes the issue by adding the missing hci_dev locking to
the hci_conn_timeout() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org # 4.3+
---
 net/bluetooth/hci_conn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2dda439c8cb8..da0277551de5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -406,6 +406,7 @@ static void hci_conn_timeout(struct work_struct *work)
 	struct hci_conn *conn = container_of(work, struct hci_conn,
 					     disc_work.work);
 	int refcnt = atomic_read(&conn->refcnt);
+	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
 
@@ -421,6 +422,8 @@ static void hci_conn_timeout(struct work_struct *work)
 	if (refcnt > 0)
 		return;
 
+	hci_dev_lock(hdev);
+
 	switch (conn->state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
@@ -450,6 +453,8 @@ static void hci_conn_timeout(struct work_struct *work)
 		conn->state = BT_CLOSED;
 		break;
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 /* Enter sniff mode */
-- 
2.5.0

