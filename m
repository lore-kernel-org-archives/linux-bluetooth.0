Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70097153572
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608832; cv=none; b=Ks5GjU/+wPR6jIFt17bRd5zSR+vyWWiYgAScQxNjznnANaGtgp+L5t9rJFk89U13Govv7X7sEUM00K2czxWM/A9hl1dKnprcM35TSJg2b3Z0Lv3EXG7Vc3XLy03JFEuNIht2TnD1WSE0hWrlMb/71EgHAw2P36l4VIKd9Mc5FEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608832; c=relaxed/simple;
	bh=jTmPoYNTAFr8UccCYSlecA4CUJyXHoMQbxNV0HloD2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LeHBRsjKFED9u4TzqBq25soACciinSsLoZxaGegarPt9fBI/qPRqTQohTJd3Aqo4wB6SF7tmgUSwiS+1ObeESJ+1K/hFnU2Rgkitb1vFGdJDa9omtv0rvqCKC9qC1o4zhDvihXU3rUOZp9nucUv8UcfK9SvpM84IUF+4SSLkOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScqrNGMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScqrNGMF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B8E9C4AF16;
	Mon, 13 May 2024 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715608832;
	bh=jTmPoYNTAFr8UccCYSlecA4CUJyXHoMQbxNV0HloD2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ScqrNGMFgmSmmYjht8NEVbd6utZ7gMJ9+7tF/h2X5OeJ6R/50tolVpMvzIv4ZsGlB
	 F8NSwOmzY8F2PFrpzl9o5PXZ/EhEMGQ9lnYvsejn7mKKOX0n4/uAJFXvuy+ySyX5Qh
	 RvAhVe9GtADve5qyGQpGy/HUmlMVvmjG1iw93C/WoZfAhG5ub9oc3fjpN6z3KJIhZC
	 EhKoB1QHBYy2usLgXmlGWgoNtln/zsHK5Mqb5rBnJkSJvC6gsaOOzI45IdFRiYxWfg
	 OeyAXXbJ/QjCXEKrdIlADGjl5/UcfF9vLfpeERz8ngSZJ85nMeG0x44mwaY1SucgM5
	 jjHjEyfoCB0hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECE8DC433F2;
	Mon, 13 May 2024 14:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Update python2 examples to run properly with
 python3
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171560883196.16121.9583318969959869241.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 14:00:31 +0000
References: <20240509214231.2783781-1-me@prestonhunt.com>
In-Reply-To: <20240509214231.2783781-1-me@prestonhunt.com>
To: Preston Hunt <me@prestonhunt.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 May 2024 14:42:30 -0700 you wrote:
> Several of the examples in the test/ directory are python2 scripts. In
> commit d31f04aa928ae8fb7a4fc5b0876dd17ea65d4513, added a python3
> shebang, causing these scripts to be run by python3. Because they are
> python2 scripts, they won't run properly.
> 
> Fixed by running Python's 2to3 utility.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] test examples: fix python3 errors
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=832412f5e36a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


