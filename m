Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385421B18B
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714644; cv=none; b=jBbs++lWpR+5gwNN+Dpab3R+ShWXZ5TMbrVW93sPPPGrFobvF3vzucNf6H5rSPsmgarNBZElWQqQQBdG9M1ngubzDEbiehUJ4jzv87l2MMbVaY/2BYk3f2ukzMabXYD33IT/GommjCCyUkVydUTHch2+9Zy5zdT9JO6tHF5mfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714644; c=relaxed/simple;
	bh=JKhe/hvaL6dpdK3i8SfVmAbnT/DFACW2oPBkPcCYo6A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=JwDdPXY9eNgugI+dazRTcOzNjFLh7p/TTR5R7h9CuGcem7jmPUAEquXjurbZ1Wbdsf44kWWgmHRcARzqsAYHaExno9KMGwvy4RjbbMX2cwlPg5N1E9U0KSyd69Z6e/EHj5ZeU1mnGo9tI9jjRCUQ+spH1/0ayhkeX7aerO9g7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ct5Uont/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ct5Uont/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749714640;
	bh=JKhe/hvaL6dpdK3i8SfVmAbnT/DFACW2oPBkPcCYo6A=;
	h=From:To:Subject:Date:From;
	b=ct5Uont/Cxknu57B28QnMcLBG2QhTbYgvZOQAgFTzTckSMEO9wk0Xs9PmC0DQ8eww
	 uxUBwojwsHxaZl7szdohT1H0cF82LxCOlzYIwGGnnpAy4SE/a3Zo+4y+VvTI06tCuU
	 iZ8BHLmhz5mq6WikDKuKWKHiz8O4Nh4Y3PM383zvxa3DLdzaqpqhYVM8OGY9/dChJt
	 PG1hfcLEQwGetqKVTPB/sIJ2mrsdccenUmzE6qaCVlpkDET4ttcyfGGzoRE7EHxOBn
	 lexFTjFx9ZXWHsmm2WrBxtOzfZc0C+JB5VZuNe0Vp0WN4L+dfw9mKc7EH9CDGZA/y9
	 snIu/e66uckeA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-5541-323A-6132-86Ef.rev.sfr.net [IPv6:2a02:8428:af44:1001:5541:323a:6132:86ef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 63F3017E1072
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 09:50:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix L2CAP MTU negotiation
Date: Thu, 12 Jun 2025 09:50:34 +0200
Message-ID: <20250612075034.190194-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

OBEX download from iPhone is currently slow due to small packet size
used to transfer data which doesn't follow the MTU negotiated during
L2CAP connection, i.e. 672 bytes instead of 32767:

  < ACL Data TX: Handle 11 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 18 len 4
        PSM: 4103 (0x1007)
        Source CID: 72
  > ACL Data RX: Handle 11 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 18 len 8
        Destination CID: 14608
        Source CID: 72
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
  < ACL Data TX: Handle 11 flags 0x00 dlen 27
      L2CAP: Configure Request (0x04) ident 20 len 19
        Destination CID: 14608
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 32767
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 63
          Max transmit: 3
          Retransmission timeout: 2000
          Monitor timeout: 12000
          Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 26
      L2CAP: Configure Request (0x04) ident 72 len 18
        Destination CID: 72
        Flags: 0x0000
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 32
          Max transmit: 255
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 65527
        Option: Frame Check Sequence (0x05) [mandatory]
          FCS: 16-bit FCS (0x01)
  < ACL Data TX: Handle 11 flags 0x00 dlen 29
      L2CAP: Configure Response (0x05) ident 72 len 21
        Source CID: 14608
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 32
          Max transmit: 255
          Retransmission timeout: 2000
          Monitor timeout: 12000
          Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 32
      L2CAP: Configure Response (0x05) ident 20 len 24
        Source CID: 72
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 32767
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 63
          Max transmit: 3
          Retransmission timeout: 2000
          Monitor timeout: 12000
          Maximum PDU size: 1009
        Option: Frame Check Sequence (0x05) [mandatory]
          FCS: 16-bit FCS (0x01)
  ...
  > ACL Data RX: Handle 11 flags 0x02 dlen 680
      Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 1 ReqSeq 2
  < ACL Data TX: Handle 11 flags 0x00 dlen 13
      Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 2 ReqSeq 2
  > ACL Data RX: Handle 11 flags 0x02 dlen 680
      Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 2 ReqSeq 3

The MTUs are negotiated for each direction. In this traces 32767 for
iPhone->localhost and no MTU for localhost->iPhone, which based on
'4.4 L2CAP_CONFIGURATION_REQ' (Core specification v5.4, Vol. 3, Part
A):

  The only parameters that should be included in the
  L2CAP_CONFIGURATION_REQ packet are those that require different
  values than the default or previously agreed values.
  ...
  Any missing configuration parameters are assumed to have their
  most recently explicitly or implicitly accepted values.

and '5.1 Maximum transmission unit (MTU)':

  If the remote device sends a positive L2CAP_CONFIGURATION_RSP
  packet it should include the actual MTU to be used on this channel
  for traffic flowing into the local device.
  ...
  The default value is 672 octets.

is set by BlueZ to 672 bytes.

It seems that the iPhone used the lowest negotiated value to transfer
data to the localhost instead of the negotiated one for the incoming
direction.

This could be fixed by using the MTU negotiated for the other
direction, if exists, in the L2CAP_CONFIGURATION_RSP.
This allows to use segmented packets as in the following traces:

  < ACL Data TX: Handle 11 flags 0x00 dlen 12
        L2CAP: Connection Request (0x02) ident 22 len 4
          PSM: 4103 (0x1007)
          Source CID: 72
  < ACL Data TX: Handle 11 flags 0x00 dlen 27
        L2CAP: Configure Request (0x04) ident 24 len 19
          Destination CID: 2832
          Flags: 0x0000
          Option: Maximum Transmission Unit (0x01) [mandatory]
            MTU: 32767
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 63
            Max transmit: 3
            Retransmission timeout: 2000
            Monitor timeout: 12000
            Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 26
        L2CAP: Configure Request (0x04) ident 15 len 18
          Destination CID: 72
          Flags: 0x0000
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 32
            Max transmit: 255
            Retransmission timeout: 0
            Monitor timeout: 0
            Maximum PDU size: 65527
          Option: Frame Check Sequence (0x05) [mandatory]
            FCS: 16-bit FCS (0x01)
  < ACL Data TX: Handle 11 flags 0x00 dlen 29
        L2CAP: Configure Response (0x05) ident 15 len 21
          Source CID: 2832
          Flags: 0x0000
          Result: Success (0x0000)
          Option: Maximum Transmission Unit (0x01) [mandatory]
            MTU: 32767
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 32
            Max transmit: 255
            Retransmission timeout: 2000
            Monitor timeout: 12000
            Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 32
        L2CAP: Configure Response (0x05) ident 24 len 24
          Source CID: 72
          Flags: 0x0000
          Result: Success (0x0000)
          Option: Maximum Transmission Unit (0x01) [mandatory]
            MTU: 32767
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 63
            Max transmit: 3
            Retransmission timeout: 2000
            Monitor timeout: 12000
            Maximum PDU size: 1009
          Option: Frame Check Sequence (0x05) [mandatory]
            FCS: 16-bit FCS (0x01)
  ...
  > ACL Data RX: Handle 11 flags 0x02 dlen 1009
        Channel: 72 len 1005 ctrl 0x4202 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
        I-frame: Start (len 21884) TxSeq 1 ReqSeq 2
  > ACL Data RX: Handle 11 flags 0x02 dlen 1009
        Channel: 72 len 1005 ctrl 0xc204 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
        I-frame: Continuation TxSeq 2 ReqSeq 2

This has been tested with kernel 5.4 and BlueZ 5.77.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/l2cap_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5bde5db58ef..40daa38276f3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3415,7 +3415,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
 	u8 remote_efs = 0;
-	u16 mtu = L2CAP_DEFAULT_MTU;
+	u16 mtu = 0;
 	u16 result = L2CAP_CONF_SUCCESS;
 	u16 size;
 
@@ -3520,6 +3520,13 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
+		/* If MTU is not provided in configure request, use the most recently
+		 * explicitly or implicitly accepted value for the other direction,
+		 * or the default value.
+		 */
+		if (mtu == 0)
+			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
 		else {
-- 
2.43.0

