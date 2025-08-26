Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFBC30AACF
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199704; cv=none; b=RjQ8W44WoSewC5TMg7XywDk/fGyXvRCkeVjJPa8ndoJ6PGIEAocNZRecfRNU1+qbjkeb6d13fFllZfJZdrn0d1hfWZEm+pRVwhtwvAVx9GhJqe+zPfxBmIn0sz4a1U7xKDTa+dnam3Xbl10xoUs98YRGarYY/EJGd60kqom8pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199704; c=relaxed/simple;
	bh=GskM42OIq308N++uxz3JUitOir5vMiqbOoTT1r7xX8s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OS2r1cnOXmMOkJQVuSUDv8fBCz+aaP0VaV/qVGa86fJDYxPpg5aXK87VAFUabYEy859j+CH9m+UCjgftMUKdmVjpgJjZYx7iuGabtRevbhXqSCtK2kUwtHX/wvxgfDjrHwKmNFVCY9eJw3sBcvP79NSS17EyR5YebOaFy9es0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ao/iaJ7j; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ao/iaJ7j"
Received: from github.com (hubbernetes-node-141faaf.ash1-iad.github.net [10.56.182.36])
	by smtp.github.com (Postfix) with ESMTPA id 205F5140842
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756199702;
	bh=03U1vxKgqhGeVVB5h2QCrNGOTjFWP1VJJYJasotxPGk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ao/iaJ7jOfYMH1ze31O/zALAHaDXtkawewRnaQz33BZHcf37ZG5/f7thBWV+KXZJb
	 1aH4Ws10G+1/SMketnrmpn4oOT7u+9xcHR1LZjGddl5Yqz+pY/TOz8uJWP0WOba65J
	 gdypJG9C31E4qSiKB8ikxI2ksGQ9SB1QgcEedM30=
Date: Tue, 26 Aug 2025 02:15:02 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995586/000000-50da77@github.com>
Subject: [bluez/bluez] 50da77: obexd: client: Fix connect RX MTU
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/995586
  Home:   https://github.com/bluez/bluez
  Commit: 50da77ff57d484042901c8486d345d378ece453f
      https://github.com/bluez/bluez/commit/50da77ff57d484042901c8486d345=
d378ece453f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-26 (Tue, 26 Aug 2025)

  Changed paths:
    M obexd/client/session.c

  Log Message:
  -----------
  obexd: client: Fix connect RX MTU

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
      Channel: 14608 len 30 ctrl 0x0000 [PSM 4103 mode Enhanced Retransmi=
ssion (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 0 ReqSeq 0
        00 00 80 00 1a 10 00 02 a0 46 00 13 71 63 dd 54  .........F..qc.T=

        4a 7e 11 e2 b4 7c 00 50 c2 49 00 48 b4 55        J~...|.P.I.H.U
  ...
  > ACL Data RX: Handle 11 flags 0x02 dlen 680
      Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retransmiss=
ion (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 1 ReqSeq 2
  < ACL Data TX: Handle 11 flags 0x00 dlen 13
      Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retransmis=
sion (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 2 ReqSeq 2
  > ACL Data RX: Handle 11 flags 0x02 dlen 680
      Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retransmiss=
ion (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 2 ReqSeq 3

The OBEX CONNECT request uses the negotiated output MTU (672, 0x02a0)
as the maximum OBEX packet length the client is able to receive
instead of the negotiated input MTU (32767).

This commit swap rx_mtu and tx_mtu as g_obex_new() is defined as:
  GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
     gssize rx_mtu, gssize tx_mtu);



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
