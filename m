Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84436CA5A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483584; cv=none; b=KJMzLW3Mf2jXkKShIECft0ZbAyovEM9jXFDGGg1WcElwbl4bx3lJ4ZoxafC6bwJuBiIqZH9CYkYOkAuZEWkgTz4RidF1Pt4s1BVHCpzSlEuPdfZ0OtIMenir7Hq4BB4thAf8enGbqmAD1xRnYcdzsdqhuVSD+yYPwcC+UoSeguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483584; c=relaxed/simple;
	bh=mn6tDnA2iYTEdxP0vKSkz9Ndtt+AvE/koviqzWV/OXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qfYQnpiO25sNABg2q68Iju6IMVvJUJMBvfnmVZ2071GZTfl6nEkRI17czLbRfp0nXxp7psynMv9bOKKX7ib66JzoyAIlqPxWDZ9Fc48xl0sR41aTxRHt9kn8o2hcILazvb1UYXhN8QzmWrt3jJhur9ElQ3gSrdvvJGVgxPyiQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muHk8zYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muHk8zYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316A4C4CEEF;
	Mon,  9 Jun 2025 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483584;
	bh=mn6tDnA2iYTEdxP0vKSkz9Ndtt+AvE/koviqzWV/OXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=muHk8zYOXorfa028jEs5YXGN/+WXy57oxckT25No62bhD+apUq+r/t5Mq1ci0nx2G
	 JdkM/R35yiE9h6PI31ahTtKzkZnpVGQVN/6COVkEyqVRKH4U92m7eya1VgCWmYf+1G
	 ovt0jP0FcPR4wDLQqdNQ0ht0BPyDJnx9aP0jFXhJgNY50zcsT1C0Sx9W1JWIzCSkGc
	 geR8j0N4T5PiKXBA7RksYOhBrPYd+uL3PPB6g+qirBuI11JeRyawP6bvLAZ1/lw0rj
	 ycoIsh71WBRFbJvHo0KB7O7bru4kd7S7ByjIpj82J22WP/AzgQzlm40saqt4WluCw0
	 HSNPBh6mQZBpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35397380DBE9;
	Mon,  9 Jun 2025 15:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: check lpac type in
 bap_bcast_stream_new()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174948361474.1126847.9883235314562695577.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 15:40:14 +0000
References: 
 <33226743ac1dc2803c5a90a1c0cdbfc97e3ecfec.1749414200.git.pav@iki.fi>
In-Reply-To: 
 <33226743ac1dc2803c5a90a1c0cdbfc97e3ecfec.1749414200.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  8 Jun 2025 23:31:03 +0300 you wrote:
> bap_bcast_stream_new() shall refuse to create streams if lpac is not of
> broadcast type.
> ---
> 
> Notes:
>     I ran across an unreproducible crash, where during connection dropping a
>     crash occurred IIRC due to stream->rpac == NULL, as if bt_bap_stream_new()
>     had produced a bcast stream for unicast lpac.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: check lpac type in bap_bcast_stream_new()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45734349087e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


