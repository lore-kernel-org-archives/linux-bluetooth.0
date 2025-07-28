Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E113AF2;
	Mon, 28 Jul 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732188; cv=none; b=pISLAf21rcr+M9l4B5EoA3D7aOVu+ZykNj78rn3WSNirSQ00ekj+ReCLwoXm1wCgzz0/H3eTgye2R8tTyGEVR0Zmti9iSw0atddGVATLqN101RP1VLP6pjwCIV7l2fCcefKMT7zNcejdEktQlo86NXwnEKvjF+UH0EAM5zemIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732188; c=relaxed/simple;
	bh=dVuYR2JK8lQErH+V3apfJf/fOloyZjZZO7Nr2BU7KLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sB7/yaVXrLThyoQ/h7/cDhQ/oMP0JsFwuqXiQAr5oR0+37CP0EAZxp1OnnXPjomQkXsNGys0goycA9WWzk/dGbpii40yjZTplGZdpvO1gH2deuZHi1oArGK9jepLD99Ol89M7tEULC92KC5gooRvUOWUM/jubQYDtV0BaoZVf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBLWkWPV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBLWkWPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB73C4CEE7;
	Mon, 28 Jul 2025 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753732188;
	bh=dVuYR2JK8lQErH+V3apfJf/fOloyZjZZO7Nr2BU7KLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NBLWkWPVbujXqeOatsO4cCgk90lSHlOu/yKBBnE2kIY5zYkG1qRBoZXtg7K/D54uE
	 3ftJcRiam9gOXM8OZBeM6RIMZFS8NYPbF1Hd9qQvo8Tdz9gXlCd6q36f1PpF3X3u7e
	 5n9c9IxUspZNlygkPjdcZ4AvkBNEhyPSMRkSocnLDTdzoiOf+9TjjWn4Fn7ULXK/H8
	 Gnj0wPdPkn+lZRngv46wsk4BBqsGCfp6TI/6QjNafCFkuECIV6DmMxybXGyS0GUmL9
	 MBm3GY4745Dlc5/SFYKZcBBYSAaolUR6qAppkuDPsgMoLryTFbk+cthLLTTt3aysCs
	 BjCmkq7ppCOGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D70383BF5F;
	Mon, 28 Jul 2025 19:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Avoid adding default advertising on
 startup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175373220501.825563.16644815912043056202.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 19:50:05 +0000
References: <20250728-default_adv-v1-1-a1164ff502a7@amlogic.com>
In-Reply-To: <20250728-default_adv-v1-1-a1164ff502a7@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Jul 2025 17:08:44 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> list_empty(&hdev->adv_instances) is always true during startup,
> so an advertising instance is added by default.
> 
> Call trace:
>   dump_backtrace+0x94/0xec
>   show_stack+0x18/0x24
>   dump_stack_lvl+0x48/0x60
>   dump_stack+0x18/0x24
>   hci_setup_ext_adv_instance_sync+0x17c/0x328
>   hci_powered_update_adv_sync+0xb4/0x12c
>   hci_powered_update_sync+0x54/0x70
>   hci_power_on_sync+0xe4/0x278
>   hci_set_powered_sync+0x28/0x34
>   set_powered_sync+0x40/0x58
>   hci_cmd_sync_work+0x94/0x100
>   process_one_work+0x168/0x444
>   worker_thread+0x378/0x3f4
>   kthread+0x108/0x10c
>   ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Avoid adding default advertising on startup
    https://git.kernel.org/bluetooth/bluetooth-next/c/b88313f2a6c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


