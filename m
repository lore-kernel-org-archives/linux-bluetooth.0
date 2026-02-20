Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78432AAA8
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609095; cv=none; b=chg10NvaJDMuczwMi3z7GpVZRo+hj9uxEjmIdAWvw8t6PA8L7Q9uutC6kmKu29jBZ2DugXk+Tl+3hufnwV4VxiI/QMOtehhkaY5mTyV0Lwr0tIxL5ki4RS8C9aCtq3SZIE+NrdxP391SGeVRoNbdmvmsTQvXuSJF8tm6QBfts6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609095; c=relaxed/simple;
	bh=rdW53QA7jnyFAfGMyb6sq++6RCU/nXJIeggRMj/bVlQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iLMy5qm3pPNne4g0LMZbJRWD5RNJKmGJlbWtARMQzA3yKs940/rg4ukmXtHgSpMa4sxwKP08WLCzZgHv1mj/mPqD605bEgCgHycJIvI8i3BPbXq52B81QXlWNT2UcBDlfbH26rqxF9PLSGL9ZDFQ5eU9c1BWsZvuG3CkeLP7BSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G2f67B6G; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G2f67B6G"
Received: from github.com (hubbernetes-node-eacf2a4.va3-iad.github.net [10.48.142.41])
	by smtp.github.com (Postfix) with ESMTPA id 6372C4E0CB2
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771609093;
	bh=fsBtYtd5K8ljgxkKFO+rMft4zc8CCls92NTW/dG0mWw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G2f67B6G8QveEDT/dHkaxmBvOj1b2fxjSA75Y3VTrS/UzBV3vKWILuS1csYrsxL/o
	 kWi5nyQz59qw00MM8pzs+iKdjA7R20RZUyUBm36H2Qn35A1zAfLtUyENHeGFYsE8Tx
	 hbqmvEShevGa9M2xEEGGoEswkk261ki2JqGY1E2o=
Date: Fri, 20 Feb 2026 09:38:13 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055976/000000-96a318@github.com>
Subject: [bluez/bluez] 7d8ed1: doc/btmon: Add missing documentation
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1055976
  Home:   https://github.com/bluez/bluez
  Commit: 7d8ed1d592f296cd3bb0532b0fb0efd189459e91
      https://github.com/bluez/bluez/commit/7d8ed1d592f296cd3bb0532b0fb0efd189459e91
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add missing documentation

This adds missing documentation for -I/--iso and -N/--no-time options.


  Commit: 123a25486df00559b69bf00a0752f393df35bbe0
      https://github.com/bluez/bluez/commit/123a25486df00559b69bf00a0752f393df35bbe0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add dedicate sections for timestamp and frame number

This adds sections for how timestamp and frame numbers are generated
and explaim the difference between a frame number and a line number.


  Commit: 1b778c8bd76f72c8fac10cca14bc2d96f5004841
      https://github.com/bluez/bluez/commit/1b778c8bd76f72c8fac10cca14bc2d96f5004841
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add connection tracking section

This adds connection tracking section which explains how connections
and buffers are tracked.


  Commit: 2a85ccab9207bb14c907d5cb9b65a4a26cfa2d9c
      https://github.com/bluez/bluez/commit/2a85ccab9207bb14c907d5cb9b65a4a26cfa2d9c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a dedicated section for analyze mode

This adds a dedicated section for analyze mode.


  Commit: 40f6f249e55f70d615decd1998bed1c0cf5a2ddb
      https://github.com/bluez/bluez/commit/40f6f249e55f70d615decd1998bed1c0cf5a2ddb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a section for automated trace analysis

This adds a section dedicated for automated trace analysis which can be
used for analysing traces programmatically or with use of AI assistance.


  Commit: b6178276a744a42b1bb9ee8d51630d40df1ede7b
      https://github.com/bluez/bluez/commit/b6178276a744a42b1bb9ee8d51630d40df1ede7b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M Makefile.am
    A doc/btsnoop-protocol.rst
    R doc/btsnoop.txt

  Log Message:
  -----------
  doc: add btsnoop protocol manpage

Add manpage-style RST doc/btsnoop-protocol.rst and synchronize opcodes
with src/shared/btsnoop.h.


  Commit: 07e7fa8a66385c63c8b487fc44f610f89f0a7202
      https://github.com/bluez/bluez/commit/07e7fa8a66385c63c8b487fc44f610f89f0a7202
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add reference to btsnoop documention

This adds SEE ALSO section mentioning btsnoop documentation.


  Commit: 933e40304fbf0b47b66833f191864c002072fce3
      https://github.com/bluez/bluez/commit/933e40304fbf0b47b66833f191864c002072fce3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Annotate ACL/SCO/ISO data with device address

Add the remote device address to ACL, SCO and ISO data packet output
so each data packet line shows which device it belongs to. This makes
it much easier to follow multi-device traces without having to
cross-reference handle numbers with earlier connection events:

< ACL Data TX: Handle 2048 [1/6] [42:96:D7:49:78:CC (Resolvable)] flags 0x00 dlen 7
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 527
> ACL Data RX: Handle 256 [20:32:C6:09:FF:6C (Apple, Inc.)] flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 33 len 8
        Destination CID: 17169
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Also fix the connection lookup in packet_hci_acldata() to use
acl_handle() to mask off the flags bits, matching what assign_handle()
stores.


  Commit: dcbb8808c3757f74196c7ba1fce98060fb2f643a
      https://github.com/bluez/bluez/commit/dcbb8808c3757f74196c7ba1fce98060fb2f643a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Print connection type in Disconnect Complete

Print the connection type (BR-ACL, LE-ACL, BR-SCO, BR-ESCO, LE-CIS,
LE-BIS) alongside the handle in Disconnect Complete events so the type
of link being torn down is immediately visible without cross-referencing
earlier connection events:

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 2050 (LE-ACL) Address: 6A:59:B2:90:5E:AB (Resolvable)
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 2304 (LE-CIS) Address: 65:0D:7B:2F:D6:E7 (Resolvable)
        Reason: Connection Terminated By Local Host (0x16)


  Commit: d0b93e980cf43d75cfa6981446fc92274eb6b6aa
      https://github.com/bluez/bluez/commit/d0b93e980cf43d75cfa6981446fc92274eb6b6aa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Add connection lifecycle to analyze summary

Record the frame number at connection and disconnection time for each
connection. Print the connected and disconnected frame numbers in the
per-connection summary produced by analyze mode so that users can
cross-reference with the btmon trace output:

  Found LE-ACL connection with handle 2051
        Address: 66:B0:26:F1:D3:BC (Resolvable)
        RX packets: 48/48
        RX Latency: 1-7604 msec (~74 msec)
        RX size: 5-51 octets (~13 octets)
        RX speed: ~0 Kb/s
        TX packets: 39/37
        TX Latency: 12-426 msec (~43 msec)
        TX size: 5-97 octets (~15 octets)
        TX speed: ~1 Kb/s
        Connected: #52044
        Disconnected: #53069
        Disconnect Reason: 0x08

Also fix the TODO in conn_destroy() that was passing a hardcoded 0x00
address type by using the stored bdaddr_type from the LE connection
complete events.


  Commit: 3a784bff3a29687d3e43a1a43b9bfef30fda2d78
      https://github.com/bluez/bluez/commit/3a784bff3a29687d3e43a1a43b9bfef30fda2d78
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Prefix data packets with proper type

This attemps to prefix data packets using conn_type_str so it
properly differentiate BR and LE bearers and CIS from BIS and also
eliminate "Data TX/RX" labels as they are implicit from the direction
marker:

< LE-CIS: Handle 2304 [8/8] SN 15 ...
> LE-ACL: Handle 2048 ...


  Commit: 96a318ec3a2b924f08eb2dab23cca47a51cdc7fa
      https://github.com/bluez/bluez/commit/96a318ec3a2b924f08eb2dab23cca47a51cdc7fa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Update documentation to reflect lastest changes

This update the diagram showing where each information is displayed to
include the connection type and peer address.


Compare: https://github.com/bluez/bluez/compare/7d8ed1d592f2%5E...96a318ec3a2b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
