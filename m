Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F00259C
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443631; cv=none; b=ix7aNiTN/u6AJEFREfpOyZmN95mCBjM/pjDTI1D55aGycAF7PWTYNlK9JTTHX779dOXgmgE6x1fYGYWWJiiH9/OXoGdH/ZhtdVKK3h2QfrKpBB9IV1COztBtOWhph/IAOQ3OGovuFEeX02795FtSJKlNCdDsvBLSJeJcUoQAhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443631; c=relaxed/simple;
	bh=WVCX9Eeg42bd589txBx1hWNaonuGZ9Gh3TjoGhCxTfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p/FEYQkwKsxHd+gwMAT68MOJaD5lw84l345fns9mP8Er4Q6jQufy9Oz5Jn4zcGUAKk5xLtezXsOUzqq3ojPAc+W+xv3ky3FWe+o7I/n9DD8o7Yf1uXBwoik30OKOCUCLGUWdQXpi1d7ANEMlEXOsjklRvMw5FRLqYDYkd+cDNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi30zuM2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi30zuM2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7946C32782;
	Mon,  3 Jun 2024 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717443630;
	bh=WVCX9Eeg42bd589txBx1hWNaonuGZ9Gh3TjoGhCxTfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qi30zuM2X8XrBq5yONF7waegb2R5q0GUkvknDFfissRNjjpzxCUzVwYNUG++uyZJM
	 6iA0fU/vtcJ2F5Coso6FMJHL213irzfrBfzOujFlO5SZYi7Stsy6MfPi7U4/q4Yv7X
	 zwBHUUChdzWjJNRHs+FntV1c0z9K+9w8jMwjbGKxamLOsg9+LVVBekdgUwQVks0mQb
	 zKRpiNyxZRpj0f+5HuZXrFtXlnxXeDXNX90vp+7GyK5UJ6RNUfHVk2lkT+RBSM03Bv
	 lHLCG37WcYiYe1zxoMXDg7gjkLoEQHfmXDcZp5AvWIFjPGaeKdXiIlE8+mc4iYoJNd
	 6J7myuCixb/og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4E90C43617;
	Mon,  3 Jun 2024 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Transport: Update bcast sink transport state to
 pending
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171744363066.28652.9819949676457366815.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 19:40:30 +0000
References: <20240528160320.103845-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240528160320.103845-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 May 2024 19:03:19 +0300 you wrote:
> Once the broadcast source is detected and a transport is created
> for a BIS that has the configuration supported by the broadcast
> sink, this transport must be set in the pending state so the
> sound server know this transport has data available.
> 
> Silviu Florian Barbulescu (1):
>   Transport: Update broadcast sink transport state to pending
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] Transport: Update bcast sink transport state to pending
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=60b482c3c9ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


