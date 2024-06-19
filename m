Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481314F9F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806229; cv=none; b=lBxh3BaIYrALQSxcPiw6D5xGVkBY98VGKEyIXawXgnkYGjcZ9u++cAfEfAAL3ZJzFFbLwJdSEQQYfFWY3DSrtg0bBU85gHXYTU6douaCNzcNP0fkxlnHKi44r5u9qrfG7+sWpCUt4SQa3hyKqdGASIIewA6wOVFL/Ln9lvA8aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806229; c=relaxed/simple;
	bh=fl6/NWrFg7iFkzDpZpvQ5xlCCm7XV7U1yu0iuA0V2sE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hl32rZz5KR+mwhLHaMPdltm8if4zZ/HUOl/QMjgFU1L4SH2HQzPUJxTti/oRrcCDW00MKrUA3pxEJFJpO1ZDg/US5YMvDKVuhNgOH0yY/tvzVRLYtCDPwvzfbK5vLZOxRsH0Wxmu3ysQEKfgKFO/rATKZDF0BRe+NlOPXccDyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BooTLrPZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BooTLrPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 375DAC4AF07;
	Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806229;
	bh=fl6/NWrFg7iFkzDpZpvQ5xlCCm7XV7U1yu0iuA0V2sE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BooTLrPZYU+dLSHSzwFph/GeYWk8j7dB/66zTeKjpHFfygCmc8hXNNDTQWRAQJrid
	 f6PELLk54piEL1jIc8XJ9+lMdPXxpPOcChLaYivajWqOxm8ROUdxiH8BRoWNkz2vlO
	 NOTYGTfe+v6WQBvvma4WeX5PpttkTCqpE4eR6uUXWIeO8va7fbazi4Q+jpNH723Uve
	 BBL97IypkLUyHez6AtKGaHROOrE/jQ4u3gsDEWAXC9A8AL0EctLvyxDuxDkD30of35
	 M95QYONVbBteNvqsxWjQcpkRkIDFgBQWmvkkH99CuVxLZ4sw6RcVNK9PunpzdUvh5O
	 4mKrgydWXJpoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2862ECF3BB4;
	Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] gas: Fix reading attributes on every connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171880622916.19669.9614923189544852520.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 14:10:29 +0000
References: <20240618195914.2470373-1-luiz.dentz@gmail.com>
In-Reply-To: <20240618195914.2470373-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Jun 2024 15:59:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Attributes only need to be read once after that they will be persisted
> by the core so there is no need to keep reading them on every
> reconnection.
> ---
>  profiles/gap/gas.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] gas: Fix reading attributes on every connection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0dc5bb2ed679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


