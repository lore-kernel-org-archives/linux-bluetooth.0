Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH] Bluetooth: Differentiate local and remote rejection if pairing
 fails
Date: Wed, 25 Jul 2012 16:06:34 +0530
Message-id: <1343212594-20058-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is to support providing re-pair option to user when pairing
fails. If the pairing failure is because local user rejected the
passkey confirmation request (or whatever) then it does not make
sense to provide re-pair option. Right now initiated application cannot
differentiate local and remote rejection when "CreatePairedDevice"
returns since agent is a different process (we are using adapter agent)
and in ssp case "Authentication Failure" is coming in both the cases.
Hcidump log is given below

Local Rejection
---------------
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr BC:85:1F:74:7F:29 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr BC:85:1F:74:7F:29 type ACL encrypt 0x00
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr BC:85:1F:74:7F:29 mode 2 clkoffset 0x0000
< ACL data: handle 12 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000002
        L2CAP Signalling Channel
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr BC:85:1F:74:7F:29 name 'GT-S5360'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr BC:85:1F:74:7F:29
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr BC:85:1F:74:7F:29
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr BC:85:1F:74:7F:29
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr BC:85:1F:74:7F:29
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr BC:85:1F:74:7F:29 capability 0x01 oob 0x00 auth 0x03
    Capability: DisplayYesNo (OOB data not present)
    Authentication: Dedicated Bonding (MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr BC:85:1F:74:7F:29
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr BC:85:1F:74:7F:29 capability 0x01 oob 0x00 auth 0x00
    Capability: DisplayYesNo (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr BC:85:1F:74:7F:29 passkey 869124
< HCI Command: User Confirmation Request Negative Reply (0x01|0x002d) plen 6
    bdaddr BC:85:1F:74:7F:29
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Negative Reply (0x01|0x002d) ncmd 1
    status 0x00 bdaddr BC:85:1F:74:7F:29
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x05 bdaddr BC:85:1F:74:7F:29
    Error: Authentication Failure
> HCI Event: Auth Complete (0x06) plen 3
    status 0x05 handle 12
    Error: Authentication Failure
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x05
    Reason: Authentication Failure

Remote Rejection
----------------
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr BC:85:1F:74:7F:29 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr BC:85:1F:74:7F:29 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr BC:85:1F:74:7F:29 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
< ACL data: handle 12 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000002
        L2CAP Signalling Channel
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr BC:85:1F:74:7F:29 name 'GT-S5360'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr BC:85:1F:74:7F:29
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr BC:85:1F:74:7F:29
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr BC:85:1F:74:7F:29
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr BC:85:1F:74:7F:29
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr BC:85:1F:74:7F:29 capability 0x01 oob 0x00 auth 0x03
    Capability: DisplayYesNo (OOB data not present)
    Authentication: Dedicated Bonding (MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr BC:85:1F:74:7F:29
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr BC:85:1F:74:7F:29 capability 0x01 oob 0x00 auth 0x00
    Capability: DisplayYesNo (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr BC:85:1F:74:7F:29 passkey 295532
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr BC:85:1F:74:7F:29
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr BC:85:1F:74:7F:29
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x05 bdaddr BC:85:1F:74:7F:29
    Error: Authentication Failure
> HCI Event: Auth Complete (0x06) plen 3
    status 0x05 handle 12
    Error: Authentication Failure
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x05
    Reason: Authentication Failure

So this patch overrides the status to "Cancelled" in case if local
user rejects pairing so that application can provide re-pair option
if pairing fails and status is not "Cancelled"

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_event.c        |   19 +++++++++++++++----
 net/bluetooth/mgmt.c             |   18 ++++++++++++++++--
 net/bluetooth/smp.c              |    3 ++-
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 475b8c0..409b7ad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -425,6 +425,7 @@ enum {
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_AUTH_CANCELLED,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1036,7 +1037,7 @@ int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					 u8 link_type, u8 addr_type, u8 status);
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status);
+		     u8 addr_type, u8 status, bool cancelled);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41ff978..08fb9d6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1948,7 +1948,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	} else {
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-				 ev->status);
+				 ev->status, test_bit(HCI_CONN_AUTH_CANCELLED,
+								&conn->flags));
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
@@ -2642,16 +2643,19 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	clear_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 	if (conn->state == BT_CONNECTED) {
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
 		hci_conn_put(conn);
 	}
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags))
+	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags)) {
+		set_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
-	else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
+	} else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
 		u8 secure;
 
 		if (conn->pending_sec_level == BT_SECURITY_HIGH)
@@ -2698,6 +2702,8 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
+		clear_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 		if (key->type == HCI_LK_UNAUTH_COMBINATION &&
 		    conn->auth_type != 0xff && (conn->auth_type & 0x01)) {
 			BT_DBG("%s ignoring unauthenticated key", hdev->name);
@@ -3116,6 +3122,8 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	clear_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 	hci_conn_hold(conn);
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -3147,6 +3155,8 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 		cp.reason = HCI_ERROR_PAIRING_NOT_ALLOWED;
 
+		set_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_NEG_REPLY,
 			     sizeof(cp), &cp);
 	}
@@ -3281,7 +3291,8 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	 * the mgmt_auth_failed event */
 	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status != 0)
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-				 ev->status);
+				 ev->status, test_bit(HCI_CONN_AUTH_CANCELLED,
+								&conn->flags));
 
 	hci_conn_put(conn);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ad6613d..bb84e1e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1824,6 +1824,10 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
+	/* Override status if local device rejected pairing */
+	if (status && test_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags))
+		status = MGMT_STATUS_CANCELLED;
+
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
 		     &rp, sizeof(rp));
 
@@ -2022,6 +2026,11 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
+	if (hci_op == HCI_OP_USER_CONFIRM_NEG_REPLY ||
+				hci_op == HCI_OP_USER_PASSKEY_NEG_REPLY ||
+				hci_op == HCI_OP_PIN_CODE_NEG_REPLY)
+		set_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 	if (type == BDADDR_LE_PUBLIC || type == BDADDR_LE_RANDOM) {
 		/* Continue with pairing via SMP */
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
@@ -3260,13 +3269,18 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status)
+		     u8 addr_type, u8 status, bool cancelled)
 {
 	struct mgmt_ev_auth_failed ev;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
-	ev.status = mgmt_status(status);
+
+	/* Override status if local device rejected pairing */
+	if (cancelled)
+		ev.status = MGMT_STATUS_CANCELLED;
+	else
+		ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 16ef0dc..39bda92 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -265,7 +265,8 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
 	mgmt_auth_failed(conn->hcon->hdev, conn->dst, hcon->type,
-			 hcon->dst_type, reason);
+			 hcon->dst_type, reason,
+			 test_bit(HCI_CONN_AUTH_CANCELLED, &hcon->flags));
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
 		cancel_delayed_work_sync(&conn->security_timer);
-- 
1.7.1

