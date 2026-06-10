Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECEF348C7B
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115608; cv=none; b=hXlejPhsOIDKsNYhnvhP3hVSbMRpyvz7NfYKBxGhDL+Wl655miOuZ/YlXGUggMFS6dnCyqwhFZnZ0TVDErC7+EQI+oyCIvBbkepwN+K2Cx7RXV2zR0jh45E8sVJs25kpMfa8s7g/tKqgvpE+2GEt2XwICGucG6Val68y03X377M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115608; c=relaxed/simple;
	bh=b3J+PD30niLoLCDNzTWFYKspYplcnRyjAdLOizpi9Ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NjXpxcSz6YE8kJVhaZhM8kuX6vOFyW+wOGIKh7IdxlnzVlbYOcl6Oq191Zmik1CMhrviq3YnI600AIH7Go6jVry/OC1JSQrr2ychBRpc1N6oEkPbrxniE6NAOCA0ucHVrse55ntto3yS78KW9XZQi4EubC083/hwc1eogfV6Jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3gs8Pkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3gs8Pkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177361F00893;
	Wed, 10 Jun 2026 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781115607;
	bh=yawzTBpxRLaWIvpa5Rs1lSAZC5j0mcj/XZWqAtO/OE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j3gs8Pkn38e4D7tFB71VSg6EGLlb6OoSQhj3pOe4Fu7Vmg2tTuR6kRf4RZqCXPtcm
	 jHs1Botbx9Rvwvf0npBwcxjv4BTVLvJMp7JwETpgNY56yXSH8+qoSrxx8dyjNL10xb
	 epB0+YJ2lQB9zMQQAKYFQbjeJEIdqlfWe90ctM7na88cisp2INS9apE0RiAL2lHz2p
	 c5+y1ulPs+qAnV4DILPx+yMPFRR3ast+YwyO4u7NNjO52ZN01HgzOShGfcmn+a8jvZ
	 NWaa4Yhw/1EWtjW8fc0HYUwMst0M6xnsTL5T9gCcYPFd0otJzbwYR5p7nzPEe2Dksk
	 iOJIkbId4ks+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197BD3930DE8;
	Wed, 10 Jun 2026 18:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] btio: handle error from broadcast ISO socket
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178111560488.3579558.9810111731433240687.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 18:20:04 +0000
References: <20260606060348.2240980-1-michal.dzik@streamunlimited.com>
In-Reply-To: <20260606060348.2240980-1-michal.dzik@streamunlimited.com>
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  6 Jun 2026 08:03:46 +0200 you wrote:
> If not handled, server_cb() will be stuck in endless loop of calling
> accept() on the socket.
> 
> Michal Dzik (2):
>   btio: handle error from broadcast ISO socket
>   bap: log errors in BIG sync
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] btio: handle error from broadcast ISO socket
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea4b494414f6
  - [BlueZ,2/2] bap: log errors in BIG sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ea27ab0dcfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


