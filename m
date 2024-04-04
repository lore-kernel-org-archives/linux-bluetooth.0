Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838E210E4
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262740; cv=none; b=A859RJ4oi0vIFvDKIXl3fh4GCgpAz2et4u0dMmO47zr6RyQtl2E9b/ACiayyixZv6D/VpHWR5x+S0sDMGaKzWkM7GwBKn7yk7VlR/oOIZGNa1eLt6BdJ+s/1YzvF9NN6LjBwbxrhrIpmJnlJB1r0LL6UgrOxjUkNGu+fvUnUf5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262740; c=relaxed/simple;
	bh=EW1b14hlHqwW/6lUjT+iTK8Zc/Je9HTYIhzejAtahs8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ul58E0ORMBQXSOzlw1usSCA1aJtQhPUFAxnIY8FY47kXieLi8OnHfx7TM1zAIqxoHZ2d5N8DPEA6MpvMLC3hTajCmBuCc06nzbprbxlpbbia5tMglUcv4O9/Yn01LcRnJXu3R6LJLMTPXJVx+IKBBGFiqNRiCpioneTu2NMvw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OH0KOmQM; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OH0KOmQM"
Received: from github.com (hubbernetes-node-8fa6df4.va3-iad.github.net [10.48.164.11])
	by smtp.github.com (Postfix) with ESMTPA id 0B7E08C0745
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712262738;
	bh=1qui2KboxDUbGsCK4fFNLiexTjYSDDWnMon7x2HVsyk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OH0KOmQMwwQwRVSudB1LsO6x+jJZSmyjIVnP8NVuIrfvldmK0/uE+BBLtMd8lojGb
	 zvWWUp460kyzufIOR20PV+04HTjzdJMAVLToaBhLptxblQXnVn81LeIFQ+8gS7tjMx
	 3bOx3YFXWVwJjLlWZl4gg/v2/r0rkItdo8aRrVqA=
Date: Thu, 04 Apr 2024 13:32:18 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4fe4fd-5069c5@github.com>
Subject: [bluez/bluez] ca3d0d: adapter: Enable Wideband Speech
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
  Commit: ca3d0d4f972657f924aa7fa650191b805bd92c59
      https://github.com/bluez/bluez/commit/ca3d0d4f972657f924aa7fa650191b805bd92c59
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Enable Wideband Speech

This enables sending MGMT_OP_SET_WIDEBAND_SPEECH so the users of SCO
sockets can take advantage of BT_PKT_STATUS to implement PLC logic.


  Commit: bcfd9acd2a8be2ba275beb3668bc1428994d5f1b
      https://github.com/bluez/bluez/commit/bcfd9acd2a8be2ba275beb3668bc1428994d5f1b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix not decoding MGMT_OP_SET_WIDEBAND_SPEECH


  Commit: 5069c5d68c16b0ecd7b6f9adccdf8e84db6f94a4
      https://github.com/bluez/bluez/commit/5069c5d68c16b0ecd7b6f9adccdf8e84db6f94a4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix not decoding MGMT_OP_SET_BLOCKED_KEYS

@ MGMT Command: Set Blocked Keys (0x0046) plen 36
        Keys: 2
        type: Long Term Key (0x01)
        Link key[16]: bf01fb9d4ef3bc36d874f5394138684c
        type: Identity Resolving Key (0x02)
        Link key[16]: a599bae4e17ca618228e0756b4e85f01
@ MGMT Event: Command Complete (0x0001) plen 3
      Load Blocked Keys (0x0046) plen 0
        Status: Success (0x00)


Compare: https://github.com/bluez/bluez/compare/4fe4fda73be1...5069c5d68c16

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
