Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708409;
	b=kgW+Dw5PYGJqm/TDMSPjMuH8qxLdWr+dIfRTMNoksNynnGRwau8TSJh5rk9F4lc+n5Bt
	 p1nOb23qeKE1Ogp0pogQEt9BzoSSvDWdan2pOTtgnmbiZWXvWc6p1kEGaOoJYBIOjnnOh
	 6q+qs9Oj4GJiENw6TIbaau5D+sregw5NlBMyK9Q9eKHoCYBjfQRFQEmNLmfYGmaL6IaWf
	 r/XtGcDoj49Z7RIoGmBYMeW+2U/EfJfaTaBCYUn+IMZ5Yl2X/MxirTyQYojRDPPhUSB1o
	 3Az5dvV/NCQnH8q9buQCMM465xhzF7HrvSMN6Sbp17S2x32Y0UVrVHMVWsu/G8qAMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=oT9YuHSPju8Pvfp1597TjYXA3UOlZvdAAaybvtSSbT0=;
	b=JhzMFhYg2nkQ9j8g9YvZbO6/f/rbWq6LBjNVGoxfcUwhqnHR+HuKjhUEivI3uhsvhGmX
	 ooBWWqgiyCAmhkRNi0xWx1DP+bKKiNR06OheDijwQ0eW0i7khVhJNN66xyG/8SihyWfMR
	 Bza0p9crFmYy93/HGPCZfAPljX2+nXBnbqiUullMXR/FRBlS7mAhPNxAqXYRIcwaYyii7
	 +QoEi64h1Zqxv9nt8d6SEh0FWqzC9l7c8YkfgnVZWluaYkjmMb50HrFP4T4Ve9Yd5CSod
	 n2sO6xffKtjV+BiGHj5OuSdwwDJxDQ3UgIqkj98IrOQbf/7uMy1YdKd/b0RW1gJvwwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHd5H17Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F8606A330;
	Tue,  3 Nov 2026 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHd5H17Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8A91F00919;
	Tue,  3 Nov 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708408;
	bh=oT9YuHSPju8Pvfp1597TjYXA3UOlZvdAAaybvtSSbT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dHd5H17QXyGwiX2nzqM3E1uELLa4jg2UKsWdyNHWAhGke+2VbhepVU9F/UwnMzLR+
	 Xnj4IRS82IAswKn7vpwJZ6onYHlyNx76DVVDhtzwXxVOjAuk4J1YTscs19hTM1e2Xr
	 1TZz7j7D99IY9CY7p1psG4kVI+WGNXplpHDqxl7nYciPbYSeEHrRzFa1wq8//kESXN
	 mXabWGtqk9c74sePHK4ISS2PGsQxCnPjD6/uE6iEfPTkowSWwe073WDqu43dwS8p9P
	 gFsF0gTsnbMVoQwR3ouGMnCyF2fHUHxpeG9YLx7ajZRm4yQyJkc4q3wc2JalQR76Sy
	 9GPQpjqFNa/1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 403C33805CDE;
	Tue,  3 Nov 2026 12:20:08 +0000 (UTC)
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
Subject: Re: [GIT PULL] bluetooth 2026-11-02
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179370840678.1093230.14823305671428075992.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 12:20:06 +0000
References: <20261102222018.2610820-1-luiz.dentz@gmail.com>
In-Reply-To: <20261102222018.2610820-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Nov 2026 17:20:18 -0500 you wrote:
> The following changes since commit c3e67bd82b9b9b1a5118f09a429ccefe2aab0741:
> 
>   ipv6: reject wrapped temporary address preferred lifetimes (2026-11-02 22:31:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-02
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-11-02
    https://git.kernel.org/netdev/net/c/03d36763291e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


