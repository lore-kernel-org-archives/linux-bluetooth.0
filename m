Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Bluetooth: Fix some code style issues in hci_core.h
Date: Thu, 17 Feb 2011 16:42:00 +0100
Message-ID: <1297957320-14790-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <20110217144340.GE10543@joana>
References: <20110217144340.GE10543@joana>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/hci_core.h |   58 +++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e4f370f..2893288 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -208,37 +208,37 @@ struct hci_dev {
 struct hci_conn {
 	struct list_head list;
 
-	atomic_t	 refcnt;
-	spinlock_t	 lock;
-
-	bdaddr_t	 dst;
-	__u16		 handle;
-	__u16		 state;
-	__u8             mode;
-	__u8		 type;
-	__u8		 out;
-	__u8		 attempt;
-	__u8		 dev_class[3];
-	__u8             features[8];
-	__u8             ssp_mode;
-	__u16            interval;
-	__u16            pkt_type;
-	__u16            link_policy;
-	__u32		 link_mode;
-	__u8             auth_type;
-	__u8             sec_level;
-	__u8		 pending_sec_level;
-	__u8		 pin_length;
-	__u8		 io_capability;
-	__u8             power_save;
-	__u16            disc_timeout;
-	unsigned long	 pend;
+	atomic_t	refcnt;
+	spinlock_t	lock;
+
+	bdaddr_t	dst;
+	__u16		handle;
+	__u16		state;
+	__u8		mode;
+	__u8		type;
+	__u8		out;
+	__u8		attempt;
+	__u8		dev_class[3];
+	__u8		features[8];
+	__u8		ssp_mode;
+	__u16		interval;
+	__u16		pkt_type;
+	__u16		link_policy;
+	__u32		link_mode;
+	__u8		auth_type;
+	__u8		sec_level;
+	__u8		pending_sec_level;
+	__u8		pin_length;
+	__u8		io_capability;
+	__u8		power_save;
+	__u16		disc_timeout;
+	unsigned long	pend;
 
 	__u8		remote_cap;
 	__u8		remote_oob;
 	__u8		remote_auth;
 
-	unsigned int	 sent;
+	unsigned int	sent;
 
 	struct sk_buff_head data_q;
 
@@ -356,7 +356,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
-					__u16 handle)
+								__u16 handle)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct list_head *p;
@@ -371,7 +371,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
-					__u8 type, bdaddr_t *ba)
+							__u8 type, bdaddr_t *ba)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct list_head *p;
@@ -386,7 +386,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
-					__u8 type, __u16 state)
+							__u8 type, __u16 state)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct list_head *p;
-- 
1.7.0.4

