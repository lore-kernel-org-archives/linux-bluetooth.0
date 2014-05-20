Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Make SMP context private to smp.c
Date: Tue, 20 May 2014 09:45:47 +0300
Message-Id: <1400568352-20454-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
References: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are no users of the smp_chan struct outside of smp.c so move it
away from smp.h. The addition of the l2cap.h include to hci_core.c,
hci_conn.c and mgmt.c is something that should have been there already
previously to avoid warnings of undeclared struct l2cap_conn, but the
compiler warning was apparently shadowed away by the mention of
l2cap_conn in the struct smp_chan definition.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c |  1 +
 net/bluetooth/hci_core.c |  1 +
 net/bluetooth/mgmt.c     |  1 +
 net/bluetooth/smp.c      | 29 +++++++++++++++++++++++++++++
 net/bluetooth/smp.h      | 29 -----------------------------
 5 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a987e7def025..97198e32f0c4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/hci_core.h>
 
 #include "smp.h"
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 313bd1c164d6..b748effc6aea 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -33,6 +33,7 @@
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/hci_core.h>
 
 #include "smp.h"
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 370cd42f488b..f8ca69dd1984 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -29,6 +29,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/mgmt.h>
 
 #include "smp.h"
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b5b926399e76..df91ed28084f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -35,6 +35,35 @@
 
 #define AUTH_REQ_MASK   0x07
 
+#define SMP_FLAG_TK_VALID	1
+#define SMP_FLAG_CFM_PENDING	2
+#define SMP_FLAG_MITM_AUTH	3
+#define SMP_FLAG_COMPLETE	4
+#define SMP_FLAG_INITIATOR	5
+
+struct smp_chan {
+	struct l2cap_conn *conn;
+	u8		preq[7]; /* SMP Pairing Request */
+	u8		prsp[7]; /* SMP Pairing Response */
+	u8		prnd[16]; /* SMP Pairing Random (local) */
+	u8		rrnd[16]; /* SMP Pairing Random (remote) */
+	u8		pcnf[16]; /* SMP Pairing Confirm */
+	u8		tk[16]; /* SMP Temporary Key */
+	u8		enc_key_size;
+	u8		remote_key_dist;
+	bdaddr_t	id_addr;
+	u8		id_addr_type;
+	u8		irk[16];
+	struct smp_csrk	*csrk;
+	struct smp_csrk	*slave_csrk;
+	struct smp_ltk	*ltk;
+	struct smp_ltk	*slave_ltk;
+	struct smp_irk	*remote_irk;
+	unsigned long	smp_flags;
+	struct work_struct confirm;
+	struct work_struct random;
+};
+
 static inline void swap128(const u8 src[16], u8 dst[16])
 {
 	int i;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index afd16231db13..5a8dc36460a1 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -116,35 +116,6 @@ struct smp_cmd_security_req {
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
 
-#define SMP_FLAG_TK_VALID	1
-#define SMP_FLAG_CFM_PENDING	2
-#define SMP_FLAG_MITM_AUTH	3
-#define SMP_FLAG_COMPLETE	4
-#define SMP_FLAG_INITIATOR	5
-
-struct smp_chan {
-	struct l2cap_conn *conn;
-	u8		preq[7]; /* SMP Pairing Request */
-	u8		prsp[7]; /* SMP Pairing Response */
-	u8		prnd[16]; /* SMP Pairing Random (local) */
-	u8		rrnd[16]; /* SMP Pairing Random (remote) */
-	u8		pcnf[16]; /* SMP Pairing Confirm */
-	u8		tk[16]; /* SMP Temporary Key */
-	u8		enc_key_size;
-	u8		remote_key_dist;
-	bdaddr_t	id_addr;
-	u8		id_addr_type;
-	u8		irk[16];
-	struct smp_csrk	*csrk;
-	struct smp_csrk	*slave_csrk;
-	struct smp_ltk	*ltk;
-	struct smp_ltk	*slave_ltk;
-	struct smp_irk	*remote_irk;
-	unsigned long	smp_flags;
-	struct work_struct confirm;
-	struct work_struct random;
-};
-
 /* SMP Commands */
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
-- 
1.9.0

