Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Bluetooth: Fix wrong memcpy size on LE start encryption
Date: Mon, 19 Sep 2011 14:41:09 -0400
Message-Id: <4e778cdf.c964cc0a.2f7c.5b05@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch fixes wrong memcpy size when copying rand value to
HCI_OP_LE_START_ENC command.
The compiler pretends that the array parameter was declared as a pointer
and sizeof reports the size of the pointer. [1]

[1] http://www.c-faq.com/aryptr/aryparmsize.html

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
---
 net/bluetooth/hci_conn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ea7f031..c2df7bf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -218,7 +218,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 	cp.handle = cpu_to_le16(conn->handle);
 	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
 	cp.ediv = ediv;
-	memcpy(cp.rand, rand, sizeof(rand));
+	memcpy(cp.rand, rand, sizeof(cp.rand));
 
 	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
 }
-- 
1.7.4.1

