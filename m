Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461023;
	b=WVy9eCQrPvMi5JDmryRKIOAulrjmMAntEZyeJd6BwrazNSnaHJPXu2Y5xUtMJ/AO2Str
	 IBdwkeeS7NEpmCrn89kEerjluxmKjVr2wIW37+x2bEMHDckuycgRihQ8x8OzdQhgjWtJ9
	 UahIpApKlT+LZ86wLv3wIxjpBMMdtmGp+fohWB+0YghwXE2Kn09s4nV6WrDEn6+PXYe6b
	 wMc8eLh/zmP7wytkWNsojdd/y27Kq3ONfBfORVgrsGRuKRLz9JSvbAMJG/bW0OvhGKadB
	 qjWgxkqm9cVppBuxn9Jlj7b2bNaY1Jy861libHmVh3uFBRRzcGSA7i2rjhWkjQboo+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461023;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XF+XlWddQxh5ypU5C2UP153MVDpw9gXUUW/TusMfDZI=;
	b=cpXSJfUijCFrL4eOfwnFIPmUilHwcXwRClJfoWJC93FYWerPakiDnYuyqNhRazWu8TKv
	 XcKW7S+Ra+KEGIhXUacMGG8y2fAf5XRMd1htzHmvVpMCdgTa2keGjg35r69cb+wrK+lGg
	 s052xpSprlNxNgQqHBYau65bY1GOOq8xcrVm9xZqsKcX+TN9xCZmhRE7WC8Eu+i5vFIoa
	 vtHa65h5Qit0VUwteeVFIDafKVHt7eE2t+zBvxfASAp7MNfXvX4jRHwEuSBBHhZyYDT+S
	 kttBYPcNJ8d7G8DDtkU5ZxXEWHNv4kDO8ySrUrGhHJNih2X8/2etLHbiZQbCyRpVeXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TH/nOe+5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C567606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH/nOe+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBDB1F000ED;
	Mon, 23 Nov 2026 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461022;
	bh=XF+XlWddQxh5ypU5C2UP153MVDpw9gXUUW/TusMfDZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TH/nOe+5nSpoSaU3cQIHkvVU+KdzZ3NPIG4QFvy4Y1j0Om+bsVGimOqPS/2XJtgfc
	 cVB5g9fFtIK9NSKG0iyqmL0v4MSmiIO8kGWTzwx1RO4l6GDm/SoAZ3fzdAvFF7jZlh
	 aVQiUmShJag56hxsp8TAVDZZOxnLarm9QJB/j3iA1U1b1jsGVo5hY7kKBPkMRy+drQ
	 yVwlznuxUajSBBG1Hm4no8NFOxjk8Xh3DT6Wd3qsNWw432IwggnDjMJfufcAes/dBK
	 xVx2Oay5j2iMPwI7FgmyDNXLFNtLjEd6yWkLsJGZ5sELgkdW7HeHG/bW2w1huOx6ww
	 Cke/F45ix3jBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43DB392EE35;
	Mon, 23 Nov 2026 19:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Don't make a periodic advertising
 set
 connectable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546102127.3063022.3369263066403108201.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:21 +0000
References: <20261122201412.2856420-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122201412.2856420-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com,
 marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 21:14:12 +0100 you wrote:
> From: Michal Dzik <michal.dzik@streamunlimited.com>
> 
> An advertising instance without MGMT_ADV_FLAG_CONNECTABLE follows the
> global connectable setting, and so does the instance of a broadcast
> source, which create_big_sync() starts with no flag but
> MGMT_ADV_FLAG_SEC_2M. Whenever the adapter is connectable, e.g. while it
> is discoverable, the set is configured as connectable extended
> advertising, and the controller rejects enabling periodic advertising on
> it with Command Disallowed ([Vol 4] Part E, Section 7.8.63), so the
> broadcast source fails to start:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Don't make a periodic advertising set connectable
    https://git.kernel.org/bluetooth/bluetooth-next/c/592031ccf61e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


