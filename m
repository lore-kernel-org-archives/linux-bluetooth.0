Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DC14B970
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260624; cv=none; b=cfL0wVprAg8WE/hH8fMkRYPTEkYJsoGNX3j3nyzl2fJowGxSWsnOC9EFOOJqCvDX+XlXJ3cmOd+1ILQDLAQmPmMHYeeq3yDKecVBJbCPX0TMXGIZguMu2wjgrr9RMwvPKHvvNRdn1NhuZZE69q4kBOV185ghoFrNDbF3HcazkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260624; c=relaxed/simple;
	bh=H8I74xRopBPp7+0V4cWza1GOI8SkEX2y9wrjF2AuHrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UidHYAl83kwo6lEttIV4w4DWkTjlV3+/LG5z2y0FGxZ07GOby4C33OB4CSNHzTy6CIqEryUvVLQJQ12RHJgx6Od3GrlngmFSYeLdH5rqiHWzRbcJGwtogZZsU10KTxn6PN7yy70CR+eavhUfuoWBJ4eQH2esba5QAxDH9CDe2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uagNQayX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uagNQayX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E077BC4CEC3;
	Fri, 18 Oct 2024 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260623;
	bh=H8I74xRopBPp7+0V4cWza1GOI8SkEX2y9wrjF2AuHrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uagNQayX0Chew6umssyuisy+Y56lIpI8x6FvJ9Fv9jQbSotC3GnxPNp1iycQHmS4L
	 qMUjOgAC/dnnH0Kz41yClVq7B2Rc2E3phjGKKm9NVm7RJ5ZMM0XBeEuMFAh4Tky+L8
	 LV78ksaIl1grtbWDl/B+HPFy3EaIjhSz17A5telkSNh4VxcBZTU0SOQ3/gezRPWfMP
	 4So5aw++obwMENmsPvIM4jpm/QNyT322BohTFB5YqzjovT+3HHOEi9UjMPFIyOIxyb
	 V17pv/UL3hQtV3nm1UXV30gWquKcBoCRHzv60QCe1C6P5FTYQWa0YPBXTGkx1fRWJX
	 Gls38G7Fv44aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC583805CC0;
	Fri, 18 Oct 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] avdtp: Fix triggering disconnect_timeout while
 discovering capabilities
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172926062924.3127332.11026812438906747568.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 14:10:29 +0000
References: <20241015194254.543683-1-luiz.dentz@gmail.com>
In-Reply-To: <20241015194254.543683-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Oct 2024 15:42:54 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If there are many endpoint registered it may delay the discovering of
> the capabilities long enough to trigger diconnect_timeout which may
> cause unexpected collisions/disconnections.
> 
> Fixes: https://github.com/bluez/bluez/issues/981
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] avdtp: Fix triggering disconnect_timeout while discovering capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c1d01a378f23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


