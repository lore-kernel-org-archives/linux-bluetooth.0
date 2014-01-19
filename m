Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Wood <simon@mungewell.org>,
	Frank Praznik <frank.praznik@oh.rr.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] lib: Use bigger IMTU when connecting SDP
Date: Sun, 19 Jan 2014 18:37:16 +0100
Message-Id: <1390153036-10030-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sony Dualshock 4 controller is ignoring L2CAP MTU while sending SDP
response. This results in data being dropped and no SDP response is
received (so no input device was created and HID connection was
refused). Workaround this by using large IMTU for SDP.

< ACL Data TX: Handle 12 flags 0x00 dlen 12
      L2CAP: Configure Request (0x04) ident 3 len 4
        Destination CID: 64
        Flags: 0x0000
> ACL Data RX: Handle 12 flags 0x02 dlen 18
      L2CAP: Configure Response (0x05) ident 3 len 10
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01)
          MTU: 672
> ACL Data RX: Handle 12 flags 0x02 dlen 16
      L2CAP: Configure Request (0x04) ident 1 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01)
          MTU: 672
< ACL Data TX: Handle 12 flags 0x00 dlen 18
      L2CAP: Configure Response (0x05) ident 1 len 10
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01)
          MTU: 672
< ACL Data TX: Handle 12 flags 0x00 dlen 24
      Channel: 64 len 20 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 0 len 15
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 0
> HCI Event: Remote Name Req Complete (0x07) plen 255
        Status: Success (0x00)
        Address: 1C:66:6D:18:F0:0A (Hon Hai Precision Ind.Co.Ltd)
        Name: Wireless Controller
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 12
        Count: 2
@ Device Connected: 1C:66:6D:18:F0:0A (0) flags 0x0000
        14 09 57 69 72 65 6c 65 73 73 20 43 6f 6e 74 72  ..Wireless Contr
        6f 6c 6c 65 72                                   oller
> ACL Data RX: Handle 12 flags 0x02 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 83
> ACL Data RX: Handle 12 flags 0x01 dlen 48
      Channel: 64 len 708 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 0 len 703
---
 lib/sdp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index 886e7cf..3b5f8f8 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4644,6 +4644,22 @@ static int sdp_connect_local(sdp_session_t *session)
 	return connect(session->sock, (struct sockaddr *) &sa, sizeof(sa));
 }
 
+static void set_l2cap_imtu(int sock, uint16_t imtu)
+{
+	struct l2cap_options l2o;
+	socklen_t len;
+
+	memset(&l2o, 0, sizeof(l2o));
+	len = sizeof(l2o);
+
+	if (getsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len) < 0)
+		return;
+
+	l2o.imtu = imtu;
+
+	setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o));
+}
+
 static int sdp_connect_l2cap(const bdaddr_t *src,
 		const bdaddr_t *dst, sdp_session_t *session)
 {
@@ -4678,6 +4694,8 @@ static int sdp_connect_l2cap(const bdaddr_t *src,
 		setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
 	}
 
+	set_l2cap_imtu(sk, SDP_RSP_BUFFER_SIZE);
+
 	sa.l2_psm = htobs(SDP_PSM);
 	sa.l2_bdaddr = *dst;
 
-- 
1.8.5.3

