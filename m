Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Respect local MITM req in io_cap reply
Date: Wed, 27 Apr 2011 16:09:47 -0700
Message-Id: <1303945787-25951-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1303372461-11848-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303372461-11848-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>

If host requires MITM protection notify that to controller in
io capabilities reply even if the remote device requires no bonding.

If it is not respected, host can get an unauthenticated link key while
it expects authenticated one.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cba0bdb..3c90736 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2369,7 +2369,7 @@ static inline u8 hci_get_auth_req(struct hci_conn *conn)
 
 	/* If remote requests no-bonding follow that lead */
 	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
-		return 0x00;
+		return conn->remote_auth | (conn->auth_type & 0x01);
 
 	return conn->auth_type;
 }
-- 
1.7.4.4

