Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA5280309
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116210; cv=none; b=AOdJbJiTAjbyYS0kz9HpCI8WN9XDHvxba1QrNSfTBVLNxYF4lv3Wgamx7h+YbVFPGUTYIrXuDelNRXO+NQV4UhPudhceipNwqaGsRonw29cbH5xQfpkfPtZVy5hmWPEQLHvLd/PmbajHz8F9dQZBhsLDEwfQ9JNhPiTXpWWLKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116210; c=relaxed/simple;
	bh=xHFVcDY4mSC/QCeD5BMK750CuIOeoWwQP++X24O8kR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TnlmtaHmuzs/3Q/Q6TrBnvVDiBdMxVkrcbAICMErCuXFPfkCBbeVlWjunIEBukFoxn2FHP8F9hd16ZXyWh9VJsQROkx70EplVpEZIp/FUv1nerOeODdSiKwTwOud4tUVhQdqjiLKVaSlGY44Y39iqcFWmGT5EzNA2l3C8wGpY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqnLFC7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqnLFC7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4831F00893;
	Wed, 10 Jun 2026 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116208;
	bh=rWmpCrvMUbHlHK0o9qWEv9RO35ZUaZVHQgRH92dRO5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gqnLFC7ygxpPJJAMaMBJKfXIxDP5NHAZkphUq4pRkEik9tpkQvxnhs28DjjJBmUuY
	 C7TwdFYmGhnVtU+8s/r8XHA3THyu4ohj3+urouqLBmDVT5C7ttN9iwr7dNxvEtLJ6L
	 nlyJfGwCxHf9mMraLNvk8Cu52+djSS5gSCxk8rl/d73nLnB/Xkr2YtsZeAZl2aXBA0
	 qnY0cri6878k6ZGXWrCjai8105NPKCdBJseN4q5Ofg/vnC7HomjX+fTa6vgftBHoPO
	 lwljp+1Z3U4xI3c7P3APBVNipgtw81cB73EMrAnUsSmnYwhjsOQRxpuNL513Z2dNtz
	 3m2lYHMmzlFAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09293930DEB;
	Wed, 10 Jun 2026 18:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/4] btio: Handle EOPNOTSUPP from accept() to
 prevent
 busy loop
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178111620639.3582779.16078863116102964223.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 18:30:06 +0000
References: <20260609185313.155105-1-luiz.dentz@gmail.com>
In-Reply-To: <20260609185313.155105-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 14:53:10 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When accept() returns EOPNOTSUPP on an L2CAP SEQPACKET server socket
> (e.g. AVCTP browsing channel, PSM 0x1b), the error is permanent and
> retrying will never succeed. Previously, only EBADFD was treated as
> fatal, causing server_cb to return TRUE for EOPNOTSUPP. Since the fd
> remains readable, this creates an infinite busy loop that hangs
> bluetoothd.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] btio: Handle EOPNOTSUPP from accept() to prevent busy loop
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c580d30d265
  - [BlueZ,v2,2/4] profile: Check if bearer is enabled on registration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=abf0911e25ef
  - [BlueZ,v2,3/4] plugins: Check btd_profile_register return value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b5895d80635
  - [BlueZ,v2,4/4] bearer: Check btd_opts.mode on btd_bearer_new
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c821a150b8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


