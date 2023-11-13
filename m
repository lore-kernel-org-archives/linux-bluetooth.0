Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBB23743
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQqYFKLD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5153EC433CA;
	Mon, 13 Nov 2023 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699903337;
	bh=JA3Lii686ynJ1zlFmQqTbM6s/kMobnl+jmInKZcbXhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NQqYFKLDYulVLwesbJoLFEAlyyLxEB1n9+3MzHSzfhO5h7PuIXljF1X+CNx46/+Pd
	 n4yRIIJOIQe7mt4ZRbwu9Lzv47578Fj9KY5J/e6N1ojQlbs2plpkohc1oALV07jKuX
	 DMfG48/xndnvpr6xrUPMXUKOhJCdJFefiaQubIuoPen4C+rKpOIp2KteX4y6XA+jIW
	 LPRup3uK6Vvi8+jhCaA0cudL7uiAJU81a/v//4uIhJKLQ/mDOq5AiQbb/rq2JZsWRQ
	 793PSnLY8wZGy/S0hByiy1tNkmeSMv3uxv6NocXupd4LxydDBOIcd2BUq+6pcSy4Y1
	 p3zY81uaO72AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AAB0E32711;
	Mon, 13 Nov 2023 19:22:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] shared/shell: Fix --init-script commandline option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169990333723.26848.7920910573164487116.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 19:22:17 +0000
References: <20231030065341.8998-1-juerg.haefliger@canonical.com>
In-Reply-To: <20231030065341.8998-1-juerg.haefliger@canonical.com>
To: Juerg Haefliger <juerg.haefliger@canonical.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Oct 2023 07:53:41 +0100 you wrote:
> The newly added option -i/--init-script introduced a short option
> namespace collision with btmgmt's --index, both of which use '-i'.
> 
> As a result, a provided --index is treated as a file name:
> 
> $ sudo btmgmt --index 0 info
> Unable to open 0: No such file or directory (2)
> 
> [...]

Here is the summary with links:
  - [v2] shared/shell: Fix --init-script commandline option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=303925b28110

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


