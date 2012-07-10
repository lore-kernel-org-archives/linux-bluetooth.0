Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: debug: Add debug to l2cap_security_cfm
Date: Tue, 10 Jul 2012 15:27:51 +0300
Message-Id: <1341923271-14222-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 41905de9..32faa36 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5377,7 +5377,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	if (!conn)
 		return 0;
 
-	BT_DBG("conn %p", conn);
+	BT_DBG("conn %p status 0x%2.2x encrypt %u", conn, status, encrypt);
 
 	if (hcon->type == LE_LINK) {
 		if (!status && encrypt)
@@ -5390,7 +5390,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		l2cap_chan_lock(chan);
 
-		BT_DBG("chan->scid %d", chan->scid);
+		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
+		       state_to_string(chan->state));
 
 		if (chan->scid == L2CAP_CID_LE_DATA) {
 			if (!status && encrypt) {
-- 
1.7.9.5

