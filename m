Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3720EA3A
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885229; cv=none; b=qsROCxrnRPFh0iT0M93QAJVgsJWAbApAR7PRuZpOMjYPMFI9hN+iBrJYEe1ZEIeZmy4C+tYg7Kvi+zz7h0hI1f04+XAKDj3oY4AGLb5Qa0WHpk5K9qbfgP6sRiylOqjP43ZsjA8r3eWyrSUtvx7KtEN/GQqbijrSSomdip9S4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885229; c=relaxed/simple;
	bh=HYn1gUx/anv1JGAj+FowYUlu0pNrKnYW8zZs+RvmXdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WcqkaWtsuKC5CwqGu33G8i1L9yu0Oe6l1nsyQdjp6+0YO+XCluT2dLpxt2QIKXM2WGLagSJYdZUaMIgNTaCcX/Dj3a5KkJw8L6r2YnQwl8yG7q8Q+3pGqUGFvshB/0ygrVVLGvvJKLbGVHuHdmHK6dbP/AEVDrVpKpwopRTtkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxcwwNUz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxcwwNUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D875C4CEC3;
	Fri, 25 Oct 2024 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729885228;
	bh=HYn1gUx/anv1JGAj+FowYUlu0pNrKnYW8zZs+RvmXdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sxcwwNUz4gCwysQPoMSuqV8vY+pcJPUUDNUblFZ+0eVIxZM3aKJNWufHGcRFJ2JBZ
	 88EBbxnXQ0UdLBjtvG6ckyD5tRReW8CQkUiyjQWpRBg/4KGo62JE51scNHUxNS5MIh
	 ujlXQmBqil7EPAXXHIF3EIeSIkcKEL3yl3iV9ofBzzn9zJ2wYgz3lWZLo4A+01TkpT
	 5ywYPWwATIyHkmrQpWdh2iEAlFPdHY2+Axkp1IXxvOWJrZ+EFTzGDVwUXMwUzFiJCQ
	 BwWImbHdSCmuP5UOboyQMC22dqJuHepNOyfdN241TovZHbHzSyBDRLWKFNfsGZBl7N
	 evICo8e6DltBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C113809A8A;
	Fri, 25 Oct 2024 19:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] transport: Fix select/unselect reply missing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172988523526.3021088.9646419891728466935.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 19:40:35 +0000
References: <20241025142842.46566-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241025142842.46566-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Oct 2024 17:28:40 +0300 you wrote:
> When a transport is selected from bluetoothctl, a reply is expected.
> Currently, if the method call is successful, no reply is sent, causing
> the following error message in bluetoothctl:
> 
> transport.Failed to select: org.freedesktop.DBus.Error.NoReply
> 
> The same error can be reproduced for the unselect method.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] transport: Send reply to select/unselect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36b26283cee3
  - [BlueZ,2/2] client/player: Fix select/unselect reply prints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c8ca715e05f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


