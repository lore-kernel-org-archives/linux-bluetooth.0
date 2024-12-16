Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E81B87E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385820; cv=none; b=oiucfowehTMNmS8JzgQzFxkUrsI7CVaM27Er3vLlmoN/b1KXfZlyNM5Msei/zQiemtvExBd2C0oO+nEOyEXHu9UsXximKm2Zpo/y4Me21xhcXPdC95B5AVwHnACRy5GIkdxQV3pQQB4Rz67f0LK9doiaTJR4gpj++pVOvYIHbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385820; c=relaxed/simple;
	bh=rVZvVi3QCwDcPbpWyGE6Kh26dLc0Xs17WfH7c1WKepo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gp/g/RKFUpI2QgiTQAn7LEuXTdBLoOnMixwydBwUVKwf5WuImrDt+ejxzR2uwjCBTqmWOjg1Auew3XDcUVkJkQsKLIufde8IfbvWXk6PWdwP3PJclNRHDFPQGfa0E2BRR3sPLAe6QkuDA2x/59IvKoee9Q+D5jbJ6NsvG0LvUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/pkTkZs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/pkTkZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1297C4CED0;
	Mon, 16 Dec 2024 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734385818;
	bh=rVZvVi3QCwDcPbpWyGE6Kh26dLc0Xs17WfH7c1WKepo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g/pkTkZsvXYCF1zMconhX6lToY4RfSeEsq14fhE44+WlkEvFCBtDc1Z0a6YX8mkMh
	 9bRyQsqI2tpw4YoyGj0op6nt1qE3qsMYilaOwin5WK7bWeBpBjAbVgFzvS5+N/O5EE
	 A8tnjlE0jx3qm7Bb/GcytMhhLQeIozZnYaPM3kGFFAZTL5/JHUynh8QzqBoKGeByRB
	 mJ7xnxWAzVOPUR7jx4JzwPIeaSvwCSD2YUoNYXC/A6clSHjXXScXoWPYP81/saTazw
	 KM37qqgOlSII5rsqvknFznXjid3TDc5fU97ZXJQaskCB7qmKM5z+ntQxrD+WfBOoAr
	 7e3wLJ27QvIxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2F6613806656;
	Mon, 16 Dec 2024 21:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] lib: Add constant for 16 bits transparent voice setting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173438583603.361160.9559733630932141894.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 21:50:36 +0000
References: <20241212161445.298083-1-frederic.danis@collabora.com>
In-Reply-To: <20241212161445.298083-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Dec 2024 17:14:45 +0100 you wrote:
> Add 16 bits, 2s complement, transparent air coding format for mSBC.
> Corresponding commit implements functionality on kernel side.
> 
> The voice setting is used by sco_connect() or sco_conn_defer_accept()
> after being set by sco_sock_setsockopt().
> 
> The PCM part of the voice setting is used for offload mode through PCM
> chipset port.
> This commits add support for mSBC 16 bits offloading, i.e. audio data
> not transported over HCI.
> 
> [...]

Here is the summary with links:
  - [BlueZ] lib: Add constant for 16 bits transparent voice setting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b631e09e943

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


