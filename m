Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>,
	Chan-yeol Park <chanyeol.park@samsung.com>
Subject: [RFC 1/2] Bluetooth: Introduce MGMT_EV_DEVICE_NAME_UPDATE event
Date: Mon, 01 Apr 2013 15:29:13 +0530
Message-id: <1364810354-2121-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A new event is added in mgmt for remote device name updation.
This event will be sent to userspace whenever a remote name
event comes and mgmt_connected is already sent.

This patch fixes the issue remote name is not shown during pairing
if l2cap connection req comes before remote name event

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:1B:DC:05:B5:CB class 0xff0408 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:1B:DC:05:B5:CB role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:1B:DC:05:B5:CB role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:1B:DC:05:B5:CB type ACL encrypt 0x00
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
> ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 11 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 11 page 1 max 0
    Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1B:DC:05:B5:CB mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1B:DC:05:B5:CB name 'Bluetooth PTS Radio v4'
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0038
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 127
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 127
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 127
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x1 len 0x16
          pat uuid-16 0x111f (Handsfree AG)
          max 51
          aid(s) 0x0004 (ProtocolDescList) 0x0009 (BTProfileDescList)
		0x0301 (SuppDataStoresList) 0x0311 (SuppFeatures)
          cont 00
< ACL data: handle 11 flags 0x00 dlen 57
    L2CAP(d): cid 0x0040 len 53 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x30
          count 45
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xd > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x105 > >
              aid 0x0301 (SuppDataStoresList)
                 uint 0x1
              aid 0x0311 (SuppFeatures)
                 uint 0x7
          cont 00
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x00 dlen 27
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 15
      MTU 1013
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 1013
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 517
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 11 flags 0x00 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 frame_type 0 credit_flow 15 pri 31 ack_timer 0
      frame_size 512 max_retrans 0 credits 3
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 frame_type 0 credit_flow 14 pri 31 ack_timer 0
      frame_size 512 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:1B:DC:05:B5:CB
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:1B:DC:05:B5:CB
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:1B:DC:05:B5:CB
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:1B:DC:05:B5:CB

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 include/net/bluetooth/hci_core.h |    3 +++
 include/net/bluetooth/mgmt.h     |    7 +++++++
 net/bluetooth/hci_event.c        |   10 +++++++---
 net/bluetooth/mgmt.c             |   22 ++++++++++++++++++++++
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 358a698..76093ae 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1090,6 +1090,9 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			  u8 *dev_class);
+
+int mgmt_device_name_update(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name,
+			    u8 name_len);
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 link_type, u8 addr_type, u8 reason);
 int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 22980a7..0a4fcd8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -485,3 +485,10 @@ struct mgmt_ev_passkey_notify {
 	__le32	passkey;
 	__u8	entered;
 } __packed;
+
+#define MGMT_EV_DEVICE_NAME_UPDATE	0x0018
+struct mgmt_ev_device_name_update {
+	struct mgmt_addr_info addr;
+	__le16	eir_len;
+	__u8	eir[0];
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1385807..d873bd6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1283,9 +1283,13 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	struct discovery_state *discov = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, bdaddr, ACL_LINK, 0x00, 0, name,
-				      name_len, conn->dev_class);
+	if (conn) {
+		if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+			mgmt_device_connected(hdev, bdaddr, ACL_LINK, 0x00, 0,
+					      name, name_len, conn->dev_class);
+		else
+			mgmt_device_name_update(hdev, bdaddr, name, name_len);
+	}
 
 	if (discov->state == DISCOVERY_STOPPED)
 		return;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03e7e73..b7ddc29 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3543,6 +3543,28 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  sizeof(*ev) + eir_len, NULL);
 }
 
+int mgmt_device_name_update(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name,
+			    u8 name_len)
+{
+	char buf[512];
+	struct mgmt_ev_device_name_update *ev = (void *) buf;
+	u16 eir_len = 0;
+
+	if (name_len <= 0)
+		return -EINVAL;
+
+	bacpy(&ev->addr.bdaddr, bdaddr);
+	ev->addr.type = BDADDR_BREDR;
+
+	eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE, name,
+				  name_len);
+
+	ev->eir_len = cpu_to_le16(eir_len);
+
+	return mgmt_event(MGMT_EV_DEVICE_NAME_UPDATE, hdev, buf,
+			  sizeof(*ev) + eir_len, NULL);
+}
+
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 {
 	struct mgmt_cp_disconnect *cp = cmd->param;
-- 
1.7.9.5

