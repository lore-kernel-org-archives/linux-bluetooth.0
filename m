Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDE3AF674
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160355; cv=none; b=KrvMfKq5iOLm/tAmJEWo/WstxB5DM4IllrCzTMgCAiMwSW6AoMVLpQLX39gneXw50gL1WkBfsE0D3smEFwj6bQf3UH4q2QJkP2QIpyPXYSZb/9Oh1K+OX8rrzPKq/IYUIetWnlPcpvLfkIjnfkofsScPZ1bfAYaQmLWaMprvJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160355; c=relaxed/simple;
	bh=R5E+8JykSP4W2ufHn++fCFgcZCLwoF+OArCikPM4MJ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EkEDz3kgSgKV7prFCTo+sAqOAQCm+1Tv3bS/R4UWOzlJTeJDjsIE0gPYsrqWDXus2jzZlFMq/TwB+JWaxPfBLqn3t4abiljiMOz8Dm+IoqsJVju1DKZLxXZnkmI8b4Q1hfb1LWdg+2E1OJBVYdL5YOQ71fwijSeYFzYZTxZnlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UgMqKn+H; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UgMqKn+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788160352;
	bh=NAcGfLdvx4aiDAbdmJn7V58InOX+g11iM7eyYZZpM20=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UgMqKn+HGmzo7iAecKLJVZpSp+7y7BgGXJWqS3rV0ByvHlCtIx9u9DxBwcp6LYi7N
	 DwjHbsB+qzsYXVQJ3dxkJFhpHpBJCW5DZKUFncaOoPCXPBQ5f6dk9oKjwCyYuomjJQ
	 V7gWSQ+YEBRzeXf5vUpxFmRqxezzHtpypxs95X6c=
Received: from github.com (hubbernetes-node-7639c5d.va3-iad.github.net [10.48.77.48])
	by smtp.github.com (Postfix) with ESMTPA id D4E761801A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 00:12:32 -0700 (PDT)
Date: Mon, 31 Aug 2026 00:12:32 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154126/000000-ed22f8@github.com>
Subject: [bluez/bluez] 81bb03: doc/hci-protocol: Fix missing & on mtu argument
 in...
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

  Branch: refs/heads/1154126
  Home:   https://github.com/bluez/bluez
  Commit: 81bb0309c998ea821502c04bc47c26a4b12b843e
      https://github.com/bluez/bluez/commit/81bb0309c998ea821502c04bc47c26a4b12b843e
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M doc/hci-protocol.rst

  Log Message:
  -----------
  doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example

getsockopt() requires a pointer argument, but mtu was passed by value.

Fix by using &mtu instead of mtu.


  Commit: d51fbc57419250ce832cf9ed7f3fc5e43ca3eb0e
      https://github.com/bluez/bluez/commit/d51fbc57419250ce832cf9ed7f3fc5e43ca3eb0e
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M doc/hci-protocol.rst

  Log Message:
  -----------
  doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER

BT_RECV_VENDOR_PKT controls receiving vendor HCI packets over
HCI_CHANNEL_USER.

Disabled by default to avoid regressions for existing applications.


  Commit: ed22f8b615f07cbc13d0a35f440be628c0cf6c72
      https://github.com/bluez/bluez/commit/ed22f8b615f07cbc13d0a35f440be628c0cf6c72
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M doc/btsnoop-protocol.rst
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h
    M src/shared/btsnoop.h

  Log Message:
  -----------
  monitor: Support vendor HCI packets

Vendor HCI packets have 0xff as packet type.

Support them in tool btmon.


Compare: https://github.com/bluez/bluez/compare/81bb0309c998%5E...ed22f8b615f0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
