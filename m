Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH v11 08/10] Bluetooth: Prevent transparent SCO on older devices
Date: Mon, 19 Aug 2013 14:24:01 +0200
Message-Id: <1376915043-24531-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376915043-24531-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376915043-24531-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Older Bluetooth devices may not support Setup Synchronous Connection or
SCO transparent data. This is indicated by the corresponding LMP feature
bits. It is not possible to know if the adapter support these features
before setting BT_VOICE option since the socket is not bound to an
adapter. An adapter can also be added after the socket is created. The
socket can be bound to an address before adapter is plugged in.

Thus, on a such adapters, if user request BT_VOICE_TRANSPARENT, outgoing
connections fail on connect() and returns -EOPNOTSUPP. Incoming
connections do not fail. However, they should only be allowed depending
on what was specified in Write_Voice_Settings command.

EOPNOTSUPP is choosen because connect() system call is failing after
selecting route but before any connection attempt.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e82d792..1170b6e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -176,6 +176,12 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
+	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
+	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->setting);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
-- 
1.7.9.5

