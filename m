Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D368833
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036228; cv=none; b=l/f571zO6GvjD7YjLzowAvfEvAbLiIsbEtQ9FsAOa/uT17qNDydqj8F4xtrwbw8xkrx/4CN8TMKQESYK7zBc/iq+nF+yi5vZviLb/ItpQOBhCGj5yKAP06SjzpkBSoFaU11DlVDtmkguD5zdj2ZC6bzS47TNImMDCNH378QwNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036228; c=relaxed/simple;
	bh=ZSYsksT3D8h49IaT66HAN74Eu22+XLNlg28GMNoUCVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fWFIlDA8naBnM42glzZbKGU8rA+4IpVjVQrTIWJ/N1lwr31bIIdElpjJTvdQzG7hJYSGPdzHdv2zK2AwDjEbUeOFKF9XBnJtlzSAlGy9CYZWJFQ59XwHM5ZnPBeqfi9krMhLZytPKA2isEGUGhRNLJhJh5GvzghiDSLEnTlLe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMjdUmJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMjdUmJH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFF15C43390;
	Thu, 15 Feb 2024 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036227;
	bh=ZSYsksT3D8h49IaT66HAN74Eu22+XLNlg28GMNoUCVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hMjdUmJHkK9+NonzVi+gvasWOw7SMpPKoE13UArDUv6RhK2HSDVSak3KKQr3H2/I/
	 V7XfQMsJI65mh7qZSVZ83wYE8LEqxe+XUNFcVf9i4sedOF4C4TwqxnABSq/wlKWvBH
	 fJZ6PYUt2GXp0t1HrqCU3iDg7CkEzFbGGpFvqbDq97yEd3u7eBWLREUfIVZDkPpfKL
	 lZh+/ZxzhU3/Zcr5vHcF8VndJK0+Ai9s0RLX9S+QR25VTpEy65GkgM12jOoFxfMFeD
	 npen7e6+MQoCgMxDOb3Ua6UgQxuBdt3BGanbaQ09o/3MFQ6Fc2jhvbMPtrPaRZu6At
	 vb+GBDI/T4R2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C45C0D8C978;
	Thu, 15 Feb 2024 22:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] advertising: Do not set timer if DiscoverableTimeout=0
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170803622779.8064.18293244687169511358.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 22:30:27 +0000
References: <20240213131205.28250-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20240213131205.28250-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 14:12:05 +0100 you wrote:
> According to org.bluez.LEAdvertisement.rst documentation, the value of
> zero should disable timeout and keep device in the discoverable mode
> forever.
> ---
>  src/advertising.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] advertising: Do not set timer if DiscoverableTimeout=0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c58a4d9f7880

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


