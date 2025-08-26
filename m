Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7C28314A
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215893; cv=none; b=XoHKd2WJL7zO36BpSHzn0s34Dq9VWzGdU4gZl6fmrE+OFSqPSEEwQG+5WU49ELtsql/geoUNYuQcsPjn/pmJzDrmaVCCI16ha83W0kDJfQngrwCpBJ0vUSWX0Gxkd4GqMo37cnfQrXwnXLfD/qItdFsRbcosYaCaaSZIQTKncI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215893; c=relaxed/simple;
	bh=MvMyo1MFadn0iftpaSGcQPYaNNq2iL0JmCYYnActSKw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=vDbeSsqtONgr9HH1++i+916wTeC5haYTWIahUI53rIErPQjuZREpoB6fz/cwYTvoKmwYY8z4o5yDWASvAxLTYLROxfAZQn5LAdQdgLzzZuZDpl73IBjsahOOA3FpS+QfSg0ziZzatTw2DHGzv+MG4twj+GPuzg8Inlu6Xbb+W5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DURjjr7D; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DURjjr7D"
Received: from github.com (hubbernetes-node-ea98534.va3-iad.github.net [10.48.173.15])
	by smtp.github.com (Postfix) with ESMTPA id BC2954E0E03
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756215890;
	bh=Xey7bWY8NykUuyB42RFXSyglVUIE4RM9YGknGypzNlM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DURjjr7DlRDcj6gkhrrXbqxGieATsTeP6/rXL3Er9kfBfWUUyNq0AJ37zDQ1Lo0fz
	 mpfKjPZq8lBb3bjQj23u/4tQ95wCQUOGkM6Aok8dUDkBvK8+A0tU3qB2m2VNvNXV2P
	 Cl46fJFigoKC8W+spzMUqN1/Hz/EjSZ8KXbds7GA=
Date: Tue, 26 Aug 2025 06:44:50 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f911b6-ba920d@github.com>
Subject: [bluez/bluez] ca209e: avrcp: Fix not ending loop during item listing
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: ca209e3f8fac8f69880f387f522504f7876d4abc
      https://github.com/bluez/bluez/commit/ca209e3f8fac8f69880f387f52250=
4f7876d4abc
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-26 (Tue, 26 Aug 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix not ending loop during item listing

When a remote applications return item with UUID set to 0, which is
against the specs (see 6.10.3 UIDs in AVRCP_v1.6.2.pdf), bluetoothd may
try to retrieve the same item in no ending loop.

  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR2 =
Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() /org/=
bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0
  bluetoothd[2]: profiles/audio/player.c:media_player_set_metadata() Titl=
e: WDR 2 Rheinland
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 en=
d 9 items 1 total 10
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2=
 Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus=
 failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_=
84_ED_21/player0/NowPlaying/item0 path
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 en=
d 9 items 0 total 10
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2=
 Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus=
 failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_=
84_ED_21/player0/NowPlaying/item0 path
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 en=
d 9 items 0 total 10


  Commit: fa2ebfd5fbff7c21ae1d7540b19c3d7a4973587f
      https://github.com/bluez/bluez/commit/fa2ebfd5fbff7c21ae1d7540b19c3=
d7a4973587f
  Author: Andreas Kemnade <andreas@kemnade.info>
  Date:   2025-08-26 (Tue, 26 Aug 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix auto connect with private addresses

When an app is registered and a device gets paired,
device_set_auto_connect() can be called before the address is resolved.
Do not ignore the request but rather record the auto connect request so
that it can be enabled in device_update_addr.


  Commit: 99abc8a9e1e1d256749e519a1758bf9a8576c468
      https://github.com/bluez/bluez/commit/99abc8a9e1e1d256749e519a1758b=
f9a8576c468
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


  Commit: ba920d3edb7afb61ca1cd1c1ae57aaccba503fc2
      https://github.com/bluez/bluez/commit/ba920d3edb7afb61ca1cd1c1ae57a=
accba503fc2
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-26 (Tue, 26 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.c
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  lib: Fix out-of-bounds write when concatenating commands

This commit fixes the hci_commandstostr() command by writing new line
character in place of trailing space when wrapping long lines. Previous
approach was to append new line character to existing string, which
caused buffer overflow when there was more than 9 lines in the output
string.

Also, the last trailing space is removed in order to return
trailing-spaces-free string to the caller.


Compare: https://github.com/bluez/bluez/compare/f911b6df4fd1...ba920d3edb=
7a

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
