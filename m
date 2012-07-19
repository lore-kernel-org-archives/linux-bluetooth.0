Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: debug: Fix printing refcnt for hci_conn
Date: Thu, 19 Jul 2012 17:03:42 +0300
Message-Id: <1342706627-19129-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use the same style for refcnt printing through all Bluetooth code
taking the reference the l2cap_chan refcnt printing.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cda6437..13b102b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -587,8 +587,7 @@ void hci_conn_put_device(struct hci_conn *conn);
 
 static inline void hci_conn_hold(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p refcnt %d -> %d", conn, atomic_read(&conn->refcnt),
-	       atomic_read(&conn->refcnt) + 1);
+	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
 
 	atomic_inc(&conn->refcnt);
 	cancel_delayed_work(&conn->disc_work);
@@ -596,8 +595,7 @@ static inline void hci_conn_hold(struct hci_conn *conn)
 
 static inline void hci_conn_put(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p refcnt %d -> %d", conn, atomic_read(&conn->refcnt),
-	       atomic_read(&conn->refcnt) - 1);
+	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
 
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		unsigned long timeo;
-- 
1.7.9.5

