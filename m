Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789238;
	b=QWiOViD5l412aa3kN6zuqonvIbOfy098M+4x7mT+WYLyNUK2izqgKBP/WR+Z0thNGumU
	 Tmn1QMR5vA5waTKZcConadJ7BR3ThLFjvQ9D2wAXdSTt5gp1NJHi+l8IfR+XOzQzrLyNQ
	 WAwVfkzPB9zBVgJXUvQcBf1KppIWfy5pyWGfAQEUZD8dupK5mklADeCwWj/ELB8otRhAE
	 YphbnZ0SEX8nUy8f5880bjHY8KUOchT8JYz35lDYysgYaDra+awzdlnxJxGIm2RmJ6qSY
	 fjtKIYap8FK9yDes9Jq+vB/8ZNbk2IH0UJI4LVFk7xGbmz9OicpZWHOH89E1sZwbEAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789238;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NKBveN7yUodXpn4bCXrkHx08PTFIZFImpoSl1UQrJbw=;
	b=qkGj2n5aGhiV5GuwjSzM5EpAWjSuRmBKzDzLBXQliLSIy59/VswpCtfbTkz9tr6yitge
	 TlFezlZ5eX+b/+UvK2U4Zj2/86k+jO+HAv2ila0+gyLTjGVNA8TQk6SwkIGkJeTVtIpCw
	 HAySiKkjjfteUS7zRe8PrHFNBA+H5GfrySbmiKi9SZ5saF9jJ8wpQzSSKGg5Yu+kOfbEN
	 4Md22+XLG5WDax6WBVdq8ot6eSwT668SSRpcGemVNDGspsOHfbngIWhNAQWw5i68K9gGv
	 87LXvpsARDJlJSVlyxJp4OjHGdVkJYVCfTwVryuenZXzmaSZUj1D1Gk7tFn88od7aqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvsEclL7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C76606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvsEclL7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B9C1F01825;
	Fri, 23 Oct 2026 21:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789237;
	bh=NKBveN7yUodXpn4bCXrkHx08PTFIZFImpoSl1UQrJbw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XvsEclL7tw3vM2SMwXUwWRxMAEzQx3TLWMUZhfHdKdhuDmMi6G4v2+1JuxtRtqyFs
	 JXs9mSQ+RBdHb1kLGyzLaZJH9evOgBxOb4aoQ6omopc16qxnG+8XMgXv48MdiDKc92
	 INTD+KeletQDeZ1InaW4i5wbDLlxyrlK7DTpQWUnslfGWEx9aFGtthwngN5JeFbSBR
	 kGnXSdHoARJvmxhsx1TSroOhZFhbSSStmwCUNj4zyJUI5LrE1yj13PcRskyKeOSl7N
	 LgPUoua5Gyf8czuwT8NoVyoKYd1gS2544xRJK5Gjg2V07p0n9UFPw7l4oAApCdlJNb
	 RZ61IwFmG0Zkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE56A391B157;
	Fri, 23 Oct 2026 21:00:37 +0000 (UTC)
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
Subject: Re: [PATCH v1] Bluetooth: btintel: fix buffer over-read in fw payload
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179278923631.1268720.7892798923940223357.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:36 +0000
References: <20261023060026.524147-1-catherine.l@intel.com>
In-Reply-To: <20261023060026.524147-1-catherine.l@intel.com>
To: Catherine L <catherine.l@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Oct 2026 11:30:26 +0530 you wrote:
> The firmware decoder cast fw_ptr + frag_len to struct
> hci_command_hdr and read cmd->plen before confirming the
> header and payload still fit in the remaining firmware
> buffer.
> 
> Add explicit bounds checks before each dereference:
> 1. Reject if the command header is not fully contained
>    in remain.
> 2. Reject if the full command including payload exceeds
>    remain.
> 3. Log the offending fragment length and remaining size
>    before returning -EINVAL.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: fix buffer over-read in fw payload
    https://git.kernel.org/bluetooth/bluetooth-next/c/4891a9f76d0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


