Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851427;
	b=4S9cLtUSMclZx8A1geL22/3ruGvN/nRcMVlz4U8lGvgvZuy2gKHY42adowtldFV3/Hux
	 3TwSMdV/1q0V+ni5X5ADgZpxPTZYvuSGKNdUQi2jPcfoAg+os3G5QH5mHLtQAWyrlMoBt
	 lCHPAhABz3pqTcdmCAyoAj6GNpA1/t4FKO89zRzpPZEvP1kRBNBMBrtNsspXGXpptERFg
	 UBG5iIwqK0v9cklwR9WTWOvfohJPSeO3VmjPLhzDIYqzV5mcKhfWHjugAeciXJ8qQ4FOp
	 hSUazdGxt+3Zr3n/y8gxWS0H9ZRaTIUvUVELACwmR27QGZvoVsFPZD58KhnN2hZ6bPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851427;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Wqs39Gh2HFZw8ngFqVRIT+LmWsb75a2GSJd/T8nAz6Y=;
	b=xlk5ISu2WMewg0j71UkEh5xIcccY8GUnHyjFlLHc2hQ8EGOcpEJe3mZM5eQp9BWvKFVF
	 4hhDF6SaM1FGHhQMRy/dlIZsDaxgBpLqoNvw3ttQCWKINvYZVVmfW8T96X7qWZVVjqtoG
	 Y7STyRaxHxuT7BNsHrsa4mSLKW2FNxqXaJ5wtEtFN+up4dt+1t/9ZB2kXitgWxKkr7fJL
	 uE8RWQlbMDMY1GKiHCTqaD/5jpNUZBsE7T4gKZww9kKHIXAryiMEtq0QvgofjDjmhsVzJ
	 ilwsFl9kRv/vmfyE4RcG+TjJJDFbuXTapPbRXWsgz1rPvj4Fsz2FZmUFKk76YGM8wJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwsgbYMr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2043606A32F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwsgbYMr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802631F000C9;
	Mon, 16 Nov 2026 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851427;
	bh=Wqs39Gh2HFZw8ngFqVRIT+LmWsb75a2GSJd/T8nAz6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AwsgbYMrHo4iVted4rInnKdxBi/fdJWlhMRHPfCex8EtiryzBzmaS15aC5B2Hp05A
	 wvHDYmtj+kuuoFJ75SpfCC4vr2Rm5XeqEmUACijL3ZMnW8E+7Ejx4FB+sUlD5MXJLN
	 Vx2YEMC49U2CWFNwTKTP+veSbCuDtqZspY2P7AW+syqe4FAELsKlxbBKRMsYfPBEKK
	 Oddf2JNWhIHW0foppp9hWUpI8IY7R6KcrTNBCHBDitXzRwXb3fapAxXS3sN2Ic2xAg
	 KhRenFGeRWrn2+JXrVvpXjdiBzFHEs/+Xo1YwsRvsb/omdLqUtyTyau8NiLXVTn6wT
	 ClyiG+YHiuQXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77315391AFAF;
	Mon, 16 Nov 2026 17:50:27 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 1/8] transport: Hand the owner over to a link
 still
 streaming
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485142602.3796096.14894644098212501182.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:26 +0000
References: 
 <0bc4e142448f50213e08cb6e690c16dc98da92e0.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <0bc4e142448f50213e08cb6e690c16dc98da92e0.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:35 -0500 you wrote:
> From: Kannan J <kannan.j@intel.com>
> 
> As a server, when the client enables both ASEs of a bidirectional CIS
> the audio server acquires one transport and its link gets the same
> owner. The client may then disable only one of the ASEs, e.g. the
> Source ASE when the microphone is closed, while the Sink ASE keeps
> streaming over the same CIS. Removing the owner of the disabled
> transport then also cleared it from the link and freed it, and
> suspending the transport set the link, no longer owned, to idle as
> well:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/8] transport: Hand the owner over to a link still streaming
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=40c121330369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


