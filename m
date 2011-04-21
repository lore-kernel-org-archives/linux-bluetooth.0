Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2 6/6] Bluetooth: Respect local MITM req in io_cap reply
Date: Thu, 21 Apr 2011 09:54:21 +0200
Message-ID: <1303372461-11848-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If host requires MITM protection notify that to controller in
io capabilities reply even if the remote device requires no bonding.

If it is not respected, host can get an unauthenticated link key while
it expects authenticated one.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 087953e..3ee0060 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2369,7 +2369,7 @@ static inline u8 hci_get_auth_req(struct hci_conn *conn)
 
 	/* If remote requests no-bonding follow that lead */
 	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
-		return 0x00;
+		return conn->auth_type & 0x01;
 
 	return conn->auth_type;
 }
-- 
1.7.1

