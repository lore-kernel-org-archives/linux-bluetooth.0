Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1525761
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914832; cv=none; b=i1WrVEL4Y1a9N/5mQOpPgUOgHuRZ+CtypGU+LbJy5uNiROFRqluDRD/+dGXO+Rs305rGQD1zBlp8+RyIwePS6Nb4/eO+teigrW3hnsp2owz+nP6x4PaXD7DZ/EYDMnF2qijbot57+V/Y9UECmYKSYs5Bc0NZMFv7Tat9H61axWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914832; c=relaxed/simple;
	bh=loT1XyR+zguJsPkq+6et9prPnTPyr8kpXxS7/l05o5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MzOs/AoWfisAHfb4XNf1rvOgR6Tn70OMq2iq8vqaMLbVQea8wG7EOEmVHnr+rMqABxxr5d8orOx4y1rdtLBtUyOAnS7kBWRHg/rl3v5fC7L1M/nbJwXgk7miWWqAI6JQN8IAvBf/r1i1XBl2M4rcjDP5KF6j2i30ZNDvzAtbHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQB+gt0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQB+gt0b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A88C43390;
	Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914831;
	bh=loT1XyR+zguJsPkq+6et9prPnTPyr8kpXxS7/l05o5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nQB+gt0bJ1O8jqVqxPlyNFJ9Sn5F60NHYNBQVgowHpZSFGNg3JpyzaoD/2Z2ImN4U
	 9v7N3cu44VB2tzpvmlSsRiEwicdwDARHlRRd7RhCjjelg8XiE4SDL7IS8zNEVhyq4M
	 9y0uSRPblrvrsuY8xYyH80s+zmSqEBFSHliCFiVnpdFE7ASjYW7obH8XnZe03bhXdR
	 0mBqmBojA8B3H/3L5vMoYvMIEIY+OjHSUe7PZaZeIVvPThVrkZsdrCe/wST5uNeJQP
	 wea20G5ehNxSyKnDGgzHH+//Uk11x/2WOFFzBAxV4ik4i4CsJhxlSZCfbFxZ26vIuY
	 mtDhdt5z8ICrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB167D84BDA;
	Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mgmt-tester: Fix eir name length related tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170991483175.24074.10982423522283626061.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 16:20:31 +0000
References: <20240307192427.1022124-1-frederic.danis@collabora.com>
In-Reply-To: <20240307192427.1022124-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Mar 2024 20:24:27 +0100 you wrote:
> According to Section 1.2 of Core Specification Supplement Part A the
> complete or short name strings are defined as utf8s, which should not
> include the trailing NULL for variable length array as defined in Core
> Specification Vol1 Part E Section 2.9.3.
> 
> This patch remove the trailing NULL in expected packets, and update the
> lengths accordingly, to be in sync with Kernel patch "Bluetooth: Fix eir
> name length"
> 
> [...]

Here is the summary with links:
  - [BlueZ] mgmt-tester: Fix eir name length related tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a23239f591d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


