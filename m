Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 6/7] Bluetooth: Respect local MITM req in io_cap reply
Date: Thu, 28 Apr 2011 12:07:58 +0200
Message-ID: <1303985279-3944-7-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
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
index 40e96cd..9d50e90 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2397,7 +2397,7 @@ static inline u8 hci_get_auth_req(struct hci_conn *conn)
 
 	/* If remote requests no-bonding follow that lead */
 	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
-		return 0x00;
+		return conn->remote_auth | (conn->auth_type & 0x01);
 
 	return conn->auth_type;
 }
-- 
1.7.1

