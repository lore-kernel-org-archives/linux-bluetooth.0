Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v8 8/8] Bluetooth: Prevent transparent SCO on older devices
Date: Fri,  5 Jul 2013 17:01:42 +0200
Message-Id: <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Older Bluetooth devices may not support Setup Synchronous Connection. This is
indicated by the eSCO support feature bit. It is not possible to know if the
adapter support eSCO before setting BT_VOICE option since the socket is not
bound to an adapter. An adapter can also be added after the socket is created.
The socket can be bound to an address before adapter is plugged in.

Thus, on a such adapters, if user requested something else than
BT_VOICE_CVSD_16BIT, outgoing connections fail on connect() and returns
-ECONNABORTED. Incoming connections do not fail. However, they should only be
allowed depending on what was specified in Write_Voice_Settings command.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 net/bluetooth/sco.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 546b7f6..02a602e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -176,6 +176,11 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
+	if (type == SCO_LINK && sco_pi(sk)->setting != BT_VOICE_CVSD_16BIT) {
+		err = -ECONNABORTED;
+		goto done;
+	}
+
 	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->setting);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
-- 
1.7.9.5

