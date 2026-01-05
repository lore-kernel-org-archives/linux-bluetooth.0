Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D732C21F0
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626008; cv=none; b=hg3vZPDp8FYtoSUmFXfIdTlD+1B6ML6Oq1i3EVyV4BnV0u2UgEY3+86yHrWvfwil+B1o8sDHccwn4eYj2nG65uKKSWuHqi7FXkb8BkAa7zThKdk2C2uma2lqYvi4YBAQWl0qM/Vkw2FPfv3XspPdeERb+dG6l4CK9i4Kn86PPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626008; c=relaxed/simple;
	bh=X9gal8DWxTy1xrXo9YCAzfzRNVXS37y+HyIgw29MvYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WVXc1Zh6ou/HXazmRy71s9uu793xiwmf80kvXm1iLnxnAtyhI7OF4A5ENAJYm3h8vSLdEoY6V83na6ZI3nwf6iDVTfK2Ba5e4dDrqOVVh1Z9N6bqY/j/A55etIg5ik5Yfa69PkCtUVyJTwT+pQ/QrqV8i/klOt1v9+I1rKcPnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIBEyuH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIBEyuH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293E7C116D0;
	Mon,  5 Jan 2026 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767626008;
	bh=X9gal8DWxTy1xrXo9YCAzfzRNVXS37y+HyIgw29MvYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nIBEyuH5OipeEXaqSX0caXRlvDNqXzOJcGFlt9fsoUMEKpqD7XvfCA/bUr523HZL1
	 k7km2V1vrRkml68n3pdGPPV5lT7w8iS25LZ8jIRyzX9FDglRlQ00nK5fXhVv2e/XUO
	 cYb5xosW+1D5u0w4dAlIzhzi7eFtN8CuCHduIoeSk6UUI+wjU1t+15Sn8/4RJdcYPa
	 EK8BI95zmeMyrFk58n8m4RrqwFfw0Jz+H78+maYooAUaOPNTuBHeLt2DExeaPSnATf
	 3nfeLAMa0Gi51RcAET2aVdaMk8Jc9UaWVPSrk8Zf6iuBnkvJ/eWwBZUr8swIBOY5fS
	 AA1zQRxNcGufw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B67EB380AA7F;
	Mon,  5 Jan 2026 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH BlueZ 1/2] 6lowpan-tester: add test for header
 compression
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176762580655.1187428.2344752861125385664.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jan 2026 15:10:06 +0000
References: 
 <d7f5c6978db76b58f9db1b6f93254d2f38c1e365.1767478380.git.pav@iki.fi>
In-Reply-To: 
 <d7f5c6978db76b58f9db1b6f93254d2f38c1e365.1767478380.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  4 Jan 2026 00:14:06 +0200 you wrote:
> Add smoke test for IPV6 header compression. These test the compressed
> ipv6 code path in net/bluetooth/6lowpan.c
> 
> Client Recv IPHC Dgram - Success
> Client Recv IPHC Raw - Success
> ---
>  tools/6lowpan-tester.c | 61 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [RESEND,BlueZ,1/2] 6lowpan-tester: add test for header compression
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6358a2a11313
  - [RESEND,BlueZ,2/2] 6lowpan-tester: re-enable previously crashing test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f30307588ea5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


