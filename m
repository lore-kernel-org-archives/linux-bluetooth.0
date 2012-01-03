Return-Path: <cyrus@holtmann.org>
Message-ID: <4F0362F8.9000000@monom.org>
Date: Tue, 03 Jan 2012 21:20:08 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: rfcomm & encryption
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to get DUN working with SSP. If SSP is disabled everything
is fine. As soon SSP is enabled the fun starts. As it turns out we
try to connect without encryption enabled and the other side blocks it:

HCI sniffer - Bluetooth packet analyzer ver 2.2
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 42 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 42 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
< ACL data: handle 42 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 < ACL data: handle 42 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 > ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x00 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1103 (DUN)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> ACL data: handle 42 flags 0x02 dlen 112
    L2CAP(d): cid 0x0040 len 108 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x67
          count 100
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1103 (DUN) uuid-16 0x1201 (Networking) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1103 (DUN) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Dial-up networking"
          cont 00
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 42
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr A0:4E:04:F6:F5:05
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr A0:4E:04:F6:F5:05 key 84B447892006A7144BCEE7D56429A17A
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr A0:4E:04:F6:F5:05
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 42

And here we start doing something wrong. Instead of encrypting the link
we just go to the next step and do a connection request.

< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x05
    Reason: Authentication Failure


Johan pointed me to the right spot in the kernel:

static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
{
	[...]

	if (conn->state == BT_CONFIG) {
		if (!ev->status && hdev->ssp_mode > 0 && conn->ssp_mode > 0) {
			struct hci_cp_set_conn_encrypt cp;
			cp.handle  = ev->handle;
			cp.encrypt = 0x01;
			hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
									&cp);
		} else {
			conn->state = BT_CONNECTED;
			hci_proto_connect_cfm(conn, ev->status);
			hci_conn_put(conn);
		}
	} else {
		hci_auth_cfm(conn, ev->status);

		hci_conn_hold(conn);
		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
		hci_conn_put(conn);
	}

	[...]
}

Only when the connection state is BT_CONFIG we will consider the option to encrypt
it. Changing this to


diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 919e3c0..22d7adf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1751,7 +1751,9 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_b
        clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
        clear_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
 -       if (conn->state == BT_CONFIG) {
+       BT_DBG("hdev->ssp_mode %d conn->ssp_mode %d state %d", hdev->ssp_mode, conn->ssp_mode, conn->state);
+
+       if (conn->state == BT_CONFIG || conn->state == BT_CONNECTED) {
                if (!ev->status && hdev->ssp_mode > 0 && conn->ssp_mode > 0) {
                        struct hci_cp_set_conn_encrypt cp;
                        cp.handle  = ev->handle;


did the trick. But I am pretty sure this is not right. Though I was unable to figure out where to fix this.

Any ideas?

cheers,
daniel

Here is the dmesg log with the patch above: http://pastebin.com/fTqhVBdx
