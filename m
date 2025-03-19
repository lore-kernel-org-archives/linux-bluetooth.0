Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B417A2F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414397; cv=none; b=t7Q7ksI6u8C1oaYcmqi6pEe+uSishcvOpxpkjFtiFIT5Dt2a008qXOlmWXUKvNma2MdaMUPX9x725+DqiBtj2noKIA6JcSoU1xIO5DOp+YoJ+Uss7Qdx96diFn5Y4klSNqIKiOOeWOTavCeNLeLd4540L6FqGioEEAUJnalKov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414397; c=relaxed/simple;
	bh=wbrZXU315p2iV6/xbmM78jma3dijkAHzVmc8mScpLHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f50kLNNPnUYMjMmynuV7l1WEkjMhQk43Lt4CmOF4Z6e8bDAm4l9+y3wPMreHHtBPzJTLpaXNJwIv3eKQvhxHhsJ9UJR/z181uhaSSQKz4FvmQnsIw1TTfE+5WWhViHvo+IOV4pDjCPCpJtpU7A2xdugi2cGd6pVcFwZCxf+NJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRRRkhEE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRRRkhEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F45C4CEE4;
	Wed, 19 Mar 2025 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742414397;
	bh=wbrZXU315p2iV6/xbmM78jma3dijkAHzVmc8mScpLHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qRRRkhEEi7vj2aHOchb46DraEnsrISbssKg+XZPMAKKNGWxzSba+FqTiLYWBiO3lP
	 I70w+h/35XlOFDMRttApjYXOU1FWijf0OKnpWSXdWlPs/5X/H/1+CxHK3S0iL56Hox
	 3q+74EYw/G0I1WJwYkFyQVFMg5XVCDC81AjoDhVoIsGxhXEajUrhkBLmXOHgRiVkuE
	 xeqen7KTGHT0o8O4/ft5olVBN2QoXq8IypsfTfD1pE4poT8QJz0gYKFHdGNp+dWJ6H
	 8E+fdy/kMAkKvHO5rneU/EQnDPt3YzPyLkLQhX36ITVJ+1+vVz5uFchvkWNawpoLwD
	 Jg6vKGlgKRJ5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D43806654;
	Wed, 19 Mar 2025 20:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] profiles/avrcp: Fix PDU for SetAbsoluteVolume with top
 level bit set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174241443277.1175967.9729001933543895057.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 20:00:32 +0000
References: <20250319121218.166878-1-frederic.danis@collabora.com>
In-Reply-To: <20250319121218.166878-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Mar 2025 13:12:18 +0100 you wrote:
> This is required for passing PTS test case AVRCP/TG/VLH/BI-02-C
> (To verify the behavior of the TG receiving a SetAbsoluteVolume
> command with the top level bit set).
> ---
>  profiles/audio/avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] profiles/avrcp: Fix PDU for SetAbsoluteVolume with top level bit set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f77e72c3ab11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


