Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF96222D7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027015; cv=none; b=Nlshb3T1DAhI5JFm1NPzR+uTEbhEUDj+H23DZw6XvLAo7G18MmYg5T7ykCA3xXfMueskbtkXhhH9mpl0pGNNa9kHJzaR/HH0Abz9m9/kcGyZSNI3/6NFSAWfCNUCjgN5spqattG4Dt2HGY+c8MmHLAaoCXG8GP1h5YpkLh2qhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027015; c=relaxed/simple;
	bh=wtgJ/lWywQJvfihfOYIvHS3BDbFgwv3knGgePlo0sLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SUPnFabzAdrryYrDQGjIpzWblsposuR0F88KYLKSQtXoM4XW9495brWTRIa9OLoEbzSVE36bcpTwYUjihJTZW3XMYS6LVOx4M4wXclA0f7MDPkZ8tR5GpqG+TpCDJZcbg62WXauuFz4EFDeEyxeJ7txVRXJnezQxyLcMGz666Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CblxohX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CblxohX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507BFC4CECE;
	Thu, 12 Dec 2024 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734027015;
	bh=wtgJ/lWywQJvfihfOYIvHS3BDbFgwv3knGgePlo0sLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CblxohX5fQ9BQXi1p8CdtkXATmP3jIo9nGDS0os4hvj+x79pM7Yx8s0Txb9UIr7Et
	 7RvrU+ZyhOhfcH9zRlgXjxj8Y2PrHgWMjNcMFAoEiJqU4LmX7Mx8IAIDsyFv2ztFL6
	 rVIZnAwZY4Vdhue1NZQcx+s+VF+PPTPOdF5nBu4UZH7p9dqewB9MrxYuVBGTTd8aXB
	 Ig5Pjm9cdibn9cXYnY3K6uxtgvGyJaQSsUr/TZUOZP3oGBpBYIDh+1F1IY2G6iwcgH
	 zRCMKIXC33mk8K/Jf/0VqySzOH7J8cCqWoYhRqDIxGmSBonta22IExWEAQJTiuyHis
	 tI4pCXOfQGY7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFB2380A959;
	Thu, 12 Dec 2024 18:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 v6] tools/obexctl: Add support for system/session bus
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173402703150.2391244.12045358287442570462.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 18:10:31 +0000
References: <20241212124903.3450994-1-quic_dgangire@quicinc.com>
In-Reply-To: <20241212124903.3450994-1-quic_dgangire@quicinc.com>
To: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Dec 2024 18:19:03 +0530 you wrote:
> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
> 
> Currently obexctl only uses session bus.
> As obexd has been enabled support for both session and system bus.
> Configuring obexctl to use session/system bus during the runtime
> if the name is available over session or system bus.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,v6] tools/obexctl: Add support for system/session bus
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=40e5ebd0cb2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


