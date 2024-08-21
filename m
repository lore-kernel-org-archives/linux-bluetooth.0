Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CF1B2ED4
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251838; cv=none; b=hpGK/0GeC/cTCdAWfgBPxnY7X4+eJgVBDakdOfhYumAk9Z9jo0/n+eHyvmtO7ftPLXELfABF+l8bvdCeNiMsaZKGoxdwiaQ9M52JSwjMrUA0go82YxZgREuoKev0kOJjZt75tpQ6LPWh9uOmROi92BoFAX4UACTPVig6X8DREcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251838; c=relaxed/simple;
	bh=Xf9tZl1dNJ1dG1YNa2jNfdATweOoRLA4Or0+W1s+H78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N7EWtpScd2cwkdvI2O6bkqwIs5RLLr372L82TAi0zHldPwNOli9MxTTZuVyqU7L5R3sLV3BWjpdja0JZOuQFcMbShxq4rNwUmNf3/AlvCDkvgjEs8TU5STW88juboCO4z5mY97mfRSL+2Ls1lhZazu0u+FQRzUcz51pOY05NC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFbPlIpF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFbPlIpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21945C32786;
	Wed, 21 Aug 2024 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724251838;
	bh=Xf9tZl1dNJ1dG1YNa2jNfdATweOoRLA4Or0+W1s+H78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JFbPlIpFMT12mrxRjRtI7z6VUNVSrSAEtWLAVKOpidkXBQlaIUrLvpA1eL3+ReV8j
	 MKOEPLxztFLcPRJnzkQQOPJfHPkKX4ImJXcuMRzUjxPd98/dOHzRcdnxapoT6XAG8R
	 8xroKLQGNVJ4QiLSokb7cP3ZE0K0bKc+sROLTYLPXbnkIrScgnX0vYcg8s85Au9PbM
	 4ORLINCfbw5miO1aaGkqNHsEGdYdN0KitSDDhDzMJg21ScqxQDbezG+pJPC2+uZsGO
	 vANKnVRH/giZEWSUTjVcHEJjoEsN7fexgIXeGr74j9QMP5RG4yziLZFIFGU0HCxHgc
	 5DlwagCDBP6Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1863809ABF;
	Wed, 21 Aug 2024 14:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_ldisc: Use speed set by btattach as
 oper_speed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172425183774.1745569.7849751646109918046.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 14:50:37 +0000
References: <20240820141716.288862-1-frederic.danis@collabora.com>
In-Reply-To: <20240820141716.288862-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Aug 2024 16:17:16 +0200 you wrote:
> Starting a BCM UART controller not defined as a platform device or
> a serdev with "btattach -B /dev/ttyS1 -P bcm -S 3000000" works fine
> but the serial port remains at the init_speed, i.e. 115200.
> 
> The oper_speed is only set if a device is declared in ACPI, device
> tree or as a platform device.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_ldisc: Use speed set by btattach as oper_speed
    https://git.kernel.org/bluetooth/bluetooth-next/c/96f44a40e702

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


