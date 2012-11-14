Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 3/3] Bluetooth: trivial: Use __constant for constants
Date: Wed, 14 Nov 2012 17:39:32 +0200
Message-Id: <1352907572-7113-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 10b3062..4a635f1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4529,12 +4529,12 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
 		/* Incoming channel on AMP */
 		if (result == L2CAP_CR_SUCCESS) {
 			/* Send successful response */
-			rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
-			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+			rsp.result = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
+			rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
 		} else {
 			/* Send negative response */
-			rsp.result = cpu_to_le16(L2CAP_CR_NO_MEM);
-			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+			rsp.result = __constant_cpu_to_le16(L2CAP_CR_NO_MEM);
+			rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
 		}
 
 		l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_RSP,
-- 
1.7.10.4

