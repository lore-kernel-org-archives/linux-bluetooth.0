Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4892D46C8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871197; cv=none; b=aib/upB7r3pMX9Q75pvHN/rZEYfI64m779RwlvJF5Hsyq48ZD2TOoC0B0Hos4tXlzre8T7bjQRzQCqm8jmetbnwsIdfRqNtTZzWh9dqVWVvqydnrBrmWJIiLbu7jYcr+MSjJljkH9dvkeEpE6ijOjFes9ohrnKCW4NscYfIDbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871197; c=relaxed/simple;
	bh=XvjpjrztlD+PhSbcKF41knSeFZECXDdnx6cCrfHMTL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oo48kzm1QAr6U8vnAOj5oD6VxRGNk+e2Qb38Lh8WJ8XNNZvT4GlAnXo31shOFdS5CnKVxVUYeMXa6SArv/RvIm4d8LzsaVZ+2IRJy6+uSbYx4+r+7djAecoIr3KQmA0UalWqsyueztcvN6xsll+gVj+v68ufP1qg4kcqrk43AMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZx6Z1wu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZx6Z1wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FC3C4CEED;
	Fri, 22 Aug 2025 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871197;
	bh=XvjpjrztlD+PhSbcKF41knSeFZECXDdnx6cCrfHMTL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZZx6Z1wu1Kk9ue4MPLelA21yWEraHav3ylhrBoU6axWXiyAEFhigUpcRUxZ4jrM69
	 ZgFPyEnhbgx/TgbwlAXuUWw8LV0XSjSB/9cNA0dfYA5tduSMYtcULDSegOFADbM1mx
	 nv+5V3hlEHiRumtEJ2qU3Mvx/ydOpc4nMQOfK/AW3BWeqXjY5XJnhJBm60BKWw+FNr
	 BzvOPyh0Lrp8qi7FfUL7JGky6KBQpjtl0/XB2t9VAIWIoL4kqDKsRgUpK8lM+mWPMM
	 Ba2dEz0tfWMqLzwMhZtk95K3SDRfuJOwJS6S5gkGrv+VAlknbagWuvhXHL1gTLSzXE
	 V/DNjPCJ2qYpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C31383BF6A;
	Fri, 22 Aug 2025 14:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] Fix DualShock 4 cable pairing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175587120600.1839534.6385671997260934970.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 14:00:06 +0000
References: <20250821125844.963198-1-hadess@hadess.net>
In-Reply-To: <20250821125844.963198-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, sdoregor@sdore.me

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Aug 2025 14:57:20 +0200 you wrote:
> I wish we could have full cable pairing support, but this is better than
> this whole plugin being unreachable code for DS4 controllers.
> 
> Bastien Nocera (2):
>   sixaxis: Fix official DualShock 4 controllers not being handled
>   sixaxis: Initiate pairing for all cable pairing devices
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] sixaxis: Fix official DualShock 4 controllers not being handled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dbf96bb28a83
  - [BlueZ,2/2] sixaxis: Initiate pairing for all cable pairing devices
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3acfa2d50a9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


