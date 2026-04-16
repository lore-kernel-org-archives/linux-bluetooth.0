Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8382866
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352837; cv=none; b=HcaTIA5qJeMGQf3HkARoVOyvPCVcphemKeibwi6lduSiqvEpNA94OgR6yswfhvo+zgTn0+Va0zQ9g/uyc1aQKZZ6d1sbPgFvlCHmcVzKbL3QXW8DaqOhWsRHKDT/El4ky3I/WamEs6uZrYV/Xb04sIteEgSy64HDhQgi68falFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352837; c=relaxed/simple;
	bh=0NK3j9Z6q9QdDzqOipoPvBxK5UKb7bB8i3uxCwlrmYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mzOH4gF+z1t0koBVEBiQjgQsiQ5a/T0ivaG7+QQ9OblDpPd6hk3lzKQb8ko6ef9D7N5GM/kkF/nCXgyyEQeLz9+1nH3dyrB0x5EZ/Aa0npA7XUz6Er0tzLbhpSs8RCf3u/X/2gWySA9bhquZwcmPyLNj97QQ28nOdEIck+6PUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz8TkDH1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz8TkDH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FE1C2BCAF;
	Thu, 16 Apr 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776352836;
	bh=0NK3j9Z6q9QdDzqOipoPvBxK5UKb7bB8i3uxCwlrmYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yz8TkDH1Re5+LoZC7kdOsdq30vekgHupgfPNUyzWn6kTHp3aaWvSK9jtFCnW969tz
	 Lwxx+ABAv5p5jeJ4YPPM6McLFHwxybl7tNGN3Te0RWqaly7GisZX/SJDZ49/giZp9z
	 EzD5U5HiEMarPHfjuIqgLs2YXHaP6bmGCUfSImBzJp92MLL+WyzwhNSW5uvuenlze3
	 yf5o56DCBBJ4ftMHuy3PAAnF6K3YmBhEnzmoRZutIPPxrVa8hHXYuWQAGJoABJ1taD
	 C99Qadn+hPMQCtaHnZYMDDmu3dAUm01L/UPzqDXiNTvOySXnyvnYo9luIle++zzn7s
	 I7bBQiNOcPbLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE23380AA63;
	Thu, 16 Apr 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] shared/queue: Add way to iterate over queue
 contents
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177635280504.3275927.6819493200765450409.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 15:20:05 +0000
References: <20260403084128.348931-1-hadess@hadess.net>
In-Reply-To: <20260403084128.348931-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 Apr 2026 10:40:54 +0200 you wrote:
> There were no accessors that would give us an iteratable structure,
> leaving us with just *_foreach() constructs that are cumbersome.
> 
> Add a way to get the first entry in the queue.
> ---
>  src/shared/queue.c |  8 ++++++++
>  src/shared/queue.h |  1 +
>  unit/test-queue.c  | 20 ++++++++++++++++++++
>  3 files changed, 29 insertions(+)

Here is the summary with links:
  - [BlueZ,1/4] shared/queue: Add way to iterate over queue contents
    (no matching commit)
  - [BlueZ,2/4] shared: Remove glib dependency from src/shared/ad.c
    (no matching commit)
  - [BlueZ,3/4] shared/queue: Fix warning when compiling ad.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6a6aaeba6aed
  - [BlueZ,4/4] shared: Remove unneeded glib includes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07a0b87e6b34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


