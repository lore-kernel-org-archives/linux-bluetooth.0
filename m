Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE94570CB
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250241; cv=none; b=VsPIRtI428uCmKf672n2lc0T4WsVP76uhH/I7G9s8dnyIiF47vnY2aBChKOmcACypTGY5XJKILRQxk6ABmRQkt4gAsTr7bXbmsK5YCYEsRwU0ccu35hS6RHVEhJCZZl7BuB9Jc1QB091uqsc4GWbWumEDIb75EYLb1SbNcFpOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250241; c=relaxed/simple;
	bh=/ufW+F/bSbTDzUWF+7Jbe/LO19bBk9HypOY38Hgh4b0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HZFakNYpqjtjttJ+LdJeUtX8ChFVqqeGQziCI3FOGOCHNLZcgVThCgSSspHxurWe4aGcDYZ8OeQysmHNCo3G+z8iNTylu1F1Rmv7g3LqjSFP4HS2LS93w03T2uCJLopFeQh5RZ0+OHW0g9woBjc5W60+uX2conwGl73adwnBLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtSyQiIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtSyQiIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AF31F000E9;
	Tue, 28 Jul 2026 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785250240;
	bh=DLadWO0Q4FkqusUss5hztTJ4KnjPO2d4ZckvKlH+oio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jtSyQiIqioeDFlCcQAwLam3QavI57OK0cKMqk3+/LpO52SYBjZSutDFm4ag8Qi63k
	 HRqpWtxke6OloSTrXlaQh82ToGtR8vdD3WcyxgKAzaHneY6jDQ22Jn+bjMwU+RHXBR
	 fKG0wFVplX0W/3J+dnryEJ2f0AALyUfzcIYL4EucMPejH5MH56zlrcGiPauVz4pSwF
	 GNE8b4c1BAzsQTLEMFxakJGAogt07BcxtdeH12aRXeU7R0lVuKSSfO9StI2pLvUh7R
	 fLJwsRHj5oBdQdDnzCiXHoKA92ShV8I5otxFXzkQ+DmcFW2n3frLby/dOmhkRSOuiF
	 2JQaQbuA7sapg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938EB3924445;
	Tue, 28 Jul 2026 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] github: Disable stale bot for triaged bugs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178525020531.1763279.13744669231541644773.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 14:50:05 +0000
References: <20260727091948.2746998-1-hadess@hadess.net>
In-Reply-To: <20260727091948.2746998-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jul 2026 11:19:42 +0200 you wrote:
> When the "bug" label is set on an issue, don't reap it with the stale
> bot, as we've triaged the problem and seen a bug.
> ---
>  .github/workflows/stale.yml | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ] github: Disable stale bot for triaged bugs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=729f96089cf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


