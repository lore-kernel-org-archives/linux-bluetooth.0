Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB003002D6
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998615; cv=none; b=HB/ALf30EPMZOiphryeS152/Nut097yfVD+nPmv/364IEFJi41F0sf4Rt6PjrntS/pOeTwN+LFShXMiONjqeSvTnyw+26/db1MDJdlAzdFlAAU6KJzAItuS3amFtdkTnBtYqKy5ZZPkXTRDAU2cqPl0ekBbWzv4LbjKoc3xrM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998615; c=relaxed/simple;
	bh=px1X7pkQ7GMeG7b0CrLkg3JRP6IQqfuURhYS2utYZgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n2FvIYO5/ucRsmQdjdvKK5T9P93/2Xglv9N9ski9Ih/smhbBX5BFlG2f5SZ2aOCtiKyQNDsHnxgYPrjeSERNazziLs65Yy0Qa+c+S8dghtx9EEJFBs9H1ks4rTjS7gGL1xA0KD+pMBMv3fKVYmLfUeSHoxCqZBS5XQDjzTNzz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYHfAUnX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYHfAUnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530C5C16AAE;
	Fri,  9 Jan 2026 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767998615;
	bh=px1X7pkQ7GMeG7b0CrLkg3JRP6IQqfuURhYS2utYZgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GYHfAUnX1E+jT5uRrlu97V7VqtlUMerz1feRZomSlwSlxWyhng+xZcbaB7lc+214F
	 V0nJE2ABTrK1MJ5moQDPGTsbReY4OFz2lJ/5lHNi9vt4HgxE2IWhpx8vTenK/uEfPJ
	 Yl5/qHCedQFnJ5A/v2qF/suJPg6VRKtFbVvd7MeZmO6nj7ECbRWQJ5UGjFfsuUSEBx
	 QXywI81RQHfv7coLKDAk7zh4pSAirpSlVBRr26bmhV8nIzr9wC+rmY3DmdGct49Zf4
	 cgGmgq1ENwppmCEDSM6Iz0ZJ3axB5g/RPMHbguSEgxk3BW5kNNTVwfu/AqDO1hyGm4
	 JcEQGE9//mwVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9023AA9A96;
	Fri,  9 Jan 2026 22:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] device: fix memory leak
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176799841077.418288.16794599486274774636.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 22:40:10 +0000
References: <20260109202925.774809-2-dalegaard@gmail.com>
In-Reply-To: <20260109202925.774809-2-dalegaard@gmail.com>
To: Lasse Dalegaard <dalegaard@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Jan 2026 21:29:25 +0100 you wrote:
> device_add_eir_uuids creates a list of added UUIDs, but it was never
> freed.
> 
> This was found with LeakSanitizer from the following backtrace:
> 
> ==764182==ERROR: LeakSanitizer: detected memory leaks
> 
> [...]

Here is the summary with links:
  - [v2] device: fix memory leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=024b148d73ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


