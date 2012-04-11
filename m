Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 1/6] Bluetooth: Use unsigned int instead of signed int
Date: Wed, 11 Apr 2012 08:48:47 +0200
Message-Id: <1334126932-27327-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The involved values are all unsigned and thus unsigned int should be
used instead of signed int. Assigning ~0 to a signed int results in -1,
which is confusing and error-prone, while the code is trying to set the
maximum value possible.

The code still works because the C standard defines that unsigned
comparison will be performed in these cases, when comparing an unsigned
int and a signed int.

Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
---
 net/bluetooth/hci_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52c7abf..43760f1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2336,7 +2336,7 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn = NULL, *c;
-	int num = 0, min = ~0;
+	unsigned int num = 0, min = ~0;
 
 	/* We don't have to lock device here. Connections are always
 	 * added and removed with TX task disabled. */
@@ -2417,7 +2417,7 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_chan *chan = NULL;
-	int num = 0, min = ~0, cur_prio = 0;
+	unsigned int num = 0, min = ~0, cur_prio = 0;
 	struct hci_conn *conn;
 	int cnt, q, conn_num = 0;
 
-- 
1.7.7.6

