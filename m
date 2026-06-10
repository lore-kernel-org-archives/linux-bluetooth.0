Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A03ED5C9
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086613; cv=none; b=ePpjcQVYa6fwmoELJ8npTEy5y5BLsxGh7QdvRuc/Esp2A3zwr8C7Qs3BVqSM0ZhcVT2WIUuZ1JkMgsx69MgolDps/Aphb3WI09A7DTBC5AjR98J9zcTNJmUYaSgSMJqfz2Qffv9xSwAG20WjX2MU660YogAPSR/+tGTjnQwlVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086613; c=relaxed/simple;
	bh=NwqnTNNHj9AXMjEFwHoui8Ehmifk9dd1D27kFRvDwtE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j1UGvCycQwU/za7cfOjx0IJQrHamDHa/ao6RgXVJrcma02X+DOa8KJcqVBWFIGFm11oWfSdawMWhGEPQVBKH499P4RCRNubtMoLpVXQRyx1hvqzHWUvhKt4g00KRvtcIA7UAlOMXhyuQzXANO++fmDYjVaLNRWRmNvXLoE73pAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EMjUyH3v; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EMjUyH3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781086611;
	bh=ZXJF4v2xBMVwXwSIcy60lKwgo0OL4MD159U9GEh58Zo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EMjUyH3vFIXTX4nrXFxAdLyPWZG6qK4VcRxsj1PbrL1ICarcS3ed9cZBnVw1wMgHb
	 +8KgEqfXUrsLXPQPRbsD8auyrdcvqAvYcFEYncAWZLgV95S7yL5IEflhWcMX2a6X8M
	 2VpzxxVyWM08dhHcYeNU+at0HSqJOuDCG4dO6WUE=
Received: from github.com (hubbernetes-node-7d9eff7.ash1-iad.github.net [10.56.86.29])
	by smtp.github.com (Postfix) with ESMTPA id 67A00181120
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 03:16:51 -0700 (PDT)
Date: Wed, 10 Jun 2026 03:16:51 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1109089/000000-cc2e16@github.com>
Subject: [bluez/bluez] cc2e16: adapter: Fix failed bonding attempt after LE
 link ...
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

  Branch: refs/heads/1109089
  Home:   https://github.com/bluez/bluez
  Commit: cc2e16f0137dbc4f21b2f5078d2c28b63a886260
      https://github.com/bluez/bluez/commit/cc2e16f0137dbc4f21b2f5078d2c28b63a886260
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix failed bonding attempt after LE link disconnection

What happens when issue occurs:
- device is connected to both bearers BR/EDR and LE
- bonding is requested
- LE link disconnects
- pairing keys arrive

BlueZ would finish bonding request with error and mark device as
temporary. Then it would be disconnected+removed after default
temporary timeout (30 seconds).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
