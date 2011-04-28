Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 2/7] Bluetooth: Don't modify sec_level if auth failed
Date: Thu, 28 Apr 2011 12:07:54 +0200
Message-ID: <1303985279-3944-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If authentication fails the security level should stay as it was set
before the process has started. Setting BT_SECURITY_LOW can hide real
security level on a link eg. having BT_SECURITY_MEDIUM on the link,
re-authenticate with failure to get BT_SECURITY_HIGH, as  a result we
get BT_SECURITY_LOW on the link while the real security is still medium.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/hci_event.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fbbb63f..35f9898 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1459,7 +1459,6 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->sec_level = conn->pending_sec_level;
 		} else {
 			mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
-			conn->sec_level = BT_SECURITY_LOW;
 		}
 
 		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
-- 
1.7.1

