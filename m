Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB92BDC01
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221793; cv=none; b=VK2MtKbu/UzKHCixEML1//sp9H6oGkTXS+D4w1+DGxMYMCtJpJq9AnltF+Ac4Mwi2nOPC/3vpdEkJA4Sb2lqE4Lefyf/VLA1hnrIXtNLey+JbuEmwscWteew1jFENsGuqUZJvvY8VIu9ULWSIvDhrt+woEG2tRyY4kATFuERzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221793; c=relaxed/simple;
	bh=UjgrLQ9DVaKrgTbdaKiUANS4woT1MVeEM11KQnDMvJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RMSpDV8CbHYvc22SVQCHzj9JoNYduiwmO+AuMWhtVaeTBxz+1/hC2g8xGNX6Iy5m9sHnGAEiAJc6P/Fq9Q+1GPl6i3rRr28Soh/DXv1LlP6Y3Z+0P5TXerM7qn+8b7IvXz+jPsy5RBgRp5lwCAdpvb00IdkOrgD4iXoihYIsHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCTgb+oR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCTgb+oR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8BAC4CEF1;
	Mon,  8 Dec 2025 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765221792;
	bh=UjgrLQ9DVaKrgTbdaKiUANS4woT1MVeEM11KQnDMvJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RCTgb+oR1xa+ayeZ+lU8BPTbhNWDxa+jdV/l8M4sgDBFVnFJs6qgJFvXpbQuo0oSZ
	 OIt8dAFuyZc3jACRDSCJC6LI22+rVNRqrMvVAAW6KgP8DkH9DkaO1uNkuqf4xPQG+r
	 vC+E9aGgZBo/n1m/v4Kl1QHsuVzhfvn9+SmTSXcF9VrrPk7fFkweH9jL971ZqHTbHi
	 NzDvXa5CVlcPHH3DEbnl7Q1XWeel1EcYJ2iycv+WrBAmBSKvNn3yS/JfysQiUBx4tn
	 9hPvbu0JUMvOgLZ1ihFjjPIS5/jYtReTh2UScS9pd29VoM9YDVATk9uIRZW7kUtsFV
	 32RECxoo9luXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B56F83808200;
	Mon,  8 Dec 2025 19:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: fix invalid BAP server transition
 releasing
 -> qos
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176522160852.3263133.12323372348510149578.git-patchwork-notify@kernel.org>
Date: Mon, 08 Dec 2025 19:20:08 +0000
References: 
 <ecf6869cea8d856b63d43632c4f94db395b51944.1765217411.git.pav@iki.fi>
In-Reply-To: 
 <ecf6869cea8d856b63d43632c4f94db395b51944.1765217411.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Dec 2025 20:12:15 +0200 you wrote:
> When remote BAP Client requests Release during streaming, our upper
> layer calls bap_ucast_disable() when releasing the transport.  This
> causes invalid releasing -> qos transition.
> 
> Fix by properly checking valid states in stream_disable(); bail out also
> when in DISABLING and RELEASING.  This leaves the valid states ENABLING
> and STREAMING, so write them explicitly.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: fix invalid BAP server transition releasing -> qos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=715ed46a436b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


