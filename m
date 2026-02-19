Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7042C1589
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520987; cv=none; b=qfaY097BfiKFHSG6A/bCnvftmzch3Wq0uE62jy8lbCdofBfY4+9I/LGGsU2B4GDPxscxfh3LgJCO0UYEfBR3WuWnUwH8fnc6U3di/dadeHxvPGgnCMNZaX6LqTA+JckhqMuw45D8ANyLhsfpsjCinMg7dMtyUnOAdPBwtW7Ayl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520987; c=relaxed/simple;
	bh=y4VAXxLImU8grJvBUP+OaA99G2u/jBNjhhmoGleaT4A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ur7s2flIKMLju8Qgt26QWMb9P7d9Sw2v9k0WMHC30M7WZa+e4UBjJ/NencXcdsBzc11z5omOoUVBYjoc4B5fr5haAoeptvUW0s7rCuupwD1iqM+BKRXeiqbYOMUdvh50q33vggTT30XrofaMkVRgZMbrXKaMRrwvQsyZ7d5IVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DDhg3bos; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DDhg3bos"
Received: from github.com (hubbernetes-node-cb47d6f.va3-iad.github.net [10.48.180.55])
	by smtp.github.com (Postfix) with ESMTPA id 74E723C0968
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771520985;
	bh=jsQvBILb7qv9ZBXvlPguQH5i2FInBBIcMquGtiqCaAE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DDhg3bos+R507rDedrKZWJycNe15sav4mru/zGLxyDpGwX5kRv1htgm8HA01nEG8N
	 VeiYy7Yy5cf34ELHt4XjuSEffUwbV8Mpn8j/Q/OgZn44x3hf/GU4xUr8DguFe2xfxL
	 2tOPoRGKm4zaSP+jR6qwC/jBkIIFYvHEc4AHpO48=
Date: Thu, 19 Feb 2026 09:09:45 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055603/000000-353f08@github.com>
Subject: [bluez/bluez] 64da88: doc/btmon: Add missing documentation
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

  Branch: refs/heads/1055603
  Home:   https://github.com/bluez/bluez
  Commit: 64da887d435014ef4be9e60f4e1532a6e6ad0ca0
      https://github.com/bluez/bluez/commit/64da887d435014ef4be9e60f4e1532a6e6ad0ca0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add missing documentation

This adds missing documentation for -I/--iso and -N/--no-time options.


  Commit: 45059d65a38d57176abe3630198f0576d22d821f
      https://github.com/bluez/bluez/commit/45059d65a38d57176abe3630198f0576d22d821f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add dedicate sections for timestamp and frame number

This adds sections for how timestamp and frame numbers are generated
and explaim the difference between a frame number and a line number.


  Commit: 359d85584f548c37200782c92be991b56b038ded
      https://github.com/bluez/bluez/commit/359d85584f548c37200782c92be991b56b038ded
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add connection tracking section

This adds connection tracking section which explains how connections
and buffers are tracked.


  Commit: 5902cbd78af2234d638d4524e85bdd38b2243d03
      https://github.com/bluez/bluez/commit/5902cbd78af2234d638d4524e85bdd38b2243d03
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a dedicated section for analyze mode

This adds a dedicated section for analyze mode.


  Commit: aeac5e7c098af31e7144c23756ec55722c0c5cb5
      https://github.com/bluez/bluez/commit/aeac5e7c098af31e7144c23756ec55722c0c5cb5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-19 (Thu, 19 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a section for automated trace analysis

This adds a section dedicated for automated trace analysis which can be
used for analysing traces programmatically or with use of AI assistance.


  Commit: 9026f57a32509235cf5dad1f244f719cf2b6af0e
      https://github.com/bluez/bluez/commit/9026f57a32509235cf5dad1f244f719cf2b6af0e
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


  Commit: f727b3fdf8f7e906fa369e937d817cfe38172aaa
      https://github.com/bluez/bluez/commit/f727b3fdf8f7e906fa369e937d817cfe38172aaa
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
earlier connection events.


  Commit: 353f080b028c477e55eb6deea74c4c3e347e9ef6
      https://github.com/bluez/bluez/commit/353f080b028c477e55eb6deea74c4c3e347e9ef6
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


Compare: https://github.com/bluez/bluez/compare/64da887d4350%5E...353f080b028c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
