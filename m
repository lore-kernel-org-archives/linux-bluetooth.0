Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14E2F6903
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050645; cv=none; b=Wk0NQIGzCqPcHjo8ipy7qYP3ISSE9yXVQhbwQPKmposf2idkx/qGNk4NsklQz61XEqsDUq421jIjNA+Sdlg7QgV0k6nvajxt8FpG/eSzqQVct6FnFZSGEMdqbNrzd1TqOShux/8wGJzgbEI+Av1O1gXmCP7DYbj0WkVRlajtD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050645; c=relaxed/simple;
	bh=+A/49oIbXvnwhWAxNbYy0sGQlkezEvc8QISoutkCgkQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HmCfZpsPy1H8rUvZHWRXPW5+2IqpmkiDVsz5Hvg+TKcaciRbkq7ONIixf5hXo/+QW36XKI+fBWJt4CJWrOIimccAMHvQPGyWDd6Y67EFVX0Lhyvny6hUFcQOouweGDQndHuA7+c7TBz/tLVN84/5tPOtQe/nKM6PyWmncQldkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CR2qbF6Y; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CR2qbF6Y"
Received: from github.com (hubbernetes-node-91ceb1b.ash1-iad.github.net [10.56.226.74])
	by smtp.github.com (Postfix) with ESMTPA id 208226013A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763050643;
	bh=4jPhxNC9v4G7jpdHqCLHzuQKp9gs7Fdvah2Tv244Ts0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CR2qbF6YbUGERs6goDMSZdWgvYKu5hGYlLN3JrMn9Xihpp1pvwA2PW1cccTRA6TGb
	 mWjW54VdReNc5zXzpSKWEPv03A3VMSekWBcLk6nuLg3Oczxk6dRIAe9YLl1gBM9blz
	 qY0xQsJRSGin30X+Jzr4AAEayQP/VCkGdlQsi62Q=
Date: Thu, 13 Nov 2025 08:17:23 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023061/000000-a834d1@github.com>
Subject: [bluez/bluez] 9f8161: monitor: Add page information to
 print_features_su...
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

  Branch: refs/heads/1023061
  Home:   https://github.com/bluez/bluez
  Commit: 9f8161fa39d34a34c35603ab7a91b804ab362a19
      https://github.com/bluez/bluez/commit/9f8161fa39d34a34c35603ab7a91b804ab362a19
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add page information to print_features_subpage

This makes print_features_subpage print the page they belong:

> HCI Event: Command Complete (0x0e) plen 253
      LE Read All Local Features (0x08|0x0087) ncmd 1
        Status: Success (0x00)
        Page: 10
        Features[0/0][8]: 403900f301000080
          LL Privacy
          LE 2M PHY
          LE Coded PHY
          LE Extended Advertising
          LE Periodic Advertising
          Periodic Advertising Sync Transfer - Sender
          Periodic Advertising Sync Transfer - Recipient
          Connected Isochronous Stream - Central
          Connected Isochronous Stream - Peripheral
          Isochronous Broadcaster
          Synchronized Receiver
          Connected Isochronous Stream (Host Support)
          LL Extended Feature Set
        Features[1/0][8]: 0000000000000000
        Features[1/1][8]: 0000000000000000
        Features[1/2][8]: 0000000000000000
        Features[2/0][8]: 0000000000000000
        Features[2/1][8]: 0000000000000000
        Features[2/2][8]: 0000000000000000
        Features[3/0][8]: 0000000000000000
        Features[3/1][8]: 0000000000000000
        Features[3/2][8]: 0000000000000000
        Features[4/0][8]: 0000000000000000
        Features[4/1][8]: 0000000000000000
        Features[4/2][8]: 0000000000000000
        Features[5/0][8]: 0000000000000000
        Features[5/1][8]: 0000000000000000
        Features[5/2][8]: 0000000000000000
        Features[6/0][8]: 0000000000000000
        Features[6/1][8]: 0000000000000000
        Features[6/2][8]: 0000000000000000
        Features[7/0][8]: 0000000000000000
        Features[7/1][8]: 0000000000000000
        Features[7/2][8]: 0000000000000000
        Features[8/0][8]: 0000000000000000
        Features[8/1][8]: 0000000000000000
        Features[8/2][8]: 0000000000000000
        Features[9/0][8]: 0000000000000000
        Features[9/1][8]: 0000000000000000
        Features[9/2][8]: 0000000000000000
        Features[10/0][8]: 0000000000000000
        Features[10/1][8]: 0000000000000000
        Features[10/2][8]: 0000000000000000


  Commit: a834d12c243732f75c8eb88453ebc3affdc5563f
      https://github.com/bluez/bluez/commit/a834d12c243732f75c8eb88453ebc3affdc5563f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix set_bredrle_commands

This fixes set_bredrle_commands which was overriding the list of
commands previously set, so instead of setting the extra command
after the command list of the specific version this is now merged
together with each version that requires the extra commands.


Compare: https://github.com/bluez/bluez/compare/9f8161fa39d3%5E...a834d12c2437

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
