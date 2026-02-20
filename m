Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A8280324
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618689; cv=none; b=MUghJH131Z2e5XAKvSNROsd2MRMhH89CvdwhPpGyzg1O4eVUeURS3PZpSjq252OZfb7ZPc1qI+see71/jEzOwaZ/n3TiTQUxmFGAkJzqiClfuoXcCkvSQSYnAz3mmYHo/L0Go4M+2tASf/fPjIbeeHeEyNmil7tm5CDoQ+tvZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618689; c=relaxed/simple;
	bh=l0Zqgb+W6b/pxBQoTR9Yiq548h68qWmZ+Lgeuoi4gqA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=azEDyzJFM/Ik/zVJ3cYKn2EyzeUvfs0l7Bl7XnkSaGuKXEwlWuHVbK5epouCK9zUB8JcI8TlcrxdXw4qlsrSrOmGiOBVsFqC9nhSkadn8LZNCDZwYlKKFs/CB8L9qDeHr0Y8Mq/myGm3zeNqemK/SDwbVIZZHvZiuAv6t9KwtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KAf0OWI6; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KAf0OWI6"
Received: from github.com (hubbernetes-node-062bb8b.va3-iad.github.net [10.48.166.16])
	by smtp.github.com (Postfix) with ESMTPA id 411263C094B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 12:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771618687;
	bh=FTtiFkWMTEwCgsOMuSY47hNXfyQjC4Q33UJovSRDzLg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KAf0OWI6nYPCOhvzBuKo4UwKLCvYJdu28snVCFJG7/Za0l50vEM8/5RHw/QmD40zi
	 +hbxR8bJPYN19cs9QntxtzNDkocjJm4Al7jMQVf8qKcjq2636vZl8/vP73qP4hXr/o
	 Fj0M8r6zvl8zM7+U7IwrhgkZw3/jeoiCIuO5IUuY=
Date: Fri, 20 Feb 2026 12:18:07 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/450e99-d84a8f@github.com>
Subject: [bluez/bluez] 5958e4: doc/btmon: Add missing documentation
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5958e449299071026d6992074f5ecaa4dfa8ec25
      https://github.com/bluez/bluez/commit/5958e449299071026d6992074f5ecaa4dfa8ec25
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add missing documentation

This adds missing documentation for -I/--iso and -N/--no-time options.


  Commit: 36197cc3965da448b56e9d3544d5d5f07fa996cb
      https://github.com/bluez/bluez/commit/36197cc3965da448b56e9d3544d5d5f07fa996cb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add dedicate sections for timestamp and frame number

This adds sections for how timestamp and frame numbers are generated
and explaim the difference between a frame number and a line number.


  Commit: 3ddbc4f499c6bd7f38652d3b4adad1c8d8f3026d
      https://github.com/bluez/bluez/commit/3ddbc4f499c6bd7f38652d3b4adad1c8d8f3026d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add connection tracking section

This adds connection tracking section which explains how connections
and buffers are tracked.


  Commit: c25a8de271371b032e4c2c8693704c0f34a96edb
      https://github.com/bluez/bluez/commit/c25a8de271371b032e4c2c8693704c0f34a96edb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a dedicated section for analyze mode

This adds a dedicated section for analyze mode.


  Commit: 197f1d2a86c17cbaa8cc6ab11bc12192e54f9caa
      https://github.com/bluez/bluez/commit/197f1d2a86c17cbaa8cc6ab11bc12192e54f9caa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a section for automated trace analysis

This adds a section dedicated for automated trace analysis which can be
used for analysing traces programmatically or with use of AI assistance.


  Commit: 076e705fdb52f14058fa524c034e23886a32b75f
      https://github.com/bluez/bluez/commit/076e705fdb52f14058fa524c034e23886a32b75f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

  Changed paths:
    M Makefile.am
    A doc/btsnoop-protocol.rst
    R doc/btsnoop.txt

  Log Message:
  -----------
  doc: add btsnoop protocol manpage

Add manpage-style RST doc/btsnoop-protocol.rst and synchronize opcodes
with src/shared/btsnoop.h.


  Commit: 791a7bb024c1a4dbb22d14ee805824a7bb51a8f3
      https://github.com/bluez/bluez/commit/791a7bb024c1a4dbb22d14ee805824a7bb51a8f3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add reference to btsnoop documention

This adds SEE ALSO section mentioning btsnoop documentation.


  Commit: 611f84a0ff0eb95f19cacf1861ca94017248b54c
      https://github.com/bluez/bluez/commit/611f84a0ff0eb95f19cacf1861ca94017248b54c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

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


  Commit: 8157e2fde5d399cd9a4b63c33539bafceb02e9c7
      https://github.com/bluez/bluez/commit/8157e2fde5d399cd9a4b63c33539bafceb02e9c7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

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


  Commit: 13cf50b6607e22ae54a1f05242825ac5097c1e62
      https://github.com/bluez/bluez/commit/13cf50b6607e22ae54a1f05242825ac5097c1e62
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

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


  Commit: 25ba1ab49f343a496be1140ac9f7612acb2ed5dc
      https://github.com/bluez/bluez/commit/25ba1ab49f343a496be1140ac9f7612acb2ed5dc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

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


  Commit: d84a8fb8db972a240fe9e76d401b09e3a3b41e2b
      https://github.com/bluez/bluez/commit/d84a8fb8db972a240fe9e76d401b09e3a3b41e2b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Update documentation to reflect lastest changes

This update the diagram showing where each information is displayed to
include the connection type and peer address.


Compare: https://github.com/bluez/bluez/compare/450e99f0801f...d84a8fb8db97

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
