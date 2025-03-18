Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF51EB5CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335198; cv=none; b=gNzJd2TF6vL1ILvFTeT7HqfXK4/YrKqqIYPv+oS2NKLCvR6jQXGWn9/Z5COLny3qknMxJiiwKHYmavMsZgQtjPaGIIKMeQ9qPug46tq2d3IG2jb2nvvIUUqWvNMt3TNb7qDIO8hxxG50weeOrHU0HDD3x+nwN1Bo5TQxAWWq+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335198; c=relaxed/simple;
	bh=n0kTv7tTqPUt6BQ84i5ZZCyW/jVnvruYM8JFKVKPqFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i3hx2UAO/viSeTQknPhhHielr4hqRS8Ciyo3ahuFW3F0SkGDE62ypLYM6VRZTVgiMd1nDUYxPsVx7PSseo7jC2LCxgGq8mTET9A4h1dlE3s4THD/7/Ze9RK7+b4/O2rA5dgxvRaYQgCFtWNuJTZmJZjMHTV+IWUlQsO/DUQ8jZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLwkoZqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLwkoZqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B923DC4CEDD;
	Tue, 18 Mar 2025 21:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335196;
	bh=n0kTv7tTqPUt6BQ84i5ZZCyW/jVnvruYM8JFKVKPqFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iLwkoZqbsYk0H5gfu0ZjEEwt5es75IiPM1wM3VhDtGuzUdqQuLfxRSq2e+WsI/f7J
	 HT15tIvGv3p/FiKrR3gldwozr8C4RMTrKa4/9g1QpdbF21i9WDYEcPPvzlnRDU7zhF
	 9sQ1KhLURAUSgSx0PHikAm5G3Zgq9NGBog8uOfJUN9g5dyD8M3+XSiPXlEnIsUn7o4
	 aVfZ0pPEs5pkb7pi1ADiEG/gCvZo8w13xm7JGRr5AIs5FWPxESrqfCXXSfQ7SUh27+
	 xszHGKXsJeil3/xQXBM8WAlnQKOTgzWyqKZE6qAo3/8CtquyOU9oYY+ALdRk6UvhXk
	 epPUS1g4cDNtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA5380DBE8;
	Tue, 18 Mar 2025 22:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] tools/tester: test COMPLETION timestamps
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174233523203.475282.2860046994782971122.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 22:00:32 +0000
References: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
In-Reply-To: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Mar 2025 21:07:08 +0200 you wrote:
> Add support for SOF_TIMESTAMPING_TX_COMPLETION also in cases where
> errqueue.h is old and doesn't define it.
> 
> Support timestamps of different types arriving out of order, as multiple
> SND may well arrive before COMPLETION.  Also allow TX timestamp arriving
> before bthost receives data, as that may well happen.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] tools/tester: test COMPLETION timestamps
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c89e18fa55e2
  - [BlueZ,v2,2/3] l2cap-tester: add test for stream socket TX timestamping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe5a5f509e0c
  - [BlueZ,v2,3/3] tools/tester: enable TX timestamping tests by default
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f4b6a649ccdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


