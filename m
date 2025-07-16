Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133571531E8
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693587; cv=none; b=CBU6MWWkY1yz7kHWuJF2eImCjbozwaUoQEgjGAe9MawOtnswx6PiWYjBco3ZPmcAFdecn/Yg0VCJ/6Nk07hlpcPaXUMLK80hPt+1Pt+ZDIGWnzw9kXkhE6qTmAx6laJ97DhjYfxMiRxZwEySmD/PbWrJtcfdyBINKlmH5N4RGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693587; c=relaxed/simple;
	bh=G7VKkOW+ZG42umTvlWtD/A7bI4QJi1jx7WweIyqvAyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VRZVr6hp+Dgr69KNTwjvbz6WUdq3RHYw9osATs4P/hxnI6LSSgg3ew9iIN6ihP+5TlXGwK133Q0VCSFph7hUjO82v9/aI16PFRChcrgKQYn8OguC45W4Rd2uQTDtPNQRclXP5jASv8afhdEVvD6r8/6y/s9itLBQIJmct4dkirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pypLp5YN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pypLp5YN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C981C4CEE7;
	Wed, 16 Jul 2025 19:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752693585;
	bh=G7VKkOW+ZG42umTvlWtD/A7bI4QJi1jx7WweIyqvAyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pypLp5YN7fWeDI67WniYf/pK1SDmaUuN0XHH9NL0vIIQc4F3pl5F9LWCFW26UcUpI
	 mBbNdYj2d2Eb4c+swoLVA+DSDj7EHCtA1eBEEx4p2ZuazuqYnRnZMKK70s2u/7dLFP
	 FyRui1KZ2CPVMUzfF+xH9dLOApXYZldf0+g3401b/O5+xlTn7lr4zTYUL6KivM+4rI
	 q++w09gYom7IC7bdhygcS5YyAACvMZNSVh/bp2HB3ulDW5ZBqPtlMn5BMS/UUU6J/X
	 mO/zGuVbS1HNBcTFjG5+2sR7cLbQoXMpcfQcXS5Vnsnl125LsrRmMmTStMITwoiT5g
	 drwqJDiJ/Dk3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB098383BA3A;
	Wed, 16 Jul 2025 19:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix attempting to adjust outgoing
 MTU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175269360576.1297178.18183542152543701483.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 19:20:05 +0000
References: <20250716135345.162225-1-luiz.dentz@gmail.com>
In-Reply-To: <20250716135345.162225-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Jul 2025 09:53:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Configuration request only configure the incoming direction of the peer
> initiating the request, so using the MTU is the other direction shall
> not be used, that said the spec allows the peer responding to adjust:
> 
> Bluetooth Core 6.1, Vol 3, Part A, Section 4.5
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU
    https://git.kernel.org/bluetooth/bluetooth-next/c/514f29ce5bf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


