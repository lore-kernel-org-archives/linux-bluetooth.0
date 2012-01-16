Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1 1/1] Bluetooth: Send correct response to IO Capability Request
Date: Mon, 16 Jan 2012 13:34:29 +0530
Message-ID: <1326701069-19146-2-git-send-email-hemant.gupta@stericsson.com>
In-Reply-To: <1326701069-19146-1-git-send-email-hemant.gupta@stericsson.com>
References: <1326701069-19146-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sends correct IO Capability response to remote device
in case Local Device supports KeyBoardDisplay IO Capability as
this capability is not valid as per BT spec for IO capability
Request Reply Command.
This capability is mapped to DisplayYesNo which is in accordance
with BT spec.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/hci_event.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d37f5b2..3590e72 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2782,7 +2782,11 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 		struct hci_cp_io_capability_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.capability = conn->io_capability;
+		/*
+		 * Change the IO capability from KeyboardDisplay
+		 * to DisplayYesNo as it is not supported by BT spec.
+		 */
+		cp.capability = (conn->io_capability == 0x04) ? 0x01 : conn->io_capability;
 		conn->auth_type = hci_get_auth_req(conn);
 		cp.authentication = conn->auth_type;
 
-- 
1.6.6.1

