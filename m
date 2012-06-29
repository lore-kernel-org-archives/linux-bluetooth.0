Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 03/19] Bluetooth: Fix processing A2MP chan in security_cfm
Date: Fri, 29 Jun 2012 17:46:36 +0300
Message-Id: <1340981212-21709-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Do not process A2MP channel in l2cap_security_cfm

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2f7995e..b01f9d1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5465,6 +5465,11 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		BT_DBG("chan->scid %d", chan->scid);
 
+		if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
+			l2cap_chan_unlock(chan);
+			continue;
+		}
+
 		if (chan->scid == L2CAP_CID_LE_DATA) {
 			if (!status && encrypt) {
 				chan->sec_level = hcon->sec_level;
-- 
1.7.9.5

