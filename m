Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418C5476C1
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061479; cv=none; b=KKZVsqlGJ/h287fqbWCJYAL20xummKS8eRcTDg+MWnSZEeKgw7G4YKxk+IFuKnScMZgnP0vRRCkb4iN6tFdzH18SN6J7uBIaiWyos7mLB+S6A3JaU8UINIKAvGAdFYzD6xgqns7qmUP96nsYXPVHqXsi0eN3iAMxc/UjuxAmIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061479; c=relaxed/simple;
	bh=iXpY9k7oFiv9C3SuHMPgUN4N51xxdNbHhnWJyLhkoCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qM2PRdGFo31cu7EpwHjxZC++2Ow2pX6/ptg0pnjZMJyFDnVCxUmoaaWR7ZyN2BrsS2AHXU3uhgSEBrKusEXHJDiEnOWzu8ZwiGSqSXn8/DTs3jq5hqV68uiOia/xCtCXLEenm5UnfcQZHmsFEleW/QSfBioVqxHchphHwPthhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXla0CoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXla0CoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18A1F00893;
	Thu, 10 Sep 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061469;
	bh=FcAc7oFuzXftjKkjOaDOFiQlfNB9sa8UFJUURUQPZKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kXla0CoWcGYHJhXMIR7f2PPsZd3XySNaLjUIAOj6w7MX9A5cThiXfNA1M8hS8rr97
	 SNz892Z+ag58sY5j/Re2scButZY1gmYH9Bdl+M3+c9cjW0d9gp6QD/LNfjoDoIkLBG
	 D9IMHdsChpZE+sPVbbLv95aS1oWqS8YeZ9NBhZvG17eZ5Yem4RRafCFK0kQfdZEZ9R
	 V8Bv5U1dSDqAp8vjEeSH6jRSlzIsHBRnXRCa+H0I3f0eX33c55WuVSlYuxuI0Ohcnb
	 o6VZZA8havxAfcV9EKPXKMzbteiNFqC0k5801YWa958M6xj9Diz2ZdN0wHab9T/xbg
	 SnBeq4oTyIweA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BC4380DBD4;
	Thu, 10 Sep 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] workflows: allow the sync workflow to be
 triggered
 manually
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906140613.1999514.17268461793181455665.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 17:30:06 +0000
References: <20260910172104.1502721-1-luiz.dentz@gmail.com>
In-Reply-To: <20260910172104.1502721-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Sep 2026 13:21:04 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The scheduled trigger is heavily throttled by Github and the run can be
> delayed for hours, which makes it hard to verify a change or to recover
> from a failed run. Add workflow_dispatch so the workflow can be started
> on demand.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] workflows: allow the sync workflow to be triggered manually
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=51d1b7924e55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


