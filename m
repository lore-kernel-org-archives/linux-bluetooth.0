Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7941EA6F
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005432; cv=none; b=dR1IXaEKIJ7zBBqpGoL4sJJWXPRj51OrsE7BfilUdmxm3lUCPe7n5pz95X63JywSWdj3U9pZZ2tyykGROesycPeP0lyuj7z3hiitvFqsUEqBYJ+/9xA5SJV//qy9TR9UiGtnvgec4J5Aa4EiHCTAeI8A2G0vF6okMEOcNI+P5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005432; c=relaxed/simple;
	bh=92PycdZTaVBZsC+DSOJs3bDHS2GhKPbpescfWABsOb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pfpe/vL9kFHvu8A+x3sp6V6dCMkMNWguJeor2TX8d7Khs4OOz1xG4P4fsV6eojjPPioMI7B7lKxuW47tUavZFyL9a87QIXbPRxNkX0ULm10vvO/cY+zQ/II7BXMW1F3WaG36aIdT2ih/fAH5RduC5qokkqZKA6P1soYWzdCeoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOEuL4TP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOEuL4TP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9C79C32786;
	Fri, 26 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722005431;
	bh=92PycdZTaVBZsC+DSOJs3bDHS2GhKPbpescfWABsOb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gOEuL4TPeSbPXC+QK2Yi6Q4yclMA7QJgm8jf40ty+lLQGjF4VqNrtI90b+RmDJcQu
	 qy0mtOMdMMVtAaxg19iE+v8A39ZgCmiiToHUltiZve2Rz1UoAxJXhmNACjnTFmeTAz
	 UNpMbdaVekK0vXKo5zYZ4XU860NhhkwZkNF4J8uyzDz3g+wfGFXCKziO5o276aKODl
	 /IsriV+UVuEwL0ogGxGn2GrdFiv1bSqgL1ED+GPNPsPYUr4sH6LoLpg9IrgvRSXdbe
	 fcqB++IJQ7iBvf+dsgfzLl4MYxGjwC0w9ryllNFdiek1Aqaqy57EmkgYKK7FFja1H+
	 0wikXFYXzN55w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C91F5C4333B;
	Fri, 26 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for
 passive scanning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172200543181.11662.17120885746605495280.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jul 2024 14:50:31 +0000
References: <20240725223451.3208825-1-luiz.dentz@gmail.com>
In-Reply-To: <20240725223451.3208825-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jul 2024 18:34:51 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> DISCOVERY_FINDING shall only be set for active scanning as passive
> scanning is not meant to generate MGMT Device Found events causing
> discovering state to go out of sync since userspace would believe it
> is discovering when in fact it is just passive scanning.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning
    https://git.kernel.org/bluetooth/bluetooth-next/c/7a27b0ac58ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


