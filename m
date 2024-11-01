Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177F4436E;
	Fri,  1 Nov 2024 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424054; cv=none; b=hjJd3xJq/SDE1qCxkpluKOWiMijZAf1dgZi+aPnVkhF7j7NEgCJsaxj8zDQpYWBnjrTSkwais9nrliH5GnsCAW9e1j4CLWy+NSgmSr3dpd8xQQMcyBGn6v5cHyEs9kR/V836RSHOaIQeAS4fMhDssXJywfLv7JLcds/lEHp8Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424054; c=relaxed/simple;
	bh=7XT1bikHvrBgnQnx5iQ2rG4eHIhIrqPvFQRufIB4Hck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u9/HeqisarvvqEpLDHn0JjwJT8MhLVvOrWYa7oVD6AgQnncPIvmiP9jEe6dOcguKfS7vY1XWM6n60FUM5sjK+zVGUxGt8YCV8+3JXtPNfYBjggssaY+w6laVDdHHixXXEVO/O02gv82pz8/zpggZhz2H9n6SwUTl4XDvnUgkwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTroap8U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTroap8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8716C4CEC3;
	Fri,  1 Nov 2024 01:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424053;
	bh=7XT1bikHvrBgnQnx5iQ2rG4eHIhIrqPvFQRufIB4Hck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YTroap8UuZ+zdkqYu2H9sBnu9JCMry4MH9M0Dr6jbjcrZGjAq3ZPjsp2ssiVIksdV
	 zXy1nZmkSIqWwhUX0QNW3CYkp7cXw6NCkmqrQg/Oy/kQOTx+fpXTN0uX0b3Yieudkc
	 jXtdu4fBh9Fhz9LATDNtLDJ68e9zOHvOf2Brchh4RpKRS1gvWTy/KNGgV/Hz0nDpdH
	 llKWVrXMxNB5FP4lKtAF80MLWdFH7sLdISpEJaPUZPCvYA9I5e2PisR7I4XB/7zCVt
	 qvhMHzyjuUVjbpP9qdFpbNFfahCVa5W2Me+eCmFxlYoDoFKC5+aqRVVTSRg3LmWp7h
	 RjVEpZNCe40CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9C380AC02;
	Fri,  1 Nov 2024 01:21:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-10-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042406149.2143055.5240050402461915225.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 01:21:01 +0000
References: <20241030192205.38298-1-luiz.dentz@gmail.com>
In-Reply-To: <20241030192205.38298-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 30 Oct 2024 15:22:05 -0400 you wrote:
> The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:
> 
>   Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-10-30
    https://git.kernel.org/netdev/net-next/c/ee802a49545a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


