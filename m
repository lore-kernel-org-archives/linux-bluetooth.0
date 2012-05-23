Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org
Subject: [PATCHv3] Bluetooth: Send a configuration request after security confirmation
Date: Wed, 23 May 2012 14:59:30 -0700
Message-Id: <1337810370-12066-1-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337742738.15105.30.camel@aeonflux>
References: <1337742738.15105.30.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes an ACL link must be raised to a higher security level after
an L2CAP connection is requested, but before a connection response is
sent.  In this case, a connection response sent by L2CAP was not
immediately followed by a configuration request.  Other code paths do
send this configuration request right away.  It was possible for the
connection to stall while L2CAP waited for the remote device (like
PTS) to trigger the configuration process.

Here is an abbreviated hcidump of the failure case with PTS:

1337806446.051982 > ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
1337806446.052050 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x000000b8
1337806446.595320 > ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 4097 scid 0x0041
1337806446.595673 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 0
1337806446.595679 < ACL data: handle 43 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
1337806446.669835 > ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00000028
1337806446.669899 < HCI Command: Authentication Requested (0x01|0x0011) plen 2
1337806446.669906 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 1
<security setup here>
1337806446.769888 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0

At this point, the connection stalls and no further messages are sent
on the L2CAP signaling channel.  No data is received either.

If we immediately send a configuration request after a successful connect
response, the connection completes:

1337724090.041162 > ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
1337724090.041236 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x000000b8
1337724090.597128 > ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 4097 scid 0x0041
1337724090.597236 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 0
1337724090.597244 < ACL data: handle 43 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
1337724090.660842 > ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00000028
1337724090.660926 < HCI Command: Authentication Requested (0x01|0x0011) plen 2
1337724090.660934 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 1
<security setup here>
1337724090.755162 < ACL data: handle 43 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
1337724090.755171 < ACL data: handle 43 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 11
1337724091.361847 > ACL data: handle 43 flags 0x02 dlen 29
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 15
1337724091.863808 > ACL data: handle 43 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
1337724091.863882 < ACL data: handle 43 flags 0x00 dlen 29
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 15
1337724092.683745 > ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 4097]
      0000: 00 00 11 22 33 44 34 2f                           ..."3D4/

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e31b005..c9e6ae4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5500,6 +5500,17 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			rsp.status = cpu_to_le16(stat);
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
 							sizeof(rsp), &rsp);
+
+			if (!test_bit(CONF_REQ_SENT, &chan->conf_state) &&
+			    res == L2CAP_CR_SUCCESS) {
+				char buf[128];
+				set_bit(CONF_REQ_SENT, &chan->conf_state);
+				l2cap_send_cmd(conn, l2cap_get_ident(conn),
+					       L2CAP_CONF_REQ,
+					       l2cap_build_conf_req(chan, buf),
+					       buf);
+				chan->num_conf_req++;
+			}
 		}
 
 		l2cap_chan_unlock(chan);
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
