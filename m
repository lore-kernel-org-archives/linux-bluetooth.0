Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE821E091
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722434; cv=none; b=aP+M5PzRQuo4tQTBBwmOnHcrbZuBliUqGmY9xHoKtBkxyb8xM4ItlHLEvbQ3xjMXVG31xXLnCssAOVs/j6rRuEQBQZLe5it9RyV0DWqN5zJ0BRuSm943g8TFKvEEt0dGjRU+dOSPsRliStB4Vh//xMKPwTW0YWsiu1sUCjjkgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722434; c=relaxed/simple;
	bh=fHU1MCW/a+i4DWYL/3ZetmYbwyM6ADm/trkkZWF/a6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BSqqc4pAszRqjLLJw9AaSqpxdVEBIaQ4HAMTI9id4Hlm4nzSp6A2i17eL30uJKnEnrfRzN7We52wx+HkbZ8vUl6RYOwl32S/5g/Cxoo2hYC1tGQ3lzhvqOqjuIwBGtgxyJm8QCG8DJLO8c2l6HliGdYunmFnze6KrU9qXpIEfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egMegTL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egMegTL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A648C2BCB0;
	Mon, 20 Apr 2026 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722434;
	bh=fHU1MCW/a+i4DWYL/3ZetmYbwyM6ADm/trkkZWF/a6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=egMegTL74gr9FrzKhY49RGlDGREibP1h/wKJmMFdHOIk4NUd9OBIOD9eWnxSDoxY4
	 8xzDKOg91Qhg9uf8uOP7RsLYaTPukEfVK5JNZygptdFkCkaJI1D3gse7iDNrAk657T
	 w4YclNar8F7v1HZ7YcJThZRyF4yIqA1A/f27miJkxQT4cubE1tVTyCoTk7jAS8EuvD
	 4tl/T03/zr/e8RIY7HBa5te+gKbmv2NwXprs5NT2OJr5N8X4vb/oMh185o7WUUsdPX
	 feLrPKrJGLWeQHTXeaV5fFcDxoljjsXD2DP1NYhAlkAaG2zYtHEZfx1+wg7LC6IEg2
	 peVi2jgXPM/2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 036EE3930022;
	Mon, 20 Apr 2026 22:00:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] BAP broadcast fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177672239855.1802062.5237202233541614890.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:58 +0000
References: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
In-Reply-To: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 Apr 2026 13:29:10 +0200 you wrote:
> Coding style corrected.
> Thanks!
> 
> Michal Dzik (4):
>   transport: allow setting Metadata property on broadcast
>   shared/bap: run callback after setting the broadcast metadata
>   audio/bap: fill BIG and BIS for receiver
>   audio: update QoS dbus property after it is set
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] transport: allow setting Metadata property on broadcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=322cc2eb736c
  - [BlueZ,v2,2/4] shared/bap: run callback after setting the broadcast metadata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4771fd2fed34
  - [BlueZ,v2,3/4] audio/bap: fill BIG and BIS for receiver
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9d8d8cbd4749
  - [BlueZ,v2,4/4] audio: update QoS dbus property after it is set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bc0a839fa383

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


