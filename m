Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/7] Bluetooth: Use the same timeouts for both ACL and LE links
Date: Fri, 19 Aug 2011 21:06:52 -0300
Message-Id: <1313798816-8647-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4376780..d8fc1f2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -476,7 +476,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
 {
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		unsigned long timeo;
-		if (conn->type == ACL_LINK) {
+		if (conn->type == ACL_LINK || conn->type == LE_LINK) {
 			del_timer(&conn->idle_timer);
 			if (conn->state == BT_CONNECTED) {
 				timeo = msecs_to_jiffies(conn->disc_timeout);
-- 
1.7.6

