Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59922DB798
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356442; cv=none; b=mE+s9Wpt7fOBOBsk//ObfYoMb6jWSmIObBhwhkBHa2K7668saF9EBAjfovpceyxuck+lzvIhJfozNlqiMK8s9j8xbSpbsVtYmQNUalkYMAzr+jK0OGArRhE9vw3HfqJnVmcad8QbysECFL7eocmfqbOuMUcXIR9VE7YtcODDlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356442; c=relaxed/simple;
	bh=d200e8G5gxYzzqWGY9x4EwF2GaaoRWdzHlQe6gQwJf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PSqtaDxbUTHI0XMzU4mSgNFxu+DuVpn29CCfZSVVH0wZf7odk++mInK2LfzN6bifd6l5jSbQW9ygolrAKVCa7NxhtVAyMVyl63DP3xczBF+AB0edCgF2HyodrZMgBLEHvXfA0PwTQlAcbZaKqXsQRJVRrey8MgGToiS41UV/WwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfI9Jbfs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfI9Jbfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B813C2BCAF;
	Thu, 16 Apr 2026 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776356442;
	bh=d200e8G5gxYzzqWGY9x4EwF2GaaoRWdzHlQe6gQwJf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UfI9JbfsYmUTkqgY2Kaf/0fkFi+1KlASrf5Ke0tTacT5BKx/vMrCdoWyFUpHbhpTf
	 CwpFW1UQS3k/6lszrehAXCgup9EVHA4Y7lOYbpQc5d4pnJMKoJd9QOmcGjB5S6Gsw5
	 YR3rl2wsm0DkimhVOojj5sUGvnB48MZpm+8mHWrvbeerwRXJMez8EezP6lwSkvqFDJ
	 PbsEEAV6RJHVOP3epNTR6GWt2EGx6PnxPt++tmvNY0xGpHJraZuBlPJELeStUuHtvL
	 5BqYjxZTDwndIfLrSMGP4kLfuHgzvdEs9qb+QuGvZPY3XSdfklWHXUjlVOx+F/mLTd
	 wUigVnKAK86jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCB9380AA67;
	Thu, 16 Apr 2026 16:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix null-ptr-deref in
 l2cap_sock_new_connection_cb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177635641079.3303094.170444577535995224.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 16:20:10 +0000
References: <20260415205008.2365697-1-oss@fourdim.xyz>
In-Reply-To: <20260415205008.2365697-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 16:49:59 -0400 you wrote:
> Add the same NULL guard already present in
> l2cap_sock_resume_cb() and l2cap_sock_ready_cb().
> 
> Fixes: 80808e431e1e ("Bluetooth: Add l2cap_chan_ops abstraction")
> Cc: stable@kernel.org
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
    https://git.kernel.org/bluetooth/bluetooth-next/c/73357fb07e59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


