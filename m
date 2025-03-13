Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD0267701
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874398; cv=none; b=RkjX/AuS1NMHUACZJNs45ywan6Jgek04TvyxzgA+n8vkUzWm9JDWzPuhKlGgZtN+AAvZtO6BeUN4+L5E/8KyZ4K+JwI4LU4MDi6ejTaMzJMXSYKFSJRy2lRDwjdQrMKTp9roto5XyzLho1zVe/M7s+0bQCNZ6cD04V61liIHbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874398; c=relaxed/simple;
	bh=mbPfvjFhBUcTWKHMBIG0TENXsQ8YJoJxyLVPVAClqbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q1mNrOuB4znOs4X+IMvy+L8L/NlimBRDdFfhIUbWrNI22aSFdZm+vgsJTvC0p1JYNvXCcUEFro04LxucNaxkBgoOov6K/djaFnBhvv/I1UeVvcb8+Ejl044rFEunbd9LcNJ6Ionq4c4w8jr+9vYHDv2ZnAt0+hEHTYDtrNmbH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip/y4qPT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip/y4qPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1FCC4CEDD;
	Thu, 13 Mar 2025 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741874397;
	bh=mbPfvjFhBUcTWKHMBIG0TENXsQ8YJoJxyLVPVAClqbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ip/y4qPT2Oq4CwqNLwQA48SJf3CBwBNz01qX8BK8FBLGQ8+LZYQUjiHJXi3NR2I9w
	 jcFE9vPAsRAdXiD0xIYbnMNyZK/oun8LAeicQXxQDO4Pc1zSA9sw5D2zaf1YZlsViQ
	 iBew7eDQ9nRn/W0TfgDkmYpmIekyL4CZbMv/R97T00D+fm5F3v352pz+13nnR0HV/3
	 1v/TINYqHrEdn242HnkEZ3hiX6/mEbn8hYJMu6+lGKCY0tVVLaZEgCmgsKqiajBJl8
	 tkPmXu1dKX1stffA+Q/TBcA6/Vi42m4kvbe1dSI1nY43i5uyJCSHvxOmKDklxlEmxF
	 yYQrkksMLeCUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C083806652;
	Thu, 13 Mar 2025 14:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_core: Enable buffer flow control for
 SCO/eSCO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174187443201.1524310.8087699036754748717.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 14:00:32 +0000
References: <20250312151421.201772-1-luiz.dentz@gmail.com>
In-Reply-To: <20250312151421.201772-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Mar 2025 11:14:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables buffer flow control for SCO/eSCO
> (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
> recently this has caused the following problem and is actually a nice
> addition for the likes of Socket TX complete:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
    https://git.kernel.org/bluetooth/bluetooth-next/c/174f3c12f664
  - [v2,2/2] Bluetooth: hci_vhci: Mark Sync Flow Control as supported
    https://git.kernel.org/bluetooth/bluetooth-next/c/5c301fb00b84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


