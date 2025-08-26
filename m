Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC51862
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199152; cv=none; b=EEr1xv6KLg4HvBADOIG1DCkFG9BggJsVFtzQB+WifiR3wdj+QZlIVS+63M5nWFFUtWaX3P3AuRykrmz0HcMxJR+JiJUyQ1DoWjrcbTx1hR68piZr2vvPO0OF2joTM7a0miMdED7qO01Uuj6f2jTfOqu9QIJ8v37Ww7eUcwYk/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199152; c=relaxed/simple;
	bh=DiuHMcfZHHEzfQV8CAUwTVbpNtfwkLO6jsWrYDuNc34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sw0XVlfFBOMECHC0Q4QgJ/JIJVVOGBm/ZankZjVodqaAi8/7o4vAkd8F0CrrW4YOuBcehQiIQ0zlHMUsb5Y9i9a5Ie1dRX6Zi2UvSgxLAUbwSpaSw1T9cju8Ph8vC9l5UoWS1GS/d133JtmclTStqgSLyKtwadzwfkj5SFhUHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ioos04Qf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ioos04Qf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756199149;
	bh=DiuHMcfZHHEzfQV8CAUwTVbpNtfwkLO6jsWrYDuNc34=;
	h=From:To:Subject:Date:From;
	b=Ioos04QfTbfMZZ34AhBE/GupPHf7x/glLoGTj7kje2dZfTaT/v4DKXPdqbjA9boW0
	 NgQpi2vGy6/lGsHtyZ6yTelTaMzz+MniKJyZvEYH2wmrMbm/7WSLpdYtBLvIegihq+
	 vyS10L3rIWWZA8b+TiQAtBu66Gjp3VuA4pj2MYQmIUK1h/rcE5H5ywso/d/5Zj8Nx2
	 qd82csNzls6z1TBwtdvW9vJkT4jzgRWpxso+C2C925gl4kLQLCd+yBvb1yFspLtgnL
	 Q9atMR2F+WKOiHumTwI6Re9+LdY+aWJxDBmJGp+ZHMok7Fi0L9SRMbn4JHJQj1zEJE
	 6qdMcckVkZXhQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-CCC5-255F-0d52-279F.rev.sfr.net [IPv6:2a02:8428:af44:1001:ccc5:255f:d52:279f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F212217E046C
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 11:05:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd: client: Fix connect RX MTU
Date: Tue, 26 Aug 2025 11:05:43 +0200
Message-ID: <20250826090543.122484-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
  < ACL Data TX: Handle 11 flags 0x00 dlen 34
      Channel: 14608 len 30 ctrl 0x0000 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 0 ReqSeq 0
        00 00 80 00 1a 10 00 02 a0 46 00 13 71 63 dd 54  .........F..qc.T
        4a 7e 11 e2 b4 7c 00 50 c2 49 00 48 b4 55        J~...|.P.I.H.U
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

The OBEX CONNECT request uses the negotiated output MTU (672, 0x02a0)
as the maximum OBEX packet length the client is able to receive
instead of the negotiated input MTU (32767).

This commit swap rx_mtu and tx_mtu as g_obex_new() is defined as:
  GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
     gssize rx_mtu, gssize tx_mtu);
---
 obexd/client/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index fa9bd7d17..89c877f08 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -373,7 +373,7 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 	else
 		type = G_OBEX_TRANSPORT_STREAM;
 
-	obex = g_obex_new(io, type, tx_mtu, rx_mtu);
+	obex = g_obex_new(io, type, rx_mtu, tx_mtu);
 	if (obex == NULL)
 		goto done;
 
-- 
2.43.0

