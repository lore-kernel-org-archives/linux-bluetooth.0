Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FD58123D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062076; cv=none; b=Tn3fVNzJpBzvq6hOhB89+eyOiBssxfD84Z//cetEhKLtHHzeqTqOI338OCCbYp5BeXnBuKSaGn57tE180D9wpJoZI4ulH9ul+ajW6cy9ge1/qC4nStdkrYBryuI7Nl/KbfyrmLgYPCC+NRjdcHQ+b1Ss+KS1/wZg83jjzqLxcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062076; c=relaxed/simple;
	bh=eRNAxnq/n5y0JTWF4IpVkYkW9gkSs3i6M1hfD9dYmZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lfoprGeSaSPjGledb2dOuQZ4Q6il6zGCEmzmaa+tKoZfLyRSybqSLRghn2F217AoOnCzK8+WJf8H7fZFBdxcENPFQHjXCCdGZnrnnmsLPLKGRK39Er/ZYDGcCY9GYfCSNhbG6EVtW34mQWDeNq5IMD5oRGYZNRrFAxLFZDUl8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu6tn4Ae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu6tn4Ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9BD1F00898;
	Thu, 10 Sep 2026 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062066;
	bh=qBzerr3SAtHWGdczL+YapDfvSMkVkb9nh32Y4r+SNWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tu6tn4AeyTTWad+Aj2lW2loKMnK4B5jAjYR0wk6r0Li3iTXB4amNuAPV57yiGGj5G
	 StJqqgI8FRm/KeC7fqxdlhkLGPtnSQMRWtwQmEUDkxLOAh0O4nfandH+0rFWDJsEv5
	 p/Rad/lRYtxjQs0cQf1J8Svq4SpYrSN79igP8IKiCkfTxvhrmHCNj0EF+spCgO50Mw
	 pwpnv7hb61eq11Uo8EeuMSFqSFNiCMjSY+zrbvdzVL7CzitoCvZVPTSIgMtOdzAzCj
	 J9oFgSicmxwN9ko6EPt98dO/lxP9V8CQhrgL3tR3dUZClMxaSFlwp7pQ1v7NZn80Bf
	 YN+MMHhWpFk3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A3A380DBD4;
	Thu, 10 Sep 2026 17:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] workflows: pass the email token to the cleanup
 task
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906200413.2003385.4059694147440618491.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 17:40:04 +0000
References: <20260910173542.1508648-1-luiz.dentz@gmail.com>
In-Reply-To: <20260910173542.1508648-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Sep 2026 13:35:42 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The cleanup task notifies the mailing list when a pull request is closed
> for being open for too long, but without the token it cannot send the
> email and the pull requests are closed silently.
> ---
>  .github/workflows/sync.yml | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ,v1] workflows: pass the email token to the cleanup task
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd10ada1b16e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


