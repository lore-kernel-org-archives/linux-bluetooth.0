Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244133A032;
	Thu,  4 Jun 2026 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539628; cv=none; b=Jk1vuYu+IRcxu5NpQ/tHHNS7jd8f7bg7ys/+j4nJQs+OX9L30WlDEBF1NB5+TaLBpI7eRGaC3gNx+ZIqHSgMOQAk19dkOeKYC7jlSha5FqvL+0atQwiTpsmlHxT9CUzJAXseD4vpHffBXP4Jlan4HI3TS0UbTFxNESzMzyeTKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539628; c=relaxed/simple;
	bh=vumErFYlhVPPbcxQLTxYJ3J5X5puUs+zubcrx43Sr5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RGpKltAZ4B9rsv2MqcMOfUKexMFLuNi5VzrDAss71jdDPX+q+xQdL+tjHwmYJsQTQLo0EtUpw1DJOcgLtu2B1THXzMNxubYqvRRnTFw8KWJMvqeNduAJp0bc8D5/pggaNFKgo8LLmaibChjQc+ENxDAg41Uc6MpQLXFG+S4jEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvNfsPIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvNfsPIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F811F00898;
	Thu,  4 Jun 2026 02:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539620;
	bh=mCksd8Oo8+Q+S0kNqShN+SnXDAHBCybVQ1V46Ezk9Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mvNfsPIKpHUR5EIFekJHMXWnFit4X/SLVwsgR/iO+w5X8wWUZjO8L+yDLZdBK17Gb
	 c+usL9h6jIdKK/aPAxV0q1969USfUMLe07bG4tBLq6QQxbTRivqwc8LCxNISjKfxFW
	 HBFWfCDeibvLetUyPVAyjEI/PSD6AqCbRY1V7y4Tmq8x2YuzF+5GpYZfUPv7V8MKiy
	 39G4+toBScM+0KQT8DDISjebglLhx3v6EeDMuyCCrNFv7sYJ6EAY/yb1bVjRH4yUR9
	 6haHwiGHqJxIhs0qHf1TzO+iiMn6qmgo5Rq8sp40GhnXKZ8WImUiL2cOvyZop4Gznw
	 2kPgaojLlPzOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D3339308E1;
	Thu,  4 Jun 2026 02:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-06-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053962113.2207566.5562894926058000252.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:20:21 +0000
References: <20260603162714.342496-1-luiz.dentz@gmail.com>
In-Reply-To: <20260603162714.342496-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 12:27:14 -0400 you wrote:
> The following changes since commit cdf88b35e06f1b385f7f6228060ae541d44fbb72:
> 
>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-06-03
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-06-03
    https://git.kernel.org/netdev/net/c/d20da9130830

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


