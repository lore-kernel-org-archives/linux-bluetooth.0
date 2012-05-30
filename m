Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/3] Bluetooth: Return proper mgmt state when LE pairing connection failed
Date: Wed, 30 May 2012 15:39:22 +0200
Message-ID: <1338385163-10589-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1338385163-10589-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1338385163-10589-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MGMT_STATUS_BUSY should be returned when LE pairing cannot be started due
to another outgoing connection attempt is ongoing.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/mgmt.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 205574e..958f764 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1911,8 +1911,15 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp.addr.type = cp->addr.type;
 
 	if (IS_ERR(conn)) {
+		int status;
+
+		if (PTR_ERR(conn) == -EBUSY)
+			status = MGMT_STATUS_BUSY;
+		else
+			status = MGMT_STATUS_CONNECT_FAILED;
+
 		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-				   MGMT_STATUS_CONNECT_FAILED, &rp,
+				   status, &rp,
 				   sizeof(rp));
 		goto unlock;
 	}
-- 
1.7.9.5

